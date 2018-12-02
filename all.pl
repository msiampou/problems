
%----------------------------------------- Ex.1 ------------------------------------------------------------------------------------------------------%
% NOTE(1): random_between might generate the same number.
% NOTE(2): Perhaps we could write one more function to avoid dublicates,
%           but more code would be added.
% NOTE(3): Perhaps we could find a better way to avoid different numbers in list.

% Every friend takes N(=Number of friends remaining) biscuits,
% except from the last one who takes the last remained.
biscuits(_,0,[]).
biscuits(K,1,[K|L]) :- biscuits(K,0,L).
biscuits(K,N,[N|L]) :- Rem is K-N, C is N-1, biscuits(Rem,C,L).

%----------------------------------------- Ex.2 ------------------------------------------------------------------------------------------------------%
% NOTE(1): 1. Add [x,y][y,x] test case.

% Replace each letter with its corresponding number. Same thing for letters.
% If a pair of letters appers in solution list, their corresponding numbers are inf.
% When solutions are inf we use a special case: every letter equals to 1.

replace(_, _, [], []).
replace(X, R, [X|T1], [R|T2]) :- replace(X, R, T1, T2).
replace(X, R, [H|T1], [H|T2]) :- \+ (H = X), replace(X, R, T1, T2).

solvelists([],[],[]).
solvelists([H1|T1], [H2|T2], [(H2,H1)|NewT])        :-    number(H1), \+ number(H2), replace(H2,H1,T2,L2), replace(H2,H1,T1,L1), solvelists(L1, L2, NewT).
solvelists([H1|T1], [H2|T2], [(H1,H2)|NewT])        :- \+ number(H1),    number(H2), replace(H1,H2,T1,L1), replace(H1,H2,T2,L2) ,solvelists(L1, L2, NewT).
solvelists([H1|T1], [H2|T2], NewT)                  :- \+ number(H1), \+ number(H2), H1 == H2,                                   solvelists(T1, T2, NewT).
solvelists([H1|T1], [H2|T2], [(H2,K), (H1,K)|NewT]) :- \+ number(H1), \+ number(H2), replace(H2,H1,T2,L2), replace(H2,H1,T1,L1), solvelists(L1, L2, NewT), \+ number(H1), \+ number(H2), K is 1.
solvelists([H1|T1], [H2|T2], [(H2,H1)|NewT])        :- \+ number(H1), \+ number(H2), replace(H2,H1,T2,L2), replace(H2,H1,T1,L1), solvelists(L1, L2, NewT).
solvelists([H1|T1], [H2|T2], NewT)                  :-    number(H1),    number(H2), H1 =:= H2,                                  solvelists(T1, T2, NewT).

%----------------------------------------- Ex.3 ------------------------------------------------------------------------------------------------------%
% NOTE(1): Maybe we could use less functions.

% 1.Find the shortest list.
% 2.Find the last element of this list.
% 3.Fill the empty positions with this number, now length(L1) = length(L2).
% 4.Find the positions of max differences of L1 and L2.
% 5.Delete numbers of such positions in longest list.
% 6.Now, find U.

findU([], _, U, U).
findU(_, [], U, U).
findU([H1|L1], [H2|L2], U, Res) :- Diff is H1-H2, abs(Diff,Num), Num > U, findU(L1,L2,Num,Res).
findU([H1|L1], [H2|L2], U, Res) :- Diff is H1-H2, abs(Diff,Num), Num =< U, findU(L1,L2,U,Res).

indexOf([], _, 0).
indexOf([N|_], N, 0).
indexOf([_|T], N, I):- indexOf(T,N,X), I is X+1.

delete_nth([],_,_,[]).
delete_nth([_|T], Pos, Pos, L) :- N1 is Pos+1, delete_nth(T,N1,Pos,L).
delete_nth([H|T], N, Pos, [H|L]) :- N1 is N+1, delete_nth(T,N1,Pos,L).

fix(L,_,N,N,L).
fix(L,Dif,C,N,Res) :- C1 is C+1, max_list(Dif,Num), indexOf(Dif,Num,Pos), delete_nth(L,0,Pos,L1), delete(Dif,Num,D), fix(L1,D,C1,N,Res).

diff([],[],[]).
diff([H1|L1], [H2|L2], [Num|L]) :- Diff is H1-H2, abs(Diff,Num), diff(L1,L2,L).

fill(L,N,N,_,L).
fill(L,C,N,Num,R) :- C1 is C+1, append(L,[Num],L1), fill(L1,C1,N,Num,R).

ugliness(X,Y,U) :- msort(X,L1), msort(Y,L2), length(L1,Len1), length(L2,Len2), Len1 > Len2, T is Len1-Len2, nth1(Len2,L2,Num), fill(L2,0,T,Num,NewL2),
                   diff(L1,NewL2,Diff),
                   fix(L1,Diff,0,T,F),
                   findU(F,L2,0,U).

ugliness(X,Y,U) :- msort(X,L1), msort(Y,L2), length(X,Len1), length(Y,Len2), Len1 < Len2, T is Len2-Len1, nth1(Len1,L1,Num), fill(L1,0,T,Num,NewL1),
                   diff(NewL1,L2,Diff),
                   fix(L2,Diff,0,T,F),
                   findU(L1,F,0,U).

ugliness(X,Y,U) :- msort(X,L1), msort(Y,L2), findU(L1,L2,0,U).

%----------------------------------------- Ex.4 ------------------------------------------------------------------------------------------------------%

% 1.Construct a list of coins initialized with 1.
% 2.Choose the one that does not exist in list.
% 3.Find his ancestors and add coins based on counter.
% 4.Remove 1st ansestor from list and repeat steps.

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
ancestor([_|T],N,Pos,X) :- N1 is N+1, ancestor(T,N1,Pos,X).     %decrease with 2 first

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

%----------------------------------------- Ex.5 ------------------------------------------------------------------------------------------------------%
% NOTE(1): Permutation seems to slow down effiency. Gonna change if I have time.

% Find permutation of the 1st list
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

%checks if a prmutation fits
fit([],_,_,_).
fit(L,P,N,Len) :- delsp(L,N,L1), delsp([P],N,[L2|_]), findpos(L1,L2,Pos), Pos=<Len, deletelist(L,Pos,0,NewL), Len1 is Len-1, Num is N+1, fit(NewL,P,Num,Len1).

%finds all permutations of a specific list
permutation([],[]).
permutation(L,[X|Y]) :- select(X,L,Q), permutation(Q,Y).

findlist([H|T],Y) :- permutation(H,Y), length(Y,Len), fit([H|T],Y,1,Len).
