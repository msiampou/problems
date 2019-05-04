
/*reversing list*/
reverse_list([],Z,Z).
reverse_list([H|T],RL,L) :- reverse_list(T,[H|RL],L).

/*pushing a list back to other list*/
push_back([],[],[]).
push_back([],[H|L],[H|R]) :- push_back([],L,R).
push_back([H|P],L,[H|R]) :- push_back(P,L,R).

/*prints char by char*/
pprint([]).
pprint([H|L]) :- write(H), pprint(L).

/*prints pattern until width is reached*/
print_line(P,[],1,L,P) :- pprint(L), nl.
print_line(P,[],0,L,P) :- reverse_list(L,[],RL), pprint(RL), nl.
print_line([H|P],[_|W],F,L,NP) :- push_back(P,[H],L3), print_line(L3,W,F,[H|L],NP).

/*printing lines until height is reached*/
construct(_,_,[],_).
construct(P,W,[_|H],1) :- print_line(P,W,1,[],NP), construct(NP,W,H,0).
construct(P,W,[_|H],0) :- print_line(P,W,0,[],NP), construct(NP,W,H,1).

disnake(P,W,H) :- construct(P,W,H,0).
