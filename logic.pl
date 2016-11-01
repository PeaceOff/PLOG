/*Adicionar um Garra a um adaptoid*/
addGarraAux([],_,_,[]).
addGarraAux([[ID,Cor,G,P] | T],Cor, ID, Tr) :- G1 is G + 1, !, validaPeca(G1,P), Tr = [[ID,Cor,G1,P]|T].
addGarraAux([A|T],Cor,ID,Tr) :- addGarraAux(T,Cor,ID,T1), Tr = [A|T1].
addGarra([],_,_,[]).
addGarra([A|T],Cor,ID,Tr) :- addGarraAux(A,Cor,ID,LN1), addGarra(T,Cor,ID,LN2), Tr = [LN1|LN2].
/*--------------------------------*/
/*Adicionar uma Perna a um adaptoid*/
addPernaAux([],_,_,[]).
addPernaAux([[ID,Cor,G,P] | T],Cor, ID, Tr) :- P1 is P + 1, !, validaPeca(G,P1), Tr = [[ID,Cor,G,P1]|T].
addPernaAux([A|T],Cor,ID,Tr) :- addPernaAux(T,Cor,ID,T1), Tr = [A|T1].
addPerna([],_,_,[]).
addPerna([A|T],Cor,ID,Tr) :- addPernaAux(A,Cor,ID,LN1), addPerna(T,Cor,ID,LN2), Tr = [LN1|LN2].
/*---------------------------------*/
/*Funcao para verificar e remover os adaptoids que nao estam alimentados*/
vizinhoVazio(T,X,Y,OffSetX,OffSetY,Res) :-  X1 is X + OffSetX, Y1 is Y + OffSetY,
                                            length(T,NL), Y1 < NL, nth0(Y1,T,LTemp),
                                            length(LTemp,CL), X1 < CL, !,
                                            getSimboloXY(T,Simb,X1,Y1),
                                            isVazio(Simb, Res), !.
vizinhoVazio(_,_,_,_,_,0).

contaVazios(T,X,Y,Res) :-   vizinhoVazio(T,X,Y,-1,-1,R1), vizinhoVazio(T,X,Y,0,-1,R2),
                            vizinhoVazio(T,X,Y,-1,0,R3), vizinhoVazio(T,X,Y,1,0,R4),
                            vizinhoVazio(T,X,Y,0,1,R5), vizinhoVazio(T,X,Y,1,1,R6),
                            somarLista([R1,R2,R3,R4,R5,R6],Res).

esfomeado(T,A,Cor,B,C) :-   Max is B + C,!, getSimboloXY(T,[A,Cor,B,C],X,Y),
                            contaVazios(T,X,Y,Res), !, Res < Max.
esfomeadosAux(_,[],_,0,[]).
esfomeadosAux(Tab,[[A,Cor,B,C] | Ls], Cor, N, Tr):- esfomeado(Tab,A,Cor,B,C), !,
                                                    esfomeadosAux(Tab, Ls, Cor, Nr, Tm),
                                                    N is Nr + 1, Tr = [vazio | Tm ] .
esfomeadosAux(Tab,[A|Ls],Cor,N, [A|Tr]) :- esfomeadosAux(Tab,Ls,Cor,N,Tr).
esfomeados(_,[],_,0,[]).
esfomeados(Tab,[L|T], Cor, N, Tr):- esfomeadosAux(Tab, L, Cor, N1, Lr),
                                    esfomeados(Tab,T, Cor, N2, T1),
                                    N is N1 + N2, Tr = [Lr | T1].

removeEsfomeados(Tab,Cor,N,Tr) :- esfomeados(Tab,Tab,Cor,N,Tr).
/*---------------------------------------------*/
/*Verificar se uma movimentacao e possivel*/
checkMov(Tab,ID,Cor,Ori,X,Y,Peca):-  oriDic(Ori,Ox,Oy),
                                getSimboloXY(Tab,[ID,Cor,_,_],Xatual,Yatual), !,
                                vizinhoVazio(Tab,Xatual,Yatual,Ox,Oy,Res), Res is 1, !,
                                getSimboloXY(Tab,Peca,Xatual,Yatual),
                                X is Xatual + Ox, Y is Yatual + Oy.
