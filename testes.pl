/*TESTES*/

testAddGarra :- tabuleiro(A), addGarra(A,branco,0,B), addGarra(B,preto,0,C), desenharTabuleiro(C).

testAddPerna :- tabuleiro(A), addPerna(A,branco,0,B), addPerna(B,preto,0,C), desenharTabuleiro(C).

testEsfomeados :-   tabuleiro2(A), removeEsfomeados(A,branco,Removidos,B), desenharTabuleiro(B), write('Removidos:'), write(Removidos),
                    nl, removeEsfomeados(B,preto,R2,C), desenharTabuleiro(C) , write('Removidos:'), write(R2).
