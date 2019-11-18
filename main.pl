/* Tugas Besar Logika Komutasional - IF 2121 */
/* Kelas 03 (Kelompok 02) */
/* Akhmad Aji Permadi      10118030 */
/* Fikra Hadi Ramadhan     13518036 */
/* Daniel Riyanto          13518075 */
/* Mario Gunawan           13518114 */

:- dynamic(player/2). 
/* player(A,B) : A adalah posisi dalam sumbu X dan B adalah posisi dalam sumbu Y. */
:- dynamic(inGame/0).
/* inGame : inGame ada ketika si pemain memberi perintah play. di awal permainan. */
:- dynamic(winGame/0).
/* winGame : winGame ada ketika si pemain sudah menangkap semua Tokemon Legendaris. */
:- dynamic(loseGame/0).
/* loseGame : loseGame ada ketika si pemain sudah tidak memiliki Tokemon lagi */
:- dynamic(healonce/0).
/* healonce : healonce muncul ketika si pemain sudah memberi perintah heal. di lokasi Gym */

:- include('map.pl').
:- include('battle.pl').
:- include('item.pl').
:- include('tokemon.pl').
:- include('gui.pl').
:- include('savefile.pl').
:- initialization(start). /* menginisialisasi prosedur start yang ada di file 'gui.pl' */

%Opening
/* Command dari si pemain untuk memulai permainan */
play :-
    inGame, /* Jika sudah ada inGame (inGame) */
    write('Kamu tidak bisa memulai game yang sudah dimulai'),!.
play :- 
	/* Alur cerita awal */
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
	write('dijaga oleh 4 Tokemon legendary.'),nl,
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
	asserta(nLegend(4)), /* menginisialisasi jumlah Tokemon Legendary yang masih liar */
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
	write('7. loads          : Melanjutkan permainan yang pernah disimpan'),nl,
	write('8. save           : Menyimpan permainan'),nl,
	write('9. status         : Menampilkan status player'),nl,
	write('10.serang         : Memilih untuk bertarung dari bertanding(hanya dapat dilakukan saat bertemu tokemon)'),nl,
	write('11.run            : Memilih untuk lari dari bertanding(hanya dapat dilakukan saat bertemu tokemon)'),nl,
	write('12.pick           : Memilih tokemon untuk digunakan(hanya dapat dilakukan pada battle)'),nl,
	write('13.attack         : Melakukan normal attack(hanya dapat dilakukan pada battle)'),nl,
	write('14.specialAttack  : Melakukan Special Attack pada musuh(hanya dapat dilakukan pada battle)'),nl,
	write('15.change(toke2)  : Mengganti toke yang sedang bertarung dengan toke2'), nl,
	write('16.capture        : Menangkap Tokemon liar yang pingsan'),nl,
	write('17.nope           : Menolak untuk menangkap Tokemon liar yang pingsan'),nl,
	write('18.use(item,toke) : Menggunakan item dengan nama "item" dari dalam inventory'),nl,
	write('19.drop(toke)     : Menghilangkan tokemon "toke" dari inventory'),nl,
	write('20.help           : Menampilkan semua perintah yang dapat dijalankan'),nl,
	write('21.quit           : Keluar dari permainan'),nl,
    write('22.type           : Melihat kekuatan masing-masing tokemon').

/* Memilih Tokemon awal */
choose(_) :- 
	inbattle(1), /* Ketika dalam pertarungan dan memberi perintah choose(Toke) */
	write('Salah perintah !'), nl,
	write('Ketik pick(NamaTokemon)'), nl, !.
choose(X) :- 
	avChoose, /* variabel ini menandai si pemain boleh memilih Tokemon awal */
	tokemon(X,A,B,C,D,E), awal(X), firstPick(X,A,B,C,D,E),!.
choose(X) :- 
	avChoose, /* variabel ini menandai si pemain boleh memilih Tokemon awal */
	\+(awal(X)), /* Tokemon yang dipilih bukan Tokemon yang ditawarkan */
	write('Mohon pilih salah satu diantara 3 opsi '),nl,!.
choose(_) :- 
	/* jika sudah tidak memenuhi semua pernyataan di atas */
	write('Kamu hanya dapat memilih Tokemon sekali di awal permainan.'),!.

/* Menampilkan status si pemain ke layar */
status :- 
	loseGame, /* si pemain sudah kalah Game */
	lose, !.
status :- 
	\+(inGame), /* si pemain belum memulai Game atau memberi perintah play. */
    write('Kamu harus memilih tokemon terlebih dahulu untuk dapat mengecek status.'),!.
