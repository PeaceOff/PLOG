imprimeVencedor(branco):- write('Jogador Branco Ganhou! Parabens!'), nl.
imprimeVencedor(preto):- write('Jogador Preto Ganhou! Parabens!'), nl.
imprimeVencedor(empate):- write('Ninguem Ganhou! Empate!'), nl.

jogadaBranco(jogo(A,B,Tab),jogo(A1,B1,T1)) :- desenharJogo(A,B,Tab), write('E a vez de branco jogar!'), read(X), write(X), nl, A1 = A, B1 = B, T1 = Tab.
jogadaPreto(jogo(A,B,Tab),jogo(A1,B1,T1)) :- desenharJogo(A,B,Tab), write('E a vez de preto jogar!'), read(X), write(X), nl, A1 = A, B1 = B, T1 = Tab.


dica:-  write('Escolha uma das seguintes acoes :'),nl,
        write('mover : m | addGarra : g | addPerna : p | addPeca : a | capturar : c'), nl,
        read(A), acao(A).

acao(plog):- write('Para o ano ha mais!'), nl, acao(404).
acao(_):- write('Opcao Invalida!'), nl, dica.
