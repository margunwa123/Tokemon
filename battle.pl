/* File untuk saat tokemon bertarung */
:- dynamic(lawan/5).
:- dynamic(chosenToke/2).
:- dynamic(runorfight/0).
:- dynamic(losing/0).
:- include('tokemon.pl').

% Pemilihan tokemon 
pick(_) :- losing, lose, !.
pick(X) :- 
        \+ losing,
        inbattle(1),
        toke(X,_,_,_,_), asserta(chosenToke(X,1)),
        %battle stage ke 1 yaitu saat bertarung(attack dan attacked) 
        write('You : Saya memilih kamu,"'),write(X),write('"'),nl,nl, life, !.

/* Bingung ini mau digimanain */
% pick(X) :- 
%         \+ losing,
%         inbattle(1),
%         \+toke(X,_,_,_,_), 
%         write('Kamu tidak memiliki pokemon tersebut!, Harap memilih ulang!'), nl, !.
pick(_) :- 
        \+ losing,
        inbattle(1), 
        chosenToke(X,_),
        write('Kamu tidak bisa memilih ulang saat bertarung, harap gunakan "change(X)."'),!.
pick(_) :- 
        \+ losing,
        \+ inbattle(1), 
        write('Kamu tidak sedang bertarung'),nl,!.

attack :- 
        losing, lose, !.
attack :-
        \+ losing,
        inbattle(2),
        write('Tokemonnya sudah pingsan!'), nl,!.
attack :- 
        \+ losing,
        \+ inbattle(1), 
        write('Kamu tidak sedang bertarung'),nl,!.
attack :- 
        \+ losing,
        inbattle(1), 
        chosenToke(X,_), toke(X,_,Att,_,TypeM), lawan(A,HP,B,C,TypeL),
        strong(TypeM, TypeL), D is div(Att * 3, 2), Z is HP - D,
        write('Serangannya sangat efektif!'), nl,
        write('Kamu menyebabkan '), write(D), write(' damage pada '), write(A),nl,nl,   
        retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)), cekhealthL, !.
attack :- 
        \+ losing, 
        inbattle(1),
        chosenToke(X,_), toke(X,_,Att,_,TypeM), lawan(A,HP,B,C,TypeL),
        strong(TypeL, TypeM), D is div(Att, 2), Z is HP - D, 
        write('Serangannya tidak efektif!'), nl, 
        write('Kamu menyebabkan '), write(D), write(' damage pada '), write(A),nl,nl,
        retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)), cekhealthL, !.   
attack :- 
        \+ losing, 
        inbattle(1),
        chosenToke(X,_), toke(X,_,Att,_,_), lawan(A,HP,B,C,TypeL),
        Z is (HP - Att),
        write('Kamu menyebabkan '), write(Att), write(' damage pada '), write(A),nl,nl,
        retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)), cekhealthL, !.

specialAttack :- 
        losing, lose, !.
specialAttack :-
        \+ losing,
        inbattle(2),
        write('Tokemonnya sudah pingsan!'), nl,!.
specialAttack :-
        \+ losing,
        \+ inbattle(1), 
        write('Kamu tidak sedang bertarung'),nl,!.
specialAttack :- 
        \+ losing,
        inbattle(1), 
        chosenToke(X,1), toke(X,_,_,Skill,TypeM), lawan(A,HP,B,C,TypeL),
        strong(TypeM, TypeL), D is div(Skill * 3, 2), Z is HP - D,
        write('Serangannya sangat efektif!'), nl,
        write('Kamu menyebabkan '), write(D), write(' damage pada '), write(A),nl,nl,   
        retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)),
        retract(chosenToke(X,1)), asserta(chosenToke(X,0)), cekhealthL, !.              
specialAttack :- 
        \+ losing,
        inbattle(1), 
        chosenToke(X,1), toke(X,_,_,Skill,TypeM), lawan(A,HP,B,C,TypeL),
        strong(TypeL, TypeM), D is div(Skill, 2), Z is HP - D,
        write('Serangannya tidak efektif!'), nl, 
        write('Kamu menyebabkan '), write(D), write(' damage pada '), write(A),nl,nl,   
        retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)),
        retract(chosenToke(X,1)), asserta(chosenToke(X,0)), cekhealthL, !.
specialAttack :- 
        \+ losing, 
        inbattle(1),
        chosenToke(X,1), toke(X,_,_,Skill,_), lawan(A,HP,B,C,TypeL),
        Z is (HP - Skill),
        write('Kamu menyebabkan '), write(Skill), write(' damage pada '), write(A),nl,nl,   
        retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)),
        retract(chosenToke(X,1)), asserta(chosenToke(X,0)), cekhealthL, !.
specialAttack :- 
        \+ losing, 
        chosenToke(X,N), N =< 1, write(X), write(' sudah memakai Skill Attack!'), nl.

attacked :- 
        chosenToke(X,_), toke(X,HP,A,B,TypeM), lawan(C,_,Att,_,TypeL),
        strong(TypeM, TypeL), D is div(Att, 2), Z is HP - D,
        write('Serangannya tidak efektif!'), nl, 
        write(C), write(' menyebabkan '), write(D), write(' damage pada '), write(X), nl, nl,
        retract(toke(X,_,_,_,_)), asserta(toke(X,Z,A,B,TypeM)), cekhealthP, !.            
