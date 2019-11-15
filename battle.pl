/* File untuk saat pokemon bertarung */
:- dynamic(lawan/5).
:- dynamic(chosenToke/2).
:- include('tokemon.pl').
 
pick(X) :- inbattle, toke(X,_,_,_,_), asserta(chosenToke(X,1)), 
           write('You : Saya memilih kamu,"'),write(X),write('"'),nl,nl, life, !.
pick(X) :- inbattle, \+toke(X,_,_,_,_), write('Kamu tidak memiliki pokemon tersebut!'), nl, !.
pick(_) :- \+ inbattle, write('Kamu tidak sedang bertarung'),nl,!.

attack:-chosenToke(X,_), toke(X,_,Att,_,TypeM), lawan(A,HP,B,C,TypeL),
        strong(TypeM, TypeL), Z is div((HP - Att) * 3, 2),
        write('Kamu menyebabkan '), write(div(Att * 3, 2)), write(' damage pada '), write(A),nl,nl,   
        retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)), cekhealthL, !.
attack:-chosenToke(X,_), toke(X,_,Att,_,TypeM), lawan(A,HP,B,C,TypeL),
        strong(TypeL, TypeM), Z is div((HP - Att), 2), 
        write('Kamu menyebabkan '), write(div(Att, 2)), write(' damage pada '), write(A),nl,nl,
        retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)), cekhealthL, !.   
attack:-chosenToke(X,_), toke(X,_,Att,_,_), lawan(A,HP,B,C,TypeL),
        Z is (HP - Att), 
        write('Kamu menyebabkan '), write(Att), write(' damage pada '), write(A),nl,nl,
        retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)), cekhealthL, !.

specialAttack:-chosenToke(X,1), toke(X,_,_,Skill,TypeM), lawan(A,HP,B,C,TypeL),
               strong(TypeM, TypeL), Z is div((HP - Skill) * 3, 2),
               write('Kamu menyebabkan '), write(Z), write(' damage pada '), write(A),nl,nl,   
               retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)),
               retract(chosenToke(X,1)), asserta(chosenToke(X,0)), cekhealthL, !.              
specialAttack:-chosenToke(X,1), toke(X,_,_,Skill,TypeM), lawan(A,HP,B,C,TypeL),
               strong(TypeL, TypeM), Z is div((HP - Skill), 2),
               write('Kamu menyebabkan '), write(Z), write(' damage pada '), write(A),nl,nl,   
               retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)),
               retract(chosenToke(X,1)), asserta(chosenToke(X,0)), cekhealthL, !.
specialAttack:-chosenToke(X,1), toke(X,_,_,Skill,_), lawan(A,HP,B,C,TypeL),
               Z is (HP - Skill),
               write('Kamu menyebabkan '), write(Z), write(' damage pada '), write(A),nl,nl,   
               retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)),
               retract(chosenToke(X,1)), asserta(chosenToke(X,0)), cekhealthL, !.
specialAttack: - \+(chosenToke(X,1)) , write(X), write(' sudah memakai Skill Attack!'), nl.

attacked:-chosenToke(X,_), toke(X,HP,A,B,TypeM), lawan(C,_,Att,_,TypeL),
          strong(TypeM, TypeL), Z is div((HP - Att), 2),
          write(C), write(' menyebabkan '), write(Z), write(' damage pada '), write(X), nl, nl,
          retract(toke(X,_,_,_,_)), asserta(toke(X,Z,A,B,TypeM)), cekhealthP, !.            
attacked:-chosenToke(X,_), toke(X,HP,A,B,TypeM), lawan(C,_,Att,_,TypeL),
          strong(TypeL, TypeM), Z is div((HP - Att) * 3, 2),
          write(C), write(' menyebabkan '), write(Z), write(' damage pada '), write(X), nl, nl,   
          retract(toke(X,_,_,_,_)), asserta(toke(X,Z,A,B,TypeM)),cekhealthP, !.
attacked:-chosenToke(X,_), toke(X,HP,A,B,TypeM), lawan(C,_,Att,_,_),
          Z is (HP - Att),
          write(C), write(' menyebabkan '), write(Z), write(' damage pada '), write(X), nl, nl,   
          retract(toke(X,_,_,_,_)), asserta(toke(X,Z,A,B,TypeM)),cekhealthP, !. 
life :- chosenToke(X,_), toke(X,HPM,_,_,TypeM), lawan(Y,HPL,_,_,TypeL),
        write(X), nl, write('Health: '), write(HPM), nl,
        write('Type: '), write(TypeM), nl, nl,
        write(Y), nl, write('Health: '), write(HPL), nl,
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
cekhealthL :- lawan(_,HPL,_,_,_), HPL > 0, 
              life, attacked, !.        

cektokemon :- write('Kamu masih memiliki sisa Tokemon!'), nl,
              write('Pilih Tokemon sekarang!'), asserta(inbattle),!.                             
cektokemon :- \+toke(_,_,_,_,_), lose,!.

change(A) :- inbattle, \+ toke(A,_,_,_,_),
             write('Kamu tidak memiliki Tokemon tersebut!'), nl, !.
change(A) :- inbattle, toke(A,_,_,_,_),
             chosenToke(X,_), A =:= X, 
             write('Kamu sedang memakai Tokemon '), write(A), nl, !.
change(A) :- inbattle, toke(A,_,_,_,_),
             chosenToke(X,_), A \= X,
             write('Kembalilah '), write(A), nl,
             retract(chosenToke(X,_)), asserta(chosenToke(A,1)),
             write('Maju, '), write(A), nl, !.
change(_) :- \+inbattle, write('Kamu tidak sedang bertarung!'),nl,!.


