:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- ensure_loaded('tpcs.pl').
:- ensure_loaded('tpc2.pl').
:- ensure_loaded('utils.pl').
:- ensure_loaded('testes.pl').

disciplina(1,'Matematica').
disciplina(2,'Portugues ').
disciplina(3,'Historia  ').
disciplina(4,'Ciencias  ').
disciplina(5,'Artes     ').

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

tpc2_disciplinas([1,2,3,4,5]).
tpc2_disciplinas2([1,2,3,4,5]).
tpc2_semana1([ [1,2,3] , [4,3] , [3,5] , [3,2] , [3,2,5] ]).
tpc2_semana2([ [2,1], [1] , [1,3] , [4] , [5] ]).

teste_turma1([[1,2,3],[4,2,3],[5,2,1],[3,4,2],[2,3,1]]).
teste_turma2([[3,2,1],[2,4,1],[2,2,1],[1,2,3,4,5],[2,3,1]]).

teste_turmas1([
              [[1,2,3],[4,2,3],[5,2,1],[3,4,2],[2,3,1]],
              [[3,2,1],[2,4,1],[2,5,1],[3,4,5],[2,3,1]],
              [[1,2,3],[4,2,3],[5,2,1],[2,3,1],[3,4,2]],
              [[5,2,1],[4,2,3],[1,2,3],[3,4,2],[2,3,1]]
            ]).


plogDivertido(NSemanas,NumeroTPCs) :-
    teste_turmas1(Horarios),
    write('|          TESTES          |'), nl, nl,
    resolveTestesPorFavor(Horarios,5,NSemanas),
    nl , nl , write('|           TPCS           |'), nl, nl,
    get_char(_),
    tpc2_disciplinas(Disciplinas),
    calculaTpcs(Horarios,1,Disciplinas, NSemanas, NumeroTPCs,2).
