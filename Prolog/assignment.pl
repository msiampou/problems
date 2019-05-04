/* constructs a list with ints from 1 to N */
pred(1,[1]).
pred(N,[N|T]) :- N > 1, N1 is N-1, pred(N1,T).

reverse([],Z,Z) :- !.
reverse([H|T],Z,Acc) :- reverse(T,Z,[H|Acc]).

between(I, J, I) :- I =< J.
between(I, J, X) :- I < J, I1 is I+1, between(I1, J, X).

/* constructs a dummy list with length = NP */
np_list(0,[]).
np_list(NP,[_|L]) :- N is NP-1, np_list(N,L). 

/* check if an activity fits */
fit(_,S,E,C,ST,[]) :- Dif is E-S, C1 is C+Dif, C1 =< ST. 
fit(Pos,S,E,C,ST,[X-Y|Res]) :- Pos == Y, activity(X,act(S1,E1)), Dif is E1-S1, C1 is C+Dif, C1 =< ST, E1 < S, fit(Pos,S,E,C1,ST,Res).  
fit(Pos,S,E,C,ST,[X-Y|Res]) :- Pos == Y, activity(X,act(S1,E1)), Dif is E1-S1, C1 is C+Dif, C1 =< ST, E < S1, fit(Pos,S,E,C1,ST,Res).
fit(Pos,S,E,C,ST,[_-Y|Res]) :- Pos \= Y, fit(Pos,S,E,C,ST,Res).

/* assign activities to each person, first NP-1, do not change after backtracking */
assign(_,1,_,[]).
assign(NP,Curr,ST,[Act-Pos|Res]) :- assign(NP,C,ST,Res), Curr is C+1, C >= NP, between(1,NP,Pos), activity(Act,act(S,E)), fit(Pos,S,E,0,ST,Res).
assign(NP,Curr,ST,[Act-C|Res]) :- assign(NP,C,ST,Res), Curr is C+1, C < NP, activity(Act,act(S,E)), fit(C,S,E,0,ST,Res).


assignment(NP,ST,ASP,ASA) :-  findall(A,activity(A,_),Activities),
                              make_template1(Activities,ASA),
                              length(Activities,NActs),
                              N is NActs+1,
                              assign(NP,N,ST,ASA), 
                              pred(NP,LNP),
                              reverse(LNP,RLNP),
                              make_template2(RLNP,Templ),
                              create(ASA,Templ,NASP),
                              add(NASP,ASP).

/* template for ASP */
make_template1([],[]).
make_template1([Act|Activities],[Act-_|Res]) :- make_template1(Activities,Res).

/* template for ASA */
make_template2([],[]).
make_template2([N|NP],[N-[]-0|Res]) :- make_template2(NP,Res).

/* compute personal time */
compute([],Res,Res).
compute([Act|L],C,Res) :- activity(Act,act(S,E)), Dif is E-S, Count is C+Dif, compute(L,Count,Res). 

/* adds personal time to list of lists */
add([],[]).
add([X-Y-Z|L],[X-Y-PT|L1]) :- compute(Y,Z,PT), add(L,L1). 

/* creates ASA */
create([],Res,Res).
create([X-Y|L],Templ,Res) :- add_nth(Templ,Y,X,NewL), create(L,NewL,Res).

/* add activity to nth list of lists */
add_nth([N-T-Y|L],1,X,[N-[X|T]-Y|L]).
add_nth([N-H-Y|ASP],Pos,X,[N-H-Y|NL]) :- add_nth(ASP,P,X,NL), Pos is P+1.  
