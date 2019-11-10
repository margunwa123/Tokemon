:- dynamic(avChoose/1).
:- dynamic(toke/5).
:- dynamic(player/2).
:- include('tokemon.pl').
:- include('map.pl').

/* Tampilan Awal */
start :-
	write('  ____  _____  _  _  ____  __  __  _____  _  _ '),nl,
	write(' |_  _||  _  || |/ || ___||  \\/  ||  _  || \\| | '),nl,
	write('   ||   ||_||  |  |  |__|  |    |  ||_||  |  | '),nl,    
	write('  |__| |_____||_|\\_||____||_/\\/\\_||_____||_|\\_| '),nl,   
	write('  ____  ____  _____     _     __    _____  ___  '),nl,  
	write(' |  _ \\|  _ \\|  _  |   | |   |  |  |  _  |/ __| '),nl,   
	write('  |___/ |   / ||_||    /_\\/   ||__  ||_||| |_-. '),nl, 
	write(' |__|  |_|\\_||_____|  |__/\\  |____||_____|\\___/ '),nl,nl,
	write('Selamat Datang di Game Tokemon!'),nl,
	write('Silahkan ketikkan command berikut untuk memberi perintah'),nl,
	write('1. play'),nl,
	write('2. load'),nl,
	write('3. save'),nl,
	write('Perhatikan untuk selalu memberikan tanda titik(.) di akhir command.'),nl,!.
	
%Command
/* Belum kelar
loads(_) :-
	gameMain(_),
	write('Kamu sedang berada dalam permainan, silahkan keluar dulu untuk dapat memulai permainan yang lain.'),nl,!.
loads(FileName):-
	\+file_exists(FileName),
	write('File yang dimaksud tidak ada, ketikkan nama file dengan benar.'),nl,!.
loads(FileName):-
	open(FileName, read, Str),
    read_file_lines(Str,Lines),
    close(Str),
    assertaList(Lines), !.

save(_):-
	\+gameMain(_),
	write('Kamu belum memulai permainan.'),nl,
	write('Silahkan masukkan perintah play. untuk dapat memulai permainan.'),nl,!.
save(FileName):-
	tell(FileName),
		player(X,Y),
		write(player(X,Y)),write('.'),nl,
		healthpoint(HP),
		write(healthpoint(HP)),write('.'), nl,
		writeSenjata,
		armor(Arm),
		write(armor(Arm)),write('.'), nl,
		maxHealth(Maxh),
		write(maxHealth(Maxh)),write('.'), nl,
		maxInventory(Maxi),
		write(maxInventory(Maxi)),write('.'),nl,
		maxArmor(Maxa),
		write(maxArmor(Maxa)),write('.'), nl,
		gameMain(GM),
		write(gameMain(GM)),write('.'), nl,
		deadzone(DZ),
		write(deadzone(DZ)),write('.'), nl,
		tick(Det),
		write(tick(Det)),write('.'), nl,
		lebarPeta(Le),
		write(lebarPeta(Le)),write('.'), nl,
		tinggiPeta(Ti),
		write(tinggiPeta(Ti)),write('.'), nl,
		writeMusuh, writeBarang, writeInventory, writeTerrain,
	told, !.
*/

%Opening
play :- 
	write('Sudah sejak dulu, tokemon hidup berdampingan dengan manusia secara baik.'),nl,
	write('Hingga pada suatu waktu, sebuah desa terserang wabah aneh yang menyebabkan para Tokemon mendadak menjadi liar dan tak terkendali.'),nl,
	write('Tokemon-tokemon tersebut sering menyerang warga dan menimbulkan ketidaknyamanan dalam desa tersebut.'),nl,
	write('Kemudian datanglah seorang penjelajah yang bertemu dengan seorang Kepala Desa.'),nl,nl,
	write('Kepala Desa :'),nl,
	write('Selamat datang, anak muda.'),nl,
	write('Saya di sini selaku Kepala Desa sangat mengaharapkan bantuan dari kamu dalam mengatasi wabah yang menyerang Tokemon-tokemon di desa ini.'),nl,
	write('Ada satu cara untuk mengentikan wabah ini, yaitu dengan menghancurkan sebuah kristal biru yang dijaga oleh <jumlah> Tokemon legendary.'),nl,
	write('Setelah ini kamu akan bertemu dengan Professor Tokemon untuk memilih satu Tokemon yang akan menemanimu memerangi wabah ini.'),nl,nl,
	write('Tidak lama setelah itu, Kepala Desa mengajak penjelajah ke GYM, tempat professor Tokemon bekerja.'),nl,nl,
	write('Professor :'),nl,
	write('Kamu pasti penjelajah yang akan membantu kami menghilangkan wabah yang menyerang Tokemon-tokemon di sini, ya.'),nl,
	write('Kalau memang benar, silahkan pilih satu dari ketiga Tokemon milikku untuk kamu bawa pergi.'),nl,nl,
	write('Pilihlah satu pokemon dengan memberi perintah choose(NamaTokemon).'),nl,
	write('1. tokemon_x'),nl,
	write('2. tokemon_y'),nl,
	write('3. tokemon_z'),nl,!,
	asserta(avChoose(1)).

