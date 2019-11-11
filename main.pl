
:- dynamic(player/2).
:- dynamic(inGame/0).
:- dynamic(winGame/0).
:- dynamic(loseGame/0).
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
    inGame,
    write('Kamu tidak bisa memulai game yang sudah dimulai'),!.
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
    initialize_map,
    asserta(inGame),
    /*tinggiPeta(T),
    write(T),nl,
    lebarPeta(L),
    write(L),nl,
    player(P1,P2),
    write(P1),nl,
    write(P2),nl,*/
	asserta(avChoose(1)),!.

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

checkWin :- /* Mengecek kondisi apakah pemain sudah menang */
    toke(A,_,_,_,_), legendary(A),
    toke(B,_,_,_,_), legendary(B),
    A \= B,
    winGame.
checkLose :-
    cekToke(X), X =:= 0,
    loseGame.

choose(X) :- avChoose(1), tokemona(X,A,B,C,D), addToke(X,A,B,C,D),cekGelut,!.
choose(_) :- write('Kamu hanya dapat memilih Tokemon sekali di awal permainan.'),!.

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
	TMin is 0,
	LMin is 0,
    lebarPeta(L),
    L1 is L+1,
    tinggiPeta(T),
    T1 is T+1,
	forall(between(TMin,T1,I), (
		forall(between(LMin,L1,J), (
			printIdx(I,J)
		))
	)),
	write('Keterangan Simbol :'), nl,
	write('P    :    Player'), nl,
	write('X    :    Border'), nl,
	write('G    :    Gym'), nl,
	write('-    :    Nothing of interest'), nl,
	!.

%Movement
w :- 
	player(T,_),
	T=:=1,
	write('Kamu tidak dapat melewati batas.'),nl,
	write('Silahkan ambil jalan lain'),nl,!.
w :-
	retract(player(T,L)),
	TBaru is T-1,
	write([TBaru,L]),nl,
	asserta(player(TBaru,L)),
    cekGelut,!.
s :- 
	player(T,_),
    tinggiPeta(TPeta),
	T=:=TPeta,
	write('Kamu tidak dapat melewati batas.'),nl,
	write('Silahkan ambil jalan lain'),nl,!.
s :-
	retract(player(T,L)),
	TBaru is T+1,
	write([TBaru,L]),nl,
	asserta(player(TBaru,L)),
    cekGelut,!.
a :- 
	player(_,L),
	L=:=1,
	write('Kamu tidak dapat melewati batas.'),nl,
	write('Silahkan ambil jalan lain'),nl,!.
a :-
	retract(player(T,L)),
	LBaru is L-1,
	write([T,LBaru]),nl,
	asserta(player(T,LBaru)),
    cekGelut,!.	
d :- 
	player(_,L),
    lebarPeta(LPeta),
	L=:=LPeta,
	write('Kamu tidak dapat melewati batas.'),nl,
	write('Silahkan ambil jalan lain'),nl,!.
d :-
	retract(player(T,L)),
	LBaru is L+1,
	write([T,LBaru]),nl,
	asserta(player(T,LBaru)),
    cekGelut,!.
quit :- halt.
restart :- consult('C:/Users/Asus/Documents/GitHub/Tokemon/main.pl').

heal :-
    gym(T,L),
    player(T,L),!,
    toke(Nama, _,C,D,E),
    forall(tokemona(Nama, Hil,C,D,E),(
        toke(Nama,Hil,C,D,E),
        write('Tokemon '),write(Nama),write(' telah berhasil kamu sembuhkan'),nl
    )).
heal :-
    write('Kamu tidak berada dalam gym sekarang, tidak bisa menyembuhkan pokemonmu!').