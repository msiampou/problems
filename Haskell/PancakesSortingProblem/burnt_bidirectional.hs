burnt_bs :: [([(Int,Int)],[Int])] -> Set.Set [(Int,Int)] -> [([(Int,Int)],[Int])] -> Set.Set [(Int,Int)] -> [Int]
burnt_bs frontier explored frontier' explored' | (elem (fst (head frontier')) (map fst frontier) == True) = (snd (frontier!!pos)) ++ reverse(snd (head frontier'))
                                               | (elem (fst (head frontier)) (map fst frontier') == True) = (snd element) ++ reverse(snd (frontier'!!pos'))
                                               | otherwise = burnt_bs fr s fr' s'
                                               where (f,s,_) = burnt_substacks 1 element [] frontier set
                                                     fr = tail f ++ [head f]
                                                     element = head frontier
                                                     set = Set.insert (fst element) explored
                                                     (f',s',_) = burnt_substacks 2 element' [] frontier' set'
                                                     fr' = tail f' ++ [head f']
                                                     element' = head frontier'
                                                     set' = Set.insert (fst element') explored'
                                                     pos = (position (fst (head frontier')) (map fst frontier))
                                                     pos' = (position (fst (head frontier)) (map fst frontier'))

burnt_bidirectional :: [(Int,Int)] -> [Int]
burnt_bidirectional x = burnt_bs frontier explored frontier' explored'
                        where frontier = [(x,[])]
                              s = Set.empty
                              explored = Set.insert x s
                              y = reverse (sortBy (flip compare `on` fst) x)
                              goal = map (\p@(f, o) -> if o == 1 then (f, 0) else p) y
                              frontier' = [(goal,[])]
                              s' = Set.empty
                              explored' = Set.insert goal s'
