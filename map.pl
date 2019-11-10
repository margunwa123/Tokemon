tinggiMap(10).
lebarMap(10).
posGym(5,5).
posPlayer(1,2).

/* indeks (T,L) merepresentasikan indeks dari suatu matrix (baris,kolom) */
batasAtas(T,_) :- T=:=0.
batasKiri(_,L) :- L=:=0.
batasBawah(T,_) :-
    Z is T-1,
    lebarMap(Z),!. % ditambah 1 supaya bordernya pas
batasKanan(_,L) :-
    Z is L-1,
    lebarMap(Z),!.
	
/* OptionalMap	
midBorder(5,4).
midBorder(5,5).
midBorder(5,6).
midBorder(6,4).
midBorder(7,4).
midBorder(7,5).
midBorder(7,6).
*/
/*
writeBorder(-1) :- write('X'),nl,!.
writeBorder(X) :- write('X'),Z is X-1, writeBorder(Z).
*/

/* T untuk lebar peta, L untuk tinggi peta */
printIdx(T,L) :-
    batasBawah(T,L),
    batasKanan(T,L),
    write('X'),nl,!.
printIdx(T,L) :-
    batasKanan(T,L),
    write('X'),nl,
    !.
printIdx(T,L) :-
    batasAtas(T,L), 
    write('X'),!.
printIdx(T,L) :-
    batasKiri(T,L),
    write('X'),!.
printIdx(T,L) :-
    batasBawah(T,L),
    write('X'),!.

/*
printIdx(T,L) :-
	midBorder(T,L), !, write('T').
*/

printIdx(T,L) :- posPlayer(T,L), write('P'), !.
printIdx(T,L) :- posGym(T,L), !,write('G'),!.
printIdx(_,_) :- write('-'),!.

peta(TPeta,LPeta) :- 
    batasBawah(TPeta,LPeta),
    batasKanan(TPeta,LPeta),
    printIdx(TPeta,LPeta),!.
peta(TPeta,LPeta) :- 
    batasKanan(TPeta,LPeta), 
    printIdx(TPeta,LPeta),
    Z is TPeta + 1, 
    peta(Z,0),!.
peta(TPeta,LPeta) :-
    printIdx(TPeta,LPeta),
    Z is LPeta + 1,
    peta(TPeta,Z),!.

map :- peta(0,0).