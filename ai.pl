%CPU
jogadaComputador(Cor,Modo,jogo(A,B,Tab),JogoF) :-   desenharJogo(A,B,Tab), nl,
                                                    imprimeVez(Cor), !,
                                                    escolheMelhorJogada(jogo(A,B,Tab), Cor,Modo, JogoF).

jogadaBot(JogoI,Cor,JogoF) :-   lerRegraM(Cor,mover(_,_,_),JogoI,J1),
                                lerRegraE(Cor,aG(_,_),J1,J2),
                                famintos(J2,_,JogoF).

escolheMelhorJogada(JogoI,Cor,Modo,JogoF):- findall(Jogo,jogadaBot(JogoI,Cor,Jogo),Possibilidades),
                                            avaliarJogada(JogoI,Cor,Possibilidades,Modo,JogoF).

avaliarJogada(JI,C,P,op,J) :- avaliarJogadaOp(JI,C,P,_,J).
avaliarJogada(JI,C,P,notOp,J) :- avaliarJogadaNotOp(JI,C,P,_,J).

melhorTabuleiro(J1,N1,_,N2,J1,N1) :- N1 > N2, !.
melhorTabuleiro(_,_,J2,N2,J2,N2).

getValueByPoints(jogo(_,_,_),branco,jogo(5,_,_),100).
getValueByPoints(jogo(_,_,_),preto,jogo(_,5,_),100).
getValueByPoints(jogo(A,B,_),branco,jogo(A1,B1,_),Value) :- Adif is A1 - A, Bdif is B1 - B, V1 is Adif - Bdif, Value is V1 * 10.
getValueByPoints(jogo(A,B,_),preto,jogo(A1,B1,_),Value) :- Adif is A1 - A, Bdif is B1 - B, V1 is Bdif - Adif, Value is V1 * 10.

getValueByPecas(JogoI, Cor, Pos, Value):-   getValueByPecas(JogoI,Cor,PecasInicial), !,
                                            getValueByPecas(Pos,Cor,PecasFinal), !,
                                            V1 is PecasFinal - PecasInicial,
                                            ((V1 > 0, PecasFinal is 3) -> Value is 10;
                                            (V1 > 0, PecasFinal < 3) -> Value is 10;
                                            (V1 < 0, PecasFinal is 3) -> Value is 5;
                                            (V1 < 0, PecasFinal < 3) -> Value is -5;
                                            Value is -10).

getValueByStarving(_,Cor,Pos,Value):-   getStarvingNum(Pos,Cor,Res),
                                        Value is 0 - Res.

%getValueByMembros(JogoI,Cor,Pos,Value):-

getValue(JogoI,Cor,Pos,Value):- getValueByPoints(JogoI,Cor,Pos,V1),
                                getValueByPecas(JogoI,Cor,Pos,V2),
                                getValueByStarving(JogoI,Cor,Pos,V3),
                                %getValueByMembros(JogoI,Cor,Pos,V4),
                                %addMore
                                somarLista([V1,V2,V3],Value).


avaliarJogadaOp(JogoI,_,[],-2000,JogoI).
avaliarJogadaOp(JogoI,Cor,[Pos|Possibilidades],N,JogoF) :-  avaliarJogadaOp(JogoI,Cor,Possibilidades,N1,J1),
                                                            getValue(JogoI,Cor,Pos,Value), melhorTabuleiro(J1,N1,Pos,Value,JogoF,N).




%avaliarJogadaNotOp(JogoI,_,[],0,JogoI).
%avaliarJogadaNotOp(JogoI,Cor,[Pos|Possibilidades],N,JogoF).
