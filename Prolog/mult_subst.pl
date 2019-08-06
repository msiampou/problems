repl_all([],_,_,[]).
repl_all([X|L], [_|T], [Y|Ys], [Y|NL]) :- X==1, repl_all(L,T,Ys,NL).
repl_all([_|L], [H|T], Ys, [H|NL]) :- repl_all(L,T,Ys,NL).

mult_subst(Is, Xs, Ls, Ys) :- zeros(Xs,Z), looop_constr(Is,Z,Indx), repl_all(Indx,Xs,Ls,Ys).
