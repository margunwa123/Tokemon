/* Tugas Besar Logika Komutasional - IF 2121 */
/* Kelas 03 (Kelompok 02) */
/* Akhmad Aji Permadi      10118030 */
/* Fikra Hadi Ramadhan     13518036 */
/* Daniel Riyanto          13518075 */
/* Mario Gunawan           13518114 */

:- dynamic(toke/7).
:- dynamic(tokeT/8).
:- dynamic(exp/2).
:- dynamic(nLegend/1).
:- dynamic(avChoose/0).
:- dynamic(randomNum/1).
:- dynamic(id/2).

/* ************* FAKTA *************** */
/* Nama Tokemon (Nama, Hp, Basic Att, Skill Att, Type, Level) */
/* Normal Tokemon 
Komposisi : (health/100) * (attack/100) = +- 20
sp.attack : attack + health/10 */
tokemon(zigzagur,1500,130,280,ground,20).      %1
tokemon(bulbalul,2000,100,300,leaves,20).      %2
tokemon(vanila_bluemon,1700,115,285,ice,20).   %3
tokemon(toketchur,1200,160,280,lightning,20).  %4
tokemon(momon,1300,150,280,leaves,20).         %5
tokemon(engasmon,1269,169,269,water,20).       %6
tokemon(santuymon,1500,120,270,fire,20).       %7
tokemon(tankmon,2500,80,330,ground,20).        %8
tokemon(konakmon,1000,200,300,water,20).       %9
tokemon(jonatan_jostar,2100,100,300,fire,20).  %10
tokemon(pikacrot,1500,133,283,lightning,20).   %11
tokemon(elsa,1800,115,285,ice,20).             %12

/* Legendary Tokemon 
Komposisi : (health/100) * (attack/100) = +- 150
sp.attack : attack + health/10 */
tokemon(hadimon,7000,210,910,ground,20).
tokemon(mariomon,5000,300,800,fire,20).
tokemon(ajimon,4000,375,775,water,20).
tokemon(danmon,3000,500,800,lightning,20).

/* TOKEMON AWAL 
Komposisi : (health/100) * (attack/100) = +- 40
sp.attack : attack + health/10 */
tokemon(wow,2000,200,400,fire,20).
tokemon(mamet,2000,200,400,water,20).
tokemon(danlap,2000,200,400,leaves,20).
/* TOKEMON DEBUGER */
tokemon(cheatmon,3000,20000,10000,leaves,20).

/* Legendary Tokemon */
legendary(hadimon).
legendary(mariomon).
legendary(ajimon).
legendary(danmon).
/* TOKEMON AWAL*/
awal(wow).
awal(mamet).
awal(danlap).
awal(cheatmon).
/* Type Tokemon */
strong(fire,leaves).
strong(fire,ice).
strong(leaves,water).
strong(leaves,ground).
strong(water,fire).
strong(water,ground).
strong(ice,ground).
strong(ice,leaves).
strong(ground,lightning).
strong(ground,fire).
strong(lightning,water).

/* *************** RULES **************** */
cekToke(Banyak) :-
	findall(T,toke(T,_,_,_,_,_,_),ListBanyak),
	length(ListBanyak,Banyak).

firstPick(A,B,C,D,E,F) :-
    asserta(toke(A,B,C,D,E,F,0)),
    write('Kamu telah berhasil memilih '),write(A),write(' sebagai tokemon pertamamu'),nl,
    write('Game telah dimulai, ada 2 item yang kamu dapatkan : '),nl,
    write('super_attackup - meningkatkan attack tokemon sebanyak 80'),nl,
    write('lemonade - meningkatkan darah tokemon sebanyak 900'),nl,
    write('efek dari item adalah permanen, cara menggunakan: use(namaItem, namaTokemon).'),
    retract(avChoose),
    initialize_map,
    initialize_tokemon,
    initialize_mapitem.

drop(X) :-
	\+(toke(X,_,_,_,_,_,_)),
	write('Tidak ada Tokemon '),write(X),write(' dalam daftar Tokemon kamu.'),nl,
	write('Pastikan nama Tokemon yang kamu masukkan benar.'),nl,!.

drop(X) :-
	cekToke(Y),
	Y > 1,
	retract(toke(X,_,_,_,_,_,_)),
	write('Tokemon '),write(X),write(' berhasil didrop.'),nl,!.
	
drop(X) :-
	cekToke(Y),
	Y =:= 1,
	toke(X,_,_,_,_,_,_),
	write('Kamu tidak dapat melakukan drop pada satu-satunya Tokemon yang kamu punya!'),nl,!.	

/* Jaga-jaga doang */
% addToke(_,_,_,_,_,_) :-
% 	cekToke(Banyak),
% 	(Banyak+1) > 6, 
%     write('Tokemon kamu sudah mencapai batas maksimal.'), nl,
%     write('Kamu harus menge-drop satu Tokemon untuk menangkap Tokemon ini'), nl, !.

addToke(A,B,C,D,E,F) :-
	/*Toke muat*/
	cekToke(Banyak),
	(Banyak+1) =< 6,
	asserta(tokeT(A,B,C,D,E,F,0,1)),
	asserta(exp(A,0)),
	write(A),write(' berhasil kamu bawa dan HP-nya kembali full secara ajaib!'),nl,!.
/*
addToke(A,B,C,D,E) :-
	tokemon(A,B,C,D,E),
	asserta(toke(A,B,C,D,E)),!,
	write('Tokemon '),write(A),write(' berhasil kamu bawa').
*/

initialize_tokemon :-
    asserta(id(zigzagur,1)),
    asserta(id(bulbalul,2)),
    asserta(id(vanila_bluemon,3)),
    asserta(id(toketchur,4)),
    asserta(id(momon,5)),
    asserta(id(engasmon,6)),
    asserta(id(santuymon,7)),
    asserta(id(tankmon,8)),
    asserta(id(konakmon,9)),
    asserta(id(jonatan_jostar,10)),
    asserta(id(pikacrot,11)),
    asserta(id(elsa,12)),
    asserta(id(hadimon,43)),
    asserta(id(mariomon,44)),
    asserta(id(ajimon,45)),
    asserta(id(danmon,46)),
    asserta(id(hadimon,47)),
    asserta(id(mariomon,48)),
    asserta(id(ajimon,49)),
    asserta(id(danmon,50)).  
/* ID dari tokeemon normal 1-10, yg legendary 46-50 */

/* mendapatkan random number, bila number sama dengan ID, maka akan ketemu tokemon */
get_random_number :- randomNum(X),retract(randomNum(X)),get_random_number,!.
get_random_number :- random(1,51,X),asserta(randomNum(X)),!. 
get_normal_number :- randomNum(X),retract(randomNum(X)),get_normal_number,!.
get_normal_number :- random(1,47,X),asserta(randomNum(X)),!.

/* Chance ketemu tokemonnya : 
   Normal Toke : masing" 2% tiap gerakan (total 30%)
   Legendary Toke : masing" 1% tiap gerakan (total 4%)
   Ga ketemu apa apa : 66% */
% Syntax IF ELSE  ::  Y =:= 2 -> (write('hehe'));write('y adl 1').
% Baca : if Y = 2 then write hehe, else write y adl 1

type :-
    write('Tokemon fire kuat melawan leaves dan ice'),nl,
    write('Tokemon leaves kuat melawan water dan ground'),nl,
    write('Tokemon water kuat melawan ground dan fire'),nl,
    write('Tokemon ice kuat melawan ground dan leaves'),nl,
    write('Tokemon ground kuat melawan lightning dan fire'),nl,
    write('Tokemon lightning kuat melawan water'),nl.