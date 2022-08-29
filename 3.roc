# Project Euler Problem #3 (https://projecteuler.net/problem=3)
# 
# The prime factors of 13195 are 5, 7, 13 and 29.
#
# What is the largest prime factor of the number 600851475143 ?

app "solve_3"
    packages { pf: "../roc/examples/hello-world/platform/main.roc" }
    imports []
    provides [main] to pf

main = solution |> Num.toStr |> Str.concat "\n"

solution = calculateLargestPrimeFactor 600851475143

calculateLargestPrimeFactor = \n ->
    calculatePrimeFactors n
        |> List.last
        |> Result.withDefault n

expect
    factor = calculateLargestPrimeFactor 2
    factor == 2
expect
    factor = calculateLargestPrimeFactor 19
    factor == 19
expect
    factor = calculateLargestPrimeFactor 20
    factor == 5
expect
    factor = calculateLargestPrimeFactor 13195
    factor == 29

calculatePrimeFactors = \n ->
    calculateFactors n
        |> List.keepIf isPrime

expect
    factors = calculatePrimeFactors 2
    factors == [2]
expect
    factors = calculatePrimeFactors 19
    factors == [19]
expect
    factors = calculatePrimeFactors 20
    factors == [2, 5]
expect
    factors = calculatePrimeFactors 13195
    factors == [5, 7, 13, 29]

calculateFactors = \n ->
    rangeExclusive 2 n
        |> List.keepIf (\x -> n % x == 0)
        |> List.prepend 1
        |> List.append n

expect
    factors = calculateFactors 2
    factors == [1, 2]
expect
    factors = calculateFactors 19
    factors == [1, 19]
expect
    factors = calculateFactors 20
    factors == [1, 2, 4, 5, 10, 20]

isPrime = \n ->
    when n is
        1 -> False
        _ -> (calculateFactors n) == [1, n]

expect isPrime 1 |> Bool.not
expect isPrime 2
expect isPrime 5
expect isPrime 19
expect isPrime 20 |> Bool.not
expect isPrime 13195 |> Bool.not

# This is a workaround for the unfortunate fact that `List.range x x == List.range x (x+1)`.
# If that is no longer true, this can be replaced by `List.range`.
rangeExclusive = \low, high ->
    if low == high then [] else List.range low high

expect
    values = rangeExclusive 1 1
    values == []
expect
    values = rangeExclusive 1 2
    values == [1]
expect
    values = rangeExclusive 1 3
    values == [1, 2]
expect
    values = rangeExclusive 2 3
    values == [2]
expect
    values = rangeExclusive 3 3
    values == []
