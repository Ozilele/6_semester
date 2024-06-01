
primes(N, X) :-
    primes(2, N, [], X).

primes(N, N, Acc, Acc).
primes(L, R, Acc, X) :-
    (is_prime(L) 
    ->  append(Acc, [L], NewAcc)
    ;   NewAcc = Acc),
    NextL is L + 1,
    primes(NextL, R, NewAcc, X).

is_prime(2) :- !.
is_prime(3) :- !.
is_prime(P) :-
    P > 3,
    integer(P),
    P mod 2 =\= 0,
    \+ has_factor(P, 3).

has_factor(N, L) :- 
    N mod L =:= 0.
has_factor(N, L) :- 
    L * L < N, 
    L2 is L + 2, 
    has_factor(N, L2).
