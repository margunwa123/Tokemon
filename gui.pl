/* Tugas Besar Logika Komutasional - IF 2121 */
/* Kelas 03 (Kelompok 02) */
/* Akhmad Aji Permadi      10118030 */
/* Fikra Hadi Ramadhan     13518036 */
/* Daniel Riyanto          13518075 */
/* Mario Gunawan           13518114 */

tab :- write('    ').

start :-
    write('     y/:::::::::::::://-                                       :://::::::::::::hhy'),nl,
    write('     `o/::::::::::::::::+:`                                ::+/:::::::::::::::odo`'),nl,
    write('        //:::::::::::::::::+:                          -::+:::::::::::::::::::/h/ '),nl,
    write('         :+::::::::::::::::::+::::://////:++///:+////:+::::::::::::::::::::::/s   '),nl,
    write('           +:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::://    '),nl,
    write('            :+:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::+      '),nl,
    write('            `:+:::::::::::::::::::::::::::::::::::::::::::::::::::::::::+:        '),nl,
    write('            `:+:++::::::::::::::::::::::::::::::::::::::::::::::::://:            '),nl,
    write('                :o::::::::::::::::::::::::::::::::::::::::::::::++//:             '),nl,
    write('                 +::::::::::::::::::::::::::::::::::::::::::::::::/o`             '),nl,
    write('               `o::::::::/oss+::::::::::::::::::::::+oso/:::::::::::+`            '),nl,
    write('               +::::::::+o` yds::::::::::::::::::::y  hhh/:::::::::::+            '),nl,
    write('              :/::::::::ohy  hy::::::::::::::::::::dy  `/:::::::::::/-           '),nl,
    write('            `o::::::::::shdhs/::::::::::::::::::::+yhdy+:::::::::::::+            '),nl,
    write('            +:::::::::::::::::::::::+++::::::::::::::::::::::::::::::/:           '),nl,
    write('           `o:::///::::::::::::::::/syyo:::::::::::::::::::///::::::::o`          '),nl,
    write('           /:/ossssso/::::::::::::::::::::::::::::::::::/ossssso+::::::/          '),nl,
    write('           o:sssssssss:::::::::::::::::::::::::::::::::/ssssssssso:::::+`         '),nl,
    write('           o:ossssssso::::::::::::/ooooooooo/::::::::::/ssssssssso::::::/         '),nl,
    write('            o::s++o++/:::::::::::::y/////////y:::::::::::s+osssso+:::::::o`       '),nl,
    write('            :/:::::::::::::::::::::s+////////y::::::::::::::::::::::::::::/       '),nl,
    write('             :/:::::::::::::::::::::s+/////y:::::::::::::::::::::::::::::::/      '),nl,
    write('              :/:::::::::::::::::::::::sy::::::::::::::::::::::::::::::::::::/    '),nl,
    write('                  o:/:::::::::::::::/::::/:::::::/:::::::::::://:::::::::/::+-    '),nl,
    write('                  -+::::::::::::::::::::::::::::::::::::::::::::::::::::::::::/   '),nl,
    write('                   o:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::+  '),nl,
    tab,tab,tab,write('       :::: ____  _____  _  _  ____  __  __  _____  _  _  ::::::::::'),nl,
	tab,tab,tab,write('        :::|_  _||  _  || |/ || ___||  \\/  ||  _  || \\| | ::::::::::'),nl,
	tab,tab,tab,write('         ::  ||   ||_|| |   | | __|  |    | | |_| |  |  |  ::::::::::'),nl,    
    tab,tab,tab,write('            |__| |_____||_|\\_||____||_/\\/\\_||_____||_|\\_| ::::::::::'),nl,nl,
	write('Selamat Datang di Game Tokemon!'),nl,
	write('Silahkan ketikkan command berikut untuk memberi perintah'),nl,
	write('1  play'),nl,
	write('2  loads'),nl,
	write('3  save'),nl,
	write('Perhatikan untuk selalu memberikan tanda titik(.) di akhir command '),nl,!. 

gui_lose :-
  write('Anda sudah tidak mempunyai Tokemon!'), nl,
  write('Desa menjadi hancur dan wabahnya tersebar ke dunia.'), nl, nl, !.

lose :- 
  write('Anda Kalah!'), nl,
  write('Ketik restart. untuk mengulang permainan!'),nl,!.   

