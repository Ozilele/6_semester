
% Kadane Algorithm

max_sum([X | L], S) :-
    (X < 0 -> NextX = 0; NextX is X),
    max_sum(L, NextX, X, S).

max_sum([X | L], MaxEnding, MaxSoFar, S) :-
    NewMaxEnding is MaxEnding + X,
    (MaxSoFar < NewMaxEnding -> NextSum = NewMaxEnding; NextSum = MaxSoFar),
    (NewMaxEnding < 0 -> MaxNextEnding = 0; MaxNextEnding = NewMaxEnding),
    max_sum(L, MaxNextEnding, NextSum, S).

max_sum([], _, MaxSum, MaxSum).

