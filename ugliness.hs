findU :: [Int] -> [Int] -> Int -> Int
findU [] _ u = u
findU _ [] u = u
findU (h1:t1) (h2:t2) u
                        | x > u = findU t1 t2 x
                        | otherwise = findU t1 t2 u
                        where x = abs(h1-h2)

indexOf :: [Int] -> Int -> Int -> Int
indexOf [] _ i = 0
indexOf (h1:t) n i
                    | n == h1 = i
                    | otherwise = indexOf t n (i+1)

select :: [Int] -> Int -> [Int]
select [] _ = []
select (h1:t1) n
                | n == h1 = t1
                | otherwise = h1 : select t1 n

nth0 :: [Int] -> Int -> Int -> Int
nth0 [] _ _ = 0
nth0 (h:t) n p
              | n == p = h
              | otherwise = nth0 t n (p+1)

dif :: [Int] -> Int -> [Int]
dif [] _ = []
dif (h:t) n = x : dif t n
              where x = abs (h-n)

fix :: [Int] -> [Int] -> [Int]
fix [] _ = []
fix (h:t) q = num : fix t q'
            where d = dif q h
                  m = foldr1 min d
                  pos = indexOf d m 0
                  num = nth0 q pos 0
                  q' = select q num

ugliness :: [Int] -> [Int] -> Int
ugliness xs ys
               | length(x) > length(y) = findU f1 y 0
               | length(x) < length(y) = findU x f2 0
               | length(x) == length(y) = findU x y 0
               where x = quicksort xs
                     y = quicksort ys
                     t1 = fix y x
                     t2 = fix x y
                     f1 = quicksort t1
                     f2 = quicksort t2
