:- dynamic(toke/5).
:- dynamic(avChoose/1).
/* ************* FAKTA *************** */
/* Nama Tokemon (Nama, Hp, Basic Att, Skill Att, Type) */
/* Normal Tokemon */
tokemon(zigzogaan,1500,100,200,water).
tokemon(bulbasaur,2000,50,100,leaf).
tokemon(blue_eyes_white_dragonmon,1700,130,200,fire).
tokemon(toketchur,1200,150,250,fire).
tokemon(momon,2000,60,90,leaf).
tokemon(engasmon,1000,180,300,water).
/* Legendary Tokemon */
tokemon(hadimon,7000,250,500,water).
tokemon(mariomon,5000,350,700,fire).
tokemon(ajimon,6000,300,600,leaf).
tokemon(danmon,6500,250,700,water).
legendary(hadimon).
legendary(mariomon).
legendary(ajimon).
legendary(danmon).
/* Tokemon Awal */
tokemona(wow,2000,100,100,fire).
tokemona(mamet,2000,100,100,water).
tokemona(danlap,2000,100,100,leaf).
%tokemona().
%tokemona().

/* Type Tokemon */
strong(fire,leaves).
strong(leaves,water).
strong(water,fire).

/* *************** RULES **************** */
cekToke(Banyak) :-
	findall(T,toke(T,_,_,_,_),ListBanyak),
	length(ListBanyak,Banyak).

addToke(_,_,_,_,_) :-
	cekToke(Banyak),
	(Banyak+1) > 6,!,
	write('Tokemon kamu sudah mencapai batas maksimal.'),fail.
	
addToke(A,B,C,D,E) :-
	/*Toke muat*/
	tokemona(A,B,C,D,E),
	asserta(toke(A,B,C,D,E)),!,
	write('Tokemon '),write(A),write(' berhasil kamu bawa'),
	retract(avChoose(1)).