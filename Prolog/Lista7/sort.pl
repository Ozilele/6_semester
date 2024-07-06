
merge_(X, Y, Z) :-                     
    freeze(X,                          
    (   X = [HX | TX]                   
    ->  freeze(Y,                       
        (   Y  = [HY | TY]              
        ->  (  HX =< HY                 
            ->  Z = [HX | TZ],          
                merge_(TX, Y, TZ)      
            ;   Z = [HY | TZ],          
                merge_(X, TY, TZ)
            )
        ;   Z = X  % if Y is empty then Z = X                      
        ))
    ; Z = Y                          
    )).

split(X, Y, Z) :-
    freeze(X,                           
    (   X = [HX | TX]                   
    ->  Y = [HX | TY],                  
        split(TX, Z, TY)                
    ;   Y = [],                         
        Z = []             
    )).

mergesort(X, Y) :-
    freeze(X, 
    (   X = [_ | TX] % jezeli X ma co najmniej 1 element
    ->  freeze(TX, 
        (   TX = [_ | _]
        ->  split(X, X1, X2),
            mergesort(X1, Y1),
            mergesort(X2, Y2),
            merge_(Y1, Y2, Y)
        ;   Y = X   %Jezeli X ma 1 element, to juz jest posortowane - wyjście z rekurencji           
        ))
    ;   Y = X  %X jest puste, wyjście z rekurencji
    )).
