#!/bin/bash

if [ -x src/ugrep ] ; then
UGREP=src/ugrep
elif [ -x ../src/ugrep ] ; then
UGREP=../src/ugrep
else
UGREP=ugrep
fi

if [ -x "$(command -v ggrep)" ] ; then
# GNU grep
GREP=ggrep
else
# GNU or BSD grep
GREP=/usr/bin/grep
fi

printf "$1 "
for (( i = 0; i < 100; ++i )); do
  printf "."
  ./pick $1 $2 $3 < words > temp_words.txt
  $UGREP -on -f temp_words.txt enwik8 > temp_result.txt
  $GREP -on -F -f temp_words.txt enwik8 | diff - temp_result.txt || exit
done
echo
