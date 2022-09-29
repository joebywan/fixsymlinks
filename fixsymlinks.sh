#!/bin/bash

path=/usr/lib/jvm/
wildcard=*openjdk*
directories=$(ls -ld $path$wildcard | awk '{print $9}')

for directory in $directories
do
  if [ -L $directory ] ; then
    if [ -e $directory ] ; then
        echo "Good link"
    else
        echo "Broken link"
        linkdest=$(ls -ld $directory | sed -e 's/.* -> //')
        unlink $linkdest
        ln -s $path$directory $linkdest
    fi
  elif [ -e $directory ] ; then
    echo "Not a link"
  else
    echo "Missing"
  fi
done