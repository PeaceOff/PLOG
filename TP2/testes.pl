horario([
          [[1,2,3],[4,2,3],[5,2,1],[3,4,2],[2,3,1]],
          [[3,2,1],[2,4,1],[2,2,1],[1,2,3,4,5],[2,3,1]],
          [[1,2,3],[4,2,3],[5,2,1],[2,3,1],[3,4,2]],
          [[5,2,1],[4,2,3],[1,2,3],[3,4,2],[2,3,1]]
        ]).

resolveTestesPorFavor(Horarios,NDisciplinas,NSemanas) :-
    solution(Horarios,NDisciplinas,NSemanas,Testes), !,
    printResults(Testes,1,1).

solution(Horarios,NDisciplinas,NSemanas,Testes) :-
    %Construcao dos dominios e das variaveis
    length(Horarios,NTurmas),
    buildTestes(NSemanas,NTurmas,NDisciplinas,Testes),
    Intervalo is 3 * NDisciplinas,%Intervalo da zona dos testes.
    MeioIntervalo is div(Intervalo,2),
    DiasTotais is NSemanas * 5,
    MetadeDias is div(DiasTotais,2),
    Min1 is MetadeDias - MeioIntervalo,
    Max1 is MetadeDias + MeioIntervalo,
    Min2 is DiasTotais - Intervalo,
    Max2 is DiasTotais, %Ultimo Dia
    Min1 > 1, Min2 > 1, %Falha mais rapido se nao for possivel
    solveTurma(Testes,Horarios,Min1,Max1,Min2,Max2),%Aplicacao das restricoes
    /*%Calcular distancia do uma disciplina entre turmas (deprecated)
    constroiEstrutura(Testes,NDisciplinas,DisciplinaTeste),
    getSum(DisciplinaTeste,Somas),
    sum(Somas,#=,DistTotal),% A logica e se a soma de todos os valores for a menor possivel eles vao ficar todos o mais junto possivel.
    */
    flat(Testes,Nivel1), flat(Nivel1,Vars),
    labeling([],Vars).%Solver

