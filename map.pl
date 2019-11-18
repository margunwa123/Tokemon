:- dynamic(lebarPeta/1).
:- dynamic(tinggiPeta/1).
:- dynamic(player/2).
:- dynamic(inbattle/1).
:- dynamic(mungkinRun/0).
gym(5,5). %gym fixed place

/* indeks (T,L) merepresentasikan indeks dari suatu matrix (baris,kolom) */
initialize_map :-
    random(10,15,T),
    random(10,15,L),
    asserta(lebarPeta(T)),asserta(tinggiPeta(L)), %ngeassert tinggi peta secara random
    random(1,T,PT),
    random(1,L,PL),         
    asserta(player(PT,PL)). %ngeassert player di posisi random

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

zoom(T,L) :-
    T1 is T-1,
    T2 is T+1,
    L1 is L-1,
    L2 is L+1,
    printIdx(T1,L1),printIdx(T1,L),printIdx(T1,L2),nl,
    printIdx(T,L1),printIdx(T,L),printIdx(T,L2),nl,
    printIdx(T2,L1),printIdx(T2,L),printIdx(T2,L2),nl.

cekKondisi :-
    player(T,L),
    gym(T,L),
    write('Kamu sekarang berada dalam Gym, ketik "heal." untuk menyembuhkan semua tokemonmu.'),!.
%tiap movement di cek kondisinya
cekKondisi :- 
    cekToke(Byk),
    Byk<3,
    get_normal_number,
    randomNum(X),
    id(Nama,X),
    tokemon(Nama,A,B,C,Type,Level),asserta(lawan(Nama,A,B,C,Type,Level)),
    write('Kamu telah bertemu dengan sebuah tokemon bernama '), write(Nama), nl,
    write('dengan tipe '), write(Type), 
    write(' dan berlevel '), write(Level), nl, nl,
    write('Apa yang akan kamu lakukan???'), nl, 
    write('1. Serang. - Bertarung melawan tokemon liar'),nl,
    write('2. Lari.   - Melarikan diri dari tokemon'),nl, 
    cadangan,
    asserta(inbattle(0)), asserta(mungkinRun), !.
%player tidak bisa menemukan legendary tokemon bila tokemonnya < 3
cekKondisi :- 
    cekToke(Byk),
    Byk>=3,
    get_random_number,
    randomNum(X),
    id(Nama,X),!,
    tokemon(Nama,A,B,C,Type,Level),asserta(lawan(Nama,A,B,C,Type,Level)),
    write('Kamu telah bertemu dengan sebuah'), (legendary(Nama) -> write(' legendary '); write('')),
    write(' tokemon bernama '), write(Nama), nl,
    write('dengan tipe '), write(Type), 
    write(' dan berlevel '), write(Level), nl, nl, 
    write('Apa yang akan kamu lakukan???'),nl,
    write('1. Serang. - Bertarung melawan tokemon liar'),nl,
    write('2. Lari.   - Melarikan diri dari tokemon'),nl,
    cadangan,
    asserta(inbattle(0)), asserta(mungkinRun),!.
cekKondisi :-
    get_item_number,
    item_number(ID),
    mapitem(ID,Efek,Nama,Raise),
    write('Kamu telah menemukan sebuah item bernama '),write(Nama),write(' dengan efek '), write(Efek), write(' sebanyak '), write(Raise),nl,
    write('Cara menggunakan item adalah ketikan use(Nama_Item,Toke).'),asserta(item(Nama)),!.
cekKondisi :-
    write('Kamu tidak menemukan apa apa di petak ini'),!.

serang :-
    loseGame, lose, !.
serang :- 
    inbattle(0), cekToke(Banyak), Banyak > 1,
    write('Tokemon yang ada : ['),
    toke(H,I,J,K,L,M,N), write(H),
    retract(toke(H,I,J,K,L,M,N)),
    toke(_,_,_,_,_,_,_) -> (
        forall(toke(A,_,_,_,_,_,_),
        (
            write(','),
            write(A)
        ))
    ),
    write(']'),nl,nl, 
    asserta(toke(H,I,J,K,L,M,N)),
    write('Untuk memilih Tokemon, berikan perintah pick(NamaTokemon).'),nl,
    retract(inbattle(0)),
    asserta(inbattle(1)), !. 

serang :- 
    inbattle(0), cekToke(Banyak), Banyak =:= 1, 
    write('Tokemon yang ada : ['),
    toke(H,_,_,_,_,_,_), write(H),
    write(']'),nl,
    write('Untuk memilih Tokemon, berikan perintah pick(NamaTokemon).'),nl,
    retract(inbattle(0)),
    asserta(inbattle(1)), !.  

lari :-
    loseGame, lose, !.
lari :- 
    \+ loseGame,
    \+ mungkinRun,
    write('Anda sudah mencoba lari tetapi tidak bisa!'), nl,
    write('Berusahalah!'), nl, !.           
lari :- 
    get_random_number,
    randomNum(X),
    (X > 35 
    ->  retract(lawan(_,_,_,_,_,_)),
        write('Anda berhasil kabur.'),
        naikexp,
        % retract(inbattle(1))
        (inbattle(0)
        ->  retract(inbattle(0));
            retract(inbattle(1))
        );
        write('Anda tidak berhasil kabur.'), nl,
        write('Berusahalah!'), nl,
        serang
    ),
    retract(mungkinRun), !.

cadangan :- 
    toke(_,_,_,_,_,_,_) -> (
        forall(toke(A,B,C,D,E,F,G),
        (
            asserta(tokeT(A,B,C,D,E,F,G,1)),
            asserta(exp(A,0))
        ))
    ), !.