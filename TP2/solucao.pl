:- use_module(library(clpfd)).
:- use_module(library(lists)).

 numSemanas(15).

disciplinas([0,1,2,3,4,5]).

horarios(  [[[0,1,2],[4,1,2],[3,2,0],[5,4,3],[0,1,2]],
            [[4,1,2],[3,2,0],[0,1,2],[5,4,3],[0,1,2]],
            [[5,4,3],[0,1,2],[0,1,2],[4,1,2],[3,2,0]],
            [[5,4,3],[0,1,2],[0,1,2],[4,1,2],[3,2,0]]]).

solucao(NumeroSemanas,Horarios,Disciplinas,Testes,TPCs):-
    length(Horarios,NTurmas), length(Disciplinas,NDisciplinas),
    buildTestes(NumeroSemanas,NTurmas,NDisciplinas,Testes).


limitTestes(PriB,PriE,SegB,SegE,Testes).

buildTPCAux([],_,[]).
buildTPCAux([Disc|Ds],NSemanas,[Tpc|Ts]) :- length(B,NSemanas), Tpc = [Disc,B], domain(B,0,1), buildTPCAux(Ds,NSemanas,Ts).
buildTPCDay([],_,[]).
buildTPCDay([Dia|Ds],NSemanas,[Tpc|Ts]) :- length(Dia,NDisc), length(Tpc,NDisc), buildTPCAux(Dia,NSemanas,Tpc), buildTPCDay(Ds,NSemanas,Ts).
buildTPCWeek([],_,[]).
buildTPCWeek([Horario|Hs],NSemanas,[R|Rs]) :- length(R,5), buildTPCDay(Horario,NSemanas,R), buildTPCWeek(Hs,NSemanas,Rs).
buildTPC(NSemanas,Horarios,Res) :- length(Horarios,NTurmas), length(Res,NTurmas), buildTPCWeek(Horarios,NSemanas,Res).

buildTestesAux([],_).
buildTestesAux([D|Ds],NSemanas) :- D = [A,B], A = [A1,A2], B = [B1,B2], domain([A1,B1],1,5), domain([A2,B2],1,NSemanas), buildTestesAux(Ds,NSemanas).
buildTestesDisc(_,_,[]).
buildTestesDisc(NSemanas,NDisciplinas,[L|Ls]) :- length(L,NDisciplinas), buildTestesAux(L,NSemanas), buildTestesDisc(NSemanas,NDisciplinas,Ls).

buildTestes(NSemanas,NTurmas,NDisciplinas,Res) :-   length(Res,NTurmas),
                                                    buildTestesDisc(NSemanas,NDisciplinas,Res).
