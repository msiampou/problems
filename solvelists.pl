solvelists([],[],[]).
solvelists([H1|T1],[H2|T2],[(H2,H1)|NewT]) :- number(H1), \+ number(H2), solvelists(T1,T2,NewT).
solvelists([H1|T1],[H2|T2],[(H1,H2)|NewT]) :- \+ number(H1), number(H2), solvelists(T1,T2,NewT).
