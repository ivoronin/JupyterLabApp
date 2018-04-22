#!/usr/bin/env python
from os.path import realpath, expanduser
from os import system, getppid, kill
from sys import argv, exit
from signal import SIGTERM

paths = {
    'script': realpath(__file__),
    'jupyter': expanduser('~/Library/Python/3.6/bin/jupyter'),
    'chrome': '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',
    'notebook': expanduser('~/Jupyter'),
}

if __name__ == '__main__':
    nargs = len(argv)
    if nargs == 1:
        # Run as application
        system('"{jupyter}" lab "--browser={script} %s"'.format(**paths))
    elif nargs == 2:
        # Run as browser
        url = argv[1]
        ppid = getppid()
        system('"{chrome}" "--app={url}"'.format(url=url, **paths))
        kill(ppid, SIGTERM)
    else:
        exit(1)
