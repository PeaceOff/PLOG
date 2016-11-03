%CPU
jogadaComputador(Cor,Modo,jogo(A,B,Tab),JogoF) :-   desenharJogo(A,B,Tab), nl,
                                                    imprimeVez(Cor), !,
                                                    write('A calcular melhor Jogada!'), nl,
                                                    escolheMelhorJogada(jogo(A,B,Tab), Cor,Modo, JogoF).

jogadaBot(JogoI,Cor,JogoF) :-   lerRegraM(Cor,_,JogoI,J1),
                                lerRegraE(Cor,_,J1,J2),
                                famintos(J2,Cor,JogoF).

escolheMelhorJogada(JogoI,Cor,Modo,JogoF):- findall(Jogo,jogadaBot(JogoI,Cor,Jogo),Possibilidades),
                                            length(Possibilidades, NPos), write('Numero de possibilidades: '), write(NPos), nl,
                                            avaliarJogada(JogoI,Cor,Possibilidades,Modo,JogoF).

avaliarJogada(JI,C,P,op,J) :- write('Modo de jogo OP'), nl, avaliarJogadaOp(JI,C,P,_,J).
avaliarJogada(JI,C,P,notOp,J) :- avaliarJogadaNotOp(JI,C,P,_,J).

melhorTabuleiro(J1,N1,_,N2,J1,N1) :- N1 > N2, !.
melhorTabuleiro(_,_,J2,N2,J2,N2).

getValueByPoints(jogo(_,_,_),branco,jogo(5,_,_),100).
getValueByPoints(jogo(_,_,_),preto,jogo(_,5,_),100).
getValueByPoints(jogo(A,B,_),branco,jogo(A1,B1,_),Value) :- Adif is A1 - A, Bdif is B1 - B, V1 is Adif - Bdif, Value is V1 * 10.
getValueByPoints(jogo(A,B,_),preto,jogo(A1,B1,_),Value) :- Adif is A1 - A, Bdif is B1 - B, V1 is Bdif - Adif, Value is V1 * 10.



getValueByPecas(_, Cor, Pos, 100):-  corInv(Cor, CorOponente), getPecasByCor(Pos,CorOponente,0), write('Tabuleiro sem pecas adversarias!!!') , nl, nl.

getValueByPecas(JogoI, Cor, Pos, Value):-   getPecasByCor(JogoI,Cor,PecasInicial), !,
                                            getPecasByCor(Pos,Cor,PecasFinal), !,
                                            V1 is PecasFinal - PecasInicial,
                                            ((V1 > 0, PecasFinal == 3) -> Value is 10;
                                            (V1 > 0, PecasFinal < 3) -> Value is 10;
                                            (V1 < 0, PecasFinal == 3) -> Value is 5;
                                            (V1 < 0, PecasFinal < 3) -> Value is -5;
                                            Value is -10).

getValueByStarving(_,Cor,Pos,Value):-   getStarvingNum(Pos,Cor,Res),
                                        Value is 0 - Res.

getValueByPernas(_,Cor,Pos,Value):-     getPernaNum(Pos,Cor,V1),
                                        Value is V1 * 5.

getValueByGarras(_,Cor,Pos,Value):-     getGarraNum(Pos,Cor,V1),
                                        Value is V1 * 1.


getValueByMovimento(jogo(_,_,T1), Cor, jogo(_,_,T2), 10):- getMoveu(T1,T2,Cor,N), N > 0, !.
getValueByMovimento(_, _, _, -10).

getValue(JogoI,Cor,Pos,Value):- getValueByPoints(JogoI,Cor,Pos,V1),
                                getValueByPecas(JogoI,Cor,Pos,V2),
                                getValueByStarving(JogoI,Cor,Pos,V3),
                                getValueByPernas(JogoI,Cor,Pos,V4),
                                getValueByGarras(JogoI,Cor,Pos,V5),
                                getValueByMovimento(JogoI,Cor,Pos,V6),
                                somarLista([V1,V2,V3,V4,V5,V6],Value).


avaliarJogadaOp(JogoI,_,[],-2000,JogoI).
avaliarJogadaOp(JogoI,Cor,[Pos|Possibilidades],N,JogoF) :-  avaliarJogadaOp(JogoI,Cor,Possibilidades,N1,J1),
                                                            getValue(JogoI,Cor,Pos,Value), melhorTabuleiro(J1,N1,Pos,Value,JogoF,N).




%avaliarJogadaNotOp(JogoI,_,[],0,JogoI).
%avaliarJogadaNotOp(JogoI,Cor,[Pos|Possibilidades],N,JogoF).
