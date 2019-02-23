% Find combinations of the 1st list by moving a number to othe position.
% Check if permutation fits.
% Checking if a permutation fits:
    %   1.Delete a sp number from all lists and permutation.
    %   2.Permutation must be the same with 1 list.
    %   3.Delete this list and repeat steps for another number.
    %   4.If we end up with an empty list of lists, permutation fits.

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

fit([],_,_,_).
fit(L,P,N,Len) :- delsp(L,N,L1), delsp([P],N,[L2|_]), findpos(L1,L2,Pos), Pos=<Len, deletelist(L,Pos,0,NewL), Len1 is Len-1, Num is N+1, fit(NewL,P,Num,Len1).

rem(X,[X|L],L).
rem(X,[H|T1],[H|T2]) :- rem(X,T1,T2).

switch_pos([],[]).
switch_pos([H|T],L) :- switch_pos(T,Q), rem(H,L,Q).

findlist([H|T],Y) :- switch_pos(H,Y), fit([H|T],Y,1,5).
