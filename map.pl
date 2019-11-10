batasAtas(_,Y) :-
    Y=:=0
    ,!.
batasKiri(X,_) :-
    X=:=0,
    !.
batasBawah(_,Y) :-
    YMax is 16,
    Y=:=YMax,
    !.
batasKanan(X,_) :-
    XMax is 21,
    X=:=XMax,
    !.
	
/* OptionalMap	
midBorder(5,4).
midBorder(5,5).
midBorder(5,6).
midBorder(6,4).
midBorder(7,4).
midBorder(7,5).
midBorder(7,6).
*/
	
gym(10,10).
player(10,11).

printMap(X,Y) :-
    batasKanan(X,Y), !, write('X').
printMap(X,Y) :-
    batasKiri(X,Y), !, write('X').
printMap(X,Y) :-
    batasAtas(X,Y), !, write('X').
printMap(X,Y) :-
    batasBawah(X,Y), !, write('X').
/*
printMap(X,Y) :-
	midBorder(X,Y), !, write('X').
*/
printMap(X,Y) :-
    player(X,Y), !, write('P').
printMap(X,Y) :-
	gym(X,Y), !, write('G').
printMap(_,_) :-
	write('-').