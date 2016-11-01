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
