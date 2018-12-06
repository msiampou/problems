replace(_, _, [], []).
replace(X, R, [X|T1], [R|T2]) :- replace(X, R, T1, T2).
replace(X, R, [H|T1], [H|T2]) :- \+ (H = X), replace(X, R, T1, T2).

keepletters([],[]).
keepletters([H1|T1],[H1|R]) :- \+ number(H1), keepletters(T1,R).
keepletters([_|T1],R) :- keepletters(T1,R).

fillones(_,[],[]).
fillones([(H1,N)|T1],[H2|T2],[(H1,N)|R]) :- H1==H2, fillones(T1,T2,R).
fillones([],[H2|T2],[(H2,K)|R]) :- K is 1, fillones([],T2,R).
fillones([(H1,N)|T1],[H2|T2],[(H2,K)|R]) :- K is 1, fillones([(H1,N)|T1],T2,R).

fitting([],[],[]).
fitting([H1|T1], [H2|T2], [(H2,H1)|NewT])   :-    number(H1), \+ number(H2), replace(H2,H1,T2,L2), replace(H2,H1,T1,L1), fitting(L1, L2, NewT).
fitting([H1|T1], [H2|T2], [(H1,H2)|NewT])   :- \+ number(H1),    number(H2), replace(H1,H2,T1,L1), replace(H1,H2,T2,L2) ,fitting(L1, L2, NewT).
fitting([H1|T1], [H2|T2], NewT)             :- \+ number(H1), \+ number(H2),                                             fitting(T1, T2, NewT).
fitting([H1|T1], [H2|T2], NewT)             :-    number(H1),    number(H2), H1 =:= H2,                                  fitting(T1, T2, NewT).

solvelists(L1,L2,F) :- keepletters(L1,R1), keepletters(L2,R2), append(R1,R2,Letters), sort(Letters,T), fitting(L1,L2,R3),
                        reverse(L1,NewL1), reverse(L2,NewL2), fitting(NewL1,NewL2,R4), append(R3,R4,R5), sort(R5,Res), fillones(Res,T,F).
