:- dynamic(toke/5).
:- dynamic(avChoose/0).
:- dynamic(randomNum/1).
:- dynamic(id/2).
:- include('gui.pl').
/* ************* FAKTA *************** */
/* Nama Tokemon (Nama, Hp, Basic Att, Skill Att, Type, Level) */
/* Normal Tokemon 
Komposisi : (health/100) * (attack/100) = +- 20
sp.attack : attack + health/10 */
tokemon(zigzogaan,1500,130,280,water,20).      %1
tokemon(bulbasaur,2000,100,300,leaves,20).     %2
tokemon(vanila_bluemon,1700,115,285,fire,20).  %3
tokemon(toketchur,1200,160,280,fire,20).       %4
tokemon(momon,1300,150,280,leaves,20).         %5
tokemon(engasmon,1269,169,269,water,20).       %6
tokemon(santuymon,1500,120,270,fire,20).       %7
tokemon(tankmon,2500,80,330,leaves,20).        %8
tokemon(konakmon,1000,200,300,water,20).        %9
tokemon(jonatan_jostar,2100,100,300,fire,20).  %10

/* Legendary Tokemon 
Komposisi : (health/100) * (attack/100) = +- 50
sp.attack : attack + health/10 */
tokemon(hadimon,7000,250,950,water,20).
tokemon(mariomon,5000,350,850,fire,20).
tokemon(ajimon,6000,300,900,leaves,20).
tokemon(danmon,6500,250,900,water,20).

/* TOKEMON AWAL 
Komposisi : (health/100) * (attack/100) = +- 40
sp.attack : attack + health/10 */
tokemon(wow,2000,200,400,fire,20).
tokemon(mamet,2000,200,400,water,20).
tokemon(danlap,2000,200,400,leaves,20).
tokemon(cheatmon,3000,10000,10000,leaves,20).

/* Nama Attack & Skill Attack tiap Tokemon */
nama(zigzogaan, bebola_air).
nama(bulbasaur, bebola_daun).
nama(vanila_bluemon, bebola_api).
nama(toketchur, smash_api).

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
strong(leaves,water).
strong(water,fire).

/* *************** RULES **************** */
cekToke(Banyak) :-
	findall(T,toke(T,_,_,_,_,_,_),ListBanyak),
	length(ListBanyak,Banyak).

cekLegend(Banyak) :-
	legendary(X),
	findall(X,toke(X,_,_,_,_,_,_),ListBanyak),
	length(ListBanyak,Banyak),!.

firstPick(A,B,C,D,E,F) :-
    asserta(toke(A,B,C,D,E,F,0)),
    write('Kamu telah berhasil memilih '),write(A),write(' sebagai tokemon pertamamu'),nl,
    write('Game telah dimulai'), 
    retract(avChoose),
    initialize_map,
    initialize_tokemon,
    initialize_mapitem.

dropToke(X) :-
	\+(toke(X,_,_,_,_,_,_)),
	write('Tidak ada Tokemon '),write(X),write(' dalam daftar Tokemon kamu.'),nl,
	write('Pastikan nama Tokemon yang kamu masukkan benar.'),nl,!.

dropToke(X) :-
	cekToke(Y),
	Y > 1,
	toke(X,_,_,_,_,_,_),
	retract(toke(X,_,_,_,_,_,_)),
	write('Tokemon '),write(X),write(' berhasil didrop.'),nl,!.
	
dropToke(X) :-
	cekToke(Y),
	Y =:= 1,
	toke(X,_,_,_,_,_,_),
	write('Kamu tidak dapat melakukan drop pada satu-satunya Tokemon yang kamu punya!'),nl,!.	

addToke(_,_,_,_,_,_) :-
	cekToke(Banyak),
	(Banyak+1) > 6,!,
	write('Tokemon kamu sudah mencapai batas maksimal.'),fail.

addToke(A,B,C,D,E,F) :-
	/*Toke muat*/
	cekToke(Banyak),
	(Banyak+1) =< 6,
	tokemon(A,B,C,D,E,F),
	asserta(toke(A,B,C,D,E,F,0)),!,
	write(A),write(' berhasil kamu bawa dan HP-nya kembali full secara ajaib!'),
	retract(avChoose).
/*
addToke(A,B,C,D,E) :-
	tokemon(A,B,C,D,E),
	asserta(toke(A,B,C,D,E)),!,
	write('Tokemon '),write(A),write(' berhasil kamu bawa').
*/

initialize_tokemon :-
    asserta(id(zigzogaan,1)),
    asserta(id(bulbasaur,2)),
    asserta(id(vanila_bluemon,3)),
    asserta(id(toketchur,4)),
    asserta(id(momon,5)),
    asserta(id(engasmon,6)),
    asserta(id(santuymon,7)),
    asserta(id(tankmon,8)),
    asserta(id(konakmon,9)),
    asserta(id(jonatan_jostar,10)),
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
