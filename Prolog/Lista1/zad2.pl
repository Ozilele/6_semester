
on(Block1, Block2).

above(Block1, Block2) :-
    on(Block1, Block2).
above(Block1, Block2) :-
    on(Block1, X),
    above(X, Block2).
/* Rekurencyjne sprawdzenie, czy Block1 lezy na Block2 bezposrednio lub Block1 lezy na bloku X, który znajduje sie powyzej bloku Block2 */