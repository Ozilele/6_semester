
filozofowie :-
    mutex_create(F1),
    mutex_create(F2),
    mutex_create(F3),
    mutex_create(F4),
    mutex_create(F5),
    thread_create(filozof(1, F1, F2), ID1, []),
    thread_create(filozof(2, F2, F3), ID2, []),
    thread_create(filozof(3, F3, F4), ID3, []),
    thread_create(filozof(4, F4, F5), ID4, []),
    thread_create(filozof(5, F5, F1), ID5, []),
    thread_join(ID1, _),
    thread_join(ID2, _),
    thread_join(ID3, _),
    thread_join(ID4, _),
    thread_join(ID5, _).

filozof(ID, ForkLeft, ForkRight) :-
    random(R),
    sleep(R),
    format('[~w] mysli~n', [ID]),
    format('[~w] chce prawy widelec~n', [ID]),
    with_mutex(ForkRight,  % Lock mutex on right fork - grab right fork
    (
        format('[~w] podniósł prawy widelec~n', [ID]),
        format('[~w] chce lewy widelec~n', [ID]),
        with_mutex(ForkLeft, % Lock mutex on left fork 
        (
            format('[~w] podniósł lewy widelec~n', [ID]),
            format('[~w] je~n', [ID]),
            format('[~w] odkłada lewy widelec', [ID])
        )),
        format('[~w] odkłada prawy widelec', [ID])
    )),
    filozof(ID, ForkLeft, ForkRight).

