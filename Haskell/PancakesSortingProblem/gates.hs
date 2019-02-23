is_an_adjacency :: Int -> Int -> Int -> Bool
is_an_adjacency a b l | (abs(a-b) == 1) || (a==1 && b==l) = True
                      | otherwise = False

free :: Int -> [Int] -> Bool
free _ [] = False
free x l | (ind == ll) = not (is_an_adjacency a x ll)
         | (ind == 1) = not (is_an_adjacency x b ll)
         | (ind == 0) = False
         | otherwise = (not(is_an_adjacency a x ll) && not(is_an_adjacency x b ll))
            where a = return_nth' (ind-1) l
                  b = return_nth' (ind+1) l
                  ind = indexOf x l
                  ll = length l

in_a_block :: Int -> [Int] -> Bool
in_a_block x l = not(free x l)

diff_blocks :: Int -> Int -> [Int] -> Bool
diff_blocks x y xs = abs(posx-posy) /= abs(x-y)
                     where posx = indexOf x xs -1
                           posy = indexOf y xs -1

first_of_block :: Int -> [Int] -> Bool
first_of_block x l | indexOf x l == 0 = False
                   | (prev == 0) = is_an_adjacency x next len
                   | otherwise = (not (is_an_adjacency prev x len) && is_an_adjacency x next len)
                   where prev = return_nth' ((indexOf x l) - 1) l
                         next = return_nth' ((indexOf x l) + 1) l
                         len = length(l)

last_of_block :: Int -> [Int] -> Bool
last_of_block x l | (next == 0) = is_an_adjacency prev x len
                  | otherwise = (is_an_adjacency prev x len && not(is_an_adjacency x next len))
                        where prev = return_nth' ((indexOf x l) - 1) l
                              next = return_nth' ((indexOf x l) + 1) l
                              len = length(l)

end_of_block :: [Int] -> Int -> Int
end_of_block [] _ = -1
end_of_block [x] _ = x
end_of_block (x:y:xs) len | (is_an_adjacency x y len == False) = x
                          | otherwise = end_of_block (y:xs) len

--t is free but t+1 and t-1
--are last elements of a block
flipping :: ([Int],[Int]) -> Int -> Int -> ([Int],[Int])
flipping list posx posp = (fs,ps)
                          where ys = flip_stack posx xs
                                posy = (indexOf x ys) -1
                                zs = flip_stack posy ys
                                posz = posp
                                vs = flip_stack posz zs
                                posv = (indexOf x vs) -1
                                xs = fst list
                                x = head xs
                                path = snd list
                                fs = flip_stack posv vs
                                ps = path ++ [posy,posz,posv]

----------------------------
-- Pancakes Sorting Problem
----------------------------

--t and t+o are both free
case_1a :: ([Int],[Int]) -> ([Int],[Int])
case_1a xs = (ys,p)
           where pos = (indexOf (x+1) list)-1
                 list = fst xs
                 path = snd xs
                 x = head list
                 p = path ++ [pos]
                 ys = flip_stack pos list

case_1b :: ([Int],[Int]) -> ([Int],[Int])
case_1b xs = (ys,p)
          where pos = (indexOf (x-1) list)-1
                list = fst xs
                path = snd xs
                x = head list
                p = path ++ [pos]
                ys = flip_stack pos list

--t is free and t+o is
--the 1st element of a block
case_2a :: ([Int],[Int]) -> ([Int],[Int])
case_2a xs = (ys,p)
           where pos = (indexOf (x+1) list)-1
                 list = fst xs
                 path = snd xs
                 x = head list
                 p = path ++ [pos]
                 ys = flip_stack pos list

case_2b :: ([Int],[Int]) -> ([Int],[Int])
case_2b xs = (ys,p)
         where pos = (indexOf (x-1) list)-1
               list = fst xs
               path = snd xs
               x = head list
               p = path ++ [pos]
               ys = flip_stack pos list

--t is free but both t+1 and t-1
--are last elements of blocks
case_3a :: ([Int],[Int]) -> ([Int],[Int])
case_3a xs | posn < posp = flipping xs posn posp
           | otherwise = flipping xs posp posn
           where posn = indexOf (x+1) list
                 posp = indexOf (x-1) list
                 list = fst xs
                 path = snd xs
                 x = head list

case_3b :: ([Int],[Int]) -> ([Int],[Int])
case_3b list = (zs,p)
             where posn = indexOf (x+1) xs
                   ys = flip_stack posn xs
                   posx = (indexOf x ys) -1
                   zs = flip_stack posx ys
                   xs = fst list
                   path = snd list
                   x = head xs
                   p = path ++ [posn,posx]

