
:- dynamic(player/2).
:- dynamic(inGame/0).
:- dynamic(winGame/0).
:- dynamic(loseGame/0).
:- dynamic(healonce/0).
:- include('map.pl').
:- initialization(start).

/* Tampilan Awal */

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
	write('Hingga pada suatu waktu, sebuah desa terserang wabah aneh yang menyebabkan para Tokemon mendadak'), nl, 
	write('menjadi liar dan tak terkendali.'),nl,
	write('Tokemon-tokemon tersebut sering menyerang warga dan menimbulkan ketidaknyamanan dalam desa tersebut.'),nl,
	write('Kemudian datanglah seorang penjelajah yang bertemu dengan seorang Kepala Desa.'),nl,nl,
	sleep(1.5),
	write('Kepala Desa :'),nl,
	write('Selamat datang, anak muda.'),nl,
	write('Saya di sini selaku Kepala Desa sangat mengaharapkan bantuan dari kamu dalam mengatasi wabah'), nl, 
	write('menyerang Tokemon-tokemon di desa ini.'),nl,
	write('Ada satu cara untuk mengentikan wabah ini, yaitu dengan menghancurkan sebuah kristal biru yang'), nl, 
	write('dijaga oleh 2 Tokemon legendary.'),nl,
	write('Setelah ini kamu akan bertemu dengan Professor Tokemon untuk memilih satu Tokemon yang akan'), nl, 
	write('menemanimu memerangi wabah ini.'),nl,nl,
	sleep(2),
	write('Tidak lama setelah itu, Kepala Desa mengajak penjelajah ke GYM, tempat professor Tokemon bekerja.'),nl,nl,
	write('Professor :'),nl,
	write('Kamu pasti penjelajah yang akan membantu kami menghilangkan wabah yang menyerang Tokemon-tokemon di'), nl, 
	write('sini, ya.'),nl,
	write('Kalau memang benar, silahkan pilih satu dari ketiga Tokemon milikku untuk kamu bawa pergi.'),nl,nl,
	write('Pilihlah satu tokemon dengan memberi perintah choose(NamaTokemon).'),nl,
	write('1. wow'),nl,
	write('2. mamet'),nl,
	write('3. danlap'),nl,!,
    asserta(inGame),
	asserta(avChoose),!. %player memilih tokemon

/* Help */
help :-
	write('Daftar Command: '),nl,
	write('1. w              : Bergerak ke arah atas'),nl,
	write('2. a              : Bergerak ke arah kiri'),nl,
	write('3. s              : Bergerak ke arah bawah'),nl,
	write('4. d              : Bergerak ke arah kanan'),nl,
	write('5. map            : Menampilkan map'),nl,
	write('6. heal           : Menyembuhkan tokemon(hanya dapat dilakukan di Gym)'),nl,
	write('7. load           : Melanjutkan permainan yang pernah disimpan'),nl,
	write('8. save           : Menyimpan permainan'),nl,
	write('9. status         : Menampilkan status player'),nl,
	write('10.serang         : Memilih untuk bertarung dari bertanding(hanya dapat dilakukan saat bertemu tokemon)'),nl,
	write('11.run            : Memilih untuk lari dari bertanding(hanya dapat dilakukan saat bertemu tokemon)'),nl,
	write('12.pick           : Memilih tokemon untuk digunakan(hanya dapat dilakukan pada battle)'),nl,
	write('13.attack         : Melakukan normal attack(hanya dapat dilakukan pada battle)'),nl,
	write('14.specialAttack  : Melakukan Special Attack pada musuh(hanya dapat dilakukan pada battle)'),nl,
	write('15.use(item,toke) : Menggunakan item dengan nama "item" dari dalam inventory'),nl,
	write('16.drop(toke)     : Menghilangkan tokemon "toke" dari inventory'),nl,
	write('17.help           : Menampilkan semua perintah yang dapat dijalankan'),nl,
	write('18.quit           : Keluar dari permainan'),nl.

% checkWin :- /* Mengecek kondisi apakah pemain sudah menang */
%     toke(A,_,_,_,_), legendary(A),
%     toke(B,_,_,_,_), legendary(B),
%     A \= B,
%     winGame.
% checkLose :-
%     cekToke(X), X =:= 0,
%     loseGame.

