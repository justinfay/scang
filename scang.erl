-module(scang).
-export([tokenize/1, atom/1, read_from_tokens/1]).

-ifndef(PRINT).
-define(PRINT(Var), io:format("DEBUG: ~p:~p - ~p ~p~n", [?MODULE, ?LINE, ??Var, Var])).
-endif.

tokenize(Chars) ->
    % Convert a string of characters into a list of tokens.
    string:tokens(
        re:replace(
            re:replace(Chars, "[(]", " ( ", [global, {return, list}]),
            "[)]", " ) ", [global, {return, list}]),
        " ").

atom(Token) ->
    {Int, _} = to_int(Token),
    if
        Int == error ->
            {Float, _} = to_float(Token),
            if
                Float == error ->
                    Token;
                true ->
                    Float
            end;
        true ->
            Int
    end.

to_int(Token) ->
    {Int, Rest} = string:to_integer(Token),
    if
        Int == error orelse Rest /= [] ->
            {error, Rest};
        true ->
            {Int, Rest}
    end.

to_float(Token) ->
    {Float, Rest} = string:to_float(Token),
    if
        Float == error orelse Rest /= [] ->
            {error, Rest};
        true ->
            {Float, Rest}
    end.


% Read an expression from a sequence of tokens.
read_from_tokens(Tokens) -> read_from_tokens(Tokens, []).
read_from_tokens([H|T], Expression) ->
    case H of
        ")" -> {Expression, T};
        "(" -> {Parsed, Tokens} = read_from_tokens(T),
	    read_from_tokens(Tokens, lists:append(Expression, [Parsed]));
        Token -> read_from_tokens(T, lists:append(Expression, [atom(Token)]))
    end;
read_from_tokens([], [H|_]) -> H.