gui_win :-
  write('Kamu sudah mengalahkan 4 Tokemon Legendary dan kristal birunya sudah dihancurkan.'), nl,
  write('Tokemon-tokemon secara tiba-tiba tidak menjadi liar lagi.'), nl,
  write('Kepala Desa dan warga-warga pun datang untuk berterima kasih.'), nl,
  write('Kehidupan di desa ini menjadi kehidupan yang membahagiakan.'), nl, nl, !.

win :-
  write('Anda Menang!'), nl,
  write('Ketik restart. untuk mengulang permainan!'),nl,!.   

% graphicbattle :-
%     write('     ____________________________                             ____________________________  '),nl,
%     write('    | YOUR TOKEMON               |             ____          | ENEMY TOKEMON              | '),nl,
%     write('    |  HP        :               |  ^-^       (o o )         |  HP        :               | '),nl,
%     write('    |  TYPE      :               | (O O)       \\   \\       |  TYPE      :               | '),nl,
%     write('    |  SP.ATTACK :               |  \\ /          |   |___   |  SP.ATTACK :               | '),nl,
%     write('    |____________________________|  / \\          \\______|  |____________________________| '),nl.

spasi(0).
spasi(N) :-
    write(' '), M is N - 1, spasi(M).

spasi_angka(N) :-
    (N >= 10000
        -> spasi(9);
        N >= 1000
            -> spasi(10);
            N >= 100
                -> spasi(11);
                    N >= 10
                        -> spasi(12);
                        spasi(13)
    ), !. 

spasi_type(N) :-
    (N = fire
      -> spasi(10);
      N = leaves
        -> spasi(8);
        N = water
          -> spasi(9);
          N = ice
            -> spasi(11);
            N = ground
              -> spasi(8);
              spasi(5) /* N =:= lightning */                  
    ), !. 

spasi_nama(N) :-
    (N = zigzagur
      -> spasi(18);
      N = bulbalul
        -> spasi(18);
        N = vanila_bluemon
          -> spasi(12);
          N = toketchur
            -> spasi(17);
            N = momon
              -> spasi(21);
              N = engasmon
                -> spasi(18);
                N = santuymon
                  -> spasi(17);
                  N = tankmon
                    -> spasi(19);
                    N = konakmon
                      -> spasi(18);
                      N = jonatan_jostar
                        -> spasi(12);
                        N = pikacrot
                          -> spasi(18);
                          N = elsa
                            -> spasi(22);
                            N = hadimon
                              -> spasi(19);
                              N = mariomon
                                -> spasi(18);
                                N = ajimon
                                  -> spasi(20);
                                  N = danmon
                                    -> spasi(20);
                                    N = wow
                                      -> spasi(23);
                                      N = mamet
                                        -> spasi(22);
                                        N = danlap
                                          -> spasi(20);
                                          spasi(18) /* N = cheatmon */  
    ), !.                          

graphicbattle(A,B,C,D,E,F,G,H,I,J,K,L):-
    write('     ____________________________                             ____________________________  '),nl,
    tab, write('|  '), write(A),
        spasi_nama(A),
        write('|             ____          |  '), write(G),
        spasi_nama(G), write('|'), nl, 
    tab, write('|  LEVEL     : '), write(F), spasi(12),
        write('|  ^-^       (o o )         |  LEVEL     : '), 
        write(L), spasi(12), write('|'), nl,
    tab, write('|  HP        : '), write(B), 
        spasi_angka(B),
        write('| (O O)       \\   \\         |  HP        : '), write(H),
        spasi_angka(H), write('|'), nl,
    tab, write('|  TYPE      : '), write(E),
        spasi_type(E),
        write('|  \\ /          |   |___    |  TYPE      : '), write(K),
        spasi_type(K), write('|'), nl,
    tab, write('|  ATTACK    : '), write(C),
        spasi_angka(C),
        write('|  / \\          \\______|    |  ATTACK    : '), write(I),
        spasi_angka(I), write('|'), nl,
    tab, write('|  SP.ATTACK : '), write(D),
        spasi_angka(D),
        write('|                           |  SP.ATTACK : '), write(J),
        spasi_angka(J), write('|'), nl,
    tab, write('|____________________________|                           |____________________________| '), nl, !.                
