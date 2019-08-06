givensum(L1, N, L2) :- givensum2(L1, 0, N, L2).

givensum2([], N, N, []). 
givensum2([H|L1], C, N, [H|L2]):- CN is H + C, givensum2(L1, CN, N, L2).
givensum2([_|L1], C, N, L2):- givensum2(L1, C, N, L2).
