f a b c = a + b + c
ssum f a b c = solve f 1 a 1 b 1 c
solve :: (Int->Int->Int->Int)->Int->Int->Int->Int->Int->Int->Int
solve f i a j b k c = if i >= a then if j >= b then if k >= c then f a b c
                      else solve f i a j b k c' + solve f i a j b (c'+1) c
                      else solve f i a j b' k c + solve f i a (b'+1) b k c
                      else solve f i a' j b k c + solve f (a'+1) a j b k c
                      where a' = (i+a) `div` 2
                            b' = (j+b) `div` 2
                            c' = (k+c) `div` 2
