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

isMultipleOfAny = \bigger, smallers ->
    isFactor = \s -> isMultipleOfThis bigger s
    List.find smallers isFactor |> Result.isOk
isMultipleOfThis = \bigger, smaller ->
    bigger % smaller == 0

