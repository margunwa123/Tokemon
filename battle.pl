/* File untuk saat tokemon bertarung */
:- dynamic(lawan/6).
:- dynamic(chosenToke/1).
:- dynamic(runorfight/0).
:- dynamic(losing/0).
:- include('tokemon.pl').

% Pemilihan tokemon 
pick(_) :- losing, lose, !.
pick(X) :- 
        inbattle(1),
        tokeT(X,_,_,_,_,_,_,_), asserta(chosenToke(X)),
        %battle stage ke 1 yaitu saat bertarung(attack dan attacked) 
        write('You : Saya memilih kamu,"'),write(X),write('"'),nl,nl, life, !.
pick(X) :- 
        inbattle(1),
        \+tokeT(X,_,_,_,_,_,_,_), 
        write('Kamu tidak memiliki pokemon tersebut!, Harap memilih ulang!'), nl, !.
/* Bingung ini mau digimanain */
% pick(_) :- 
%         inbattle(1), 
%         chosenToke(X,_),
%         write('Kamu tidak bisa memilih ulang saat bertarung, harap gunakan "change(X)."'),!.
pick(_) :- 
        \+ inbattle(1), 
        write('Kamu tidak sedang bertarung'),nl,!.

/* Tokemon sendiri menyerang lawan */
attack :- 
        losing, /* jika sudah kalah */ 
        lose, !.
attack :- 
        inbattle(2), /* jika sudah mengalahkan tokemon lawan */
        write('Tokemonnya sudah pingsan!'), nl,!.
attack :- 
        \+ inbattle(1), /* jika belum ketemu lawan */
        write('Kamu tidak sedang bertarung'),nl,!.
attack :- 
        inbattle(1), /* jika ketemu lawan */
        chosenToke(X), tokeT(X,_,Att,_,TypeM,_,_,_), lawan(A,HP,B,C,TypeL,E),
        exp(X,F),
        strong(TypeM, TypeL), /* jika tokemon sendiri tipenya lebih kuat dari lawan */
        D is div(Att * 3, 2), 
        Z is HP - D, /* mengganti HP Lawan karena di-attack */
        G is F + div(D, 10), /* menambahkan exp sebesar 10% damage ke tokemon yang menyerang */
        retract(exp(X,F)), asserta(exp(X,G)),
        write('Serangannya sangat efektif!'), nl,
        write('Kamu menyebabkan '), write(D), write(' damage pada '), write(A),nl,nl,   
        retract(lawan(_,_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL,E)), cekhealthL, !.
attack :- 
        inbattle(1), /* jika ketemu lawan */
        chosenToke(X), tokeT(X,_,Att,_,TypeM,_,_,_), lawan(A,HP,B,C,TypeL,E),
        exp(X,F),
        strong(TypeL, TypeM), /* jika tokemon sendiri tipenya lebih lemah dari lawan */
        D is div(Att, 2), 
        Z is HP - D, /* mengganti HP Lawan karena di-attack */
        G is F + div(D, 10), /* menambahkan exp sebesar 10% damage ke tokemon yang menyerang */
        retract(exp(X,F)), asserta(exp(X,G)), 
        write('Serangannya tidak efektif!'), nl, 
        write('Kamu menyebabkan '), write(D), write(' damage pada '), write(A),nl,nl,
        retract(lawan(_,_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL,E)), cekhealthL, !.   
attack :- 
        inbattle(1), /* jika ketemu lawan */
        chosenToke(X), tokeT(X,_,Att,_,_,_,_,_), lawan(A,HP,B,C,TypeL,E),
        exp(X,F),
        D is Att, 
        Z is HP - D, /* mengganti HP Lawan karena di-attack */
        G is F + div(D, 10), /* menambahkan exp sebesar 10% damage ke tokemon yang menyerang */
        retract(exp(X,F)), asserta(exp(X,G)),
        write('Kamu menyebabkan '), write(Att), write(' damage pada '), write(A),nl,nl,
        retract(lawan(_,_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL,E)), cekhealthL, !.

/* Tokemon sendiri menyerang lawan dengan Special Attack */
specialAttack :- 
        losing, /* jika sudah kalah */ 
        lose, !.
specialAttack :-
        inbattle(2), /* jika sudah mengalahkan tokemon lawan */
        write('Tokemonnya sudah pingsan!'), nl,!.
