biscuits(_,0,[]).
biscuits(K,1,[K|L]) :- biscuits(K,0,L).
biscuits(K,N,[N|L]) :- Rem is K-N, C is N-1, biscuits(Rem,C,L).
