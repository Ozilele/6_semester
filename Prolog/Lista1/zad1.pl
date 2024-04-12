
jest_matką(X) :- matka(X, Y).
jest_ojcem(X) :- ojciec(X, Y).
jest_synem(X) :- meżczyzna(X), rodzic(Y, X).
rodzeństwo(X, Y) :- ojciec(Z, X), ojciec(Z, Y), matka(G, X), matka(G, Y), X \= Y.
siostra(X, Y) :- kobieta(X), rodzeństwo(X, Y).
dziadek(X, Y) :- ojciec(X, Z), rodzic(Z, Y).

