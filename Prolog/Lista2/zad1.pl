
środkowy(L, X) :-
    append(Y, [X|T], L),
    length(Y, N1),
    length(T, N),       
    N1 =:= N.            


