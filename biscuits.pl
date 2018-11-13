newList([Result],0,Y,X,Result).
newList([List],N,Y,X,Z) :- N>1, C is N-1, Num is Y-1, Max is X-Y, append(List,[Num],Result), newList([Result],C,Num,Max,Z).
newList([List],N,Y,X,Z) :- N=<1, C is N-1, Num is Y-1, Max is X-Y, append(List,[Max],Result), newList([Result],C,Num,Max,Z).
biscuits(X,Y,Z) :- N is X/Y, C is Y-1, append([],[N],L), newList([L],C,N,X,Z).
