#!/bin/bash

cd ~/Documents
ls *.pdf > ~/Documents/all_pdf

chosen=$(echo "" | cat ~/Documents/all_pdf | dmenu -l 10 -p "Which PDF: ")

if [ "$chosen" != "" ]; then
    zathura "$chosen" &
fi


