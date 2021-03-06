ones(Max, Max, []).
ones(N, Max, [1|L]) :- N1 is N+1, ones(N1, Max, L).

serial(Max, Max, []).
serial(N, Max, [N1|L]) :- N1 is N+1, serial(N1, Max, L).

rnth([],_,_,[]).
rnth([_|T],Pos,Pos,[-1|X]) :- N1 is Pos+1, rnth(T,N1,Pos,X).
rnth([H|T],N,Pos,[H|X]) :- N1 is N+1, rnth(T,N1,Pos,X).

%find empolyee --call it with starting pos = 2. --
ancestor([],_,_,X) :- X is 0.
ancestor([X|_],Pos,Pos,X).
ancestor([_|T],N,Pos,X) :- N1 is N+1, ancestor(T,N1,Pos,X).

%find the first number that does not exist in list.
notexists(L,[H|_],H) :- \+ member(H,L).
notexists(L,[_|T],Num) :- notexists(L,T,Num).

%adding coins to a specific empolyee
add([],_,_,_,[]).
add([X|Z],N,Pos,C,[Y|L]) :- N=:=Pos, Y is X+C, N1 is N+1, add(Z,N1,Pos,C,L).
add([X|Z],N,Pos,C,[X|L]) :- N1 is N+1, add(Z,N1,Pos,C,L).

%giving coins to all empolyees
give_coins(_,Y,0,_,Y).
give_coins(L1,L2,Num,X,Y) :- ancestor(L1,2,Num,N), X1 is X+1, add(L2,1,N,X1,NewL), give_coins(L1,NewL,N,X1,Y).

%the employer Num starts a job and quites afterwards
work(_,Z,[],Z).
work(L,Z,S,Res) :- notexists(L,S,Num), give_coins(L,Z,Num,1,Z1), delete(S,Num,S1), rnth(L,2,Num,L1), work(L1,Z1,S1,Res).

corporation(L,Result) :- length(L,Len1), Len is Len1+1, ones(0,Len,Z), serial(0,Len,S), work(L,Z,S,Result).