% Recebe uma lista de listas e devolve uma lista em que cada elemento é a soma dos elementos de cada uma das listas
getSum([],[]) :- !.
getSum([Disciplina|Ds],Somas) :-
    getSum(Ds,D1),
    sum(Disciplina,#=,Soma),
    Somas = [Soma|D1].

/*Passa da estrutura de testes para uma estrutura que facilita a minimizacao dos testes de turmas diferentes para uma mesma disciplina*/
constroiPorDisciplinaAux([],_,_,[]) :- !.
constroiPorDisciplinaAux([Turma|Ts],IndexD,IndexT,Res) :-
    constroiPorDisciplinaAux(Ts,IndexD,IndexT,R1),
    getDataTurmaPorDisciplinaTeste(Turma,IndexD,IndexT,Data),
    Res = [Data|R1].

constroiPorDisciplina(_,I1,I2,_,[]) :- I1 is I2 + 1, !.
constroiPorDisciplina(Testes,IndexD,NDisciplinas,IndexT,Res) :-
    NewIndex is IndexD + 1,
    constroiPorDisciplina(Testes,NewIndex,NDisciplinas,IndexT,R1),
    constroiPorDisciplinaAux(Testes,IndexD,IndexT,R2),%Devolve a lista por disciplina
    Res = [R2|R1].

constroiEstrutura(Testes,NDisciplinas,Res) :-
    constroiPorDisciplina(Testes,1,NDisciplinas,1,Testes1),
    constroiPorDisciplina(Testes,1,NDisciplinas,2,Testes2),
    append(Testes1,Testes2,Res).

getDataTurmaPorDisciplinaTeste(Turma,IndexDisciplina,IndexTeste,Data) :-
    nth1(IndexDisciplina,Turma,Testes),
    nth1(IndexTeste,Testes,Data).
/*************************************************************************/

/*Resolucao para todos os testes de todas as turmas*/
solveTurma(Testes,Horarios,Min1,Max1,Min2,Max2) :-
    teste1PorTurma(Testes,Min1,Max1,Testes1),
    teste2PorTurma(Testes,Min2,Max2,Testes2),
    solveTurmaAux(Testes1,Horarios),
    solveTurmaAux(Testes2,Horarios).

solveTurmaAux([],[]) :- !.
solveTurmaAux([Testes|Ts],[Horario|Hs]):-
    solveTesteForTurma(Testes,Horario),
    solveTurmaAux(Ts,Hs).

/***********Resolve para uma turma***********/
solveTesteForTurma(Testes,Horario):-
    length(Testes,Ndis),
    calculaOcorrencias(Horario, _, OcurrDias, Ndis),
    diaDisciplina(Testes,OcurrDias),
    all_distinct(Testes),
    semTestesSeguidos(Testes),
    restringe2PorSemana(Testes).

%Resolve o problema de o teste ter de ser marcado num dia em que haja aula da disciplina
diaDisciplina([],[]) :- !.
diaDisciplina([Teste|Ts],[Disciplina|Ds]) :-
    list_to_fdset(Disciplina,DomainSet),
    Dia in_set DomainSet,
    Teste mod 5 #= Dia mod 5,
    diaDisciplina(Ts,Ds).

%Predicado que restringe a não haver testes em dias seguidos
semTestesSeguidos(Testes) :-
    buildTasks(Testes,1,Tasks),
    cumulative(Tasks,[limit(5)]).

%Constroi as tasks para o predicado semTestesSeguidos/1
buildTasks([],_,[]) :- !.
buildTasks([T|Ts],Index,Res) :-
    I1 is Index + 1,
    buildTasks(Ts,I1,R1),%!!!Falta ver o caso em que um é na sexta e outra é na segunda!!!
    /*
    ((((T mod 5) #= 0) #/\ Tdepois #= T #/\ Tantes #= T - 1))
    #\/
    ((((T mod 5) #= 1) #/\ Tantes #= T #/\ Tdepois #= T + 1))
    #\/
    (((T mod 5) #> 1) #/\ Tantes #= T - 1 #/\ Tdepois #= T + 1),
    */
    Tdepois #= T + 1,%A resposta passa por se o mod for 1 ou 0 (Segunda e sexta)
    Tantes #= T - 1,%e entao Tantes e Tdepois serao igual a T
    Res = [task(Tantes,_,Tdepois,5,Index)|R1].

%Verifica se a cada tres valores exitem pelo menos 2 diferentes e garante assim o max de 2 testes por semana
checkTrios([_,_]) :- !.
checkTrios([A,B,C|Ts]) :-
    nvalue(2,[A,B,C]),
    checkTrios([B,C|Ts]).

%Restringe os testes a 2 por semana
restringe2PorSemana(Testes) :-
    converteSemana(Testes,Res),
    msort(Res,Sorted),
    checkTrios(Sorted).

%Converte uma lista de dias totais numa lista de semanas
converteSemana([],[]) :- !.
converteSemana([DiaTotal|Ds],Res) :-
    converteSemana(Ds,R1),
    DiaTmp #= DiaTotal - 1,
    Tmp #= DiaTmp div 5,
    Sem #= Tmp + 1,
    Res = [Sem|R1].
/*************************************************/

/*Devolve uma lista por turma para o 1 testes com as datas dos testes por disciplina*/
teste1PorTurma([],_,_,[]) :- !.
teste1PorTurma([Turma|Ts],MinBound,MaxBound,Res) :-
    teste1PorTurmaAux(Turma,MinBound,MaxBound,Testes),
    teste1PorTurma(Ts,MinBound,MaxBound,R1),
    Res = [Testes|R1].

teste1PorTurmaAux([],_,_,[]) :- !.
teste1PorTurmaAux([[A,_]|Ds],MinBound,MaxBound,Res) :-
    domain([A],MinBound,MaxBound),
    teste1PorTurmaAux(Ds,MinBound,MaxBound,R1), Res = [A|R1].
/*****************************************/

/*Devolve uma lista por turma para o 2 testes com as datas dos testes por disciplina*/
teste2PorTurma([],_,_,[]) :- !.
teste2PorTurma([Turma|Ts],MinBound,MaxBound,Res) :-
    teste2PorTurmaAux(Turma,MinBound,MaxBound,Testes),
    teste2PorTurma(Ts,MinBound,MaxBound,R1),
    Res = [Testes|R1].

teste2PorTurmaAux([],_,_,[]) :- !.
teste2PorTurmaAux([[_,A]|Ds],MinBound,MaxBound,Res) :-
    domain([A],MinBound,MaxBound),
    teste2PorTurmaAux(Ds,MinBound,MaxBound,R1), Res = [A|R1].
/*****************************************/

%Estrutura numero 1 para os testes
buildTestesAux([],_).
buildTestesAux([D|Ds],NSemanas) :-
    D = [_,_],
    MaxDias is NSemanas * 5,
    domain(D,1,MaxDias),
    buildTestesAux(Ds,NSemanas).
buildTestesDisc(_,_,[]).
buildTestesDisc(NSemanas,NDisciplinas,[L|Ls]) :-
    length(L,NDisciplinas),
    buildTestesAux(L,NSemanas),
    buildTestesDisc(NSemanas,NDisciplinas,Ls).
buildTestes(NSemanas,NTurmas,NDisciplinas,Res) :-
    length(Res,NTurmas),
    buildTestesDisc(NSemanas,NDisciplinas,Res).

/*HELPERS*/
%Sort que nao elimina duplicados
msort(Keys, KeysS) :-
   keys_pairs(Keys, Pairs), % pairs_keys(Pairs, Keys)
   keysort(Pairs, PairsS),
   pairs_keys(PairsS, KeysS).

keys_pairs([], []).
keys_pairs([K|Ks], [K-_|Ps]) :-
   keys_pairs(Ks, Ps).

pairs_keys([], []).
pairs_keys([K-_|Ps],[K|Ks]) :-
   pairs_keys(Ps, Ks).


/*PRINTERS*/

printDisciplina(Testes,NDisciplina) :-
    format("    Disciplina ~w:", [NDisciplina]), nl,
    format("    Teste 1 - Dia ~w | Teste 2 - Dia ~w",Testes), nl, !.

printTurma([],_,_) :- !.
printTurma([Disciplina|Ds],NTurma,NDisciplina) :-
    printDisciplina(Disciplina,NDisciplina),
    D1 is NDisciplina + 1, !,
    printTurma(Ds,NTurma,D1).

printResults([],_,_) :- !.
printResults([Turma|Ts],NTurma,NDisciplina) :-
    format("Turma ~w:",[NTurma]), nl,
    printTurma(Turma,NTurma,NDisciplina),
    N1 is NTurma + 1, !,
    printResults(Ts,N1,NDisciplina).
