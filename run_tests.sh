#!/bin/sh

# TODO: exit immediately if a test fails

TESTS="t/t1.scm t/t2.scm t/t3.scm t/t4.scm t/t5.scm t/t6.scm"

echo running tests in larceny
for TEST in $TESTS
do
    larceny -r7rs -path . -program "$TEST"
done
echo
echo
echo

echo running tests in sagittarius
for TEST in $TESTS
do
    sagittarius -c -L. -S.sld "$TEST"
done
echo
echo
echo

echo running tests in chicken
for TEST in $TESTS
do
    csi -require-extension r7rs chicken.scm "$TEST" -e '(exit)'
done
echo
echo
echo

