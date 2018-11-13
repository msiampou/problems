% --------            NOOB VERSION            --------% 

add([Result],0,Y,X,Result). 	 
add([List],N,Y,X,Z) :- N>1, C is N-1, Num is Y-2, Rem is X-Y, append(List,[Num],Result), add([Result],C,Num,Rem,Z).
add([List],N,Y,X,Z) :- N=<1, C is N-1, Num is Y-2, Rem is X-Y, append(List,[Rem],Result), add([Result],C,Num,Rem,Z).
biscuits(X,Y,Z) :- N is X/Y, C is Y-1, append([],[N],L), add([L],C,N,X,Z).

% --------            PRO VERSION            --------%

biscuits(_,0,[]).
biscuits(K,1,[K|L]) :- biscuits(K,0,L).
biscuits(K,N,[H|L]) :- Z is div(K,N), random_between(1,Z,H), Rem is K-H, C is N-1, biscuits(Rem,C,L).
