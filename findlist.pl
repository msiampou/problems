%delete a specific number from every list
delsp([],_,[]).
delsp([H|T],Num,[Y|X]) :- delete(H,Num,Y), delsp(T,Num,X).

%checks if 2 lists are the same
same([],[]).
same([H1|R1], [H2|R2]):- H1 =:= H2, same(R1, R2).

%deletes a specific list from a list of lists
deletelist([],_,_,[]).
deletelist([_|T],Pos,N,L) :- N=:=Pos, N1 is N+1, deletelist(T,Pos,N1,L).
deletelist([H|T],Pos,N,[H|L]) :- N1 is N+1, deletelist(T,Pos,N1,L).

%find the position of a specific list in a list of lists
findpos([],_,0).
findpos([H|_], Y, 0) :- same(H,Y).
findpos([_|T], Y, N) :- findpos(T,Y,N1), N is N1+1.

%checks if a prmutation fits
fit([],_,_,_).
fit(L,P,N,Len) :- delsp(L,N,L1), delsp([P],N,[L2|_]), findpos(L1,L2,Pos), Pos=<Len, deletelist(L,Pos,0,NewL), Len1 is Len-1, Num is N+1, fit(NewL,P,Num,Len1).

%finds all permutations of a specific list
permutation([],[]).
permutation(L,[X|Y]) :- select(X,L,Q), permutation(Q,Y).

findlist([H|T],Y) :- permutation(H,Y), length(Y,Len), fit([H|T],Y,1,Len).