case_3c :: ([Int],[Int]) -> ([Int],[Int])
case_3c list = (zs,p)
            where posn = indexOf (x-1) xs
                  ys = flip_stack posn xs
                  posx = (indexOf x ys) -1
                  zs = flip_stack posx ys
                  xs = fst list
                  path = snd list
                  x = head xs
                  p = path ++ [posn,posx]

--t is in a block and t+o is free
case_4a :: ([Int],[Int]) -> ([Int],[Int])
case_4a xs = (ys,p)
           where pos = (indexOf (x+1) list)-1
                 list = fst xs
                 path = snd xs
                 x = head list
                 p = path ++ [pos]
                 ys = flip_stack pos list

case_4b :: ([Int],[Int]) -> ([Int],[Int])
case_4b xs = (ys,p)
        where pos = (indexOf (x-1) list)-1
              list = fst xs
              path = snd xs
              x = head list
              p = path ++ [pos]
              ys = flip_stack pos list

--t is free and t+o is
--the 1st element of a block
case_5a :: ([Int],[Int]) -> ([Int],[Int])
case_5a xs = (ys,p)
           where pos = (indexOf (x+1) list)-1
                 list = fst xs
                 path = snd xs
                 x = head list
                 p = path ++ [pos]
                 ys = flip_stack pos list

case_5b :: ([Int],[Int]) -> ([Int],[Int])
case_5b xs = (ys,p)
       where pos = (indexOf (x-1) list)-1
             list = fst xs
             path = snd xs
             x = head list
             p = path ++ [pos]
             ys = flip_stack pos list

--t is in a block with last element t+k*o
--t-o is in other block
--t+(k+1)*o is free
case_6a :: ([Int],[Int]) -> ([Int],[Int])
case_6a list = (fs,ps)
                where posx = indexOf ((end_of_block xs len) +1) xs
                      ys = flip_stack posx xs
                      posy = (indexOf ((end_of_block xs len)) ys) -1
                      zs = flip_stack posy ys
                      posz = (indexOf (x-1) zs)
                      vs = flip_stack posz zs
                      posi = (indexOf x vs) -1
                      xs = fst list
                      x = head xs
                      path = snd list
                      fs = flip_stack posi vs
                      ps = path ++ [posx,posy,posz,posi]
                      len = length(fst(list))

case_6a' :: ([Int],[Int]) -> ([Int],[Int])
case_6a' list = (fs,ps)
                where posx = indexOf ((end_of_block xs len) -1) xs
                      ys = flip_stack posx xs
                      posy = (indexOf ((end_of_block xs len)) ys) -1
                      zs = flip_stack posy ys
                      posz = (indexOf (x+1) zs)
                      vs = flip_stack posz zs
                      posi = (indexOf x vs) -1
                      xs = fst list
                      x = head xs
                      path = snd list
                      fs = flip_stack posi vs
                      ps = path ++ [posx,posy,posz,posi]
                      len = length(fst(list))

case_6b :: ([Int],[Int]) -> ([Int],[Int])
case_6b list = (fs,ps)
                where posx = indexOf ((end_of_block xs len) +1) xs
                      ys = flip_stack posx xs
                      posy = ((indexOf (end_of_block xs len) ys) -1)
                      zs = flip_stack posy ys
                      posz = indexOf x zs
                      vs = flip_stack posz zs
                      posi = (indexOf (x-1) vs) -1
                      xs = fst list
                      x = head xs
                      path = snd list
                      fs = flip_stack posi vs
                      ps = path ++ [posx,posy,posz,posi]
                      len = length(fst(list))

case_6b' :: ([Int],[Int]) -> ([Int],[Int])
case_6b' list = (fs,ps)
                where posx = indexOf ((end_of_block xs len) -1) xs
                      ys = flip_stack posx xs
                      posy = ((indexOf (end_of_block xs len) ys) -1)
                      zs = flip_stack posy ys
                      posz = indexOf x zs
                      vs = flip_stack posz zs
                      posi = (indexOf (x+1) vs) -1
                      xs = fst list
                      x = head xs
                      path = snd list
                      fs = flip_stack posi vs
                      ps = path ++ [posx,posy,posz,posi]
                      len = length(fst(list))