/*-----------------------------------------*/
/*Remover uma peca da tabuleiro*/
removePecaAux([],_,_,[]).
removePecaAux([[ID,Cor,_,_]|Line],ID,Cor,[vazio|Res]):- removePecaAux(Line,ID,Cor,Res), !.
removePecaAux([Elem|Line],ID,Cor,[Elem|Res]):- removePecaAux(Line,ID,Cor,Res).
removePeca([],_,_,[]).
removePeca([Line|Tab],ID,Cor,Res):- removePecaAux(Line,ID,Cor,LineRes),
                                    removePeca(Tab,ID,Cor,LineRes2),
                                    Res = [LineRes|LineRes2].
/*-----------------------------*/
/*Inserir uma peca num tabuleiro*/
inserePecaAux([],_,_,[]).
inserePecaAux([_|Line],Peca,CoordX,LineRes) :-  CoordX is 0,
                                                    LineRes = [Peca|Line].
inserePecaAux([Elem|Line],Peca,CoordX,[Elem|LineRes]) :-   NewX is CoordX - 1,
                                                    inserePecaAux(Line,Peca,NewX,LineRes).
inserePeca([],_,_,_,[]).
inserePeca([Line|Res],Peca,CoordX,CoordY,TabRes) :- CoordY is 0,
                                                    inserePecaAux(Line,Peca,CoordX,NewLine), !,
                                                    TabRes = [NewLine|Res].
inserePeca([Line|Res],Peca,CoordX,CoordY,[Line|TabRes]):-   NewY is CoordY - 1,
                                                            inserePeca(Res,Peca,CoordX,NewY,TabRes).
/*--------------------------------*/
/*Mover um peca*/
moverPeca(Tab,ID,Cor,Ori,TabRes) :- checkMov(Tab,ID,Cor,Ori,CoordX,CoordY,Peca), !,
                                    removePeca(Tab,ID,Cor,Res),
                                    inserePeca(Res,Peca,CoordX,CoordY,TabRes).
/*--------------*/
/*Funcoes para atacar e capturar um inimigo*/
%addPontos(Cor,Pontos).
maisGarras(Tab,G1,G2,ID1,Cor1,ID2,Cor2,Ori,TabRes):-G1 > G2, !, removePeca(Tab,ID2,Cor2,Res), moverPeca(Res,ID1,Cor1,Ori,TabRes).%adicionar os pontos ao jogador.
maisGarras(Tab,G1,G2,ID1,Cor1,_,_,_,TabRes):-G2 > G1, !, removePeca(Tab,ID1,Cor1,TabRes).%adicionar os pontos ao jogador.
maisGarras(Tab,G1,G2,ID1,Cor1,ID2,Cor2,_,TabRes):-  G1 is G2, G1 > 0, !,
                                                    removePeca(Tab,ID1,Cor1,Res),
                                                    removePeca(Res,ID2,Cor2,TabRes).%adicionar pontos

atacar(Tab,ID1,Cor1,ID2,Cor2,Ori,TabRes) :- getSimboloXY(Tab,[ID1,Cor1,G1,_],_,_),
                                            getSimboloXY(Tab,[ID2,Cor2,G2,_],_,_), !,
                                            maisGarras(Tab,G1,G2,ID1,Cor1,ID2,Cor2,Ori,TabRes).

capturar(Tab,ID,Cor,Ori,TabRes):-   getSimboloXY(Tab,[ID,Cor,_,_],X,Y),
                                    oriDic(Ori,Ox,Oy), NewX is X + Ox, NewY is Y + Oy, !,
                                    getSimboloXY(Tab,[IDinimigo,CorInimigo,_,_],NewX,NewY),
                                    atacar(Tab,ID,Cor,IDinimigo,CorInimigo,Ori,TabRes).
/*-----------------------------------------*/
