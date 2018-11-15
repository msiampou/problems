diff([],_,[]).
diff(_,[],[]).
diff([H1|L1], [H2|L2], [Num|L]) :- Diff is H1-H2, abs(Diff,Num), diff(L1,L2,L).
