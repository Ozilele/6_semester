
/* prime(LO, HI, Primes) :-
    createTable(HI, Lista),
    iterateOuter(Lista, 2, HI, LO, Primes).

createTable(N, List) :-
    createTmpTable(N, [], List).

createTmpTable(0, List, List).
createTmpTable(N, Acc, List) :-
    N > 0,
    N1 is N - 1,
    createTmpTable(N1, [true | Acc], List).

element(List, Pos, Elem) :-
    nth1(Pos, List, Elem).

iterateOuter(_, _, HI, L, []) :-
    L > HI, !. % Gdy osiągniemy HI, kończymy iterację

iterateOuter(List, I, N, L, [I | Primes]) :-
    I * I > N, !, % gdy kwadrat I przekroczy N, end
    NextI is I + 1,
    L1 is L + 1,
    iterateOuter(List, NextI, N, L1, Primes).

iterateOuter(List, I, N, L, Primes) :-
    I * I =< N,
    markMultiplies(List, I, N, Tmp1),
    NextI is I + 1,
    iterateOuter(Tmp1, NextI, N, L, Primes).

% Predykat wykreślający wielokrotności liczby I
markMultiplies(Tmp, I, N, Tmp1) :-
    J is I * I,
    markMultipliesHelper(Tmp, I, N, J, Tmp1).

markMultipliesHelper(Tmp, _, N, J, Tmp) :-
    J > N, !.

markMultipliesHelper(Tmp, I, N, J, Tmp1) :-
    nth1(J, Tmp, true), !,
    replace(Tmp, J, false, Tmp2),
    NewJ is J + I,
    markMultipliesHelper(Tmp2, I, N, NewJ, Tmp1).

markMultipliesHelper(Tmp, I, N, J, Tmp1) :-
    NextJ is J + 1,
    markMultipliesHelper(Tmp, I, N, NextJ, Tmp1).

replace([_|T], 1, X, [X|T]) :- !.
replace([H|T], I, X, [H|R]) :-
    I > 1,
    I1 is I - 1,
    replace(T, I1, X, R).

/* writePrimes([], _, _, []).
writePrimes([H|T], Index, N, [Index|Primes]) :-
    H = true, !,
    NextIndex is Index + 1,
    writePrimes(T, NextIndex, N, Primes).
writePrimes([_|T], Index, N, Primes) :-
    NextIndex is Index + 1,
    writePrimes(T, NextIndex, N, Primes).
*/



