create_formula(NVars, NClauses, Density, Formula) :-
    formula(NVars, 1, NClauses, Density, Formula).
 
formula(_, C, NClauses, _, []) :-
  C > NClauses.
formula(NVars, C, NClauses, Density, [Clause|Formula]) :-
  C =< NClauses,
  one_clause(1, NVars, Density, Clause),
  C1 is C + 1,
  formula(NVars, C1, NClauses, Density, Formula).

one_clause(V, NVars, _, []) :-
  V > NVars.
one_clause(V, NVars, Density, Clause) :-
  V =< NVars,
  rand(1, 100, Rand1),
  (Rand1 < Density ->
     (rand(1, 100, Rand2),
      (Rand2 < 50 ->
       Literal is V ;
       Literal is -V),
      Clause = [Literal|NewClause]) ;
     Clause = NewClause),
  V1 is V + 1,
  one_clause(V1, NVars, Density, NewClause).

rand(N1, N2, R) :-
  random(R1),
  R is R1 mod (N2 - N1 + 1) + N1.
