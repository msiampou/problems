-- barrier is a power of 2
findbarrier :: Int -> Int -> Int
findbarrier a n
                | (r < a && a <= s) = s
                |otherwise = findbarrier a (n+1)
                where r = 2^(n-1)
                      s = 2^n

f2k :: Int -> Int -> [Int]
f2k a n
        | a == n = [n]
        | a > n = n : f2k (a-n) k
        | a < n = f2k a k
        where k = n `div` 2

-- split q
sumdivs :: [Int] -> Int -> [Int]
sumdivs [] a = []
sumdivs (h:t) a = y : sumdivs t a
                where (_,y) = reduce h a

-- reduce fraction if q is power of 2
reduce :: Int -> Int -> (Int,Int)
reduce x y
          | rem == 1 = (x,y)
          | otherwise = reduce x' y'
          where rem = gcd x y
                x' = x `div` rem
                y' = y `div` rem

-- reduce fraction if q is not power of 2
fraction_reduce :: Int -> Int -> Int-> (Int,Int)
fraction_reduce p q b = (s,r)
                where x = p * b
                      s = x `div` q
                      r = x `mod` q

-- if p/q < 1 use binary computation
binary :: Int -> Int -> Int -> Int -> [Int]
binary s r a q = x ++ y
                where x = sumdivs (f2k s a) a
                      y = map(*q) (sumdivs (f2k r a) a)

-- else use simple computation
compute' :: Int -> Int -> Int -> [Int]
compute' p q n
              | m2 == m1*p = [n]
              | m2 < m1*p = n : compute' p' q' (n+1)
              | otherwise = compute' p q (n+1)
              where p' = m1*p - m2
                    q' = l
                    l = lcm q n
                    m1 = l `div` q
                    m2 = l `div` n
compute p q
          | q == b = sumdivs t q
          | otherwise = binary s r b q
          where t = f2k p b
                b = findbarrier q 1
                (s,r) = fraction_reduce p q b

fractions :: Int -> Int -> [Int]
fractions p q
              | p' == 0 = []
              | p' >= q' = compute' p' q' 2
              | otherwise = compute p' q'
              where (p',q') = reduce p q
