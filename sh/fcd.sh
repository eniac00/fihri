#!/bin/bash

path=`fzf --expect=esc --reverse`

path_array=($path)
path_array1=${path_array[0]}

if [ $path_array1 != 'esc' ]
then
    path=${path%/*}
    path=`echo $path | sed 's/^ *//g'`
    cd "$path"
fi