/* Help */
help :-
	write('Daftar Command: '),nl,
	write('1. w       : Bergerak ke arah atas'),nl,
	write('2. a       : Bergerak ke arah kiri'),nl,
	write('3. s       : Bergerak ke arah bawah'),nl,
	write('4. d       : Bergerak ke arah kanan'),nl,
	write('5. map     : Menampilkan map'),nl,
	write('6. heal    : Menyembuhkan Tokemon(hanya dapat dilakukan di Gym)'),nl,
	write('7. load    : Melanjutkan permainan yang pernah disimpan'),nl,
	write('8. save    : Menyimpan permainan'),nl,
	write('9. status  : Menampilkan status player'),nl,
	write('10.quit    : Keluar dari permainan'),nl,!.

choose(X) :- avChoose(1), tokemona(X,A,B,C,D), addToke(X,A,B,C,D),!.
choose(X) :- write('Kamu hanya dapat memilih Tokemon sekali di awal permainan.'),!.

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
	
cekToke(Banyak) :-
	findall(T,toke(T,_,_,_,_),ListBanyak),
	length(ListBanyak,Banyak).
 	
status :- 
	write('Kamu memiliki '),cekToke(X),write(X),write(' Tokemon.'),nl,nl,
	write('Dengan rincian: '),nl,nl,
	toke(A,B,C,D,E) -> (
		forall(toke(A,B,C,D,E),
		(
			write('    -'),write(A),nl,
			write('       Hp : '),write(B),nl,
			write('Basic Att : '),write(C),nl,
			write('Skill Att : '),write(D),nl,
			write('     Type : '),write(E),nl,nl
		));(
			write('Belum ada Tokemon yang dimiliki.')
		)),!.
		
/*
Coming soon
	write('Masih ada '),cekMusuh(X),write(X),write(' Tokemon Legendary yang harus dikalahkan.'),nl,nl,
*/	
	
% Map
map :-
	XMin is 0,
	XMax is 21,
	YMin is 0,
	YMax is 16,
	forall(between(YMin,YMax,J), (
		forall(between(XMin,XMax,I), (
			printMap(I,J)
		)),
		nl
	)),
	write('Keterangan Simbol :'), nl,
	write('P    :    Player'), nl,
	write('X    :    Border'), nl,
	write('G    :    Gym'), nl,
	write('-    :    Nothing of interest'), nl,
	!.

%Movement
w :- 
	player(_,Y),
	Y=:=1,
	write('Kamu tidak dapat melewati batas.'),nl,
	write('Silahkan ambil jalan lain'),nl,!.
w :-
	retract(player(X,Y)),
	Y > 1,
	YBaru is Y-1,
	write([X,YBaru]),nl,
	asserta(player(X,YBaru)),!.
s :- 
	player(_,Y),
	Y=:=15,
	write('Kamu tidak dapat melewati batas.'),nl,
	write('Silahkan ambil jalan lain'),nl,!.
s :-
	retract(player(X,Y)),
	Y < 15,
	YBaru is Y+1,
	write([X,YBaru]),nl,
	asserta(player(X,YBaru)),!.
a :- 
	player(X,_),
	X=:=1,
	write('Kamu tidak dapat melewati batas.'),nl,
	write('Silahkan ambil jalan lain'),nl,!.
a :-
	retract(player(X,Y)),
	X > 1,
	XBaru is X-1,
	write([XBaru,Y]),nl,
	asserta(player(XBaru,Y)),!.	
d :- 
	player(X,_),
	X=:=20,
	write('Kamu tidak dapat melewati batas.'),nl,
	write('Silahkan ambil jalan lain'),nl,!.
d :-
	retract(player(X,Y)),
	X < 20,
	XBaru is X+1,
	write([XBaru,Y]),nl,
	asserta(player(XBaru,Y)),!.
