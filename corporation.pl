indexOf([], _, 0).
indexOf([Element|_], Element, 0).
indexOf([_|Tail], Element, Index):- indexOf(Tail, Element, Index1), Index is Index1+1.

successors(L,3,[]).
successors(L,X,Y) :- indexOf(L,X,Pos), X1 is Pos+2, successors(L,X1,Y1), Y is Y1+1.

%find how many times a specific number appears in list
find([],_,0).
find([H|T],N,Y) :- H =:= N, find(T,N,X), Y is X+1.
find([_|T],N,X) :- find(T,N,X).

%iterating list N times
loop(_,0,[]).
loop(L,N,[H|T]) :- find(L,N,H), Num is N-1, loop(L,Num,T).

corporation(L1,Result) :- length(L1,Len), N is Len+1, loop(L1,N,L2), reverse(L2,Result).
