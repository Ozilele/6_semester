
my_gcd(0, B, B) :- !. % zakończenie wnioskowania
my_gcd(A, B, Wynik) :-
    A > 0,
    NewA is B mod A,
    my_gcd(NewA, A, Wynik).

/* Akumulator do przechowywania wyniku */
totient_util(N, N, Acc, Acc).
totient_util(N, I, Acc, T) :-
    I < N,
    my_gcd(I, N, GCD),
    (GCD = 1 -> NewAcc is Acc + 1; NewAcc is Acc),
    NewI is I + 1,
    totient_util(N, NewI, NewAcc, T).

totient(1, T) :- 
    T is 1.
totient(N, T) :-
    totient_util(N, 2, 1, T).
