split(0,_,[]).
split(N,[X|L],[X|R]) :- N1 is N-1, split(N1,L,R). 

subseqs(_,[],[]).
subseqs(N,X,[]) :- length(X,L), N>L.
subseqs(N,[X|List],[Y|Subseqs]) :- split(N,[X|List],Y), subseqs(N,List,Subseqs).  

lcs([],_,[]). 
lcs(_,[],[]).
lcs([H|L1],[H|L2],[H|Lcs]) :- lcs(L1,L2,Lcs).
lcs([H1|L1],[H2|L2],Lcs):- lcs(L1,[H2|L2],Lcs1), lcs([H1|L1],L2,Lcs2), longest(Lcs1,Lcs2,Lcs).

longest(L1,L2,L1) :- length(L1,Length1), length(L2,Length2), Length1 > Length2.
longest(L1,L2,L2) :- length(L1,Length1), length(L2,Length2), Length1 =< Length2.
