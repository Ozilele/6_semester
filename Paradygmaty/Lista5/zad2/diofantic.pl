% ax + by = gcd(a, b)

gcd_extended(A, 0, GCD, X, Y) :-
    X is 1,
    Y is 0,
    GCD is A.
gcd_extended(A, B, GCD, X, Y) :-
    B > 0,
    NewB is A mod B,
    gcd_extended(B, NewB, GCD, X1, Y1),
    X is Y1,
    Y is X1 - (A // B) * Y1.

de(A, B, X, Y, Z) :-
    gcd_extended(A, B, Z, X, Y).