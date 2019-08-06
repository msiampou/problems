max_sub([H|L1],[H|L2],[H|Res]) :- max_sub(L1,L2,Res).
max_sub(_,_,[]).

maxcsl2([],_,R,R).
maxcsl2([H|L1],L2,D,R) :- max_sub([H|L1],L2,Y), length(Y,Len1), length(D,Len2), Len1>Len2, maxcsl2(L1,L2,Y,R).
maxcsl2([H|L1],L2,D,R) :- max_sub([H|L1],L2,Y), length(Y,Len1), length(D,Len2), Len1=<Len2, maxcsl2(L1,L2,D,R).

maxcsl3([],_,R,R).
maxcsl3([X|L1],L2,D,R) :- maxcsl2(L2,[X|L1],[],R1), maxcsl2([X|L1],L2,[],R2), longest(R1,R2,Y), longest(D,Y,N), maxcsl3(L1,L2,N,R).  

maxcsl(L1,L2,R) :- maxcsl3(L1,L2,[],R).
