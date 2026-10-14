-- Directional window navigation that breaks ties by most-recently-visited
-- window (like tmux) instead of cursor position. Falls back to
-- vim-tmux-navigator's commands when there is no vim window in the given
-- direction, so movement across tmux panes still works.

local counter = 0
local visits = {} -- winid -> visit order
local suppress = false -- don't stamp vim's interim focus pick during a close

local group = vim.api.nvim_create_augroup("MruNavigate", { clear = true })

vim.api.nvim_create_autocmd("WinEnter", {
    group = group,
    callback = function()
        if suppress then
            return
        end
        counter = counter + 1
        visits[vim.api.nvim_get_current_win()] = counter
    end,
})
visits[vim.api.nvim_get_current_win()] = 0

-- When the current window closes, vim picks the successor by layout; jump
-- to the most recently visited remaining window instead (like tmux).
vim.api.nvim_create_autocmd("WinClosed", {
    group = group,
    callback = function(args)
        local closed = tonumber(args.match)
        if closed ~= vim.api.nvim_get_current_win() then
            visits[closed] = nil
            return
        end
        -- Closing a diff window prefers the other diff windows in the tab
        -- (e.g. fugitive's dv pair), so a double close dismisses the diff
        -- even if the status split was visited more recently.
        local closed_diff = vim.api.nvim_get_option_value("diff", { win = closed })
        local best, best_stamp, best_diff
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            if win ~= closed and vim.api.nvim_win_get_config(win).relative == "" then
                local stamp = visits[win] or 0
                local diff = closed_diff
                    and vim.api.nvim_get_option_value("diff", { win = win })
                if not best
                    or (diff and not best_diff)
                    or (diff == best_diff and stamp > best_stamp) then
                    best, best_stamp, best_diff = win, stamp, diff
                end
            end
        end
        visits[closed] = nil
        if not best then
            return
        end
        -- Switch away while the closing window still exists, so vim never
        -- focuses its own layout-based successor (an interim focus would
        -- e.g. drag scroll-bound diff windows around). Save the target's
        -- view first and restore it once the close and resize settle,
        -- since resizing the now-current window can shift its topline.
        local view = vim.api.nvim_win_call(best, vim.fn.winsaveview)
        local buf = vim.api.nvim_win_get_buf(best)
        if pcall(vim.api.nvim_set_current_win, best) then
            -- WinEnter doesn't fire for switches made inside an autocmd,
            -- so stamp the visit manually.
            counter = counter + 1
            visits[best] = counter
            vim.schedule(function()
                -- Skip if something (e.g. fugitive's dv) has since put a
                -- different buffer in the window; the saved view would
                -- apply the old buffer's position to the new one.
                if vim.api.nvim_win_is_valid(best)
                    and vim.api.nvim_get_current_win() == best
                    and vim.api.nvim_win_get_buf(best) == buf then
                    vim.fn.winrestview(view)
                end
            end)
            return
        end
        -- Fallback if switching is disallowed in this context: fix up focus
        -- after the close, suppressing the interim WinEnter stamp.
        suppress = true
        vim.schedule(function()
            suppress = false
            if vim.api.nvim_win_is_valid(best)
                and vim.api.nvim_get_current_win() ~= best then
                vim.api.nvim_set_current_win(best)
            end
        end)
    end,
})

local tmux_cmd = {
    h = "TmuxNavigateLeft",
    j = "TmuxNavigateDown",
    k = "TmuxNavigateUp",
    l = "TmuxNavigateRight",
}

-- Windows adjacent to the current one in direction dir ('h'/'j'/'k'/'l'),
-- i.e. in the nearest row/column that direction with perpendicular overlap.
local function candidates(dir)
    local cur = vim.api.nvim_get_current_win()
    local cr, cc = unpack(vim.fn.win_screenpos(cur))
    local ch, cw = vim.fn.winheight(cur), vim.fn.winwidth(cur)

    local found = {}
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if win ~= cur and vim.api.nvim_win_get_config(win).relative == "" then
            local r, c = unpack(vim.fn.win_screenpos(win))
            local h, w = vim.fn.winheight(win), vim.fn.winwidth(win)
            local ok, dist
            if dir == "k" then
                ok = r + h <= cr and c < cc + cw and cc < c + w
                dist = cr - (r + h)
            elseif dir == "j" then
                ok = r >= cr + ch and c < cc + cw and cc < c + w
                dist = r - (cr + ch)
            elseif dir == "h" then
                ok = c + w <= cc and r < cr + ch and cr < r + h
                dist = cc - (c + w)
            else -- "l"
                ok = c >= cc + cw and r < cr + ch and cr < r + h
                dist = c - (cc + cw)
            end
            if ok then
                table.insert(found, { win = win, dist = dist })
            end
        end
    end

    local nearest = math.huge
    for _, cand in ipairs(found) do
        nearest = math.min(nearest, cand.dist)
    end
    return vim.tbl_filter(function(cand)
        return cand.dist == nearest
    end, found)
end

local function navigate(dir)
    local cands = candidates(dir)
    if #cands == 0 then
        -- No vim window that way; let vim-tmux-navigator hand off to tmux.
        vim.cmd(tmux_cmd[dir])
        return
    end
    local best = cands[1].win
    for _, cand in ipairs(cands) do
        if (visits[cand.win] or 0) > (visits[best] or 0) then
            best = cand.win
        end
    end
    vim.api.nvim_set_current_win(best)
end

for _, dir in ipairs({ "h", "j", "k", "l" }) do
    vim.keymap.set("n", "<c-" .. dir .. ">", function()
        navigate(dir)
    end, { silent = true, desc = "MRU-aware " .. tmux_cmd[dir] })
end
vim.keymap.set("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", { silent = true })
