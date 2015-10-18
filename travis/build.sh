#!/bin/bash
echo '######################################'
echo '#                Build               #'
echo '#              - START -             #'
echo '######################################'

PATH=$PATH:texlive2015/x86_64-linux/
echo $PATH
xelatex
make all

echo '######################################'
echo '#                Build               #'
echo '#            - FINISHED -            #'
echo '######################################'
