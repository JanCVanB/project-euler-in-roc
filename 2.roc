# Project Euler Problem #2 (https://projecteuler.net/problem=2)
#
# Each new term in the Fibonacci sequence is generated by adding the
# previous two terms. By starting with 1 and 2, the first 10 terms will be:
#
# 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
#
# By considering the terms in the Fibonacci sequence whose values
# do not exceed four million, find the sum of the even-valued terms.

app "solve_2"
    packages { pf: "../roc/examples/hello-world/platform/main.roc" }
    imports []
    provides [main] to pf

main = solution |> Num.toStr |> Str.concat "\n"

solution = computeFibonacciNumbersUpTo 4_000_000
    |> List.keepIf isEven
    |> List.sum

computeFibonacciNumbersUpTo = \maximum ->
    more = \olds ->
        last2 = List.sublist olds { start: List.len olds - 2, len: 2 }
        next1 = List.sum last2
        news = List.append olds next1
        if next1 > maximum then olds else more news
    more [1, 2]

expect
    fibs = computeFibonacciNumbersUpTo 5
    fibs == [1, 2, 3, 5]
expect
    fibs = computeFibonacciNumbersUpTo 20
    fibs == [1, 2, 3, 5, 8, 13]

isEven = \n -> n % 2 == 0

expect isEven -1 |> Bool.not
expect isEven 0
expect isEven 1 |> Bool.not
expect isEven 2
expect isEven 3 |> Bool.not
expect isEven 4
