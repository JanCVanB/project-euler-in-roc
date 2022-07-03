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

expect (calculateLargestPrimeFactor 2) == 2
expect (calculateLargestPrimeFactor 19) == 19
expect (calculateLargestPrimeFactor 20) == 5
expect (calculateLargestPrimeFactor 13195) == 29

calculatePrimeFactors = \n ->
    calculateFactors n
        |> List.keepIf isPrime

expect (calculatePrimeFactors 2) == [2]
expect (calculatePrimeFactors 19) == [19]
expect (calculatePrimeFactors 20) == [2, 5]
expect (calculatePrimeFactors 13195) == [5, 7, 13, 29]

calculateFactors = \n ->
    (
        if n == 2 then
            []
        else
            List.range 2 n
    )
        |> List.keepIf (\x -> n % x == 0)
        |> List.prepend 1
        |> List.append n

expect (calculateFactors 2) == [1, 2]
expect (calculateFactors 19) == [1, 19]
expect (calculateFactors 20) == [1, 2, 4, 5, 10, 20]

isPrime = \n ->
    when n is
        1 -> False
        _ -> (calculateFactors n) == [1, n]

expect (isPrime 1) == False
expect (isPrime 2) == True
expect (isPrime 5) == True
expect (isPrime 19) == True
expect (isPrime 20) == False
expect (isPrime 13195) == False
