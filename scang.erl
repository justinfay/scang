-module(scang).
-export([tokenize/1, read_from_tokens/1]).

-ifndef(PRINT).
-define(PRINT(Var), io:format("DEBUG: ~p:~p - ~p ~p~n", [?MODULE, ?LINE, ??Var, Var])).
-endif.

tokenize(Chars) ->
    % Split a string into a list of tokens by.
    string:tokens(
        re:replace(
            re:replace(Chars, "[(]", " ( ", [global, {return, list}]),
            "[)]", " ) ", [global, {return, list}]),
        " ").

atom(Token) ->
    % TODO
    Token.

read_from_tokens(Tokens) -> read_from_tokens(Tokens, []).
read_from_tokens([H|T], Expression) ->
    case H of
        ")" -> {Expression, T};
        "(" -> {Parsed, Tokens} = read_from_tokens(T),
	    read_from_tokens(Tokens, lists:append(Expression, [Parsed]));
        Token -> read_from_tokens(T, lists:append(Expression, [atom(Token)]))
    end;
read_from_tokens([], [H|_]) -> H.
