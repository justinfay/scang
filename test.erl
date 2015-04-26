-module(test).
-export([test/0]).

test() ->
    test_tokenize(),
    tests_passed.

test_tokenize() ->
    Program = scang:tokenize("(begin (define r 10) (* pi (* r r)))"),
    Program = [
        "(", "begin", "(", "define", "r", "10", ")",
        "(", "*", "pi", "(", "*", "r", "r", ")", ")", ")"].
