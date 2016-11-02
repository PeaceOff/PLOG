oriDic(0,0,-1).
oriDic(1,1,0).
oriDic(2,1,1).
oriDic(3,0,1).
oriDic(4,-1,0).
oriDic(5,-1,-1).
oriDic(_,_,_) :- invalido.
charDic('A',1).
charDic('B',2).
charDic('C',3).
charDic('D',4).
charDic('E',5).
charDic('F',6).
charDic('G',7).
charDic('a',1).
charDic('b',2).
charDic('c',3).
charDic('d',4).
charDic('e',5).
charDic('f',6).
charDic('g',7).
charDic(_,_) :- invalido.
corInv(preto,branco).
corInv(branco,preto).
isVazio(vazio,1) :- !.
isVazio(_,0).
validaPeca([_,_,B,C]):- A is B + C, A < 7.
validaPeca(B,C):- A is B + C,A < 7.

getSimboloXY(T,Simbolo,X,Y) :- nth0(Y,T,L) , nth0(X,L,Simbolo).

somarLista([],0).
somarLista([Head|Tail],Result) :-
    somarLista(Tail,SumOfTail),
    Result is Head + SumOfTail.

getNewIndex(Tab,Cor,CurrID,NextID) :-   getSimboloXY(Tab,[CurrID,Cor,_,_],_,_), NID is CurrID + 1, !,
                                        getNewIndex(Tab,Cor,NID,NextID).
getNewIndex(_,_,ID,ID).

ganhou(Jogador,jogo(A,B,Tab)) :- ganhou(Jogador,A,B,Tab).
ganhou(Jogador,A,B,_) :-    A >= 5, B < 5, !, Jogador = branco.
ganhou(Jogador,A,B,_) :-    B >= 5, A < 5, !, Jogador = preto.
ganhou(Jogador,A,B,_) :-    A >= 5, B >= 5, Jogador = empate.
ganhou(Jogador,A,B,Tab) :-    \+ getSimboloXY(Tab,[_,preto,_,_],_,_), \+ getSimboloXY(Tab,[_,branco,_,_],_,_), A > B, Jogador = branco.
ganhou(Jogador,A,B,Tab) :-    \+ getSimboloXY(Tab,[_,preto,_,_],_,_), \+ getSimboloXY(Tab,[_,branco,_,_],_,_), A < B, Jogador = preto.
ganhou(Jogador,A,B,Tab) :-    \+ getSimboloXY(Tab,[_,preto,_,_],_,_), \+ getSimboloXY(Tab,[_,branco,_,_],_,_), A is B, Jogador = empate.
ganhou(Jogador,_,_,Tab):-   \+ getSimboloXY(Tab,[_,preto,_,_],_,_), Jogador = branco.
ganhou(Jogador,_,_,Tab):-   \+ getSimboloXY(Tab,[_,branco,_,_],_,_), Jogador = preto.
ganhou(_,_,_,_) :- fail.

somarPontos(branco,A,B,A1,B,N) :- A1 is A + N.
somarPontos(preto,A,B,A,B1,N) :- B1 is B + N.
