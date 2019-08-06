construct_list(1,[1]).
construct_list(N,[N|List]) :- N > 1, N1 is N-1, construct_list(N1,List).

getMod(List,Num,X) :- member(X,List), Y is mod(Num,X), Y == 0.

split_list(_,_,[],_,[]).
split_list(Max,Max,[H|L],Temp,[Y|R]) :- append([H],Temp,Y), split_list(1,Max,L,[],R).
split_list(N,Max,[H|L],Temp,R) :- N < Max, append([H],Temp,Y), N1 is N+1, split_list(N1,Max,L,Y,R).

spliteq(L,NL) :- length(L,N), construct_list(N,List), getMod(List,N,Max), split_list(1,Max,L,[],NL). 
