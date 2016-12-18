:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- include('utils.pl').


pre_marca_tpcs(Semana, Disciplinas, Ns, NTPC, TPCs, DiaLivre):-
  length(Disciplinas, Ndis),
  calculaOcorrencias(Semana, Ocorrencias, OcorrenciasDias, Ndis),
%  write('Ocorrencias'), write(Ocorrencias), nl,
%  write('ODia'), write(OcorrenciasDias), nl,
%  desenvolveOcorrencias(OcurrDias, OcorrenciasDias, Ns, Ndis).
  marca_tpcs(Ocorrencias, OcorrenciasDias, Ns, NTPC, TPCs, DiaLivre),
%  write('Resultado'), nl,
  print_tpc1(Semana, TPCs, DiaLivre).


%desenvolveOcorrencias([O | Os], [R | Rs], Ns, Ndis):-


marca_tpcs(Ocorrencias, OcorrenciasDias, NS, NTPC, TPCs, DiaLivre):-
  Dias is NS * 5,
  limitDia(OcorrenciasDias, Res),
  list_to_fdset(Res, Set),
  write(Res),
  DiaLivre in_set Set,
  criarListagemPDisciplina(NS, Dias, DiaLivre, Ocorrencias, OcorrenciasDias, TPCs),
%write('FIM'). testeA(Semana, Disciplinas, Ocorrencias, OcorrenciasDias, NS, NTPC, TPCs, DiaLivre):-
  %criarRectangulos(TPCs, Rects),
  criarTasks(TPCs, Tasks),
  cumulative(Tasks, [limit(NTPC)]),
  %disjoint2(Rects, [ bounding_box([0,0], [Dias, NTPC]) ]),%wrap(0,Dias,0, NTPC)]),
  flat(TPCs, Result),
  K = [DiaLivre | Result], !,
  labeling([], K).


limitDia1([],A, A).
limitDia1([[K] | Rs],Dia, T2):-member(K, Dia), !,
  select(K, Dia, T1),
  limitDia1(Rs,T1, T2).

limitDia1([_ | Rs],Days, T2):- !,
  limitDia1(Rs, Days, T2).


limitDia(Ocurrencias, Res):-
  limitDia1(Ocurrencias, [1,2,3,4,5], Res).


adicionaRects([L | []], Rs, [A | Rs]):-
  L #\= 0 #<=> M,
  domain([Temp], 1,2),
  A = f(L, M, Temp, M).

adicionaRects([L | Ls], Rs, [R | T1]):-
  adicionaRects(Ls, Rs, T1),
  L #\= 0 #<=> M,
  domain([Temp], 1,2),
  R = f(L, M, Temp, M).


criarRectangulos([], []).
criarRectangulos([TPC | Ts], Rects):-
  criarRectangulos(Ts, R1),
  adicionaRects(TPC, R1, Rects).

%asdasd

adicionaTasks([L | []], Rs, [A | Rs]):-
  L #\= 0 #<=> M,
  length(Rs, ID),
  A = task(L, M, _, M, ID).

adicionaTasks([L | Ls], Rs, [R | T1]):-
  adicionaTasks(Ls, Rs, T1),
  L #\= 0 #<=> M,
  length(Rs, ID),
  R = task(L, M, _, M, ID).


criarTasks([], []).
criarTasks([TPC | Ts], Rects):-
  criarTasks(Ts, R1),
  adicionaTasks(TPC, R1, Rects).

%asdd

