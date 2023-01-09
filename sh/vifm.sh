#!/bin/bash

path=`fzf --expect=esc --reverse`
path_array=($path)
path_array_1=${path_array[0]}

if [ $path_array_1 != 'esc' ]
then
    path=`echo $path | sed 's/^ *//g'`
    vim -o "$path"
fi