--t is in a block with last element t+k*o
--t-o is in other block
--t+(k+1)*o is in a block
case_7a :: ([Int],[Int]) -> ([Int],[Int])
case_7a list = (fs,ps)
                where posx = indexOf (end_of_block xs len) xs
                      ys = flip_stack posx xs
                      posy = ((indexOf ((end_of_block xs len) +1) ys) -1)
                      xs = fst list
                      x = head xs
                      path = snd list
                      fs = flip_stack posy ys
                      ps = path ++ [posx,posy]
                      len = length(fst(list))

case_7a' :: ([Int],[Int]) -> ([Int],[Int])
case_7a' list = (fs,ps)
                where posx = indexOf (end_of_block xs len) xs
                      ys = flip_stack posx xs
                      posy = ((indexOf ((end_of_block xs len) -1) ys) -1)
                      xs = fst list
                      x = head xs
                      path = snd list
                      fs = flip_stack posy ys
                      ps = path ++ [posx,posy]
                      len = length(fst(list))

case_7b :: ([Int],[Int]) -> ([Int],[Int])
case_7b list = (fs,ps)
                where posx = indexOf ((end_of_block xs len) +1) xs
                      ys = flip_stack posx xs
                      posy = ((indexOf (end_of_block xs len) ys) -1)
                      xs = fst list
                      x = head xs
                      path = snd list
                      fs = flip_stack posy ys
                      ps = path ++ [posx,posy]
                      len = length(fst(list))

case_7b' :: ([Int],[Int]) -> ([Int],[Int])
case_7b' list = (fs,ps)
                where posx = indexOf ((end_of_block xs len) -1) xs
                      ys = flip_stack posx xs
                      posy = ((indexOf (end_of_block xs len) ys) -1)
                      xs = fst list
                      x = head xs
                      path = snd list
                      fs = flip_stack posy ys
                      ps = path ++ [posx,posy]
                      len = length(fst(list))

solve :: ([Int],[Int]) -> ([Int],[Int])
solve t  | xs == goal = t
         | xs == reverse(goal) = (reverse(xs),(p ++ [(length xs)]))
         | free x xs && free (x+1) xs = solve (case_1a t)
         | free x xs && free (x-1) xs = solve (case_1b t)
         | free x xs && first_of_block (x+1) xs = solve (case_2a t)
         | free x xs && first_of_block (x-1) xs = solve (case_2b t)
         | free x xs && last_of_block (x+1) xs = solve (case_3b t)
         | free x xs && last_of_block (x-1) xs = solve (case_3c t)
         | in_a_block x xs && free (x+1) xs = solve (case_4a t)
         | in_a_block x xs && free (x-1) xs = solve (case_4b t)
         | in_a_block x xs && first_of_block (x+1) xs = solve (case_5a t)
         | in_a_block x xs && first_of_block (x-1) xs = solve (case_5b t)
         | in_a_block x xs && in_a_block (x+1) xs && diff_blocks x (x+1) xs && free prev xs && (posp < posy) = solve (case_6a' t)
         | in_a_block x xs && in_a_block (x-1) xs && diff_blocks x (x-1) xs && free next xs && (posn < posy) = solve (case_6a t)
         | in_a_block x xs && in_a_block (x+1) xs && diff_blocks x (x+1) xs && free prev xs && (posp > posy) = solve (case_6b' t)
         | in_a_block x xs && in_a_block (x-1) xs && diff_blocks x (x-1) xs && free next xs && (posn > posy) = solve (case_6b t)
         | in_a_block x xs && in_a_block (x+1) xs && diff_blocks x (x+1) xs && last_of_block (x+1) xs && in_a_block prev xs && first_of_block prev xs = solve (case_7a' t)
         | in_a_block x xs && in_a_block (x-1) xs && diff_blocks x (x-1) xs && last_of_block (x-1) xs && in_a_block next xs && first_of_block next xs = solve (case_7a t)
         | in_a_block x xs && in_a_block (x+1) xs && diff_blocks x (x+1) xs && last_of_block (x+1) xs && in_a_block prev xs && last_of_block prev xs = solve (case_7b' t)
         | in_a_block x xs && in_a_block (x-1) xs && diff_blocks x (x-1) xs && last_of_block (x-1) xs && in_a_block next xs && last_of_block next xs = solve (case_7b t)
         | otherwise = solve (reverse(fst t),((snd t) ++ [(length xs)]))
         where xs = fst t
               x = head xs
               p = snd t
               goal = quicksort xs
               next = end_of_block xs len +1
               prev = end_of_block xs len -1
               posx = indexOf (x-1) xs
               posy = indexOf (x+1) xs
               posn = indexOf next xs
               posp = indexOf prev xs
               len = length(fst(t))

gates :: [Int] -> [Int]
gates xs = snd (solve ((lengthish xs),[]))
