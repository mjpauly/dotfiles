c.InteractiveShellApp.extensions = ['autoreload']
c.InteractiveShellApp.exec_lines = [
    '%autoreload 1',
    '%run -i ~/ipython_startup.py',
]
c.InteractiveShellApp.pylab='auto'
c.TerminalInteractiveShell.confirm_exit = False
