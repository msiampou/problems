findU([], _, U, U).
findU(_, [], U, U).
findU([H1|L1], [H2|L2], U, Res) :- Diff is H1-H2, abs(Diff,Num), Num > U, findU(L1,L2,Num,Res).
findU([H1|L1], [H2|L2], U, Res) :- Diff is H1-H2, abs(Diff,Num), Num =< U, findU(L1,L2,U,Res).

lessUgly([], _, _, _, N, N).
lessUgly(_, [], _, _, N, N).
lessUgly([H1|L1], [H2|L2], [H3|L3], U, _, Res) :- Diff is H1-H2, abs(Diff,Num), Num > U, lessUgly(L1,L2,L3,Num,H3,Res).
lessUgly([H1|L1], [H2|L2], [_|L3], U, N, Res) :- Diff is H1-H2, abs(Diff,Num), Num =< U, lessUgly(L1,L2,L3,U,N,Res).

fix(_,_,L,0,L).
fix(L1,L2,L,T,NewL) :- N is T-1, lessUgly(L1,L2,L,0,0,Pos), delete(L,Pos,K), length(L1,Len1), length(L2,Len2), Len1 > Len2,fix(K,L2,K,N,NewL).
fix(L1,L2,L,T,NewL) :- N is T-1, lessUgly(L1,L2,L,0,0,Pos), delete(L,Pos,K), length(L1,Len1), length(L2,Len2), Len1 < Len2, fix(L1,K,K,N,NewL).

ugliness(L1,L2,U) :- sort(L1,NewL1), sort(L2,NewL2), length(L1,Len1), length(L2,Len2), Len1 =:= Len2, findU(NewL1,NewL2,0,U).
ugliness(L1,L2,U) :- sort(L1,NewL1), sort(L2,NewL2), length(L1,Len1), length(L2,Len2), Len1 > Len2, T is Len1-Len2, fix(NewL1,NewL2,NewL1,T,NewList3), findU(NewList3,NewL2,0,U).
ugliness(L1,L2,U) :- sort(L1,NewL1), sort(L2,NewL2), length(L1,Len1), length(L2,Len2), Len1 < Len2, T is Len2-Len1, fix(NewL1,NewL2,NewL2,T,NewList3), findU(NewL1,NewList3,0,U).
