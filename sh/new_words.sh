#!/bin/bash


word=$(echo "" | dmenu -p "Add word: ")
meaning=$(echo "" | dmenu -p "$word meaning: ")

if [ "$word" != "" ]; then
    echo "$word | $meaning" >> ~/.newwords
fi