attacked :- 
        chosenToke(X,_), toke(X,HP,A,B,TypeM), lawan(C,_,Att,_,TypeL),
        strong(TypeL, TypeM), D is div(Att * 3, 2), Z is HP - D,
        write('Serangannya sangat efektif!'), nl,
        write(C), write(' menyebabkan '), write(D), write(' damage pada '), write(X), nl, nl,   
        retract(toke(X,_,_,_,_)), asserta(toke(X,Z,A,B,TypeM)),cekhealthP, !.
attacked :- 
        chosenToke(X,_), toke(X,HP,A,B,TypeM), lawan(C,_,Att,_,_),
        Z is (HP - Att),
        write(C), write(' menyebabkan '), write(Att), write(' damage pada '), write(X), nl, nl,   
        retract(toke(X,_,_,_,_)), asserta(toke(X,Z,A,B,TypeM)),cekhealthP, !.

life :- 
        chosenToke(X,_), toke(X,HPM,_,_,TypeM), lawan(Y,HPL,_,_,TypeL),
        write(X), nl, write('Health: '), write(HPM), nl,
        write('Type: '), write(TypeM), nl, nl,
        write(Y), nl, write('Health: '), write(HPL), nl,
        write('Type: '), write(TypeL), nl, nl, !.

cekhealthP :- 
        chosenToke(X,_), toke(X,HPM,_,_,_), HPM =< 0, 
        write(X), write(' meninggal!'),nl,nl,
        retract(inbattle(1)),asserta(inbattle(0)), retract(chosenToke(X,_)), retract(toke(X,_,_,_,_)),
        cektokemon,!.
cekhealthP :- 
        chosenToke(X,_), toke(X,HPM,_,_,_), HPM > 0, 
        life, !.        

cekhealthL :- 
        lawan(Y,HPL,_,_,_), HPL =< 0, 
        write(Y), write(' pingsan! Apakah kamu mau menangkapnya?'),nl,nl,
        write('Jika ingin menangkapnya, berikan perintah capture.'),nl,
        write('Jika tidak ingin, berikan perintah nope.'), nl,
        retract(inbattle(1)),asserta(inbattle(2)),!.        
cekhealthL :- 
        lawan(_,HPL,_,_,_), HPL > 0, 
        life, attacked, !.        

capture :-
        \+ losing,
        inbattle(2),
        lawan(X,_,_,_,_), tokemon(X,B,C,D,E), asserta(avChoose), 
        addToke(X,B,C,D,E), retract(lawan(X,_,_,_,_)), 
        retract(inbattle(2)), 
        nl, map, !.

nope :- 
        \+ losing,
        inbattle(2),
        lawan(X,_,_,_,_), 
        write(X), write(' pun sadar'), nl,
        write(X), write('(dalam bahasa Tokemon) : Dasar belagu'), nl,
        write(X), write(' meninggalkan kamu'), nl,
        retract(lawan(X,_,_,_,_)), 
        retract(inbattle(2)), 
        nl, map, !.

cektokemon :- 
        cekToke(Banyak), Banyak > 1, !,
        write('Kamu masih memiliki sisa Tokemon!'), nl,
        write('Sisa Tokemon : ['),
        toke(H,I,J,K,L), write(H),
        retract(toke(H,I,J,K,L)),
        toke(_,_,_,_,_) -> (
                forall(toke(A,_,_,_,_),
                (
                write(','),
                write(A)
                ))
        ),
        write(']'),nl, 
        asserta(toke(H,I,J,K,L)),
        write('Pilih Tokemon sekarang dengan berikan perintah pick(NamaTokemon)'), asserta(inbattle(1)), !.
cektokemon :- 
        cekToke(Banyak), Banyak =:= 1, 
        write('Sisa Tokemon : ['),
        toke(H,_,_,_,_), write(H),
        write(']'),nl,
        asserta(inbattle(1)), !. 
cektokemon :- 
        cekToke(Banyak), Banyak =:= 0, asserta(losing), lose,!.

change(_) :- 
        losing, lose, !.
change(_) :- 
        \+ losing,
        \+ inbattle(1), 
        write('Kamu tidak sedang bertarung!'),nl,!.
change(A) :- 
        \+ losing, 
        inbattle(1), 
        \+(toke(A,_,_,_,_)),
        write('Kamu tidak memiliki Tokemon tersebut!'), nl, !.
change(A) :- 
        \+ losing, 
        inbattle(1), 
        toke(A,_,_,_,_),
        chosenToke(X,_), 
        A =:= X, 
        write('Kamu sedang memakai Tokemon '), write(A), nl, !.
change(A) :- 
        \+ losing, 
        inbattle(1), 
        toke(A,_,_,_,_),
        chosenToke(X,_), 
        A \= X,
        write('Kembalilah '), write(A), nl,
        retract(chosenToke(X,_)), asserta(chosenToke(A,1)),
        write('Maju, '), write(A), nl, !.
