:- dynamic(lebarPeta/1).
:- dynamic(tinggiPeta/1).
:- dynamic(player/2).
:- dynamic(posToke/3).
:- dynamic(inbattle/0).
:- include('tokemon.pl').

gym(5,5). %gym fixed place

/* posToke adalah representasi dari posisi tokemon pada map, yaitu posToke(Nama,T,L) */

/* indeks (T,L) merepresentasikan indeks dari suatu matrix (baris,kolom) */
initialize_map :-
    random(10,15,T),
    random(10,15,L),
    asserta(lebarPeta(T)),asserta(tinggiPeta(L)),
    random(1,T,PT),
    random(1,L,PL),
    asserta(player(PT,PL)),
    asserta(posToke(zigzogaan,8,4)),
    asserta(posToke(momon,5,3)).
    %randomToke(1).
/*
Belom beres, pengen ngebikin random tokemon positions
randomToke(6) :-
    lebarPeta(LPeta),
    tinggiPeta(TPeta),
    random(1,TPeta,TokeT),
    random(1,LPeta,TokeL),
    asserta(posToke(6,TokeT,TokeL)),!.
randomToke(ID) :-
    lebarPeta(LPeta),
    tinggiPeta(TPeta),
    random(1,TPeta,TokeT),
    random(1,LPeta,TokeL),
    asserta(posToke(ID,TokeT,TokeL)),
    Z is ID + 1,
    randomToke(Z),!.
*/
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

/* Zoom membesarkan suatu petak di T,L dgn idx
 0,0 0,1 0,2
 1,0 1,1 1,2
 2,0 2,1 2,2
*/
printToke(T,L) :-
    posToke(_,T,L),
    write('T'),!.
printToke(T,L) :-
    printIdx(T,L),!.
zoom(T,L) :-
    T1 is T-1,
    T2 is T+1,
    L1 is L-1,
    L2 is L+1,
    printToke(T1,L1),printToke(T1,L),printToke(T1,L2),nl,
    printToke(T,L1),printToke(T,L),printToke(T,L2),nl,
    printToke(T2,L1),printToke(T2,L),printToke(T2,L2),nl.

cekKondisi :- 
    get_random_number,
    randomNum(X),
    id(Nama,X),
    tokemon(Nama,A,B,C,Type),asserta(lawan(Nama,A,B,C,Type)),
    write('Kamu telah bertemu dengan sebuah pokemon bernama '),write(Nama),write(' dengan tipe '),write(Type),nl,
    write('Apa yang akan kamu lakukan???'),nl,
    write('1. Attack. - Bertarung melawan tokemon liar'),nl,
    write('2. Run.    - Melarikan diri dari tokemon'),nl,
    asserta(inbattle),!.
cekKondisi :-
    player(T,L),
    gym(T,L),
    write('Kamu sekarang berada dalam Gym, ketik "gym." untuk menyembuhkan semua tokemonmu.'),!.
cekKondisi :-
    write('Kamu tidak menemukan apa apa di petak ini'),!.
