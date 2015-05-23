-module(test).
-export([test/0]).

test() ->
    test_tokenize(),
    test_atom(),
    test_read_from_tokens(),
    tests_passed.

test_tokenize() ->
    Program = scang:tokenize("(begin (define r 10) (* pi (* r r)))"),
    Program = [
        "(", "begin", "(", "define", "r", "10", ")",
        "(", "*", "pi", "(", "*", "r", "r", ")", ")", ")"].

test_atom() ->
    10.1 = scang:atom("10.1"),
    10 = scang:atom("10"),
    "abc" = scang:atom("abc"),
    "10abc" = scang:atom("10abc"),
    "10.1abc" = scang:atom("10.1abc").

test_read_from_tokens() ->
    Tokens = scang:read_from_tokens([
        "(", "begin", "(", "define", "r", "10", ")",
        "(", "*", "pi", "(", "*", "r", "r", ")", ")", ")"]),
    Tokens = ["begin", ["define", "r", 10], ["*", "pi", ["*", "r", "r"]]].
