dica:-  write('Escolha uma das seguintes acoes :'),nl,
        write('mover : m | addGarra : g | addPerna : p | addPeca : a'), nl,
        read(A), acao(A).

acao(plog):- write('Para o ano ha mais!'), nl, acao(404).
acao(_):- write('Opcao Invalida!'), nl, dica.
