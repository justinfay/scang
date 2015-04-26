-module(scang).
-export([tokenize/1]).

tokenize(Chars) ->
    string:tokens(
        re:replace(
            re:replace(Chars, "[(]", " ( ", [global, {return, list}]),
            "[)]", " ) ", [global, {return, list}]),
        " ").
