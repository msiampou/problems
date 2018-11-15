dfs_paths(tree(X, void, void), [X]) :- !.
dfs_paths(tree(X, L, _R), [X|Xs]) :- dfs_paths(L, Xs).
dfs_paths(tree(X, _L, R), [X|Xs]) :- dfs_paths(R, Xs).

tree(T) :- T = tree(1, tree(2,tree(3,void,void),tree(4,tree(5,void,void),void)), void).
test(X) :- tree(T), dfs_paths(T,X).
