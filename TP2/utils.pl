flat([],[]).
flat([T|Ts], Rs):-
  flat(Ts, R1),
  append(T, R1,Rs).
