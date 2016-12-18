:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- ensure_loaded('tpcs.pl').
:- ensure_loaded('tpc2.pl').
:- ensure_loaded('utils.pl').
:- ensure_loaded('testes.pl').
:- ensure_loaded('statistics.pl').

disciplina(1,'Matematica').
disciplina(2,'Portugues ').
disciplina(3,'Historia  ').
disciplina(4,'Ciencias  ').
disciplina(5,'Artes     ').
disciplina(6,'EVT       ').
disciplina(7,'Ingles    ').

semana(1,'Segunda').
semana(2,'Terca').
semana(3,'Quarta').
semana(4,'Quinta').
semana(5,'Sexta').

%teste2.pl
nome_semana(1, 'Segunda').
nome_semana(2, 'Terca  ').
nome_semana(3, 'Quarta ').
nome_semana(4, 'Quinta ').
nome_semana(5, 'Sexta  ').

nome_discip(1,'Matematica').
nome_discip(2,'Portugues ').
nome_discip(3,'Historia  ').
nome_discip(4,'Ciencias  ').
nome_discip(5,'Artes     ').
nome_discip(6,'EVT       ').
nome_discip(7,'Ingles    ').

tpc2_disciplinas([1,2,3,4,5]).
tpc2_disciplinas2([1,2,3,4,5]).
tpc2_disciplinas3([1,2,3,4,5,6]).
tpc2_disciplinas4([1,2,3,4,5,6,7]).
tpc2_semana1([ [1,2,3] , [4,3] , [3,5] , [3,2] , [3,2,5] ]).
tpc2_semana2([ [2,1], [1] , [1,3] , [4] , [5] ]).

teste_turma1([[1,2,3],[4,2,3],[5,2,1],[3,4,2],[2,3,1]]).
teste_turma2([[3,2,1],[2,4,1],[2,2,1],[1,2,3,4,5],[2,3,1]]).

teste_turmas1([%4 turmas e 5 disciplinas Funciona nos tpcs tambem
              [[1,2,3],[4,2,3],[5,2,1],[3,4,2],[2,3,1]],
              [[3,2,1],[2,4,1],[2,5,1],[3,4,5],[2,3,1]],
              [[1,2,3],[4,2,3],[5,2,1],[2,3,1],[3,4,2]],
              [[5,2,1],[4,2,3],[1,2,3],[3,4,2],[2,3,1]]
            ]).

teste_turmas2([%13 turmas e 5 disciplinas - Funciona nos tpcs tambem
              [[1,2,3],[4,2,3],[5,2,1],[3,4,2],[2,3,1]],
              [[3,2,1],[2,4,1],[2,5,1],[3,4,5],[2,3,1]],
              [[1,2,3],[4,2,3],[5,2,1],[2,3,1],[3,4,2]],
              [[5,2,1],[4,2,3],[1,2,3],[3,4,2],[2,3,1]],
              [[1,2,3],[4,2,3],[5,2,1],[3,4,2],[2,3,1]],
              [[3,2,1],[2,4,1],[2,5,1],[3,4,5],[2,3,1]],
              [[1,2,3],[4,2,3],[5,2,1],[2,3,1],[3,4,2]],
              [[1,2,3],[4,2,3],[5,2,1],[3,4,2],[2,3,1]],
              [[3,2,1],[2,4,1],[2,5,1],[3,4,5],[2,3,1]],
              [[1,2,3],[4,2,3],[5,2,1],[2,3,1],[3,4,2]],
              [[1,2,3],[4,2,3],[5,2,1],[3,4,2],[2,3,1]],
              [[3,2,1],[2,4,1],[2,5,1],[3,4,5],[2,3,1]],
              [[1,2,3],[4,2,3],[5,2,1],[2,3,1],[3,4,2]]
            ]).

