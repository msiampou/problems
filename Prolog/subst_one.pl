subst_one(X, [X|L1], Y, [Y|L1]).
subst_one(X, [K|L1], Y, [K|L2]) :- subst_one(X, L1, Y, L2).