choose(_) :- 
	inbattle(1),
	write('Salah perintah !'), nl,
	write('Ketik pick(NamaTokemon)'), nl, !.
choose(X) :- avChoose, tokemon(X,A,B,C,D,E), awal(X), firstPick(X,A,B,C,D,E),!.
choose(X) :- avChoose, \+(awal(X)), write('Mohon pilih salah satu diantara 3 opsi '),nl,!.
choose(_) :- write('Kamu hanya dapat memilih Tokemon sekali di awal permainan.'),!.

status :- losing, lose, !.

status :- \+(inGame),
    	  write('Kamu harus memilih tokemon terlebih dahulu untuk dapat mengecek status.'),!.

status :- 
	write('Kamu memiliki '),cekToke(X),write(X),write(' Tokemon.'),nl,nl,
	write('Dengan rincian: '),nl,nl,
    forall(toke(A,B,C,D,E,F,G),
    (
		H is (F + 1) * 50,
        write('    -'),write(A),nl,
        write('       Hp : '),write(B),nl,
        write('Basic Att : '),write(C),nl,
        write('Skill Att : '),write(D),nl,
		write('     Type : '),write(E),nl,
		write('    Level : '),write(F),nl,
		write('		 Exp : '),write(G),write(' dari '),write(H),nl
    )),
    write('Ada '), cekLegend(Y), write(Y),write(' Tokemon Legendary yang sudah kamu tangkap.'),nl,
    write('Item kamu : [ | '), 
    forall(item(I),
    (
        write(I),write(' | ')
    )),write(']'),!.
		
% Map
map :- losing, lose,!.
map :- \+(inGame), write('Harap memulai game terlebih dahulu'),!.
map :- avChoose, write('Pilih tokemon awal terlebih dahulu!'),!.
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
	losing, lose, !.
w :-
	inbattle(2),
	write('Tokemonnya lagi pingsan dan kamu harus mengambil keputusan!'), nl, !.
w :-
    inbattle(0),write('Kamu harus memilih keputusan sekarang!'),!.
w :- 
    inbattle(1),write('Kamu tidak bisa bergerak saat dalam pertarungan'),!.
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
    cekKondisi,!.

s :-
	losing, lose, !.
s :-
	inbattle(2),
	write('Tokemonnya lagi pingsan dan kamu harus mengambil keputusan!'), nl, !.
s :- 
    inbattle(0),write('Kamu harus memilih keputusan sekarang!'),!.
s :-
    inbattle(1),write('Kamu tidak bisa bergerak saat dalam pertarungan'),!.
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
    cekKondisi,!.

a :- 
	losing, lose, !.
a :-
	inbattle(2),
	write('Tokemonnya lagi pingsan dan kamu harus mengambil keputusan!'), nl, !.
a :- 
	inbattle(0),
    write('Kamu harus memilih keputusan sekarang!'),!.
a :-
	inbattle(1),
	write('Kamu tidak bisa bergerak saat dalam pertarungan'),!.
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
	cekKondisi,!.	
	
d :- 
	losing, lose, !.	
d :-
	inbattle(2),
	write('Tokemonnya lagi pingsan dan kamu harus mengambil keputusan!'), nl, !.	
d :- 
	inbattle(0),
    write('Kamu harus memilih keputusan sekarang!'),!.	
d :-
	inbattle(1),
    write('Kamu tidak bisa bergerak saat dalam pertarungan'),!.
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
    cekKondisi,!.

heal :-
	losing, lose, !.
heal :-
    gym(T,L),
    player(T,L),
    healonce,
    write('Kamu hanya bisa menyembuhkan tokemonmu sekali dalam gym'),!.
heal :-
    gym(T,L),
    player(T,L),
    toke(Nama, _,C,D,E),
    forall(tokemona(Nama, Hil,C,D,E),(
        toke(Nama,Hil,C,D,E),
        write('Tokemon '),write(Nama),write(' telah berhasil kamu sembuhkan'),nl
    )),
    asserta(healonce),!.
heal :-
    avChoose,
    write('Kamu belum memilih tokemon!'),!.
heal :-
    write('Kamu tidak berada dalam gym sekarang, tidak bisa menyembuhkan tokemonmu!').


look :-
    player(T,L),
    zoom(T,L).

/* PROSEDUR KELUAR/ RELOAD FILE */
quit :- halt.
restart :- consult('main.pl').
