decode_rl([],[]).
decode_rl([(X,N)|Ys],[X|Res]) :- N > 0, N1 is N-1, decode_rl([(X,N1)|Ys],Res).
decode_rl([(X,0)|Ys],[X|Res]) :- decode_rl(Ys,Res).
decode_rl([X|Ys],[X|Res]) :- decode_rl(Ys,Res).

flatten2([], []) :- !.
flatten2([L1|L2], FL) :- !, flatten2(L1, FL1), flatten2(L2, FL2), append(FL1, FL2, FL).
flatten2(X, [X]).
