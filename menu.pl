
clearScreen :- clearConsole(50).

clearConsole(0).
clearConsole(N):- nl, N1 is N - 1, clearConsole(N1).

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
            write('|                        WELCOME!                        |'), nl,
            write('|                                                        |'), nl,
            write('| Made By:                                               |'), nl,
            write('|     David Azevedo up201405846                          |'), nl,
            write('|     Joao Ferreira up201404332                          |'), nl,
            write('|                                                        |'), nl,
            write('|               Press any key to continue!               |'), nl,
            write(' -------------------------------------------------------- '), nl,
            get_char(_), startMenu.

startMenu :-    clearScreen,
                write(' -------------------------------------------------------- '), nl,
                write('|                                                        |'), nl,
                write('|                                                        |'), nl,
                write('|                                                        |'), nl,
                write('|                                                        |'), nl,
                write('|                                                        |'), nl,
                write('|                                                        |'), nl,
                write('|                                                        |'), nl,
                write('|                                                        |'), nl,
                write('|                                                        |'), nl,
                write('|                                                        |'), nl,
                write('|                                                        |'), nl,
                write('|                                                        |'), nl,
                write('|                                                        |'), nl,
                write('|                                                        |'), nl,
                write('|                                                        |'), nl,
                write('|               Press any key to continue!               |'), nl,
                write(' -------------------------------------------------------- '), nl,
                get_char(_).

testSwitch :-   read(A), (%(CONDITION -> if true ; if false)
                A == 1 -> write('Escolheu 1');
                A == 2 -> write('Escolheu 2');
                A == 3 -> write('Escolheu 3');
                write('You choose poorly')),
                nl, testSwitch.
