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
	write('2  load'),nl,
	write('3  save'),nl,
	write('Perhatikan untuk selalu memberikan tanda titik(.) di akhir command '),nl,!. 

graphicbattle :-
    write('     ____________________________                           ____________________________  '),nl,
    write('    | YOUR TOKEMON               |             ____        | ENEMY TOKEMON              | '),nl,
    write('    |  HP        :               |  ^-^       (o o )       |  HP        :               | '),nl,
    write('    |  TYPE      :               | (O O)       \\   \\       |  TYPE      :               | '),nl,
    write('    |  SP.ATTACK :               |  \\ /          |   |___  |  SP.ATTACK :               | '),nl,
    write('    |____________________________|  / \\          \\______|  |____________________________| '),nl.

lose :- write('Anda Kalah!'), nl,
        write('Ketik restart. untuk mengulang permainan!'),!.   