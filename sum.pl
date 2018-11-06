list_sum([],Move).
list_sum([Sum|[]],Move) :- Sum>10, Move = "next", list_sum([],Move).
list_sum([Sum|[]],Move) :- Sum=<10, Move = "stop", list_sum([],Move).
list_sum([H1,H2|T],Move) :- N is H1+H2, list_sum([N|T],Move).
