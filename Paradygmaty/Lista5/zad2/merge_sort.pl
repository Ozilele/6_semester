% Funkcja pomocnicza do wyciągania podlisty
sublist(L, Start, Len, SubList) :-
    length(Prefix, Start),
    append(Prefix, Rest, L),
    length(SubList, Len),
    append(SubList, _, Rest).

% Funkcja merge_util/4 do łączenia dwóch posortowanych list
merge_util([], R, R).
merge_util(L, [], L).
merge_util([H1|T1], [H2|T2], [H1|M]) :-
    H1 =< H2,
    merge_util(T1, [H2|T2], M).
merge_util([H1|T1], [H2|T2], [H2|M]) :-
    H1 > H2,
    merge_util([H1|T1], T2, M).

% Funkcja merge/5 do łączenia dwóch posortowanych podlist
merge(X, Left, Mid, Right, Out) :-
    ArrOneLength is Mid - Left + 1,
    ArrTwoLength is Right - Mid,
    LeftInd is Left - 1,
    sublist(X, LeftInd, ArrOneLength, LeftArr),
    sublist(X, Mid, ArrTwoLength, RightArr),
    merge_util(LeftArr, RightArr, Y),
    length(X, N),
    PrefixLen is Left - 1,
    SuffixLen is N - Right,
    sublist(X, 0, PrefixLen, Prefix),
    sublist(X, Right, SuffixLen, Suffix),
    append(Prefix, Y, Temp),
    append(Temp, Suffix, Out).

% Funkcja merge_sort_util/4 do rekurencyjnego sortowania przez scalanie
merge_sort_util(X, L, R, SortedList) :-
    L >= R,
    Ind is L - 1,
    sublist(X, Ind, 1, SortedList),
    !.
merge_sort_util(X, L, R, SortedList) :-
    Mid is (L + R) // 2,
    merge_sort_util(X, L, Mid, LeftSorted),
    merge_sort_util(X, Mid + 1, R, RightSorted),
    merge_util(LeftSorted, RightSorted, SortedList).

% Funkcja merge_sort/2 do sortowania listy
merge_sort(X, Y) :-
    length(X, N),
    merge_sort_util(X, 1, N, Y).
