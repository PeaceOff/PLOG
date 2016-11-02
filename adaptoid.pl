:- use_module(library(lists)).
:- include('tabuleiro.pl').
:- include('testes.pl').
:- include('logic.pl').
:- include('utils.pl').

init :- write('Comecando o jogo!'),tabuleiro3(Tab), asserta(jogo(0,0,Tab)), nl.
end :- retract(jogo(_,_,_)), write('Fim do Jogo!'), nl.

desenharJogo(A,B,Tab) :-write('|Pontos| Branco(X) : '), write(A), write(' | Preto(O) : '), write(B), nl, desenharTabuleiro(Tab).
imprimeVencedor(branco):- write('Jogador Branco Ganhou! Parabens!'), nl.
imprimeVencedor(preto):- write('Jogador Preto Ganhou! Parabens!'), nl.
imprimeVencedor(empate):- write('Ninguem Ganhou! Empate!'), nl.
imprimeVez(Cor):- write('E a vez do jogador '), write(Cor), write(' jogar!'), nl.

jogadaBranco(Jogo,Jogo) :- ganhou(_,Jogo).
jogadaBranco(jogo(A,B,Tab),jogo(A1,B1,T1)) :-   desenharJogo(A,B,Tab),
                                                write('E a vez de branco jogar!'), nl,
                                                jogada(jogo(A,B,Tab),branco,jogo(A1,B1,T1)).
jogadaPreto(Jogo,Jogo) :- ganhou(_,Jogo).
jogadaPreto(jogo(A,B,Tab),jogo(A1,B1,T1)) :-    desenharJogo(A,B,Tab),
                                                write('E a vez de preto jogar!'), nl,
                                                jogada(jogo(A,B,Tab),preto,jogo(A1,B1,T1)).

%jogo(PontosW,PontosB,Tabuleiro).

jogando(hh,Jogo) :- retract(jogo(A,B,Tab)), !,
                    jogadaBranco(jogo(A,B,Tab),jogo(A1,B1,T1)), !,
                    jogadaPreto(jogo(A1,B1,T1),jogo(A2,B2,T2)),
                    asserta(jogo(A2,B2,T2)), Jogo = jogo(A2,B2,T2).
jogando(hh,_).

%CPU
jogando(hc,Jogo) :- retract(jogo(A,B,Tab)), !,
                    jogadaBranco(jogo(A,B,Tab),jogo(A1,B1,T1)), !,
                    jogadaComputador(preto,jogo(A1,B1,T1),jogo(A2,B2,T2)),
                    asserta(jogo(A2,B2,T2)), Jogo = jogo(A2,B2,T2).
jogando(hc,_).
%Fim CPU

jogar(Modo) :- init, repeat, once(jogando(Modo,Jogo)), ganhou(Jogador,Jogo), imprimeVencedor(Jogador), end.

jogada(jogo(A,B,Tab),Cor,jogo(A3,B3,T3)):-  imprimeVez(Cor), !,
                                            movimento(jogo(A,B,Tab),Cor,jogo(A1,B1,T1)), !,
                                            evoluir(jogo(A1,B1,T1),Cor,jogo(A2,B2,T2)), !,
                                            famintos(jogo(A2,B2,T2),Cor,jogo(A3,B3,T3)).

%CPU
jogadaComputador(Cor, jogo(A,B,Tab),JogoF) :- desenharJogo(A,B,Tab), nl,
                                              jogadaC(jogo(A,B,Tab), Cor, JogoF).

jogadaC(JogoI, Cor, JogoF):-imprimeVez(Cor), !,
                            lerRegraM(Cor,mover(_,_,_),JogoI,J1),
                            lerRegraE(Cor,aG(_,_),J1,JogoF).
%Fim CPU

movimento(JI,Cor,JF) :- write('Escolha uma opcao - Mover : m | Capturar : c | Skip : s'), nl, !,
                        read(X), acao1(X,Regra), !, lerRegraM(Cor,Regra,JI,JF).

lerRegraM(_,s,Jogo,Jogo).
lerRegraM(Cor,mover(X,Y,Ori),jogo(A,B,Tab),jogo(A,B,T1)) :- getSimboloXY(Tab,[ID,Cor,_,P],X,Y), !,
                                                            P > 0, !,
                                                            moverPeca(Tab,ID,Cor,Ori,T1).
lerRegraM(Cor,capturar(X,Y,Ori), jogo(A,B,Tab), JF) :-  getSimboloXY(Tab,[ID,Cor,G,_],X,Y), !,
                                                        G > 0, !,
                                                        capturar(jogo(A,B,Tab),ID,Cor,Ori,JF).

evoluir(Jogo,_,Jogo):- ganhou(_,Jogo).
evoluir(JI,Cor,JF) :-   write('Escolha um opcao - Adicionar Perna : p | Adicionar Garra : g | Adicionar Corpo : c | Skip : s'), nl , !,
                        read(Acao), acao2(Acao,Regra), !, lerRegraE(Cor,Regra,JI,JF).

lerRegraE(_,s,Jogo,Jogo).
lerRegraE(Cor,aP(X,Y),jogo(A,B,Tab),jogo(A,B,T1)):- getSimboloXY(Tab,[ID,Cor,G,P],X,Y), !,
                                                    (P + G) < 6, !,
                                                    addPerna(Tab,Cor,ID,T1).
lerRegraE(Cor,aG(X,Y),jogo(A,B,Tab),jogo(A,B,T1)):- getSimboloXY(Tab,[ID,Cor,G,P],X,Y), !,
                                                    (P + G) < 6, !,
                                                    addGarra(Tab,Cor,ID,T1).
lerRegraE(Cor,aC(X,Y),jogo(A,B,Tab),jogo(A,B,T1)):- addCorpo(Tab,Cor,X,Y,T1).

famintos(Jogo,_,Jogo):- ganhou(_,Jogo).
famintos(jogo(A,B,T),Cor,jogo(A1,B1,T1)) :- corInv(Cor,CI), removeEsfomeados(T,CI,Removidos,T1), somarPontos(Cor,A,B,A1,B1,Removidos).



acao1(m,Regra):-write('Indique a letra'), read(Cena), charDic(Cena,Y), nl, write('Indique o numero'), read(X), nl,
                write('Indique uma orientacao [0..5]'), read(Ori), oriDic(Ori,_,_), Regra = mover(X,Y,Ori).
acao1(c,Regra):- acao1(m,mover(X,Y,Ori)), Regra = capturar(X,Y,Ori).
acao1(s,s).
acao1(_,_) :- invalido.
acao2(p,Regra) :- write('Indique a letra'), read(Cena), charDic(Cena,Y), nl, write('Indique o numero'), read(X), nl, Regra = aP(X,Y).
acao2(g,Regra) :- acao2(p,aP(X,Y)), Regra = aG(X,Y).
acao2(c,Regra) :- acao2(p,aP(X,Y)), Regra = aC(X,Y).
acao2(s,s).
acao2(_,_) :- invalido.
invalido :- write('Opcao Invalida!'), nl, fail.
