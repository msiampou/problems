module Functions where
import Data.List
import Debug.Trace
import Data.Function (on)
import qualified Data.Set as Set

------------------------------
---- Several Functions
------------------------------

take_first :: (t,t) -> t
take_first (a,b) = a

take_second :: (t,t) -> t
take_second (a,b) = b

all_upside :: [(Int,Int)] -> [(Int,Int)]
all_upside [] = []
all_upside (h:l) = (take_first h,0) : all_upside l

flip_all :: [(Int,Int)] -> [(Int,Int)]
flip_all [] = []
flip_all ((f,s):l) | (s == 0) = (f,1) : flip_all l
                   | otherwise = (f,0) : flip_all l

flip_first :: [(Int,Int)] -> [(Int,Int)]
flip_first ((f,s): l) | (s == 0) = (f , 1) : l
                      | otherwise = (f , 0 ) :l

remove_duplicates :: (Ord a) => [a] -> [a]
remove_duplicates = map head . group . sort

--return the index of a list of lists
return_index :: Eq t => Int -> [t] -> [[t]] -> Int
return_index _ _ [] = -1
return_index n l (h:t) | l == h = n
                       | otherwise = return_index (n+1) l t

--those two functions split a list in 2 pieces
first_half n l = take n l
second_half n l = l \\ first_half n l
quicksort [] = []
quicksort (h:t) = (quicksort less) ++ [h] ++ quicksort greater
                  where less = filter ( < h) t
                        greater = filter ( >= h) t

position :: Eq a => a -> [a] -> Int
position i xs =
    case i `elemIndex` xs of
       Just n  -> n
       Nothing -> 0

indexOf :: Eq a => a -> [a] -> Int
indexOf n l = case elemIndex n l of
               Just n  -> n+1
               Nothing -> 0

--returns the nth biggest element of a list
nth_biggest :: Int -> [Int] -> Int
nth_biggest n l = return_nth n (reverse(quicksort l))


nth_biggest' :: Int -> [(Int,Int)] -> (Int,Int)
nth_biggest' n l = return_nth n (reverse(quicksort l))

return_nth :: Int -> [t] -> t
return_nth n l = l !! (n-1)

return_nth' :: Int -> [Int] -> Int
return_nth' _ [] = 0
return_nth' n (h:t)  | n == 1 = h
                    | otherwise = return_nth' (n-1) t

len :: [Int] -> [Int] -> [Int]
len [] _ = []
len (h:l) sorted = ((position h sorted) + 1) : (len l sorted)

lengthish :: [Int] -> [Int]
lengthish [] = []
lengthish l = (len l (quicksort l))

list_of_lengthish :: [[Int]] -> [[Int]]
list_of_lengthish [] = []
list_of_lengthish (h:l) = (len h (quicksort h)) : list_of_lengthish l

-- flips stack given a specific position
flip_stack :: Int -> [Int] -> [Int]
flip_stack pos s = (reverse (first_half pos s)) ++ second_half pos s

-- flips stack given a specific position
flip_stack' :: Int -> [(Int,Int)] -> [(Int,Int)]
flip_stack' pos s = (reverse z) ++ y
                  where x = first_half pos s
                        y = second_half pos s
                        z = map (\p@(f,o) -> if o == 1 then (f, 0) else (f, 1)) x
