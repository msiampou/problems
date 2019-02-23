--------------------------------------
----- Bidirectional Sorting Function
--------------------------------------

-- generating successors of intial stack and sorted stack at the same time
-- returns path when a successors is found in both frontiers
bbfs :: [([Int],[Int])] -> Set.Set [Int] -> [([Int],[Int])] -> Set.Set [Int] -> [Int]
bbfs frontier explored frontier' explored' | (elem (fst (head frontier')) (map fst frontier) == True) = (snd (frontier!!pos)) ++ reverse(snd (head frontier'))
                                         | (elem (fst (head frontier)) (map fst frontier') == True) = (snd (head frontier)) ++ reverse(snd (frontier'!!pos'))
                                         | otherwise = bbfs fr s fr' s'
                                         where (f,s,e) = substacks 2 element [] frontier set
                                               fr = (tail f) ++ [head f]
                                               element = head frontier
                                               set = Set.insert (fst element) explored
                                               (f',s',e') = substacks 2 (head frontier') [] frontier' set'
                                               fr' = (tail f') ++ [head f']
                                               element' = head frontier'
                                               set' = Set.insert (fst element') explored'
                                               pos = (position (fst (head frontier')) (map fst frontier))
                                               pos' = (position (fst (head frontier)) (map fst frontier'))

bidirectional :: [Int] -> [Int]
bidirectional x = bbfs frontier explored frontier' explored'
  where frontier = [(x,[])]
        s = Set.empty
        explored = Set.insert x s
        goal = quicksort x
        frontier' = [(goal,[])]
        s' = Set.empty
        explored' = Set.insert goal s'
