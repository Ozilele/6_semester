
prime_factors_util(_, N, Acc, X) :-
    is_prime(N),
    append(Acc, [N], NewAcc),
    X = NewAcc,
    !.
prime_factors_util(CurrPrime, N, Acc, X) :-
    (N mod CurrPrime =:= 0
    ->  append(Acc, [CurrPrime], NewAcc),
        NewN is N / CurrPrime,
        NextCurr = CurrPrime
    ;   NewAcc = Acc,
        NewN = N,
        nextPrime(CurrPrime, NextCurr)        
    ),
    prime_factors_util(NextCurr, NewN, NewAcc, X).

% zwracający listę X rozkładu N na czynniki pierwsze;
prime_factors(N, X) :-
    (is_prime(N) 
    ->  X = [N], !
    ;   prime_factors_util(2, N, [], X)        
    ).

nextPrime(L, X) :-
    NextL is L + 1,
    nextPrimeUtil(NextL, X).

nextPrimeUtil(L, X) :-
    (is_prime(L)
    ->  X = L
    ;   NextL is L + 1,
        nextPrimeUtil(NextL, X)
    ).  

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