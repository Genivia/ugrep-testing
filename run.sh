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

echo Testing $UGREP against $GREP as the reference grep
echo

echo -n '                                                                abcdefghijklmnopqrstuvwxyz' > alpha.txt
for (( k = 1; k <= 8; ++k )); do
  printf "tails test length $k"
  s=`tail -c $k alpha.txt`
  for (( n = k; n <= 64; ++n )); do
    (tail -c $n alpha.txt | $UGREP -q $s) || exit
    (tail -c $n alpha.txt | $UGREP -qi $s) || exit
    (tail -c $n alpha.txt | $UGREP -q -U "\w{$k}") || exit
    (tail -c $n alpha.txt | $UGREP -q -U -v "\d{$k}") || exit
    (tail -c $n alpha.txt | $UGREP -q -v "1") || exit
    (tail -c $n alpha.txt | $UGREP -q -v "12") || exit
    (tail -c $n alpha.txt | $UGREP -q -v "123") || exit
    (tail -c $n alpha.txt | $UGREP -q -v "1234") || exit
    (tail -c $n alpha.txt | $UGREP -q -v "12345") || exit
    (tail -c $n alpha.txt | $UGREP -q -v "123456") || exit
    (tail -c $n alpha.txt | $UGREP -q -v "1234567") || exit
    (tail -c $n alpha.txt | $UGREP -q -v "12345678") || exit
    printf '.'
  done
  echo
done

echo

echo trickle test length 8: 594045
./trickle 1000 65536 < enwik8 | $UGREP -c -U '\w{8,8}' | $UGREP -q 594045 || exit
echo trickle test length 7: 665927
./trickle 1000 65536 < enwik8 | $UGREP -c -U '\w{7,8}' | $UGREP -q 665927 || exit
echo trickle test length 6: 722712
./trickle 1000 65536 < enwik8 | $UGREP -c -U '\w{6,8}' | $UGREP -q 722712 || exit
echo trickle test length 5: 775310
./trickle 1000 65536 < enwik8 | $UGREP -c -U '\w{5,8}' | $UGREP -q 775310 || exit
echo trickle test length 4: 843643
./trickle 1000 65536 < enwik8 | $UGREP -c -U '\w{4,8}' | $UGREP -q 843643 || exit
echo trickle test length 3: 858707
./trickle 1000 65536 < enwik8 | $UGREP -c -U '\w{3,8}' | $UGREP -q 858707 || exit
echo trickle test length 2: 886585
./trickle 1000 65536 < enwik8 | $UGREP -c -U '\w{2,8}' | $UGREP -q 886585 || exit
echo trickle test length 1: 889497
./trickle 1000 65536 < enwik8 | $UGREP -c -U '\w{1,8}' | $UGREP -q 889497 || exit
echo trickle test short string: 199654
./trickle 1000 65536 < enwik8 | $UGREP -c -U 'the' | $UGREP -q 199654 || exit
echo trickle test short string: 222185
./trickle 1000 65536 < enwik8 | $UGREP -c -U -i 'the' | $UGREP -q 222185 || exit
echo trickle test short string: 199654
./trickle 1000 65536 < enwik8 | $UGREP -c -U 'the\w*' | $UGREP -q 199654 || exit
echo trickle test short string: 222185
./trickle 1000 65536 < enwik8 | $UGREP -c -U -i 'the\w*' | $UGREP -q 222185 || exit
echo trickle test longer string: 12519
./trickle 1000 65536 < enwik8 | $UGREP -c -U 'there' | $UGREP -q 12519 || exit
echo trickle test longer string: 18553
./trickle 1000 65536 < enwik8 | $UGREP -c -U -i 'there' | $UGREP -q 18553 || exit
echo trickle test longer string: 12519
./trickle 1000 65536 < enwik8 | $UGREP -c -U 'there\w*' | $UGREP -q 12519 || exit
echo trickle test longer string: 18553
./trickle 1000 65536 < enwik8 | $UGREP -c -U -i 'there\w*' | $UGREP -q 18553 || exit

echo

./test-ugrep.sh 1 1 1 '(s|er|ing)' || exit
./test-ugrep.sh 1 2 2 '(s|er|ing)' || exit
./test-ugrep.sh 1 3 3 '(s|er|ing)' || exit
./test-ugrep.sh 1 4 8 '(s|er|ing)' || exit
./test-ugrep.sh 1 0 999 '(s|er|ing)' || exit