specialAttack :-
        \+ inbattle(1), /* jika belum ketemu lawan */
        write('Kamu tidak sedang bertarung'), nl,!.
specialAttack :- 
        inbattle(1), /* jika ketemu lawan */
        chosenToke(X), tokeT(X,P,Q,Skill,TypeM,R,S,1), lawan(A,HP,B,C,TypeL,E),
        exp(X,F),
        strong(TypeM, TypeL), /* jika tokemon sendiri tipenya lebih kuat dari lawan */ 
        D is div(Skill * 3, 2), 
        Z is HP - D, /* mengganti HP Lawan karena di-attack */
        G is F + div(D, 10), /* menambahkan exp sebesar 10% damage ke tokemon yang menyerang */
        retract(exp(X,F)), asserta(exp(X,G)),
        write('Serangannya sangat efektif!'), nl,
        write('Kamu menyebabkan '), write(D), write(' damage pada '), write(A),nl,nl,   
        retract(lawan(_,_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL,E)),
        retract(tokeT(X,_,_,_,_,_,_,_)), 
        asserta(tokeT(X,P,Q,Skill,TypeM,R,S,0)), /* mengubah jumlah Special Attack satu Tokemon karena digunakan */
        cekhealthL, !.              
specialAttack :- 
        inbattle(1), /* jika ketemu lawan */
        chosenToke(X), tokeT(X,P,Q,Skill,TypeM,R,S,1), lawan(A,HP,B,C,TypeL,E),
        exp(X,F),
        strong(TypeL, TypeM), /* jika tokemon sendiri tipenya lebih lemah dari lawan */ 
        D is div(Skill, 2), 
        Z is HP - D, /* mengganti HP Lawan karena di-attack */
        G is F + div(D, 10), /* menambahkan exp sebesar 10% damage ke tokemon yang menyerang */
        retract(exp(X,F)), asserta(exp(X,G)),
        write('Serangannya tidak efektif!'), nl, 
        write('Kamu menyebabkan '), write(D), write(' damage pada '), write(A),nl,nl,   
        retract(lawan(_,_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL,E)),
        retract(tokeT(X,_,_,_,_,_,_,_)), 
        asserta(tokeT(X,P,Q,Skill,TypeM,R,S,0)), /* mengubah jumlah Special Attack satu Tokemon karena digunakan */
        cekhealthL, !.
specialAttack :-  
        inbattle(1),
        chosenToke(X), tokeT(X,P,Q,Skill,TypeM,R,S,1), lawan(A,HP,B,C,TypeL,E),
        exp(X,F),
        D is Skill, 
        Z is HP - D, /* mengganti HP Lawan karena di-attack */
        G is F + div(D, 10), /* menambahkan exp sebesar 10% damage ke tokemon yang menyerang */
        retract(exp(X,F)), asserta(exp(X,G)),
        write('Kamu menyebabkan '), write(Skill), write(' damage pada '), write(A),nl,nl,   
        retract(lawan(_,_,_,_,_,_)), asserta(lawan(A,Z,B,C,TypeL,E)),
        retract(tokeT(X,_,_,_,_,_,_,_)), 
        asserta(tokeT(X,P,Q,Skill,TypeM,R,S,0)), /* mengubah jumlah Special Attack satu Tokemon karena digunakan */
        cekhealthL, !.
specialAttack :-  
        chosenToke(X), 
        tokeT(X,_,_,_,_,_,_,0), /* jika jumlah Special Attack Tokemon-nya udah habis */
        write(X), write(' sudah memakai Skill Attack!'), nl.

attacked :- 
        chosenToke(X), tokeT(X,HP,A,B,TypeM,E,F,G), lawan(C,_,Att,_,TypeL,_),
        exp(X,L),
        strong(TypeM, TypeL), /* jika tipe lawan lebih lemah dari Tokemon sendiri */
        D is div(Att, 2), 
        Z is HP - D, /* mengganti HP Tokemon sendiri karena diserang */
        M is L + div(D, 15), /* menambahkan exp sebesar 6.67% damage ke tokemon yang menyerang */
        retract(exp(X,L)), asserta(exp(X,M)),
        write('Serangannya tidak efektif!'), nl, 
        write(C), write(' menyebabkan '), write(D), write(' damage pada '), write(X), nl, nl,
        retract(tokeT(X,_,_,_,_,_,_,_)), asserta(tokeT(X,Z,A,B,TypeM,E,F,G)), cekhealthP, !.            
