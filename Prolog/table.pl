getTable([]).
getTable([X|L]) :- member(X,[true,false]), getTable(L).

eval(or(true,_),true).
eval(or(_,true),true).
eval(or(false,false),false).
eval(or(Expr,false),R) :- eval(Expr,Res), eval(or(Res,false),R).
eval(or(false,Expr),R) :- eval(Expr,Res), eval(or(Res,false),R).
eval(or(Expr1,Expr2),R) :- eval(Expr1,Res1), eval(Expr2,Res2), eval(or(Res1,Res2),R).
eval(and(true,true),true). 
eval(and(_,false),false). 
eval(and(false,_),false).
eval(and(Expr,true),R) :- eval(Expr,Res), eval(and(Res,true),R).
eval(and(true,Expr),R) :- eval(Expr,Res), eval(and(true,Res),R).
eval(and(Expr1,Expr2),R) :- eval(Expr1,Res1), eval(Expr2,Res2), eval(and(Res1,Res2),R).
eval(not(true),false).
eval(not(false),true). 
eval(not(Expr),R) :- eval(Expr,R).

table(Expr,Vars) :- getTable(Vars), write(Vars), eval(Expr,R), write(R).    
