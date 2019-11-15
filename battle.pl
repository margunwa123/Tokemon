/* File untuk saat pokemon bertarung */
:- dynamic(inbattle/0).
:- dynamic(lawan/5).
:- dynamic(chosenToke/2).
:- include('map.pl').
:- include('tokemon.pl').
 
pick(X) :- inbattle, toke(X,_,_,_,_), asserta(chosenToke(X,1)), 
           write('You : Saya memilih kamu,"'),write(X),write('"'),nl,nl, life, !.
pick(X) :- inbattle, \+toke(X,_,_,_,_), write('Kamu tidak memiliki pokemon tersebut!'), nl.
pick(X) :- \+ inbattle, write('Kamu tidak sedang bertarung'),nl,!.

attack :- inbattle, chosenToke(X,_), toke(X,_,Att,_,TypeM), lawan(A,HP,B,C,TypeL),
          strong(TypeM, TypeL), Z is div((HP - Att) * 3, 2),
          write('Kamu menyebabkan '), write(Z), write(' damage pada '), write(A),nl,nl   
          retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)),cekhealthL,!.
attack :- inbattle, chosenToke(X,_), toke(X,_,Att,_,TypeM), lawan(A,HP,B,C,TypeL),
          strong(TypeL, TypeM), Z is div((HP - Att), 2), 
          write('Kamu menyebabkan '), write(Z), write(' damage pada '), write(A),nl,nl
          retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)),cekhealthL,!.   
attack :- inbattle, chosenToke(X,_), toke(X,_,Att,_,TypeM), lawan(A,HP,B,C,TypeL),
          Z is (HP - Att), 
          write('Kamu menyebabkan '), write(Z), write(' damage pada '), write(A),nl,nl
          retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)),cekhealthL,!.
attack :- \+ inbattle, write('Kamu tidak sedang bertarung'),nl,!.         

specialAttack :- inbattle, chosenToke(X,1), toke(X,_,_,Skill,TypeM), lawan(A,HP,B,C,TypeL),
                 strong(TypeM, TypeL), Z is div((HP - Skill) * 3, 2),
                 write('Kamu menyebabkan '), write(Z), write(' damage pada '), write(A),nl,nl   
                 retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)),
                 retract(chosenToke(X,1)), asserta(chosenToke(X,0)),cekhealthL,!.              
specialAttack :- inbattle, chosenToke(X,1), toke(X,_,_,Skill,TypeM), lawan(A,HP,B,C,TypeL),
                 strong(TypeL, TypeM), Z is div((HP - Skill), 2),
                 write('Kamu menyebabkan '), write(Z), write(' damage pada '), write(A),nl,nl   
                 retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)),
                 retract(chosenToke(X,1)), asserta(chosenToke(X,0)),cekhealthL,!.
specialAttack :- inbattle, chosenToke(X,1), toke(X,_,_,Skill,TypeM), lawan(A,HP,B,C,TypeL),
                 Z is (HP - Skill),
                 write('Kamu menyebabkan '), write(Z), write(' damage pada '), write(A),nl,nl   
                 retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)),
                 retract(chosenToke(X,1)), asserta(chosenToke(X,0)),cekhealthL,!.
specialAttack :- inbattle, \+chosenToke(X,1), write(X), write(' sudah memakai Skill Attack!'), nl.
specialAttack :- \+ inbattle, write('Kamu tidak sedang bertarung'),nl,!.


attacked :- inbattle, chosenToke(X,_), toke(X,HP,A,B,TypeM), lawan(C,_,Att,_,TypeL),
            strong(TypeM, TypeL), Z is div((HP - Att), 2),
            write(C), write(' menyebabkan'), write(Z), write(' damage pada '), write(X), nl, nl
            retract(toke(X,_,_,_,_)), asserta(toke(X,Z,A,B,TypeM)),cekhealthP,!.            
attacked :- inbattle, chosenToke(X,_), toke(X,HP,A,B,TypeM), lawan(C,_,Att,_,TypeL),
            strong(TypeL, TypeM), Z is div((HP - Att) * 3, 2),
            write(C), write(' menyebabkan'), write(Z), write(' damage pada '), write(X), nl, nl   
            retract(toke(X,_,_,_,_)), asserta(toke(X,Z,A,B,TypeM)),cekhealthP,!.
attacked :- inbattle, chosenToke(X,_), toke(X,HP,A,B,TypeM), lawan(C,_,Att,_,TypeL),
            Z is (HP - Att),
            write(C), write(' menyebabkan'), write(Z), write(' damage pada '), write(X), nl, nl   
            retract(toke(X,_,_,_,_)), asserta(toke(X,Z,A,B,TypeM)),cekhealthP,!. 

life :- chosenToke(X,_), toke(X,HPM,_,_,TypeM), lawan(Y,HPL,_,_,TypeL),
        write(X), write('Health: '), write(HPM), nl,
        write('Type: '), write(TypeM), nl, nl,
        write(Y), write('Health: '), write(HPL), nl,
        write('Type: '), write(TypeL), nl, nl, !.

cekhealthP :- chosenToke(X,_), toke(X,HPM,_,_,_), HPM < 0, 
              write(X), write(' meninggal!'),nl,nl,
              retract(inbattle), retract(chosenToke(X,_)), retract(toke(X,_,_,_,_)),
              cektokemon,!.
cekhealthP :- chosenToke(X,_), toke(X,HPM,_,_,_), HPM > 0, 
              life, !.        

cekhealthL :- lawan(Y,HPL,_,_,_), HPL < 0, 
              write(Y), write(' pingsan! Apakah kamu mau menangkapnya?'),nl,nl,
              retract(inbattle),!.        
cekhealthL :- lawan(Y,HPL,_,_,_), HPL > 0, 
              life, !, attacked.        

cektokemon :- write('Kamu masih memiliki sisa Tokemon!'), nl,
              write('Pilih Tokemon sekarang!'), asserta(inbattle),!.                             
cektokemon :- \+toke(X,_,_,_,_), lose,!.

change(A) :- inbattle, \+ toke(A,_,_,_,_),
             write('Kamu tidak memiliki Tokemon tersebut!'), nl, !.
change(A) :- inbattle, chosenToke(X,_), A =:= X, 
             write('Kamu sedang memakai Tokemon '), write(A), nl, !.
change(A) :- inbattle, chosenToke(X,_), A =/= X,
             write('Kembalilah '), write(A), nl,
             retract(chosenToke(X,_)), asserta(chosenToke(A,_)),
             write('Maju, '), write(A), nl, !.
change(A) :- \+inbattle, write('Kamu tidak sedang bertarung!'),nl,!.


