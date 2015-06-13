#!/bin/bash

TESTS1="t/t1.scm t/t2.scm t/t3.scm t/t4.scm t/t5.scm t/t6.scm t/t7.scm  t/t9.scm"

TESTS2="t/records/t1.scm t/records/t2.scm t/records/t3.scm t/records/t4.scm"

function test1 {
    echo running tests in $1
    for TEST in $TESTS1
    do
	 eval $2
    done
    echo
    echo
    echo
}

function test2 {
    echo running tests in $1
    for TEST in $TESTS2
    do
	 eval $2
    done
    echo
    echo
    echo
}

test1 larceny "larceny -r7rs -path .:substitution/assoc:unification/basic -program \"\$TEST\""
test1 sagittarius "sagittarius -c -L. -Lsubstitution/assoc -Lunification/basic -S.sld \"\$TEST\""
#test1 chicken "csi -require-extension r7rs chicken-basic.scm \"\$TEST\" -e '(exit)'"

test1 larceny "larceny -r7rs -path .:substitution/binary-trie:unification/basic -program \"\$TEST\""
test1 sagittarius "sagittarius -c -L. -Lsubstitution/binary-trie -Lunification/basic -S.sld \"\$TEST\""


test2 larceny "larceny -r7rs -path .:substitution/assoc:unification/records -program \"\$TEST\""
test2 sagittarius "sagittarius -c -L. -Lsubstitution/assoc -Lunification/records -S.sld \"\$TEST\""
#test2 chicken "csi -require-extension r7rs chicken-records.scm \"\$TEST\" -e '(exit)'"

test2 larceny "larceny -r7rs -path .:substitution/binary-trie:unification/records -program \"\$TEST\""
test2 sagittarius "sagittarius -c -L. -Lsubstitution/binary-trie -Lunification/records -S.sld \"\$TEST\""




