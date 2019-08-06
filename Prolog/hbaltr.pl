hbaltr(0,nil).
hbaltr(1,t(nil,x,nil)).
hbaltr(H,t(L,x,R)) :- H > 1, LH is H-1, LR is H-2, hbaltr(LH,L), hbaltr(LR,R). 
hbaltr(H,t(L,x,R)) :- H > 1, LH is H-2, LR is H-1, hbaltr(LH,L), hbaltr(LR,R). 

in(X, t(_, X, _)).
in(X, t(L, _, _)) :- in(X, L).
in(X, t(_, _, R)) :- in(X, R).
