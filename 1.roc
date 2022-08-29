# Project Euler Problem #1 (https://projecteuler.net/problem=1)
#
# If we list all the natural numbers below 10 that are multiples of 3 or 5,
# we get 3, 5, 6 and 9. The sum of these multiples is 23.
#
# Find the sum of all the multiples of 3 or 5 below 1000.

app "solve_1"
    packages { pf: "../roc/examples/hello-world/platform/main.roc" }
    imports []
    provides [main] to pf

main = solution |> Num.toStr |> Str.concat "\n"

solution = List.range 3 1000 |> sumMultiples [3, 5]

sumMultiples = \numbers, factors ->
    isMultiple = \n -> isMultipleOfAny n factors
    numbers |> List.keepIf isMultiple |> List.sum

expect
    sum = sumMultiples [1, 2, 3] [1, 2, 3]
    sum == 6
expect
    sum = sumMultiples [4, 5, 6] [2]
    sum == 10
expect
    sum = sumMultiples [6, 7, 8, 9] [3, 10]
    sum == 15

isMultipleOfAny = \bigger, smallers ->
    isFactor = \s -> isMultipleOfThis bigger s
    List.find smallers isFactor |> Result.isOk

expect isMultipleOfAny 6 [] |> Bool.not
expect isMultipleOfAny 6 [2]
expect isMultipleOfAny 6 [2, 3]
expect isMultipleOfAny 6 [2, 3, 4]
expect isMultipleOfAny 6 [3, 4]
expect isMultipleOfAny 6 [4] |> Bool.not

isMultipleOfThis = \bigger, smaller ->
    bigger % smaller == 0

expect isMultipleOfThis 2 6 |> Bool.not
expect isMultipleOfThis 6 2
expect isMultipleOfThis 6 3
expect isMultipleOfThis 6 4 |> Bool.not
