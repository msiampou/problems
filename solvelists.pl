replace(_, _, [], []).
replace(X, R, [X|T1], [R|T2]) :- replace(X, R, T1, T2).
replace(X, R, [H|T1], [H|T2]) :- H \= X, replace(X, R, T1, T2).

solvelists([],[],[]).
solvelists([H1|T1], [H2|T2], [(H2,H1)|NewT]) :- number(H1), \+ number(H2), replace(H2,H1,T2,L), solvelists(T1, L, NewT).
solvelists([H1|T1], [H2|T2], [(H1,H2)|NewT]) :- \+ number(H1), number(H2), replace(H1,H2,T1,L), solvelists(L, T2, NewT).
solvelists([H1|T1], [H2|T2], NewT) :- \+ number(H1), \+ number(H2), H1 == H2, solvelists(T1, T2, NewT).
solvelists([H1|T1], [H2|T2], NewT) :- number(H1), number(H2), H1 =:= H2, solvelists(T1, T2, NewT).
