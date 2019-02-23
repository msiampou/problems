import Data.List
import Debug.Trace
import Functions
import Data.Function (on)
import qualified Data.Set as Set

burnt_substacks :: Int -> ([(Int,Int)],[Int]) -> [(Int,Int)] -> [([(Int,Int)],[Int])] -> Set.Set [(Int,Int)] -> ([([(Int,Int)],[Int])],Set.Set [(Int,Int)],Int)
burnt_substacks n stack goal frontier explored | x == goal = (fr,explored,1)
                                               | n > length(fst stack) = (frontier,explored,0)
                                               | (Set.member x explored == False) && (elem x (map fst frontier) == False) = burnt_substacks (n+1) stack goal fr explored
                                               | otherwise = burnt_substacks (n+1) stack goal frontier explored
                                               where x = flip_stack' n (fst stack)
                                                     p = (snd stack) ++ [n]
                                                     fr = frontier ++ [(x,p)]

burnt_bfs_search :: [(Int,Int)] -> [([(Int,Int)],[Int])] -> Set.Set [(Int,Int)] -> [Int]
burnt_bfs_search goal frontier explored | end == 1 = snd (last f)
                                        | otherwise = burnt_bfs_search goal fr s
                                        where (f,s,end) = burnt_substacks 1 element goal frontier set
                                              fr = tail f
                                              element = head frontier
                                              set = Set.insert (fst element) explored

burnt_bfs :: [(Int,Int)] -> [Int]
burnt_bfs x | x == goal = []
            | otherwise = burnt_bfs_search goal frontier explored
            where
            frontier = [(x,[])]
            s = Set.empty
            explored = Set.insert x s
            y = reverse (sortBy (flip compare `on` fst) x)
            goal = map (\p@(f, o) -> if o == 1 then (f, 0) else p) y
