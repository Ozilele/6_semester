
wstaw_znaki([X], X).
wstaw_znaki(Lista, X + Y) :-
    append([L|Lewy], [P|Prawy], Lista),
    wstaw_znaki([L|Lewy], X),
    wstaw_znaki([P|Prawy], Y).
    
wstaw_znaki(Lista, X - Y) :-
    append([L|Lewy], [P|Prawy], Lista),
    wstaw_znaki([L|Lewy], X),
    wstaw_znaki([P|Prawy], Y).
    
wstaw_znaki(Lista, X * Y) :-
    append([L|Lewy], [P|Prawy], Lista),
    wstaw_znaki([L|Lewy], X),
    wstaw_znaki([P|Prawy], Y).
    
wstaw_znaki(Lista, X / Y) :-
    append([L|Lewy], [P|Prawy], Lista),
    wstaw_znaki([L|Lewy], X),
    wstaw_znaki([P|Prawy], Y).
    
count(X,W) :-
    number(X),
    W is X.
    
count(X+Y, W) :-
    count(X,A),
    count(Y,B),
    W is A+B.
    
count(X-Y, W) :-
    count(X,A),
    count(Y,B),
    W is A-B.

count(X*Y, W) :-
    count(X,A),
    count(Y,B),
    W is A*B.

count(X/Y, W) :-
    count(X,A),
    count(Y,B),
    B =\= 0,
    W is A/B.
    
wyrazenie(Lista, Wartosc, Wyrazenie) :-
    wstaw_znaki(Lista, Wyrazenie),
    count(Wyrazenie, Wynik),
    Wartosc =:= Wynik.
