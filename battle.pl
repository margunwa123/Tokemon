/* File untuk saat pokemon bertarung */
:- dynamic(inbattle/0).
:- dynamic(lawan/5).
:- dynamic(chosenToke/2).
:- include('map.pl').
:- include('tokemon.pl').
 
pick(X):-toke(X,_,_,_,_), asserta(chosenToke(X,1)), 
         write('You : Saya memilih kamu,"'),write(X),write('"'),nl,nl,!.
pick(X):-\+toke(X,_,_,_,_), write('Kamu tidak memiliki pokemon tersebut!'), nl.

attack:-chosenToke(X,_), toke(X,_,Att,_,TypeM), lawan(A,HP,B,C,TypeL),
        strong(TypeM, TypeL), Z is div((HP - Att) * 3, 2),
        write('Kamu menyebabkan '), write(Z), write(' damage pada '), write(A),nl,nl   
        retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)),!.
attack:-chosenToke(X,_), toke(X,_,Att,_,TypeM), lawan(A,HP,B,C,TypeL),
        strong(TypeL, TypeM), Z is div((HP - Att), 2), 
        write('Kamu menyebabkan '), write(Z), write(' damage pada '), write(A),nl,nl
        retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)),!.   
attack:-chosenToke(X,_), toke(X,_,Att,_,TypeM), lawan(A,HP,B,C,TypeL),
        Z is (HP - Att), 
        write('Kamu menyebabkan '), write(Z), write(' damage pada '), write(A),nl,nl
        retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)),!.

specialAttack:-chosenToke(X,1), toke(X,_,_,Skill,TypeM), lawan(A,HP,B,C,TypeL),
               strong(TypeM, TypeL), Z is div((HP - Skill) * 3, 2),
               write('Kamu menyebabkan '), write(Z), write(' damage pada '), write(A),nl,nl   
               retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)),
               retract(chosenToke(X,1)), asserta(chosenToke(X,0)),!.              
specialAttack:-chosenToke(X,1), toke(X,_,_,Skill,TypeM), lawan(A,HP,B,C,TypeL),
               strong(TypeL, TypeM), Z is div((HP - Skill), 2),
               write('Kamu menyebabkan '), write(Z), write(' damage pada '), write(A),nl,nl   
               retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)),
               retract(chosenToke(X,1)), asserta(chosenToke(X,0)),!.
specialAttack:-chosenToke(X,1), toke(X,_,_,Skill,TypeM), lawan(A,HP,B,C,TypeL),
               Z is (HP - Skill),
               write('Kamu menyebabkan '), write(Z), write(' damage pada '), write(A),nl,nl   
               retract(lawan(_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL)),
               retract(chosenToke(X,1)), asserta(chosenToke(X,0)),!.
specialAttack:-\+chosenToke(X,1), write(X), write(' sudah memakai Skill Attack!'), nl.

attacked:-chosenToke(X,_), toke(X,HP,A,B,TypeM), lawan(C,_,Att,_,TypeL),
          strong(TypeM, TypeL), Z is div((HP - Att), 2),
          write(C), write(' menyebabkan'), write(Z), write(' damage pada '), write(X), nl, nl
          retract(toke(X,_,_,_,_)), asserta(toke(X,Z,A,B,TypeM)),!.            
attacked:-chosenToke(X,_), toke(X,HP,A,B,TypeM), lawan(C,_,Att,_,TypeL),
          strong(TypeL, TypeM), Z is div((HP - Att) * 3, 2),
          write(C), write(' menyebabkan'), write(Z), write(' damage pada '), write(X), nl, nl   
          retract(toke(X,_,_,_,_)), asserta(toke(X,Z,A,B,TypeM)),!.
attacked:-chosenToke(X,_), toke(X,HP,A,B,TypeM), lawan(C,_,Att,_,TypeL),
          Z is (HP - Att),
          write(C), write(' menyebabkan'), write(Z), write(' damage pada '), write(X), nl, nl   
          retract(toke(X,_,_,_,_)), asserta(toke(X,Z,A,B,TypeM)),!. 

life:-chosenToke(X,_), toke()                 

