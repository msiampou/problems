find([],_,Res,Res).
find([H|T],N,X,Res) :- H =:= N, Y is X+1, find(T,N,Y,Res).
find([_|T],N,X,Res) :- find(T,N,X,Res).

%iterating list N times
loop(_,0,[]).
loop(L,N,[H|T]) :- find(L,N,0,H), Num is N-1, loop(L,Num,T).

corporation(L1,Result) :- length(L1,Len), N is Len+1, loop(L1,N,L2), reverse(L2,Result).
