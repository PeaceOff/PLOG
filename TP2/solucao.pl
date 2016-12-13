:- use_module(library(clpfd)).

 numSemanas(15).

disciplinas([0,1,2,3,4,5]).

horarios(   [[0,1,2],[4,1,2],[3,2,0],[5,4,3],[0,1,2]],
            [[4,1,2],[3,2,0],[0,1,2],[5,4,3],[0,1,2]],
            [[5,4,3],[0,1,2],[0,1,2],[4,1,2],[3,2,0]],
            [[5,4,3],[0,1,2],[0,1,2],[4,1,2],[3,2,0]]).

%solucao(NumeroSemanas,Horarios,Disciplinas,NmaxTPCDia,NmaxTPCDisciplina).

buildTPCAux([],_,[]).
buildTPCAux([Disc|Ds],NSemanas,[Tpc|Ts]) :- length(B,NSemanas), Tpc = [Disc,B], buildTPCAux(Ds,NSemanas,Ts).
buildTPCDay([],_,[]).
buildTPCDay([Dia|Ds],NSemanas,[Tpc|Ts]) :- length(Dia,NDisc), length(Tpc,NDisc), buildTPCAux(Dia,NSemanas,Tpc), buildTPCDay(Ds,NSemanas,Ts).
buildTPCWeek([],_,[]).
buildTPCWeek([Horario|Hs],NSemanas,[R|Rs]) :- length(R,5), buildTPCDay(Horario,NSemanas,R), buildTPCWeek(Hs,NSemanas,Rs).
buildTPC(NTurmas,NSemanas,Horarios,Res) :- length(Res,NTurmas), buildTPCWeek(Horarios,NSemanas,Res).

buildTestesAux([]).
buildTestesAux([D|Ds]) :- length(D,2), buildTestesAux(Ds).
buildTestesDisc(_,[]).
buildTestesDisc(NDisciplinas,[L|Ls]) :- length(L,NDisciplinas), buildTestesAux(L), buildTestesDisc(NDisciplinas,Ls).

buildTestes(NTurmas,NDisciplinas,Res) :-    length(Res,NTurmas),
                                            buildTestesDisc(NDisciplinas,Res).
