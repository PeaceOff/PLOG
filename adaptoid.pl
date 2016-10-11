tabuleiro( [
            [#,#,#,#,'',['W',5,5],'','',#,#,#,#],
			[#,#,#,'','','','','','',#,#,#],
			[#,#,'','','','','','','','',#,#],
			[#,'','','',['B',6,5],'','','','','','',#],
			[#,#,'','','','','','','','',#,#],
			[#,#,#,'','','','','','',#,#,#],
			[#,#,#,#,'','','','',#,#,#,#]
           ]
          ).


desenhar(#) :- write('###').
desenhar(''):- write('   ').
desenhar([A,B,C]):- write(B), write(A), write(C).

desenharMember(0,S):- write('').
desenharMember(N,S):- N > 0, N < 6, write(S), N1 is N - 1, desenharMember(N1,S).
desenharMember(6,S):- write(S),write(S),write(S),write(S),write(S).

desenharMemberC(6,S):- write(S).
desenharMemberC(N,S):- N < 6, write(' ').

desenharEspaco(0):- write('').
desenharEspaco(N):- N > 0, N < 6, write(' '), N1 is N - 1, desenharEspaco(N1).
desenharEspaco(N):- write('').
desenharResto(N):-  R is 5-N, desenharEspaco(R).

desenharC(#):-      write('       ').
desenharC(''):-     write('/     \\').
desenharC([A,B,C]):-write('/'), desenharMember(B,'Y'), desenharResto(B), write('\\').

desenharM(#):-      write('       ').
desenharM(''):-     write('|     |').
desenharM([A,B,C]):-write('|'), desenharMemberC(B,'Y') ,write(' '), write(A) , write(' ') ,  desenharMemberC(C,'L'), write('|').

desenharB(#):-      write('       ').
desenharB(''):-     write('\\     /').
desenharB([A,B,C]):-write('\\'), desenharMember(C,'L'), desenharResto(C), write('/').

desenharS(#):-      write('       ').
desenharS(''):-     write('-------').
desenharS([A,B,C]):-write('-------').


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



/*
   /BBBBB\/     \
   |B O P||E A E|
   \PPPPP/\     /
    ------------
   /_ _ _\/_ _ _\
   |E O E||E A E|
   \_ _ _/\_ _ _/
/**/
