------------------------------
---- BSF Sorting Function
------------------------------

-- generating successors of stack
-- searching for goal at leaf nodes before pushing them in frontier
-- returns 1 if goal was found - return path and exit
-- returns frontier and explored set in any case
substacks :: Int -> ([Int],[Int]) -> [Int] -> [([Int],[Int])] -> Set.Set [Int] -> ([([Int],[Int])],Set.Set [Int],Int)
substacks n stack goal frontier explored | x == goal = (fr,explored,1)
                                         | n > length(fst stack) = (frontier,explored,0)
                                         | (Set.member x explored == False) && (elem x (map fst frontier) == False) = substacks (n+1) stack goal fr explored
                                         | otherwise = substacks (n+1) stack goal frontier explored
                                         where x = flip_stack n (fst stack)
                                               p = (snd stack) ++ [n]
                                               fr = frontier ++ [(x,p)]

-- continue generating successors until goal is found
bfs_search :: [Int] -> [([Int],[Int])] -> Set.Set [Int] -> [Int]
bfs_search goal frontier explored | end == 1 = snd (last f)
                                  | otherwise = bfs_search goal fr s
                                  where (f,s,end) = substacks 2 element goal frontier set
                                        fr = tail f
                                        element = head frontier
                                        set = Set.insert (fst element) explored

bfs :: [Int] -> [Int]
bfs x | x == goal = []
      | otherwise = bfs_search goal frontier explored
        where frontier = [(x,[])]
              s = Set.empty
              explored = Set.insert x s
              goal = quicksort x
