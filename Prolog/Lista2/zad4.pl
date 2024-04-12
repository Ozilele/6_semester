

test :-
    between(1, 10, N),
    time((lista(N, _), fail)).

lista(N, L) :-
    numlist(1, N, A),
    permutation(A, P),
    odd_indices(L, P),
    permutation(A, Q),
    even_indices(L, Q),
    check(1, L).

odd_indices([], []).
odd_indices([X, _|L], [X|R]) :-
    odd_indices(L, R).

check(_, []).
check(K, [X|T]) :-
    X < K,
    check(K, T).

check(K, [X|T]) :-
    X =:= K,
    check(K+1, T).

even_indices([], []).
even_indices([_, X|L], [X|R]) :-
    even_indices(L, R).

/*
N   N!          inf		       avg
1   1           38             38
2   2           112            56
3   6           734            122.3
4   24          10218          425.75
5   120         250966         2091.38
6   720         9311528        12932.68
7   5040        476646990      94572.81
*/