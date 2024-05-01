% Zagadka Einsteina

% Applied rules - 1, 8, 12, 2, 3, 4, 5, 6, 7, 9, 10, 11, 13, 14, 15

left(Lewy,Prawy,[Lewy,Prawy|_]).
left(Lewy,Prawy,[_|R]) :-
	left(Lewy,Prawy,R).

next_to(X, Y, Street) :-
    left(X, Y, Street).

next_to(X, Y, Street) :-
    left(Y, X, Street).

% Numer domu, kolor, nationality, drink, cigarette, pet
rybki(Kto) :-
    Street = [[1,_,_,_,_,_], [2,_,_,_,_,_], [3,_,_,_,_,_], [4,_,_,_,_,_], [5,_,_,_,_,_]],
    member([1,_,norweg,_,_,_], Street),
    member([3,_,_,mleko,_,_], Street),
    member([2,blue,_,_,_,_], Street),
    member([_, czerwony, anglik, _, _, _], Street),
    left([_,zielony,_,_,_,_], [_,bialy,_,_,_,_], Street),
    member([_, _, dunczyk, herbata, _, _], Street),
    next_to([_, _, _, _, light, _], [_, _, _, _, _, koty], Street),
    member([_,zolty,_,_,cygaro,_], Street),
    member([_, _, niemiec, _, fajka, _], Street),
    next_to([_, _, _, _, light, _], [_, _, _, woda, _, _], Street),
    member([_, _, _, _, bezfiltra, ptaki], Street),
    member([_, _, szwed, _, _, psy], Street),
    next_to([_, _, _, _, _, konie], [_, zolty, _, _, _, _], Street), 
    member([_, _, _, piwo, mentolowe, _], Street), 
    member([_,zielony,_,kawa,_,_], Street),
    member([_, _, Kto, _, _, rybki], Street).





