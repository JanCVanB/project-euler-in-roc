# Project Euler Problem #1 (https://projecteuler.net/problem=1)
#
# If we list all the natural numbers below 10 that are multiples of 3 or 5,
# we get 3, 5, 6 and 9. The sum of these multiples is 23.
#
# Find the sum of all the multiples of 3 or 5 below 1000.

app "solve_1"
    packages { pf: "../examples/hello-world/zig-platform" }
    imports []
    provides [main] to pf

main = solution |> Num.toStr |> Str.concat "\n"

solution = List.range 3 1000 |> sumMultiples [3, 5]

sumMultiples = \numbers, factors ->
    List.walk numbers 0 \sum, n ->
        sum + (if (n |> isMultipleOfAny factors) then n else 0)

isMultipleOfAny = \bigger, smallers ->
    List.find smallers (\s -> isMultipleOfOne bigger s) |> Result.isOk
isMultipleOfOne = \bigger, smaller ->
    bigger % smaller == 0

