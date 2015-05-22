-module(test).
-export([test/0]).

test() ->
    test_tokenize(),
    test_read_from_tokens(),
    tests_passed.

test_tokenize() ->
    Program = scang:tokenize("(begin (define r 10) (* pi (* r r)))"),
    Program = [
        "(", "begin", "(", "define", "r", "10", ")",
        "(", "*", "pi", "(", "*", "r", "r", ")", ")", ")"].

test_read_from_tokens() ->
    Tokens = scang:read_from_tokens([
        "(", "begin", "(", "define", "r", "10", ")",
        "(", "*", "pi", "(", "*", "r", "r", ")", ")", ")"]),
    Tokens = ["begin", ["define", "r", "10"], ["*", "pi", ["*", "r", "r"]]].

