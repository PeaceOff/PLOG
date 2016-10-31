:- use_module(library(lists)).

tabuleiro( [
            [#,#,#,#,#,#,#,#,#,#],
            [a,vazio,vazio,vazio,vazio,#],
      		[b,vazio,vazio,vazio,vazio,vazio,#],
      		[c,vazio,vazio,vazio,vazio,vazio,vazio,#],
      		[#,vazio,[0,branco,0,0],vazio,vazio,vazio,[0,preto,0,0],vazio,#],
			[c,#,vazio,vazio,vazio,vazio,vazio,vazio,#],
      		[b,#,#,vazio,vazio,vazio,vazio,vazio,#],
      		[a,#,#,#,vazio,vazio,vazio,vazio,#],
            [#,#,#,#,#,#,#,#,#,#,#,#,#,#,#,#,#]
           ]
          ).

tabuleiro2( [
          [#,#,#,#,#,#,#,#,#,#],
          [a,[1,branco,3,2],vazio,vazio,vazio,#],
    		[b,vazio,vazio,vazio,vazio,vazio,#],
    		[c,vazio,vazio,vazio,vazio,vazio,vazio,#],
    		[#,vazio,[0,branco,0,0],vazio,vazio,vazio,[0,preto,0,0],vazio,#],
			[c,#,vazio,vazio,vazio,vazio,vazio,vazio,#],
    		[b,#,#,vazio,vazio,vazio,vazio,[1,preto,3,2],#],
    		[a,#,#,#,vazio,vazio,vazio,vazio,#],
          [#,#,#,#,#,#,#,#,#,#,#,#,#,#,#,#,#]
         ]
        ).

/*TO DO
    Diminiuir o lixo que e impresso no ecra;
*/

desenharCor(branco) :- write('X').
desenharCor(preto) :- write('O').

desenharMember(0,_):- write('').
desenharMember(N,S):- N > 0, N < 6, write(S), N1 is N - 1, desenharMember(N1,S).
desenharMember(6,S):- write(S),write(S),write(S),write(S),write(S).

desenharMemberC(6,S):- write(S).
desenharMemberC(N,_):- N < 6, write(' ').

desenharEspaco(0):- write('').
desenharEspaco(N):- N > 0, N < 6, write(' '), N1 is N - 1, desenharEspaco(N1).
desenharEspaco(_):- write('').
desenharResto(N):-  R is 5-N, desenharEspaco(R).

desenharC(a):-       write('           ').
desenharC(b):-       write('       ').
desenharC(c):-       write('    ').
desenharC(#):-       write('').
desenharC(vazio):-   write('/     \\').
desenharC([_,_,B,_]):- write('/'), desenharMember(B,'Y'), desenharResto(B), write('\\').

desenharM(a):-      desenharC(a).
desenharM(b):-      desenharC(b).
desenharM(c):-      desenharC(c).
desenharM(#):-      desenharC(#).
desenharM(vazio):-     write('|     |').
desenharM([_,A,B,C]):-write('|'), desenharMemberC(B,'Y') ,write(' '), desenharCor(A) , write(' '),  desenharMemberC(C,'L'), write('|').

desenharB(a):-      desenharC(a).
desenharB(b):-      desenharC(b).
desenharB(c):-      desenharC(c).
desenharB(#):-      desenharC(#).
desenharB(vazio):-     write('\\     /').
desenharB([_,_,_,C]):-write('\\'), desenharMember(C,'L'), desenharResto(C), write('/').

desenharS(a):-      desenharC(a).
desenharS(b):-      desenharC(b).
desenharS(c):-      desenharC(c).
desenharS(#):-      desenharC(#).
desenharS(vazio):-     write(' ¯¯¯¯¯ ').
desenharS([_,_,_,_]):-write(' ¯¯¯¯¯ ').

desenharLinhaC([X|Xs]):- desenharC(X), desenharLinhaC(Xs).
desenharLinhaC([]):- nl.
desenharLinhaM([X|Xs]):- desenharM(X), desenharLinhaM(Xs).
desenharLinhaM([]):- nl.
desenharLinhaB([X|Xs]):- desenharB(X), desenharLinhaB(Xs).
desenharLinhaB([]):- nl.
desenharLinhaS([X|Xs]):- desenharS(X), desenharLinhaS(Xs).
desenharLinhaS([]):- nl.

desenharLinha(A):- desenharLinhaC(A) , desenharLinhaM(A) , desenharLinhaB(A), desenharLinhaS(A).
desenharLinha([]):- write('').

desenharTabuleiro( [ X | Xs ]) :- desenharLinha(X), desenharTabuleiro(Xs).
desenharTabuleiro([]) :- nl.

desenharJogo(A,B,Tab) :-write('|Pontos| Branco(X) : '), write(A), write(' | Preto(O) : '), write(B), nl, desenharTabuleiro(Tab).

validaPeca([_,_,B,C]):- A is B + C, A < 7.
validaPeca(B,C):- A is B + C,A < 7.


/*LOOP INICIAL*/

%jogo(PontosW,PontosB,Tabuleiro).
init :- write('Comecando o jogo!'),tabuleiro(Tab), asserta(jogo(0,0,Tab)), nl.

ganhou(Jogador,jogo(A,B,_)) :- ganhou(Jogador,A,B).
ganhou(Jogador,5,B) :- B < 5, !, Jogador = branco.
ganhou(Jogador,A,5) :- A < 5, !, Jogador = preto.
ganhou(Jogador,5,5) :- Jogador = empate.

imprimeVencedor(branco):- write('Jogador Branco Ganhou! Parabens!'), nl.
imprimeVencedor(preto):- write('Jogador Preto Ganhou! Parabens!'), nl.
imprimeVencedor(empate):- write('Ninguem Ganhou! Empate!'), nl.

jogadaBranco(jogo(A,B,Tab),jogo(A1,B1,T1)) :- desenharJogo(A,B,Tab), write('E a vez de branco jogar!'), read(X), write(X), nl, A1 = A, B1 = B, T1 = Tab.
jogadaPreto(jogo(A,B,Tab),jogo(A1,B1,T1)) :- desenharJogo(A,B,Tab), write('E a vez de preto jogar!'), read(X), write(X), nl, A1 = A, B1 = B, T1 = Tab.

%getElemID([[ID,Cor,A,B]|_],Cor,ID,Elem) :- Elem = [ID,Cor,A,B].%quando encontra acaba a execução.
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

getSimboloXY(T,Simbolo,Row,Col) :- nth0(Col,T,L) , nth0(Row,L,Simbolo).
isVazio(vazio,1) :- !.
isVazio(_,0).
vizinhoVazio(T,X,Y,OffSetX,OffSetY,Res) :- X1 is X + OffSetX, Y1 is Y + OffSetY, length(T,NL), Y1 < NL, nth0(Y1,T,LTemp), length(LTemp,CL), X1 < CL, !, getSimboloXY(T,Simb,X1,Y1), isVazio(Simb, Res), !.
vizinhoVazio(_,_,_,_,_,0).
contaVazios(T,X,Y,Res) :-   vizinhoVazio(T,X,Y,-1,-1,R1), vizinhoVazio(T,X,Y,0,-1,R2),
                            vizinhoVazio(T,X,Y,-1,0,R3), vizinhoVazio(T,X,Y,1,0,R4),
                            vizinhoVazio(T,X,Y,0,1,R5), vizinhoVazio(T,X,Y,1,1,R6),
                            somarLista([R1,R2,R3,R4,R5,R6],Res).



esfomeado(T,A,Cor,B,C) :- Max is B + C,!, getSimboloXY(T,[A,Cor,B,C],X,Y), contaVazios(T,X,Y,Res), !, Res < Max.


esfomeadosAux(_,[],_,0,[]).

esfomeadosAux(Tab,[[A,Cor,B,C] | Ls], Cor, N, Tr) :- esfomeado(Tab,A,Cor,B,C), !, esfomeadosAux(Tab, Ls, Cor, Nr, Tm), N is Nr + 1, Tr = [vazio | Tm ] .

esfomeadosAux(Tab,[A|Ls],Cor,N, [A|Tr]) :- esfomeadosAux(Tab,Ls,Cor,N,Tr).

esfomeados(_,[],_,0,[]).
esfomeados(Tab,[L|T], Cor, N, Tr):- esfomeadosAux(Tab, L, Cor, N1, Lr), esfomeados(Tab,T, Cor, N2, T1), N is N1 + N2, Tr = [Lr | T1].

removeEsfomeados(Tab,Cor,N,Tr) :- esfomeados(Tab,Tab,Cor,N,Tr).

jogando(hh,Jogo) :- retract(jogo(A,B,Tab)), jogadaBranco(jogo(A,B,Tab),jogo(A1,B1,T1)), jogadaPreto(jogo(A1,B1,T1),jogo(A2,B2,T2)), asserta(jogo(A2,B2,T2)), Jogo = jogo(A2,B2,T2).
%jogando(ch) :- retract(jogo(_,_,_)), jogadaComputador(JogoI,JogoF), jogadaPreto(JogoI,JogoF), asserta(JogoF).
%jogando(cc) :- retract(jogo(_,_,_))
jogar(Modo) :- init, repeat, once(jogando(Modo,Jogo)), ganhou(Jogador,Jogo), imprimeVencedor(Jogador).




/*TESTES*/

testAddGarra :- tabuleiro(A), addGarra(A,branco,0,B), addGarra(B,preto,0,C), desenharTabuleiro(C).

testAddPerna :- tabuleiro(A), addPerna(A,branco,0,B), addPerna(B,preto,0,C), desenharTabuleiro(C).

testEsfomeados :-   tabuleiro2(A), removeEsfomeados(A,branco,Removidos,B), desenharTabuleiro(B), write('Removidos:'), write(Removidos),
                    nl, removeEsfomeados(B,preto,R2,C), desenharTabuleiro(C) , write('Removidos:'), write(R2).
