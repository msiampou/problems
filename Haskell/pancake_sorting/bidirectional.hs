import Data.List
import Debug.Trace
import Functions
import Data.Function (on)
import qualified Data.Set as Set

--------------------------------------
----- Bidirectional Sorting Function
--------------------------------------

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
