:- dynamic(toke/5).
:- dynamic(avChoose/0).
:- dynamic(randomNum/1).
:- dynamic(id/2).
/* ************* FAKTA *************** */
/* Nama Tokemon (Nama, Hp, Basic Att, Skill Att, Type) */
/* Normal Tokemon */
tokemon(zigzogaan,1500,100,200,water).
tokemon(bulbasaur,2000,50,100,leaf).
tokemon(vanila_bluemon,1700,130,200,fire).
tokemon(toketchur,1200,150,250,fire).
tokemon(momon,2000,60,90,leaf).
tokemon(engasmon,1000,180,300,water).
tokemon(hadimon,7000,250,500,water).
tokemon(mariomon,5000,350,700,fire).
tokemon(ajimon,6000,300,600,leaf).
tokemon(danmon,6500,250,700,water).
tokemon(wow,2000,100,100,fire).
tokemon(mamet,2000,100,100,water).
tokemon(danlap,2000,100,100,leaf).
/* Legendary Tokemon */
legendary(hadimon).
legendary(mariomon).
legendary(ajimon).
legendary(danmon).
/* Tokemon Awal */
awal(wow).
awal(mamet).
awal(danlap).

/* Type Tokemon */
strong(fire,leaves).
strong(leaves,water).
strong(water,fire).

/* *************** RULES **************** */
cekToke(Banyak) :-
	findall(T,toke(T,_,_,_,_),ListBanyak),
	length(ListBanyak,Banyak).
/*
cekLegend(Banyak) :-
	findall(legendary(X),toke(X,_,_,_,_),ListBanyak),
	length(ListBanyak,Banyak).
*/
firstPick(A,B,C,D,E) :-
    asserta(toke(A,B,C,D,E)),
    write('Kamu telah berhasil memilih '),write(A),write(' sebagai tokemon pertamamu'),nl,
    write('Game telah dimulai'),
    initialize_map,
    asserta(inGame).

addToke(_,_,_,_,_) :-
	cekToke(Banyak),
	(Banyak+1) > 6,!,
	write('Tokemon kamu sudah mencapai batas maksimal.'),fail.

addToke(A,B,C,D,E) :-
	/*Toke muat*/
	tokemon(A,B,C,D,E),
	asserta(toke(A,B,C,D,E)),!,
	write('Tokemon '),write(A),write(' berhasil kamu bawa'),
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
    asserta(id(hadimon,47)),
    asserta(id(mariomon,48)),
    asserta(id(ajimon,49)),
    asserta(id(danmon,50)).  
/* ID dari tokeemon normal 1-15, yg legendary 46-50 */

/* mendapatkan random number, bila number sama dengan ID, maka akan ketemu tokemon */
get_random_number :- randomNum(X),retract(randomNum(X)),get_random_number,!.
get_random_number :- random(1,51,X),asserta(randomNum(X)),!. 
random_reroll :- 
    randomNum(X), 
    X > 46, 
    random(1,3,Y),
    Y =:= 2 -> ( get_random_number ),!.
random_reroll :- write(''),!.
/* Chance ketemu tokemonnya : 
   Normal Toke : masing" 2% tiap gerakan (total 30%)
   Legendary Toke : masing" 1% tiap gerakan (total 4%)
   Ga ketemu apa apa : 66% */
% Syntax IF ELSE  ::  Y =:= 2 -> (write('hehe'));write('y adl 1').
% Baca : if Y = 2 then write hehe, else write y adl 1
