#!/bin/bash

TESTS1="bench/run_bench.scm"

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

test1 larceny "larceny -r7rs -path .:substitution/assoc:unification/records -program \"\$TEST\"" > bench/results_assoc.txt

test1 larceny "larceny -r7rs -path .:substitution/binary-trie:unification/records -program \"\$TEST\"" > bench/results_trie.txt

test1 larceny "larceny -r7rs -path .:substitution/llrb-tree:unification/records -program \"\$TEST\"" > bench/results_llrb.txt
