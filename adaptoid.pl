:- use_module(library(lists)).
:- include('tabuleiro.pl').
:- include('testes.pl').

init :- write('Comecando o jogo!'),tabuleiro(Tab), asserta(jogo(0,0,Tab)), nl.

desenharJogo(A,B,Tab) :-write('|Pontos| Branco(X) : '), write(A), write(' | Preto(O) : '), write(B), nl, desenharTabuleiro(Tab).

validaPeca([_,_,B,C]):- A is B + C, A < 7.
validaPeca(B,C):- A is B + C,A < 7.

/*LOOP INICIAL*/

%jogo(PontosW,PontosB,Tabuleiro).
ganhou(Jogador,jogo(A,B,_)) :- ganhou(Jogador,A,B).
ganhou(Jogador,A,B) :- A >= 5, B < 5, !, Jogador = branco.
ganhou(Jogador,A,B) :- B >= 5, A < 5, !, Jogador = preto.
ganhou(Jogador,A,B) :- A >= 5, B >= 5, Jogador = empate.

imprimeVencedor(branco):- write('Jogador Branco Ganhou! Parabens!'), nl.
imprimeVencedor(preto):- write('Jogador Preto Ganhou! Parabens!'), nl.
imprimeVencedor(empate):- write('Ninguem Ganhou! Empate!'), nl.

jogadaBranco(jogo(A,B,Tab),jogo(A1,B1,T1)) :- desenharJogo(A,B,Tab), write('E a vez de branco jogar!'), read(X), write(X), nl, A1 = A, B1 = B, T1 = Tab.
jogadaPreto(jogo(A,B,Tab),jogo(A1,B1,T1)) :- desenharJogo(A,B,Tab), write('E a vez de preto jogar!'), read(X), write(X), nl, A1 = A, B1 = B, T1 = Tab.

getSimboloXY(T,Simbolo,Row,Col) :- nth0(Col,T,L) , nth0(Row,L,Simbolo).
%getElemID([[ID,Cor,A,B]|_],Cor,ID,Elem) :- Elem = [ID,Cor,A,B].%quando encontra acaba a execu��o.
%getElemID([_|T],Cor,ID,Elem) :- getElemID(T,Cor,ID,Elem).

addGarraAux([],_,_,[]).
addGarraAux([[ID,Cor,G,P] | T],Cor, ID, Tr) :- G1 is G + 1, !, validaPeca(G1,P), Tr = [[ID,Cor,G1,P]|T].
addGarraAux([A|T],Cor,ID,Tr) :- addGarraAux(T,Cor,ID,T1), Tr = [A|T1].
addGarra([],_,_,[]).
addGarra([A|T],Cor,ID,Tr) :- addGarraAux(A,Cor,ID,LN1), addGarra(T,Cor,ID,LN2), Tr = [LN1|LN2].

addPernaAux([],_,_,[]).
addPernaAux([[ID,Cor,G,P] | T],Cor, ID, Tr) :- P1 is P + 1, !, validaPeca(G,P1), Tr = [[ID,Cor,G,P1]|T].
addPernaAux([A|T],Cor,ID,Tr) :- addPernaAux(T,Cor,ID,T1), Tr = [A|T1].
addPerna([],_,_,[]).
addPerna([A|T],Cor,ID,Tr) :- addPernaAux(A,Cor,ID,LN1), addPerna(T,Cor,ID,LN2), Tr = [LN1|LN2].

somarLista([],0).
somarLista([Head|Tail],Result) :-
    somarLista(Tail,SumOfTail),
    Result is Head + SumOfTail.

isVazio(vazio,1) :- !.
isVazio(_,0).
vizinhoVazio(T,X,Y,OffSetX,OffSetY,Res) :- X1 is X + OffSetX, Y1 is Y + OffSetY, length(T,NL), Y1 < NL, nth0(Y1,T,LTemp), length(LTemp,CL), X1 < CL, !, getSimboloXY(T,Simb,X1,Y1), isVazio(Simb, Res), !.
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


jogando(hh,Jogo) :- retract(jogo(A,B,Tab)),
                    jogadaBranco(jogo(A,B,Tab),jogo(A1,B1,T1)),
                    jogadaPreto(jogo(A1,B1,T1),jogo(A2,B2,T2)),
                    asserta(jogo(A2,B2,T2)), Jogo = jogo(A2,B2,T2).

jogar(Modo) :- init, repeat, once(jogando(Modo,Jogo)), ganhou(Jogador,Jogo), imprimeVencedor(Jogador).
