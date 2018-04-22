#!/bin/bash
JUPYTER=~/Library/Python/3.6/bin/jupyter
BROWSER="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
NOTEBOOKDIR=~/Jupyter

"${JUPYTER}" lab --no-browser --notebook-dir="${NOTEBOOKDIR}" &
JUPYTER_PID=$!
sleep 3
URL=$("${JUPYTER}" notebook list | tail -1 | awk '{ print $1 }')
"${BROWSER}" "--app=${URL}"
kill ${JUPYTER_PID}
