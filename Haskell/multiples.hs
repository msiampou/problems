listsort [] ys = ys
listsort xs [] = xs
listsort (x:xs) (y:ys)
                       | x < y = x : listsort xs (y:ys)
                       | x > y = y : listsort (x:xs) ys
                       | x == y = x : listsort xs ys

multiples = 1 : listsort(map (2*) multiples) (listsort (map (3*) multiples) (map(5*) multiples))
