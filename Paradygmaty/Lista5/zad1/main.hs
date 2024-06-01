
-- Zad 1
binomial :: Int -> Int -> Int
binomial n 0 = 1
binomial n k = if n == k then 1 else binomial (n - 1) k + binomial (n - 1) (k - 1)

-- Zad 4
de a 0 = (1, 0, a)
de a b = if a < b then de b a
         else 
            let 
                (x1, y1, z) = de b (a `mod` b)
                x = y1
                y = x1 - (a `div` b) * y1
            in
                (x, y, z)

-- Zad 6
gcd_ :: Int -> Int -> Int
gcd_ a 0 = a
gcd_ a b = if b > a then gcd_ b a else gcd_ b (a `mod` b)
totient n = let 
    tot 1 n res = res + 1
    tot curr n res = if gcd_ curr n == 1 then tot (curr - 1) n (res + 1) else tot (curr - 1) n res
    in
        tot n n 0

-- Zad 8
has_factor n l = if n `mod` l == 0 then True else if l * l < n then has_factor n (l + 2) else False  
is_prime :: Int -> Bool
is_prime 2 = True
is_prime 3 = True
is_prime p = if p `mod` 2 == 0 then False else if has_factor p 3 == False then True else False

primes n = let 
    primes_util curr 1 lst = lst
    primes_util curr n lst = if is_prime curr then primes_util (curr + 1) (n - 1) (lst ++ [curr]) else primes_util (curr + 1) (n - 1) lst
    in
        primes_util 2 n []

-- Zad 5
prime_factors :: Int -> [Int]
next_prime p = if is_prime p then p else next_prime (p + 1)
prime_factors n = if is_prime n then [n] else 
    let 
        prime_factors_util curr n lst = if is_prime n then lst ++ [n]
                                        else if n `mod` curr == 0 then 
                                            prime_factors_util curr (n `div` curr) (lst ++ [curr])
                                        else prime_factors_util (next_prime (curr + 1)) n lst;
    in
        prime_factors_util 2 n []

-- Zad 7
contains :: Eq a => [a] -> a -> Bool
contains [] _ = False
contains (x : xs) y = if x == y then True else contains xs y

unique_elements :: Eq a => [a] -> [a]
unique_elements [] = []
unique_elements (x:xs) = 
    if contains xs x then 
        unique_elements xs
    else 
        x : unique_elements xs

loopList [] res = round res
loopList (x : xs) res = loopList xs (res * (1 - (1 / x)))

totient2 :: Int -> Int
totient2 1 = 1
totient2 n = let
        factors = prime_factors n
        unique_factors = unique_elements factors
        unique_factors_doubles = map fromIntegral unique_factors -- Double Conversion
        result = fromIntegral n -- Double Conversion
    in
        loopList unique_factors_doubles result

-- Zad 2
sum_pairs _ [] = []
sum_pairs (x:xs) (y:ys) = (x + y) : sum_pairs xs ys

pascal_row 0 row = row
pascal_row n row = let
                    new_row = 1 : (sum_pairs row (tail row)) ++ [1]
                in
                    pascal_row (n - 1) new_row

-- listElement :: [Int] -> Int -> Int -> Int
listElement (x:xs) k curr = if k == curr then x else listElement xs k (curr + 1) 
binomial2 n k = listElement (pascal_row n [1]) k 0

-- Zad 3
merge [] r = r
merge l [] = l
merge (x:xs) (y:ys) = if x <= y then x : merge xs (y:ys) else y : merge (x:xs) ys

mergesort_util :: [Int] -> Int -> Int -> [Int]
mergesort_util lst l r = if l >= r then [lst !! l]  
    else let
        mid = (l + r) `div` 2
        leftSorted = mergesort_util lst l mid
        rightSorted = mergesort_util lst (mid + 1) r
    in
        merge leftSorted rightSorted

mergesort :: [Int] -> [Int]
mergesort lst = mergesort_util lst 0 ((length lst) - 1) 

main = do 
    putStrLn "Binomial"
    print (binomial 10 2)
    putStrLn "Diofantic Solution:"
    print(de 40 18)
    putStrLn "Totient function:"
    print(totient 1)
    print(totient 20)
    putStrLn "Lista liczb pierwszych do 100:"
    print(primes 97)
    putStrLn "Prime factorization:"
    print(prime_factors 275)
    putStrLn "Totient 2 function:"
    print(totient2 81)
    putStrLn "Binomial 2 function:"
    print(binomial2 12 2)
    putStrLn "Merge Sort:"
    print (mergesort [5, 7, 2, 4, 10, 9, 0])