attacked :- 
        chosenToke(X), tokeT(X,HP,A,B,TypeM,E,F,G), lawan(C,_,Att,_,TypeL,_),
        exp(X,L),
        strong(TypeL, TypeM), /* jika tipe lawan lebih kuat dari Tokemon sendiri */
        D is div(Att * 3, 2), 
        Z is HP - D, /* mengganti HP Tokemon sendiri karena diserang */
        M is L + div(D, 15), /* menambahkan exp sebesar 6.67% damage ke tokemon yang menyerang */
        retract(exp(X,L)), asserta(exp(X,M)),
        write('Serangannya sangat efektif!'), nl,
        write(C), write(' menyebabkan '), write(D), write(' damage pada '), write(X), nl, nl,   
        retract(tokeT(X,_,_,_,_,_,_,_)), asserta(tokeT(X,Z,A,B,TypeM,E,F,G)),cekhealthP, !.
attacked :- 
        chosenToke(X), tokeT(X,HP,A,B,TypeM,E,F,G), lawan(C,_,Att,_,_,_),
        exp(X,L),
        D is Att, 
        Z is HP - Att, /* mengganti HP Tokemon sendiri karena diserang */
        M is L + div(D, 15), /* menambahkan exp sebesar 6.67% damage ke tokemon yang menyerang */
        retract(exp(X,L)), asserta(exp(X,M)),
        write(C), write(' menyebabkan '), write(Att), write(' damage pada '), write(X), nl, nl,   
        retract(tokeT(X,_,_,_,_,_,_,_)), asserta(tokeT(X,Z,A,B,TypeM,E,F,G)),cekhealthP, !.

/* Menghasilkan status pertarungan ke layar */
life :- 
        chosenToke(X), tokeT(X,HPP,_,_,TypeP,LevelP,_,_), lawan(Y,HPL,_,_,TypeL,LevelL),
        write(X), nl, 
        write('Health: '), write(HPP), nl,
        write('Type  : '), write(TypeP), nl, 
        write('Level : '), write(LevelP), nl, nl,
        write(Y), nl, 
        write('Health: '), write(HPL), nl,
        write('Type  : '), write(TypeL), nl, 
        write('Level : '), write(LevelL), nl, nl, !.

/* Mengecek HP Player */
cekhealthP :- 
        chosenToke(X), tokeT(X,HPP,_,_,_,_,_,_), 
        HPP =< 0, /* jika HP-nya sudah <= 0 */
        write(X), write(' meninggal!'),nl,nl,
        retract(inbattle(1)),asserta(inbattle(0)), 
        retract(chosenToke(X)), /* menhapus tokemon X dari list-list */ 
        retract(tokeT(X,_,_,_,_,_,_,_)),
        retract(toke(X,_,_,_,_,_,_)),
        retract(exp(X,_)),
        cektokemon,!.
cekhealthP :- 
        chosenToke(X), tokeT(X,HPP,_,_,_,_,_,_), 
        HPP > 0, /* jika HP-nya tetap > 0 */ 
        life, !.        

/* Mengecek HP Lawan */
cekhealthL :- 
        lawan(Y,HPL,_,_,_,_), 
        HPL =< 0, /* Jika HP Lawan sudah <= 0 */
        write(Y), write(' pingsan! Apakah kamu mau menangkapnya?'),nl,nl,
        write('Jika ingin menangkapnya, berikan perintah capture.'),nl,
        write('Jika tidak ingin, berikan perintah nope.'), nl,
        retract(inbattle(1)),
        asserta(inbattle(2)), /* Masuk ke situasi menang dari lawan */
        !.        
cekhealthL :- 
        lawan(X,HPL,_,_,_,_), 
        HPL > 0, /* Jika HP Lawan masih > 0 */ 
        life,
        tab,tab,write('       . . .'), nl, sleep(0.5), /* menampilkan efek loading */
        tab,tab,write('       . . .'), nl, sleep(0.5),
        tab,tab,write('       . . .'), sleep(0.5), nl, nl,
        write(X), write(' menyerang!'), nl, 
        attacked, !.        

