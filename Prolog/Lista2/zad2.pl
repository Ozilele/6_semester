

jednokrotnie(X, L) :-
    member(X, L),
    append(Prefix, [X | T], L),
    \+ member(X, Prefix),
    \+ member(X, T).

dwukrotnie(X, L) :-
    append(Prefix, [X | T], L),
    \+ member(X, Prefix),
    jednokrotnie(X, T).
