:- use_module(library(lists)).
:- include('tabuleiro.pl').
:- include('testes.pl').
:- include('input.pl').
:- include('logic.pl').
:- include('utils.pl').

init :- write('Comecando o jogo!'),tabuleiro(Tab), asserta(jogo(0,0,Tab)), nl.

desenharJogo(A,B,Tab) :-write('|Pontos| Branco(X) : '), write(A), write(' | Preto(O) : '), write(B), nl, desenharTabuleiro(Tab).

/*LOOP INICIAL*/

%jogo(PontosW,PontosB,Tabuleiro).
ganhou(Jogador,jogo(A,B,_)) :- ganhou(Jogador,A,B).
ganhou(Jogador,A,B) :- A >= 5, B < 5, !, Jogador = branco.
ganhou(Jogador,A,B) :- B >= 5, A < 5, !, Jogador = preto.
ganhou(Jogador,A,B) :- A >= 5, B >= 5, Jogador = empate.

jogando(hh,Jogo) :- retract(jogo(A,B,Tab)),
                    jogadaBranco(jogo(A,B,Tab),jogo(A1,B1,T1)),
                    jogadaPreto(jogo(A1,B1,T1),jogo(A2,B2,T2)),
                    asserta(jogo(A2,B2,T2)), Jogo = jogo(A2,B2,T2).

jogar(Modo) :- init, repeat, once(jogando(Modo,Jogo)), ganhou(Jogador,Jogo), imprimeVencedor(Jogador).
