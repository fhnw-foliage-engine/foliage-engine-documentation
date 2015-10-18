#!/bin/bash
echo '######################################'
echo '#                Build               #'
echo '#              - START -             #'
echo '######################################'

PATH=$PATH:/tmp/texlive2015/x86_64-linux/
ls /tmp/texlive2015/x86_64-linux/
make all

echo '######################################'
echo '#                Build               #'
echo '#            - FINISHED -            #'
echo '######################################'
