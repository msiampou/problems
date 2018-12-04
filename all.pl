
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
% NOTE(1): There are test cases that have more than 1 correct solutions.

% Replace each letter with its corresponding number. Same thing for letters.
% If a pair of letters appers in solution list, their corresponding numbers are inf.
% When solutions are inf an empty list is returned, to show so.

replace(_, _, [], []).
replace(X, R, [X|T1], [R|T2]) :- replace(X, R, T1, T2).
replace(X, R, [H|T1], [H|T2]) :- \+ (H = X), replace(X, R, T1, T2).

keepletters([],[]).
keepletters([H1|T1],[H1|R]) :- \+ number(H1), keepletters(T1,R).
keepletters([_|T1],R) :- keepletters(T1,R).

fillones(_,[],[]).
fillones([(H1,N)|T1],[H2|T2],[(H1,N)|R]) :- H1==H2, fillones(T1,T2,R).
fillones([],[H2|T2],[(H2,K)|R]) :- K is 1, fillones([],T2,R).
fillones([(H1,N)|T1],[H2|T2],[(H2,K)|R]) :- K is 1, fillones([(H1,N)|T1],T2,R).

fitting([],[],[]).
fitting([H1|T1], [H2|T2], [(H2,H1)|NewT])   :-    number(H1), \+ number(H2), replace(H2,H1,T2,L2), replace(H2,H1,T1,L1), fitting(L1, L2, NewT).
fitting([H1|T1], [H2|T2], [(H1,H2)|NewT])   :- \+ number(H1),    number(H2), replace(H1,H2,T1,L1), replace(H1,H2,T2,L2) ,fitting(L1, L2, NewT).
fitting([H1|T1], [H2|T2], NewT)             :- \+ number(H1), \+ number(H2),                                             fitting(T1, T2, NewT).
fitting([H1|T1], [H2|T2], NewT)             :-    number(H1),    number(H2), H1 =:= H2,                                  fitting(T1, T2, NewT).

solvelists(L1,L2,F) :- keepletters(L1,R1), keepletters(L2,R2), append(R1,R2,Letters), sort(Letters,T), fitting(L1,L2,R3),
                        reverse(L1,NewL1), reverse(L2,NewL2), fitting(NewL1,NewL2,R4), append(R3,R4,R5), sort(R5,Res), fillones(Res,T,F).

%----------------------------------------- Ex.3 -----------------------------------------------------------------------------------------------------------%
% NOTE(1): Maybe we could use less functions.

% 1.Short lists.
% 2.Find the shortest list.
% 3.For every number in shortest list find the min diffence with other's list's elements.
% 4.Discard the element that gives the biggest diffence from the 2nd list.
% 5.Repeat until length(L1) = length(L2).
% 7.Find max difference (U).

findU([], _, U, U).
findU(_, [], U, U).
findU([H1|L1], [H2|L2], U, Res) :- Diff is H1-H2, abs(Diff,Num), Num > U, findU(L1,L2,Num,Res).
findU([H1|L1], [H2|L2], U, Res) :- Diff is H1-H2, abs(Diff,Num), Num =< U, findU(L1,L2,U,Res).

indexOf([], _, 0).
indexOf([N|_], N, 0).
indexOf([_|T], N, I):- indexOf(T,N,X), I is X+1.

dif([],_,[]).
dif([H|T],Num,[D1|L]) :- D is H-Num, abs(D,D1), dif(T,Num,L).

fix([],_,[]).
fix([H|L1],L2,[Num|R]) :- dif(L2,H,Diff), min_list(Diff,Min), indexOf(Diff,Min,Pos), nth0(Pos,L2,Num), select(Num,L2,L3), fix(L1,L3,R).

ugliness(X,Y,U) :- msort(X,L1), msort(Y,L2), length(L1,Len1), length(L2,Len2), Len1 > Len2, fix(L2,L1,F), findU(F,L2,0,U).
ugliness(X,Y,U) :- msort(X,L1), msort(Y,L2), length(L1,Len1), length(L2,Len2), Len1 < Len2, fix(L1,L2,F), findU(L1,F,0,U).
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

%----------------------------------------- Ex.5 ------------------------------------------------------------------------------------------------------%
% NOTE(1): Permutation seems to slow down effiency. Have to find smth else.

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
