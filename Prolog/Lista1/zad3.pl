    
prime(L0, HI, X) :-
    prime(L0, HI, L0, X).

prime(L1, HI, Current, Current) :-
    is_prime(Current),
    Current =< HI.

prime(LO, HI, Current, X) :-
    Current < HI,
    Next is Current + 1,
    prime(L0, HI, Next, X).
    
is_prime(2) :- !.
is_prime(3) :- !.
is_prime(P) :-
    P > 3,
    integer(P),
    P mod 2 =\= 0,
    \+ has_factor(P, 3).

has_factor(N, L) :- N mod L =:= 0.
has_factor(N, L) :- L * L < N, L2 is L + 2, has_factor(N, L2).