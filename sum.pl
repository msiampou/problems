list_sum([],Move).
list_sum([Item|[]],Move) :- Item>10, Move = "next", list_sum([],Move).
list_sum([Item|[]],Move) :- Item=<10, Move = "stop", list_sum([],Move).
list_sum([Item1,Item2|Tail],Move) :- N is Item1+Item2, list_sum([N|Tail],Move).
