binnumbs(0, []).
binnumbs(N, [H|L]) :- N > 0, member(H, [0,1]), N1 is N - 1, binnumbs(N1, L).
