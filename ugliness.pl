findU([], _, U, U).
findU(_, [], U, U).
findU([H1|L1], [H2|L2], U, Res) :- Diff is H1-H2, abs(Diff,Num), Num > U, findU(L1,L2,Num,Res).
findU([H1|L1], [H2|L2], U, Res) :- Diff is H1-H2, abs(Diff,Num), Num =< U, findU(L1,L2,U,Res).

indexOf([], _, 0).
indexOf([N|_], N, 0).
indexOf([_|T], N, I):- indexOf(T,N,X), I is X+1.

dif([],_,[]).
dif([H|T],Num,[D1|L]) :- D is H-Num, abs(D,D1), dif(T,Num,L).

fix([],_,[]).
fix([H|L1],L2,[Num|R]) :- dif(L2,H,Diff), min_list(Diff,Min), indexOf(Diff,Min,Pos), nth0(Pos,L2,Num), select(Num,L2,L3), fix(L1,L3,R).

ugliness(X,Y,U) :- msort(X,L1), msort(Y,L2), length(L1,Len1), length(L2,Len2), Len1 > Len2, fix(L2,L1,F), msort(F,F1), findU(F1,L2,0,U).
ugliness(X,Y,U) :- msort(X,L1), msort(Y,L2), length(L1,Len1), length(L2,Len2), Len1 < Len2, fix(L1,L2,F), msort(F,F2), findU(L1,F2,0,U).
ugliness(X,Y,U) :- msort(X,L1), msort(Y,L2), findU(L1,L2,0,U).
