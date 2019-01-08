quicksort :: Ord a => [a] -> [a]
quicksort []     = []
quicksort (p:xs) = (quicksort lesser) ++ [p] ++ (quicksort greater)
    where
        lesser  = filter (< p) xs
        greater = filter (>= p) xs

merge :: Eq a => [a] -> [a]
merge [] = []
merge (x:xs) = x : merge (filter (/= x) xs)

-- returns number of edges in each adj list
numcomp :: [[Int]] -> [Int]
numcomp [] = []
numcomp (h:t) = length(h) : numcomp t

-- finds a path starting from 1 edge
findx' :: Int -> [(Int,Int)] -> [Int]
findx' _ [] = []
findx' n ((x,y):t)
                  | n == x = y : findx' n t
                  | otherwise = findx' n t

findy' :: Int -> [(Int,Int)] -> [Int]
findy' _ [] = []
findy' n ((x,y):t)
                  | n == y = x : findy' n t
                  | otherwise = findy' n t

-- finds neighbors of edges
nearedges :: [Int] -> [(Int,Int)] -> [[Int]]
nearedges [] _ = []
nearedges (h:t) list = quicksort (merge (findx' h list ++ findy' h list)) : nearedges t list

getcomp :: Int -> Int -> [[Int]] -> [Int]
getcomp _ _ [] = []
getcomp curr pos (h:t)
                      | curr == pos = h
                      | otherwise = getcomp (curr+1) pos t

flatten :: [[Int]] -> [Int]
flatten [] = []
flatten (h:t) = h ++ flatten t

remove :: Int -> [Int] -> [[Int]] -> [[Int]]
remove _ [] t2 = t2
remove curr (h1:t1) (h2:t2)
                        | curr == h1 = [] : remove (curr+1) t1 t2
                        | otherwise = h2 : remove (curr+1) (h1:t1) t2

-- get all possible paths
getall :: [Int] -> [[Int]] -> [Int] -> [Int]
getall [] _ sol = sol
getall (h:t) list sol = getall t list (sol ++ x)
                    where x = getcomp 1 h list

cycles :: [Int] -> [[Int]] -> [Int] -> [Int]
cycles c list sol
                  | length(c) == 0 = sol
                  | length(y) == 0 = sol
                  | otherwise = cycles x l (sol ++ x)
                  where x = merge (getall c list [])
                        l = remove 1 c list
                        y = flatten list

--find adjacency list for each edge
adjlists :: [Int] -> [[Int]] -> [[Int]]
adjlists [] _ = []
adjlists (h:t) listx = x : adjlists t listx
                  where x = quicksort (merge (h : cycles [h] listx []))

components :: ([Int],[(Int,Int)]) -> (Int,[Int])
components (l,v) = (length res , quicksort (numcomp res))
                    where res = merge (adjlists l x)
                          x = nearedges l v
