
wariancja(L, X) :-
    length(L, N),
    sum_list(L, Sum),
    Avg is Sum / N,
    maplist(diff_squared(Avg), L, SquaredDiffs), % apply to each element in list L diff_squared and store in SquaredDiffs
    sum_list(SquaredDiffs, SumSquaredDiffs),
    X is SumSquaredDiffs / N.

diff_squared(Mean, X, DiffSquared) :-
    Diff is X - Mean,
    DiffSquared is Diff * Diff.