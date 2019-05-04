activity(a01, act(0,3)).
activity(a02, act(0,4)).
activity(a03, act(1,5)).
activity(a04, act(4,6)).
activity(a05, act(6,8)).
activity(a06, act(6,9)).
activity(a07, act(9,10)).
activity(a08, act(9,13)).
activity(a09, act(11,14)).
activity(a10, act(12,15)).
activity(a11, act(14,17)).
activity(a12, act(16,18)).
activity(a13, act(17,19)).
activity(a14, act(18,20)).
activity(a15, act(19,20)).

assignment(NP,TS,[1-[A1],2-[A2],3-[A3]]) :- activity(A1,act(S1,_)), activity(A2,act(S2,_)), activity(A3,act(S3,_)), A1 \= A2, A2 \= A3, A1 \= A3, S1<TS, S2<TS, S3<TS.
