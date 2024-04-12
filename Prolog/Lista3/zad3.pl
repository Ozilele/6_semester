% Odd and even permutations

even_permutation([], []).
even_permutation([X|T], Perm) :-
    even_permutation(T, Perm1),
    odd(X, Perm1, Perm).

even_permutation([X|T], Perm) :-
    odd_permutation(T, Perm1),
    even(X, Perm1, Perm).

odd_permutation([X|T], Perm) :-
    odd_permutation(T, Perm1),
    odd(X, Perm1, Perm).

odd_permutation([X|T], Perm) :-
    even_permutation(T, Perm1),
    even(X, Perm1, Perm).

even(X, [Y|InList], [Y,X|InList]).
even(X, [Y,Z|InList], [Y,Z|OutList]) :-
    even(X, InList, OutList).

odd(X, InList, [X|InList]).
odd(X, [Y,Z|InList], [Y,Z|OutList]) :-
    odd(X, InList, OutList).