teste_turmas3([%4 turmas e 6 disciplinas
              [[1,2,3,5],[2,4,6,3],[1,5,2],[3,4,2],[4,6,1]],
              [[1,5,2],[3,4,2],[4,6,1],[1,2,3,5],[2,4,6,3]],
              [[1,2,3,5],[4,6,1],[2,4,6,3],[1,5,2],[3,4,2]],
              [[3,4,2],[4,6,1],[1,2,3,5],[2,4,6,3],[1,5,2]]
            ]).

teste_turmas4([%12 turmas e 7 disciplinas
              [[1,2,6,3,5],[2,4,6,3],[1,5,2,7],[7,3,4,2],[7,4,6,1]],
              [[7,1,5,2],[7,3,4,2],[7,4,6,1],[1,2,3,5],[2,4,6,3]],
              [[1,2,3,5],[7,4,6,1],[2,4,6,3],[1,5,2,7],[6,3,4,2]],
              [[3,4,2,6],[7,4,6,1],[1,2,3,5],[2,4,6,3],[7,1,5,2]],
              [[1,2,6,3,5],[2,4,6,3],[1,5,2,7],[7,3,4,2],[7,4,6,1]],
              [[7,1,5,2],[7,3,4,2],[7,4,6,1],[1,2,3,5],[2,4,6,3]],
              [[1,2,3,5],[7,4,6,1],[2,4,6,3],[1,5,2,7],[6,3,4,2]],
              [[3,4,2,6],[7,4,6,1],[1,2,3,5],[2,4,6,3],[7,1,5,2]],
              [[1,2,6,3,5],[2,4,6,3],[1,5,2,7],[7,3,4,2],[7,4,6,1]],
              [[7,1,5,2],[7,3,4,2],[7,4,6,1],[1,2,3,5],[2,4,6,3]],
              [[1,2,3,5],[7,4,6,1],[2,4,6,3],[1,5,2,7],[6,3,4,2]],
              [[3,4,2,6],[7,4,6,1],[1,2,3,5],[2,4,6,3],[7,1,5,2]]
            ]).

trabalhoPratico2(NSemanas,NumeroTPCs) :-
    teste_turmas1(Horarios),
    write('|          TESTES          |'), nl, nl,
    resolveTestesPorFavor(Horarios,5,NSemanas),%Numero de Disciplinas
    nl , nl , write('|           TPCS           |'), nl, nl,
    get_char(_),
    tpc2_disciplinas(Disciplinas),
    calculaTpcs(Horarios,1,Disciplinas, NSemanas, NumeroTPCs,2).

trabalhoPratico22(NSemanas,NumeroTPCs) :-
    teste_turmas2(Horarios),
    write('|          TESTES          |'), nl, nl,
    resolveTestesPorFavor(Horarios,5,NSemanas),%Numero de Disciplinas
    nl , nl , write('|           TPCS           |'), nl, nl,
    get_char(_),
    tpc2_disciplinas(Disciplinas),
    calculaTpcs(Horarios,1,Disciplinas, NSemanas, NumeroTPCs,2).

trabalhoPratico23(NSemanas,NumeroTPCs) :-%TPCS 4.
    teste_turmas3(Horarios),
    write('|          TESTES          |'), nl, nl,
    resolveTestesPorFavor(Horarios,6,NSemanas),%Numero de Disciplinas
    nl , nl , write('|           TPCS           |'), nl, nl,
    get_char(_),
    tpc2_disciplinas3(Disciplinas),
    calculaTpcs(Horarios,1,Disciplinas, NSemanas, NumeroTPCs,2).

trabalhoPratico24(NSemanas,NumeroTPCs) :-%TPCS 4.
    teste_turmas4(Horarios),
    write('|          TESTES          |'), nl, nl,
    resolveTestesPorFavor(Horarios,7,NSemanas),%Numero de Disciplinas
    nl , nl , write('|           TPCS           |'), nl, nl,
    get_char(_),
    tpc2_disciplinas4(Disciplinas),
    calculaTpcs(Horarios,1,Disciplinas, NSemanas, NumeroTPCs,2).
