#!/bin/sh
bd=`TZ='America/Los_Angeles' date +"%b %d %Y"`
sed "s/Nov 10 2023/$bd/" simple.asm > simple_tmp.asm
