c.InteractiveShellApp.extensions = ['autoreload']     
c.InteractiveShellApp.exec_lines = [
    '%autoreload 1',
    'from datetime import datetime, timedelta',
    'import imp',
    'fetch = imp.load_source("fetch", "/sanhome/yshah/Util/fetch.py")'
]
c.InteractiveShellApp.pylab='auto'
