sum_chars([],[]).
sum_chars([X|_],[]) :- name(' ',[X]).
sum_chars([X|Chars],[X|Word]) :- \+name(' ',[X]), sum_chars(Chars,Word).

collect_words([],[]).
collect_words(Chars,[Y|Words]) :- sum_chars(Chars,Word), name(Y,Word), append(Word,[],Chars), collect_words([],Words).
collect_words(Chars,[Y|Words]) :- sum_chars(Chars,Word), name(Y,Word), append(Word,[_|Rest],Chars), collect_words(Rest,Words).

tokenize(List,Words) :- name(List,Chars), collect_words(Chars,Words).
