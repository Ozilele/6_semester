% Fakty
biały(' ').
biały('\t').
biały('\n').
key(read).
key(write).
key(if).
key(then).
key(else).
key(fi).
key(while).
key(do).
key(od).
key(and).
key(or).
key(mod).
sep(';').
sep('+').
sep('-').
sep('*').
sep('/').
sep('(').
sep(')').
sep('<').
sep('>').
sep('=<').
sep('>=').
sep(':=').
sep('=').
sep('/=').

read_stream(Stream, X) :-
    get_char(Stream, C),
    czytaj_dalej(Stream, C, X).

czytaj_dalej(_, end_of_file, []) :-
    !.
czytaj_dalej(S, C1, X) :-
    biały(C1), /* jezeli bialy znak */
    !,
    get_char(S, C2),
    czytaj_dalej(S, C2, X).

czytaj_dalej(S, C1, [H | T]) :-
    czytaj_slowo(S, C1, C2, '', H),
    czytaj_dalej(S, C2, T).

czytaj_slowo(_, end_of_file, end_of_file, N, N) :-
    !.
czytaj_slowo(_, C, C, N, N) :-
    biały(C),
    !.

czytaj_slowo(_,C, C, N, N) :- % N is prefix char 
    char_type(C, punct),  % punct character(not a letter or digit)                          
    atom_length(N, L), 
    L > 0,                                              
    atom_chars(N, L2),                                
    \+ same_jakies(L2, punct),                      
    !.

czytaj_slowo(_,C, C, N, N) :-
    char_type(C, upper), % zmienna                         
    atom_length(N, L),
    L > 0,
    atom_chars(N, L2),
    \+ same_jakies(L2, upper), 
    !.

czytaj_slowo(_,C, C, N, N) :-
    char_type(C, lower), % keyword                                 
    atom_length(N, L),
    L > 0,
    atom_chars(N, L2),
    \+ same_jakies(L2, lower),
    !.   

czytaj_slowo(_,C, C, N, N) :-
    char_type(C, digit), % digit                       
    atom_length(N, L),
    L > 0,
    atom_chars(N, L2),
    \+ same_jakies(L2, digit),
    !.    

czytaj_slowo(S, C1, C3, N1, N) :-
    atom_concat(N1, C1, N2), % Do N2 dokleja się znak do dotychczasowego słowa
    get_char(S, C2),
    czytaj_slowo(S, C2, C3, N2, N).

same_jakies([], _) :-
    !.
same_jakies([H|L], Y) :-
    char_type(H, Y),
    same_jakies(L, Y).

process_word(Word, Token) :-
    (   key(Word) 
    ->  Token = key(Word)
    ;   sep(Word)
    ->  Token = sep(Word)
    ;   atom_chars(Word, Chars),
        czy_liczba_naturalna(Chars)
    ->  number_chars(Number, Chars),
        Token = int(Number)
    ;   atom_chars(Word, [First|Rest]),
        char_type(First, upper),
        maplist(is_uppercase, Rest),
        Token = id(Word)
    ).

czy_liczba_naturalna(Chars) :-
    maplist(char_type_check(digit), Chars).

char_type_check(Type, Char) :-
    char_type(Char, Type).

is_uppercase(Char) :-
    char_type(Char, upper).

% Czytanie strumienia znaków i zamiana go na listę tokenów
scanner(Stream, Tokeny) :-
    read_stream(Stream, A),
    maplist(process_word, A, Tokeny).

