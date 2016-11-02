oriDic(0,0,-1).
oriDic(1,1,0).
oriDic(2,1,1).
oriDic(3,0,1).
oriDic(4,-1,0).
oriDic(5,-1,-1).
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
