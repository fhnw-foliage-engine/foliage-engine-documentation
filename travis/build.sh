#!/bin/bash
echo '######################################'
echo '#                Build               #'
echo '#              - START -             #'
echo '######################################'

PATH=$PATH:/tmp/texlive2015/x86_64-linux/
xelatex
make all


echo '######################################'
echo '#                Build               #'
echo '#            - FINISHED -            #'
echo '######################################'
