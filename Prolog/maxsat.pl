:- [create_formula].
:- lib(ic_global).
:- lib(branch_and_bound).

maxsat(NV, NC, D, F, S, M) :- create_formula(NV, NC, D, F),
                            length(S, NV),
                            S #:: 0..1,
                            compute_costlist(F,S,CostList),
                            M #= sum(CostList),
                            Cost #= -M,
                            bb_min(search(S, 0, first_fail, indomain_middle, complete, []), Cost,_).
get_val(1,[X|_],X) :- !.
get_val(Idx,[_|List],X) :- Idx > 1, Idx1 is Idx-1, get_val(Idx1,List,X).

last(X,[]) :- X#=0.
last(X,Y) :- append(_,[X],Y).

compute_costlist([],_,[]).
compute_costlist([H|F],S,[K|CostList]) :- clause_eval(H,S,X), sorted(X,Xs), last(K,Xs), compute_costlist(F,S,CostList).

clause_eval([],_,[]).
clause_eval([H|T],S,[X|Res]) :- H>0, abs(H,AbsH), get_val(AbsH,S,Val), X#::0..1, X#=Val, clause_eval(T,S,Res).
clause_eval([H|T],S,[X|Res]) :- H<0, abs(H,AbsH), get_val(AbsH,S,Val), X#::0..1, X#\=Val, clause_eval(T,S,Res).