status :-
	(inbattle(1); inbattle(2)), /* si pemain sedang dalam situasi bertarung */
	write('Kamu memiliki '),cekToke(X),write(X),write(' Tokemon.'),nl,nl,
	write('Dengan rincian: '),nl,nl,
    forall(tokeT(A,B,C,D,E,F,G,_), /* menampilkan semua Tokemon yang dimiliki si Pemain */
    (
		H is F * 30, /* H adalah exp maksimal suatu Toke untuk naik ke level selanjutnya */
        write('    -'),write(A),nl,
        write('       Hp : '),write(B),nl,
        write('Basic Att : '),write(C),nl,
        write('Skill Att : '),write(D),nl,
		write('     Type : '),write(E),nl,
		write('    Level : '),write(F),nl,
		write('      Exp : '),write(G),write(' / '),write(H),nl,nl
    )),
	write('Ada '), nLegend(Y), write(Y),write(' Tokemon Legendary yang masih liar.'),nl, 
	/* menampilkan jumlah Tokemon Legendary yang perlu ditangkap */
    write('Item kamu : [ | '), /* menampilkan semua item yang dimiliki si Pemain */
    forall(item(I),
    (
        write(I),write(' | ')
    )),write(']'),!.
status :- 
	/* jika si Pemain tidak dalam situasi bertarung */
	write('Kamu memiliki '),cekToke(X),write(X),write(' Tokemon.'),nl,nl,
	write('Dengan rincian: '),nl,nl,
    forall(toke(A,B,C,D,E,F,G), /* menampilkan semua Tokemon yang dimiliki si Pemain */
    (
		H is F * 30,
        write('    -'),write(A),nl,
        write('       Hp : '),write(B),nl,
        write('Basic Att : '),write(C),nl,
        write('Skill Att : '),write(D),nl,
		write('     Type : '),write(E),nl,
		write('    Level : '),write(F),nl,
		write('      Exp : '),write(G),write(' / '),write(H),nl,nl
    )),
	write('Ada '), nLegend(Y), write(Y),write(' Tokemon Legendary yang masih liar.'),nl, 
	/* menampilkan jumlah Tokemon Legendary yang perlu ditangkap */
    write('Item kamu : [ | '), /* menampilkan semua item yang dimiliki si Pemain */
    forall(item(I),
    (
        write(I),write(' | ')
    )),write(']'),!.
		
% Map
map :- 
	loseGame, /* si Pemain sudah kalah permainan */
	lose,!.
map :- 
	\+(inGame), /* si Pemain belum memulai permainan atau belum memberi perintah play. */
	write('Harap memulai game terlebih dahulu'),!.
map :- 
	avChoose, /* variabel ini menandai si Pemilih belum memilih Tokemon awal */
	write('Pilih tokemon awal terlebih dahulu!'),!.
map :- 
	/* jika tidak memenuhi pernyataan di atas */
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
	loseGame, lose, !.
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
	loseGame, lose, !.
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
	loseGame, lose, !.
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
	loseGame, lose, !.	
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

/* Heal */
heal :-
	loseGame, lose, !.
heal :-
    gym(T,L),
    player(T,L),
    healonce,
    write('Kamu hanya bisa menyembuhkan tokemonmu sekali dalam gym'),!.
heal :-
    gym(T,L),
    player(T,L),
    % toke(Nama,_,C,D,E,F,G),
    % forall(tokemon(Nama,Hil,C,D,E,F),(
    %     toke(Nama,Hil,C,D,E),
    %     write('Tokemon '),write(Nama),write(' telah berhasil kamu sembuhkan'),nl
    % )),
	toke(_,_,_,_,_,_,_) -> (
		forall(toke(A,B,C,D,E,F,G),
		(
			asserta(tokeT(A,B,C,D,E,F,G,_))
		))
	),
	retractall(toke(_,_,_,_,_,_,_)),
	tokeT(_,_,_,_,_,_,_,_) -> (
		forall(tokeT(A,HP,C,D,E,F,G,_),
		(
			tokemon(A,B,_,_,_,H),
			J is div(B * (F - H + 10), 10),
			( HP >= J 
			-> asserta(toke(A,HP,C,D,E,F,G));
			asserta(toke(A,J,C,D,E,F,G)),
			write('Tokemon '),write(A),write(' telah berhasil kamu sembuhkan'),nl
			)
		))
	),
	retractall(tokeT(_,_,_,_,_,_,_,_)),
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
restart :- inbattle(_),write('Selesaikan pertaruganmu dahulu!').
restart :- [main].
