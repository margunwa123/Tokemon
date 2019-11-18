:- dynamic(item/1).
/*item(Nama) merupakan item milik player*/
:- dynamic(item_number/1).
/* mapitem(ID,raiseAttack,Nama,UpAttack). */
mapitem(11,raiseAttack,choice_band,40).
mapitem(12,raiseAttack,attackup,60).
mapitem(13,raiseAttack,super_attackup,80).
mapitem(14,raiseAttack,hyper_attackup,100).
/*------------------------------------------*/

/* mapitem(ID,raiseSpAttack,Nama,UpSpAttack). */
mapitem(21,raiseSpAttack,calcium,80).
mapitem(22,raiseSpAttack,spattackup,120).
mapitem(23,raiseSpAttack,super_spattackup,160).
mapitem(24,raiseSpAttack,hyper_spattackup,200).
/*------------------------------------------*/

/* mapitem(ID,raiseHP,Nama,UpHP). */
mapitem(31,raiseHP,potion,200).
mapitem(32,raiseHP,super_potion,600).
mapitem(33,raiseHP,lemonade,900).
mapitem(34,raiseHP,hyper_potion,1200).
/*------------------------------------------*/

get_item_number :-
    item_number(X),
    retract(item_number(X)),
    get_item_number,!.
get_item_number :-
    random(1,50,X),
    asserta(item_number(X)),!.

initialize_mapitem :-
    asserta(item(super_attackup)),
    asserta(item(lemonade)).
/* Nama Tokemon (Nama, Hp, Basic Att, Skill Att, Type) */

use(Nama,Toke) :-
    \+ inbattle(1),
    \+ inbattle(0),
    toke(Toke,Hp,Att,Sp,Type,Lvl,Exp),
    item(Nama),
    mapitem(_,Effect,Nama,Num),
    Effect = raiseHP,
    X is Hp + Num,
    retract(toke(Toke,_,_,_,_,_,_)),retract(item(Nama)),
    asserta(toke(Toke,X,Att,Sp,Type,Lvl,Exp)),!.
use(Nama,Toke) :-
    tokeT(Toke,Hp,Att,Sp,Type,Lvl,Exp,_),
    item(Nama),
    mapitem(_,Effect,Nama,Num),
    Effect = raiseHP,
    X is Hp + Num,
    retract(tokeT(Toke,_,_,_,_,_,_,_)),retract(item(Nama)),
    asserta(tokeT(Toke,X,Att,Sp,Type,Lvl,Exp,_)),!.
use(Nama,Toke) :-
    \+ inbattle(1),
    \+ inbattle(0),
    toke(Toke,Hp,Att,Sp,Type,Lvl,Exp),
    item(Nama),
    mapitem(_,Effect,Nama,Num),
    Effect = raiseAttack,
    X is Att + Num,
    retract(toke(Toke,_,_,_,_,Lvl,Exp)),retract(item(Nama)),
    asserta(toke(Toke,Hp,X,Sp,Type,Lvl,Exp)),!.
use(Nama,Toke) :-
    tokeT(Toke,Hp,Att,Sp,Type,Lvl,Exp,_),
    item(Nama),
    mapitem(_,Effect,Nama,Num),
    Effect = raiseAttack,
    X is Att + Num,
    retract(tokeT(Toke,_,_,_,_,Lvl,Exp,_)),retract(item(Nama)),
    asserta(tokeT(Toke,Hp,X,Sp,Type,Lvl,Exp,_)),!.
use(Nama,Toke) :-
    \+ inbattle(1),
    \+ inbattle(0),
    toke(Toke,Hp,Att,Sp,Type,Lvl,Exp),
    item(Nama),
    mapitem(_,Effect,Nama,Num),
    Effect = raiseSpAttack,
    X is Sp + Num,
    retract(toke(Toke,_,_,_,_,_,_)),retract(item(Nama)),
    asserta(toke(Toke,Hp,Att,X,Type,Lvl,Exp)),!.
use(Nama,Toke) :-
    tokeT(Toke,Hp,Att,Sp,Type,Lvl,Exp,_),
    item(Nama),
    mapitem(_,Effect,Nama,Num),
    Effect = raiseSpAttack,
    X is Sp + Num,
    retract(tokeT(Toke,_,_,_,_,_,_,_)),retract(item(Nama)),
    asserta(tokeT(Toke,Hp,Att,X,Type,Lvl,Exp,_)),!.
use(_,Nama) :-
    \+(item(Nama)),
    write('Kamu tidak memiliki item tersebut'),nl,!.
use(Toke,_) :-
    \+(toke(Toke,_,_,_,_,_,_)),
    write('Kamu tidak memiliki toke tersebut'),nl,!.