/* Menangkap Tokemon liar */
capture :-
        \+ losing, /* jika belum kalah Game */
        inbattle(2), /* jika dalam situasi menang dalam pertarungan */
        lawan(X,_,_,_,_,_), tokemon(X,B,C,D,E,F), asserta(avChoose), 
        addToke(X,B,C,D,E,F), retract(lawan(X,_,_,_,_,_)), 
        retract(inbattle(2)), naikexp, retract(id(X,_)),
        nl, map, !.

/* Menolak untuk menangkap Tokemon Liar */
nope :- 
        \+ losing, /* jika belum kalah Game */
        inbattle(2), /* jika dalam situasi menang dalam pertarungan */
        lawan(X,_,_,_,_,_), /* ini bisa dingertiin sendiri lah ya */
        write(X), write(' pun sadar'), nl,
        write(X), write('(dalam bahasa Tokemon) : Dasar belagu'), nl,
        write(X), write(' meninggalkan kamu'), nl,
        retract(lawan(X,_,_,_,_,_)), 
        retract(inbattle(2)), naikexp,
        nl, map, !.

/* Mengecek tokemon sisa setelah ada Tokemon yang mati */
cektokemon :- 
        cekToke(Banyak), Banyak > 1, !,
        write('Kamu masih memiliki sisa Tokemon!'), nl,
        write('Sisa Tokemon : ['),
        toke(H,I,J,K,L,M,N), write(H),
        retract(toke(H,I,J,K,L,M,N)),
        toke(_,_,_,_,_,_,_) -> (
                forall(toke(A,_,_,_,_,_,_),
                (
                write(','),
                write(A)
                ))
        ),
        write(']'),nl, 
        asserta(toke(H,I,J,K,L,M)),
        write('Pilih Tokemon sekarang dengan berikan perintah pick(NamaTokemon)'), asserta(inbattle(1)), !.
cektokemon :- 
        cekToke(Banyak), Banyak =:= 1, 
        write('Sisa Tokemon : ['),
        toke(H,_,_,_,_,_,_), write(H),
        write(']'),nl,
        asserta(inbattle(1)), !. 
cektokemon :- 
        cekToke(Banyak), Banyak =:= 0, asserta(losing), lose,!.

/* Mengganti Tokemon di tengah pertarungan */
change(_) :- 
        losing, lose, !.
change(_) :- 
        \+ losing,
        \+ inbattle(1), 
        write('Kamu tidak sedang bertarung!'),nl,!.
change(A) :- 
        \+ losing, 
        inbattle(1), 
        \+(toke(A,_,_,_,_,_,_)),
        write('Kamu tidak memiliki Tokemon tersebut!'), nl, !.
change(A) :- 
        \+ losing, 
        inbattle(1), 
        toke(A,_,_,_,_,_,_),
        chosenToke(X), 
        A \= X,
        write('Kembalilah '), write(X), nl,
        retract(chosenToke(X)), asserta(chosenToke(A)),
        write('Maju, '), write(A), nl, !.
change(A) :- 
        \+ losing, 
        inbattle(1), 
        toke(A,_,_,_,_,_,_),
        chosenToke(X), 
        write('Kamu sedang memakai Tokemon '), write(A), nl, !.

/* Setelah pertarungan selesai, tiap tokemon akan bertambah exp dan mungkin level up */
naikexp :- 
        toke(_,_,_,_,_,_,_) -> (
                forall(toke(A,B,C,D,E,F,G),
                (
                exp(A,L),
                
                (L > 0 
                ->
                write(A), write(' bertambah exp sebesar '), write(L), nl,
                M is G + L,
                N is F * 50,
                        (N =< M
                        -> P is F + 1,
                           Q is M - N,
                           R is div(B * 11, 10),
                           S is div(C * 11, 10),
                           T is div(D * 11, 10),
                           write(A), write(' level up menjadi '), write(P), nl,
                           asserta(toke(A,R,S,T,E,P,Q));
                           asserta(toke(A,B,C,D,E,F,M))
                        );
                M is G + L,
                N is F * 50,        
                        (N =< M
                        -> P is F + 1,
                           Q is M - N,
                           R is div(B * 11, 10),
                           S is div(C * 11, 10),
                           T is div(D * 11, 10),
                           write(A), write(' level up menjadi '), write(P), nl,
                           asserta(toke(A,R,S,T,E,P,Q));
                           asserta(toke(A,B,C,D,E,F,M))
                        )        
                )       
                ))
        ),
        retractall(exp(_,_)), retractall(tokeT(_,_,_,_,_,_,_,_)), !.
        