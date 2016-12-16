:- use_module(library(clpfd)).
:- use_module(library(lists)).

testeSemana([[1,2],[3,4],[5,4],[3,2,4],[1,2,3]]).

%analisar turma
turmaTPCs([Turma|Ts], Semanas, MaximoTPCs):-
  turmaTPCs1([Turma|Ts], 1, Semanas, MaximoTPCs).

turmaTPCs1([], _, _, _).
turmaTPCs1([Turma|Ts], N, Semanas, MaximoTPCs):-
  write('------------------'), nl,
  write('Turma: '), write(N), nl, !,
  tpcs(Turma, Semanas, MaximoTPCs, TPCs, DiaLivre), !,
  printTPCResult(Turma, TPCs, DiaLivre),
  get_char(_),
  N2 is N + 1, !,
  turmaTPCs1(Ts, N2, Semanas, MaximoTPCs).



%Adicionar razao de tpc por disciplina.
tpcs(Semana, NS, NTPC, TPCs, DiaLivre):-
  domain([DiaLivre],1,5),
  domain([RTPC],NTPC,NTPC),
  constroiLabels(Semana, NS, DiaLivre, TPCs),
  limitarTPCs(TPCs, RTPC, NS, DiaLivre),
  flat(TPCs,  ResultMid),
  flat(ResultMid, Results),
  labeling([],Results).

%
%Limitar os TPCs a dois
limitarTPCs3([LastE|[]],Semana,R):-
  nth1(Semana, LastE, N1),
  N1 #= 1  #<=> R.

limitarTPCs3([Disciplina| Ds], Semana, R):-
  limitarTPCs3(Ds, Semana, R1),
  nth1(Semana, Disciplina, N1),
  N1 #= 1  #<=> M,
  R #= R1 + M.

limitarTPCs2(_, _, S, NS):- S > NS, !.
limitarTPCs2(Dia, NTPC, Semana, NS):- Semana =< NS, !,
  limitarTPCs3(Dia, Semana, R),
  R #=< NTPC,
  S2 is Semana + 1,
  limitarTPCs2(Dia, NTPC, S2, NS).

limitarTPCs1([], _, _, _).
limitarTPCs1([Dia|Ds], NTPC, NS, DiaLivre):-
  limitarTPCs2(Dia, NTPC, 1, NS),
  limitarTPCs1(Ds, NTPC,NS,DiaLivre).


limitarTPCs(Semana, NTPC, NS, DiaLivre):-
  limitarTPCs1(Semana, NTPC, NS, DiaLivre).

%getResults
flat([],[]).
flat([T|Ts], Rs):-
  flat(Ts, R1),
  append(T, R1,Rs).

%bla
constroiLabels2([_ | Ds], NS, livre, [A | As]):-
  length(A, NS),
  domain(A, 0, 0),
  constroiLabels2(Ds, NS, livre, As).

constroiLabels2([_ | Ds], NS, ocupado, [A | As]):-
  length(A, NS),
  domain(A, 0, 1),
  NK is div(NS,2),
  count(1, A, #=, NK),
  constroiLabels2(Ds, NS, ocupado, As).

constroiLabels2([], _, _, []).


constroiLabels1([Dia | Ds], N, NS, DiaLivre, [A|As]):- N \= DiaLivre, !,
  length(Dia, Disciplinas), length(A, Disciplinas),
  constroiLabels2(Dia, NS, ocupado, A),
  N1 is N + 1,
  constroiLabels1(Ds, N1, NS, DiaLivre, As).

constroiLabels1([Dia | Ds], N, NS, N, [A|As]):- !,
  length(Dia, Disciplinas), length(A, Disciplinas),
  constroiLabels2(Dia, NS, livre, A),
  N1 is N + 1,
  constroiLabels1(Ds, N1, NS, N, As).

constroiLabels1([], _, _, _, []).

constroiLabels(Semana, NS, DiaLivre, Array):-
  length(Array, 5),
  constroiLabels1(Semana, 1, NS, DiaLivre, Array).

%prints

printTPCResultTPC([]).
printTPCResultTPC([1|Es]):-
  write('X '),
  printTPCResultTPC(Es).

printTPCResultTPC([0|Es]):-
  write('_ '),
  printTPCResultTPC(Es).

printTPCResultAux2([],[]).
printTPCResultAux2([Dis| Ds], [Tpc| Ts]):-
  disciplina(Dis,DisNome),
  write('    '), write(DisNome), nl,
  write('    '), write('   TPC: '),
  printTPCResultTPC(Tpc), nl,
  printTPCResultAux2(Ds,Ts).

printDisciplinas([]).
printDisciplinas([Dis| Ds]):-
  disciplina(Dis,DisNome),
  write('    '), write(DisNome), nl,
  printDisciplinas(Ds).

printTPCResultAux1([],[],_,_).
printTPCResultAux1([Dia|Ds], [TDia|TDs], Ns, Ns):- !,
  semana(Ns, Semana),
  write(Semana), write(': Dia Livre'),nl,
  N2 is Ns + 1,
  printDisciplinas(Dia),
  printTPCResultAux1(Ds, TDs, Ns, N2).

printTPCResultAux1([Dia|Ds], [TDia|TDs], DiaLivre, Ns):-
  semana(Ns, Semana),
  write(Semana), nl,
  N2 is Ns + 1,
  printTPCResultAux2(Dia, TDia),
  printTPCResultAux1(Ds, TDs, Ns, N2).

printTPCResult(Turma, TPCs, DiaLivre):-
  printTPCResultAux1(Turma, TPCs, DiaLivre, 1).
