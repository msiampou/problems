exists(X,[X|_]).
exists(X,[_|Y]) :- exists(X,Y).

compr([],[]).
compr([H|X],Y) :- compr(X,Y), exists(H,Y).
compr([H|X],[H|Y]) :- compr(X,Y), \+exists(H,Y).
