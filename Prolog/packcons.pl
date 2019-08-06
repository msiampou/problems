exists(X,[X|_]).
exists(X,[_|Y]) :- exists(X,Y).

seq([],Temp,Temp).
seq([H|L1],Temp,Res) :- exists(H,Temp), append([H],Temp,NL), seq(L1,NL,Res).
seq([H|L1],[],Res) :- append([H],[],NL), seq(L1,NL,Res).
seq(_,Temp,Temp).

packcons([],[]).
packcons(L1,[Y|L2]) :- seq(L1,[],Y), append(Y,Rest,L1), packcons(Rest,L2).
