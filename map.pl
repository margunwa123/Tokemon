:- dynamic(lebarPeta/1).
:- dynamic(tinggiPeta/1).
gym(5,5).
:- dynamic(player/2).

/* indeks (T,L) merepresentasikan indeks dari suatu matrix (baris,kolom) */
init_map :-
    random(10,15,T),
    random(10,15,L),
    asserta(lebarPeta(T)),asserta(tinggiPeta(L)),
    T1 is T-1,
    L1 is L-1,
    random(1,T1,PT),
    random(1,L1,PL),
    asserta(player(PT,PL)).

batasAtas(T,_) :- T=:=0.
batasKiri(_,L) :- L=:=0.
batasBawah(T,_) :-
    Z is T-1,
    tinggiPeta(Z),!. % ditambah 1 supaya bordernya pas
batasKanan(_,L) :-
    Z is L-1,
    lebarPeta(Z),!.
	
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

printIdx(T,L) :- player(T,L), write('P'), !.
printIdx(T,L) :- gym(T,L), !,write('G'),!.
printIdx(_,_) :- write('-'),!.
