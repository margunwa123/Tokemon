
%save(Filename).
/*mensave file dengan format filename.txt*/
save(_):-
	\+ inGame,
	write('Kamu belum memulai permainan.'),nl,
	write('Silahkan masukkan perintah play. untuk dapat memulai permainan.'),nl,!.
	
save(FileName):-
	write('Kamu berhasil menyimpan dengan nama file: '),write(FileName),
	healonce,
	tell(FileName),
		nLegend(N),
		write(nLegend(N)),write('.'),nl,
		write(healonce),write('.'),nl,
		player(X,Y),
		write(player(X,Y)),write('.'),nl,
		lebarPeta(A),
		write(lebarPeta(A)),write('.'),nl,
		tinggiPeta(B),
		write(tinggiPeta(B)),write('.'),nl,
		writeToke,
		writeItem,
		writeID,
	told,!.
	
save(FileName):-
	tell(FileName),
		nLegend(N),
		write(nLegend(N)),write('.'),nl,
		player(X,Y),
		write(player(X,Y)),write('.'),nl,
		lebarPeta(A),
		write(lebarPeta(A)),write('.'),nl,
		tinggiPeta(B),
		write(tinggiPeta(B)),write('.'),nl,
		writeToke,
		writeItem,
		writeID,
	told, !.

%load(Filename).
/*load file dengan format filename.txt*/
loads(_) :-
	inGame,
	write('Kamu sedang berada dalam permainan, silahkan keluar dulu untuk dapat memulai permainan yang lain.'),nl,!.
loads(FileName):-
	\+file_exists(FileName),
	write('File yang dimaksud tidak ada, ketikkan nama file dengan benar.'),nl,!.
loads(FileName):-
	open(FileName, read, Str),
    read_file_lines(Str,Lines),
    close(Str),
    assertaList(Lines),
	asserta(inGame),
	write('File '),write(FileName),write(' berhasil di-load'),nl,!.

/* Write */
writeToke:-
	\+toke(_,_,_,_,_,_,_),
	!.

writeToke :-
	forall(toke(A,B,C,D,E,F,G),(
		write(toke(A,B,C,D,E,F,G)),write('.'),nl
	)), !.

writeItem :-
	\+item(_),
	!.

writeItem :-
	forall(item(X), (
		write(item(X)),write('.'),nl
	)), !.

writeID :-
	\+id(_,_),
	!.

writeID :-
	forall(id(X,Y), (
		write(id(X,Y)),write('.'),nl
	)),!.

/* Membaca file menjadi list of lines */
read_file_lines(Stream,[]) :-
    at_end_of_stream(Stream).

read_file_lines(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read(Stream,X),
    read_file_lines(Stream,L).	

/* 	assertaList(ListFakta)
	meng-asserta semua fakta dalam ListFakta  */	
assertaList([]) :- !.

assertaList([X|L]):-
	asserta(X),
	assertaList(L), !.
