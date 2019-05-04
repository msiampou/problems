:- lib(ic_global).

numpart(N,L1,L2) :- Len is N div 2, length(L2,Len), L2 #:: 1..N,
                     Len1 is Len-1, length(Temp,Len1), Temp #:: 2..N,
                     Sum is (N*(N+1)) div 4,
                     Sqsum is ((N*(N+1))*(2*N+1)) div 12,
                     constrain(Temp,S1,1,1,Sum,Sqsum),
                     constrain(L2,_,0,0,Sum,Sqsum),
                     add1(Temp,L1), add1(S1,NS1),
                     sum(L1) #= Sum, sum(NS1) #= Sqsum,
                     append(L1,L2,Set), sorted(Set,Sset),
                     orderedList(L3,N), same(L3,Sset),
                     generate(Temp), generate(L2).

orderedList(L,N):- orderedList(L,1,N).
orderedList([N],N,N).
orderedList([H|T],C,N):- C < N, H is C, C1 is C+1, orderedList(T,C1,N).

add1(Xs,[1|Xs]).

same([],[]).
same([H1|R1], [H2|R2]):- H1 = H2, same(R1, R2).

constrain([],[],_,_,_,_).
constrain([X|Xs],[S|Sq],C1,C2,Sum,Ssum) :- fill(X,Xs), S #= X*X, I #= C1+X, J #= C2+S, I #=< Sum , J #=< Ssum, constrain(Xs,Sq,I,J,Sum,Ssum).

fill(_,[]).
fill(X,[Y|Ys]) :- X #< Y , fill(X,Ys).

generate(L1) :- search(L1, 0, largest, indomain_max, complete, []).
