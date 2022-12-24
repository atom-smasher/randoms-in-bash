#!/bin/bash

## randoms-in-bash - https://github.com/atom-smasher/randoms-in-bash
## atom smasher
## I <3 ENTROPY
## v0.1 24 dec 2022

## playing around with ways to get high quality and/or large random numbers, using only bash

## (2**63)-1 = 0x7fffffffffffffff = $(( ( ( ( 0x7ff8 << 12 ^ 0x7ff8 ) << 12 ^ 0x7ff8 ) << 12 ^ 0x7ff8 ) << 12 ^ 0x7fff ))
##         0 =                0x0 = $(( ( ( (      0 << 12 ^      0 ) << 12 ^      0 ) << 12 ^      0 ) << 12 ^      0 ))
## as i understand the bash source code, RANDOM is only deterministic when it's explicitly set;
##     otherwise RANDOM reseeds itself every time its used
echo $(( ( ( ( ${RANDOM} << 12 ^ ${RANDOM} ) << 12 ^ ${RANDOM} ) << 12 ^ ${RANDOM} ) << 12 ^ ${RANDOM} ))

## not quite a true PRNG. among other factors, epoch-seconds sort-of sets a lower-bound for output
##     output can be less than epoch-sconds, eg epoch=1671840000.000000 (Sat 24 Dec 2022 00:00:00 GMT), RANDOM=0x6
## nonetheless, this could be useful when large "random" numbers are needed, eg for NON-SECURITY uses
## the high bits are set by $RANDOM, and the low bits are set by epoch EPOCHREALTIME
echo $(( ( ${RANDOM} << 48 ) ^ ${EPOCHREALTIME//./} ))
