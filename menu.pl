clearScreen :- clearConsole(50).

clearConsole(0).
clearConsole(N):- nl, N1 is N - 1, clearConsole(N1).

%getOri(Ori) :- get_char(Ori), get_char(_).

welcome :-  clearScreen,
            write(' -------------------------------------------------------- '), nl,
            write('|                   _             _        _     _       |'), nl,
            write('|          /\\      | |           | |      (_)   | |      |'), nl,
            write('|         /  \\   __| | __ _ _ __ | |_ ___  _  __| |      |'), nl,
            write('|        / /\\ \\ / _` |/ _` | \'_ \\| __/ _ \\| |/ _` |      |'), nl,
            write('|       / ____ \\ (_| | (_| | |_) | || (_) | | (_| |      |'), nl,
            write('|      /_/    \\_\\__,_|\\__,_| .__/ \\__\\___/|_|\\__,_|      |'), nl,
            write('|                          | |                           |'), nl,
            write('|                          |_|                           |'), nl,
            write('|                                                        |'), nl,
            write('|                                                        |'), nl,
            write('|                        WELCOME!                        |'), nl,
            write('|                                                        |'), nl,
            write('|                                                        |'), nl,
            write('| Made By:                                               |'), nl,
            write('|     David Azevedo up201405846                          |'), nl,
            write('|     Joao Ferreira up201404332                          |'), nl,
            write('|                                                        |'), nl,
            write('|                Press enter to continue!                |'), nl,
            write(' -------------------------------------------------------- '), nl,
            get_char(_), startMenu.

startMenu :-    clearScreen,
                write(' -------------------------------------------------------- '), nl,
                write('|                   _             _        _     _       |'), nl,
                write('|          /\\      | |           | |      (_)   | |      |'), nl,
                write('|         /  \\   __| | __ _ _ __ | |_ ___  _  __| |      |'), nl,
                write('|        / /\\ \\ / _` |/ _` | \'_ \\| __/ _ \\| |/ _` |      |'), nl,
                write('|       / ____ \\ (_| | (_| | |_) | || (_) | | (_| |      |'), nl,
                write('|      /_/    \\_\\__,_|\\__,_| .__/ \\__\\___/|_|\\__,_|      |'), nl,
                write('|                          | |                           |'), nl,
                write('|                          |_|                           |'), nl,
                write('|                                                        |'), nl,
                write('|                                                        |'), nl,
                write('|   Escolha uma das seguintes opcoes :                   |'), nl,
                write('|                                                        |'), nl,
                write('|     1. Jogar                                           |'), nl,
                write('|     2. Tutorial                                        |'), nl,
                write('|     3. Sobre                                           |'), nl,
                write('|     4. Sair                                            |'), nl,
                write('|                                                        |'), nl,
                write('|                Press enter to continue!                |'), nl,
                write(' -------------------------------------------------------- '), nl,
                get_char(A), get_char(_),%How to tirar apenas um character de input
                (A = '1' -> jogarMenu;
                A = '2' -> startMenu;
                A = '3' -> startMenu;
                A = '4' -> sair;
                startMenu).

sair.

jogarMenu :-    clearScreen,
                write(' -------------------------------------------------------- '), nl,
                write('|                   _             _        _     _       |'), nl,
                write('|          /\\      | |           | |      (_)   | |      |'), nl,
                write('|         /  \\   __| | __ _ _ __ | |_ ___  _  __| |      |'), nl,
                write('|        / /\\ \\ / _` |/ _` | \'_ \\| __/ _ \\| |/ _` |      |'), nl,
                write('|       / ____ \\ (_| | (_| | |_) | || (_) | | (_| |      |'), nl,
                write('|      /_/    \\_\\__,_|\\__,_| .__/ \\__\\___/|_|\\__,_|      |'), nl,
                write('|                          | |                           |'), nl,
                write('|                          |_|                           |'), nl,
                write('|                                                        |'), nl,
                write('|                                                        |'), nl,
                write('|   Escolha uma das seguintes opcoes :                   |'), nl,
                write('|                                                        |'), nl,
                write('|     1. Humano vs Humano                                |'), nl,
                write('|     2. Humano vs Computador                            |'), nl,
                write('|     3. Computador vs Computador                        |'), nl,
                write('|     4. Sair                                            |'), nl,
                write('|                                                        |'), nl,
                write('|                Press enter to continue!                |'), nl,
                write(' -------------------------------------------------------- '), nl,
                get_char(A), get_char(_),%How to tirar apenas um character de input
                (A = '1' -> jogar(hh);
                A = '2' -> startMenu;
                A = '3' -> startMenu;
                A = '4' -> sair;
                startMenu).

testSwitch :-   read(A), (%(CONDITION -> if true ; if false)
                (A == 1, 5 < 4) -> write('Escolheu 1');
                (A == 2, 5 > 4) -> write('Escolheu 2');
                A == 3 -> write('Escolheu 3');
                write('You choose poorly')),
                nl, testSwitch.
