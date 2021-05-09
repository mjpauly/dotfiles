c.InteractiveShellApp.extensions = ['autoreload']     
c.InteractiveShellApp.exec_lines = [
    '%autoreload 1',
    # 'from datetime import datetime, timedelta',
    # 'from sympy import *',
    # 'init_session()',
    # 'from IPython.display import display',
]
c.InteractiveShellApp.pylab='auto'
c.TerminalInteractiveShell.confirm_exit = False
