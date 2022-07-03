# Project Euler Problem #3 (https://projecteuler.net/problem=3)
# 
# The prime factors of 13195 are 5, 7, 13 and 29.
#
# What is the largest prime factor of the number 600851475143 ?

app "solve_3"
    packages { pf: "../roc/examples/hello-world/zig-platform" }
    imports []
    provides [main] to pf

main = solution |> Num.toStr |> Str.concat "\n"

solution = findLargestPrimeFactor 21

findLargestPrimeFactor = \n -> findPrimes n |> List.last

findPrimes = \n ->
    List.range 2 n
        |> ...

