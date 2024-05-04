
% perm(L1, L2) zachodzi, gdy
% lista L2 jest permutacjπ listy L1.
perm([], []).
perm(L1, [X | L3]) :-
    select(X, L1, L2),
    perm(L2, L3).
dobra(X) :-
    \+ zła(X).
zła(X) :- 
    append(_, [Wi | L1], X),
    append(L2, [Wj | _], L1),
    length(L2, K),
    abs(Wi - Wj) =:= K + 1.
% abs(Wi - Wj) = odległość hetmanów w pionie
% K + 1 = odległość hetmanów w poziomie

hetmany(N, P) :-
    numlist(1, N, L),
    perm(L, P),
    dobra(P).

draw_row(_, _, 0) :- !.
draw_row(List, Row, Times) :-
    Times > 0,
    write('+-----'),
    NewTimes is Times - 1,
    (   NewTimes =:= 0 
    ->  write('+'), nl
    ;   true
    ),
    draw_row(List, Row, NewTimes).

draw_column(_, _, _, 0) :- !.
draw_column(List, Row, Col, Times) :-
    Times > 0,
    write('|'),
    (   mod(Row + Col, 2) =:= 1 % jasne pole
    ->  (   nth1(X, List, Row), 
            X =:= Col
        ->  write(' ### ')
        ;   write('     ')    
        )
    ;   (   nth1(X, List, Row),
            X =:= Col
        ->  write(':###:')
        ;   write(':::::')
        )
    ),
    (
        Times =:= 1
    ->  write('|')
    ;   true
    ),
    NewCol is Col + 1,
    NewTimes is Times - 1,
    draw_column(List, Row, NewCol, NewTimes).

rysuj(_, _, 0) :- !.
rysuj(N, L, Row) :-
    draw_row(L, Row, N),
    draw_column(L, Row, 1, N),
    nl,
    draw_column(L, Row, 1, N),
    nl,
    NewRow is Row - 1,
    rysuj(N, L, NewRow).

board(L) :-
    length(L, N),
    rysuj(N, L, 12),
    draw_row(L, 0, 12).
