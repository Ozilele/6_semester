
zabierz_zapalki(0, X, Wynik) :-
    Wynik = X.
zabierz_zapalki(N, List, Wynik) :-
    N =\= 0,
    append(Left, [1 | Right], List),
    append(Left, [0 | Right], List2),
    New_N is N - 1,
    zabierz_zapalki(New_N, List2, Wynik).

check_BigSquare(X, List) :-
    (List = [1,1,1,1,_,_,1,_,_,_,1,_,_,1,_,_,_,1,_,_,1,1,1,1] -> Y is 1; Y is 0),
    X =:= Y.

check_MidSquare(X, List) :-
    (List = [1, 1, _, 1, _, 1, _, _, _, _, 1, _, 1, _, 1, 1, _, _, _, _, _, _, _, _] -> Y1 is 1; Y1 is 0), % left upper square
    (List = [_, _, _, _, _, _, _, 1, 1, _, 1, _, 1, _, _, _, _, 1, _, 1, _, 1, 1, _] -> Y2 is Y1 + 1; Y2 is Y1), % left down square
    (List = [_, 1, 1, _, 1, _, 1, _, _, _, _, 1, _, 1, _, 1, 1, _, _, _, _, _, _, _] -> Y3 is Y2 + 1; Y3 is Y2), % right upper square
    (List = [_, _, _, _, _, _, _, _, 1, 1, _, 1, _, 1, _, _, _, _, 1, _, 1, _, 1, 1] -> Y4 is Y3 + 1; Y4 is Y3), % right down square
    X =:= Y4.

check_SmallSquare(X, List) :-
    (List = [1,_,_,1,1,_,_,1,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_] -> Y1 is 1; Y1 is 0),
	(List = [_,1,_,_,1,1,_,_,1,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_] -> Y2 is Y1+1; Y2 is Y1),
	(List = [_,_,1,_,_,1,1,_,_,1,_,_,_,_,_,_,_,_,_,_,_,_,_,_] -> Y3 is Y2+1; Y3 is Y2),
	(List = [_,_,_,_,_,_,_,1,_,_,1,1,_,_,1,_,_,_,_,_,_,_,_,_] -> Y4 is Y3+1; Y4 is Y3),
	(List = [_,_,_,_,_,_,_,_,1,_,_,1,1,_,_,1,_,_,_,_,_,_,_,_] -> Y5 is Y4+1; Y5 is Y4),
	(List = [_,_,_,_,_,_,_,_,_,1,_,_,1,1,_,_,1,_,_,_,_,_,_,_] -> Y6 is Y5+1; Y6 is Y5),
	(List = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,1,_,_,1,1,_,_,1,_,_] -> Y7 is Y6+1; Y7 is Y6),
	(List = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,1,_,_,1,1,_,_,1,_] -> Y8 is Y7+1; Y8 is Y7),
	(List = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,1,_,_,1,1,_,_,1] -> Y9 is Y8+1; Y9 is Y8),
	X =:= Y9.

draw(25,_).
draw(N,[H| Lista]) :-
    (
        mod(N,7) =:= 1
    ;   mod(N,7) =:= 2
    ;   mod(N,7) =:= 3
    ),
    write('+'),
    (H =:= 1 -> write('---'); write('   ')),
    (mod(N,7) =:= 3 -> (write('+'),nl); true),
    N2 is N + 1,
    draw(N2,Lista).
draw(N,[H| Lista]) :-
    (
        mod(N,7) =:= 4
    ;   mod(N,7) =:= 5
    ;   mod(N,7) =:= 6
    ;   mod(N,7) =:= 0
    ),
    (H =:= 1 -> write('|'); write(' ')),
    (mod(N,7) =:= 0 -> nl; write('   ')),
    N2 is N+1,
    draw(N2, Lista).

% Predykat zapałki(K, D, S, M)
zapalki(K, D, S, M) :-
    List = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
    between(0,24,K),
    zabierz_zapalki(K, List, Wynik),
    check_BigSquare(D, Wynik),
    check_MidSquare(S, Wynik),
    check_SmallSquare(M, Wynik),
    write('Solution: '),
    nl,
    draw(1, Wynik).