./test-ugrep.sh 1 1 1 '(ment|ings)' || exit
./test-ugrep.sh 1 2 2 '(ment|ings)' || exit
./test-ugrep.sh 1 3 3 '(ment|ings)' || exit
./test-ugrep.sh 1 4 8 '(ment|ings)' || exit
./test-ugrep.sh 1 0 999 '(ment|ings)' || exit

./test-ugrep.sh 1 || exit
./test-ugrep.sh 2 || exit
./test-ugrep.sh 3 || exit
./test-ugrep.sh 4 || exit
./test-ugrep.sh 5 || exit
./test-ugrep.sh 6 || exit
./test-ugrep.sh 7 || exit
./test-ugrep.sh 8 || exit
./test-ugrep.sh 16 || exit
./test-ugrep.sh 256 || exit

./test-ugrep.sh 1 1 3 || exit
./test-ugrep.sh 2 1 3 || exit
./test-ugrep.sh 3 1 3 || exit
./test-ugrep.sh 4 1 3 || exit
./test-ugrep.sh 5 1 3 || exit
./test-ugrep.sh 6 1 3 || exit
./test-ugrep.sh 7 1 3 || exit
./test-ugrep.sh 8 1 3 || exit
./test-ugrep.sh 16 1 3 || exit
./test-ugrep.sh 256 1 3 || exit

./test-ugrep.sh 1 1 4 || exit
./test-ugrep.sh 2 1 4 || exit
./test-ugrep.sh 3 1 4 || exit
./test-ugrep.sh 4 1 4 || exit
./test-ugrep.sh 5 1 4 || exit
./test-ugrep.sh 6 1 4 || exit
./test-ugrep.sh 7 1 4 || exit
./test-ugrep.sh 8 1 4 || exit
./test-ugrep.sh 16 1 4 || exit
./test-ugrep.sh 256 1 4 || exit

./test-ugrep.sh 1 2 4 || exit
./test-ugrep.sh 2 2 4 || exit
./test-ugrep.sh 3 2 4 || exit
./test-ugrep.sh 4 2 4 || exit
./test-ugrep.sh 5 2 4 || exit
./test-ugrep.sh 6 2 4 || exit
./test-ugrep.sh 7 2 4 || exit
./test-ugrep.sh 8 2 4 || exit
./test-ugrep.sh 16 2 4 || exit
./test-ugrep.sh 256 2 4 || exit

./test-ugrep.sh 1 2 2 || exit
./test-ugrep.sh 2 2 2 || exit
./test-ugrep.sh 3 2 2 || exit
./test-ugrep.sh 4 2 2 || exit
./test-ugrep.sh 5 2 2 || exit
./test-ugrep.sh 6 2 2 || exit
./test-ugrep.sh 7 2 2 || exit
./test-ugrep.sh 8 2 2 || exit
./test-ugrep.sh 16 2 2 || exit
./test-ugrep.sh 256 2 2 || exit

./test-ugrep.sh 1 3 3 || exit
./test-ugrep.sh 2 3 3 || exit
./test-ugrep.sh 3 3 3 || exit
./test-ugrep.sh 4 3 3 || exit
./test-ugrep.sh 5 3 3 || exit
./test-ugrep.sh 6 3 3 || exit
./test-ugrep.sh 7 3 3 || exit
./test-ugrep.sh 8 3 3 || exit
./test-ugrep.sh 16 3 3 || exit
./test-ugrep.sh 256 3 3 || exit

./test-ugrep.sh 1 4 4 || exit
./test-ugrep.sh 2 4 4 || exit
./test-ugrep.sh 3 4 4 || exit
./test-ugrep.sh 4 4 4 || exit
./test-ugrep.sh 5 4 4 || exit
./test-ugrep.sh 6 4 4 || exit
./test-ugrep.sh 7 4 4 || exit
./test-ugrep.sh 8 4 4 || exit
./test-ugrep.sh 16 4 4 || exit
./test-ugrep.sh 256 4 4 || exit

./test-ugrep.sh 1 4 8 || exit
./test-ugrep.sh 2 4 8 || exit
./test-ugrep.sh 3 4 8 || exit
./test-ugrep.sh 4 4 8 || exit
./test-ugrep.sh 5 4 8 || exit
./test-ugrep.sh 6 4 8 || exit
./test-ugrep.sh 7 4 8 || exit
./test-ugrep.sh 8 4 8 || exit
./test-ugrep.sh 16 4 8 || exit
./test-ugrep.sh 256 4 8 || exit

echo OK