aplicarDominio([], _, _).
aplicarDominio([V | Ls], DomainSet, DiaLivre):-
  DiasDaSemana in_set DomainSet,
  (V #=< 0) #\/ ( (V #> 0) #/\
  ((V mod 5) #= DiasDaSemana mod 5 ) #/\ ((V mod 5) #\= DiaLivre mod 5) ),
  aplicarDominio(Ls, DomainSet, DiaLivre).

criarListagemPDisciplina(_, _, _, [], [], []).
criarListagemPDisciplina(NumeroSemanas, Dias, DiaLivre, [Ocurr | Os], [OcurrD | Ocurrs], [TPC | Ts]):-
  criarListagemPDisciplina(NumeroSemanas, Dias, DiaLivre, Os, Ocurrs, Ts),
  Total is Ocurr * NumeroSemanas,
  length(TPC, Total),
  list_to_fdset(OcurrD, Set),
  domain(TPC, 0, Dias),
  aplicarDominio(TPC, Set, DiaLivre),
  Mid is div(Total, 2),
  MidP1 is Mid + 1,
  nvalue(MidP1, TPC),
  count(0, TPC, #=, Mid).



calculaOcorrencias3(Ls, N, Dia, 1, Vs, RVs):- member(N, Ls), RVs = [Dia | Vs].
calculaOcorrencias3(Ls, N, _, 0, Vs, Vs):- \+ member(N, Ls).

calculaOcorrencias2([], _, 6, 0, []).
calculaOcorrencias2([Dia|Ds], N, Day, V, VD):-
  calculaOcorrencias2(Ds, N, Dia2, V2, VD2),
  Day is Dia2 - 1,
  calculaOcorrencias3(Dia, N, Day, R, VD2, VD),
  V is V2 + R.

calculaOcorrencias1(_, [], [], Ndis, N):- Ndis < N, !.
calculaOcorrencias1(Semana, Ocurr, OcurrDias, Ndis, N):- N =< Ndis, !,
  N2 is N + 1,
  calculaOcorrencias2(Semana, N, _, V, VD),
  calculaOcorrencias1(Semana, O2, OD2, Ndis, N2),
  OcurrDias = [VD|OD2],
  Ocurr = [V|O2].


calculaOcorrencias(Semana, Ocurr, OcurrDias, Ndis):-
  calculaOcorrencias1(Semana, Ocurr, OcurrDias, Ndis, 1).

%print tpcs

translate(0, 5).
translate(N, N).


print_discp([]).
print_discp([D | Ds]):-
  nome_discip(D, N),
  write('    '), write(N), nl,
  print_discp(Ds).

print_horario([], _).
print_horario([S | Ss], Ns):-
  nome_semana(Ns, SS),
  write(SS), nl,
  print_discp(S),
  N2 is Ns + 1,
  print_horario(Ss, N2).

print_tpcPorDisciplina2([],_).
print_tpcPorDisciplina2([0 | Vs], S):- !,
  print_tpcPorDisciplina2(Vs,S).
print_tpcPorDisciplina2([N | Vs], S):-
  Kappa = div(N, 5),
  K1 is Kappa + 1,
  K1 \= S, !,
  nl, write(' Semana '), write(K1), write(' '),
  Mod = mod(N, 5),
  Mod2 is Mod,
  translate(Mod2,Mod3),
  nome_semana(Mod3, Nome2),
  write(Nome2), write(' '),
  print_tpcPorDisciplina2(Vs, K1).

print_tpcPorDisciplina2([N | Vs], S):-
  Mod = mod(N, 5),
  Mod2 is Mod,
  translate(Mod2,Mod3),
  nome_semana(Mod3, Nome2),
  write(Nome2), write(' '),
  print_tpcPorDisciplina2(Vs, S).


print_tpcPorDisciplina([],_).
print_tpcPorDisciplina([TPC | Ts], Ns):-
  nome_discip(Ns, Nome), nl, nl,
  write('TPC:'), write(Nome),
  print_tpcPorDisciplina2(TPC, 0),
  N2 is Ns + 1,
  print_tpcPorDisciplina(Ts,N2).


print_tpc1(Semana, TPCs, DiaLivre):-
  print_horario(Semana, 1),
  nome_semana(DiaLivre, NomeDiaSemana),
  write('Dia Livre: ') , write(NomeDiaSemana), nl,
  get_char(_),
  print_tpcPorDisciplina(TPCs, 1) , nl.
