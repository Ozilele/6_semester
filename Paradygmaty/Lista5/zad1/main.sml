
(* Zad 1 *)
fun binomial n 0 = 1
|   binomial n k = if n = k then 1 else binomial (n - 1) k + binomial (n - 1) (k - 1);

val res_binomial = binomial 10 2;

(* Zad 4 *)
fun de a 0 = (1, 0, a)
|   de a b = if a < b then de b a 
            else 
                let 
                    val (x1, y1, z) = de b (a mod b)
                    val x = y1
                    val y = x1 - (a div b) * y1
                in
                    (y1, y, z)
                end;
(* Operator ~ w Standard ML jest operatorem negacji, który zmienia znak liczby całkowitej. *)
val (x, y, gcd) = de 40 18;

(* Zad 6 *)
fun gcd a 0 = a
|   gcd a b = if b > a then gcd b a else gcd b (a mod b);
fun totient n = let 
    fun tot 1 n res = res + 1
    |   tot curr n res = if gcd curr n = 1 then tot (curr - 1) n (res + 1) else tot (curr - 1) n res
    in
        tot n n 0
    end;

val val_totient = totient 10;
totient 81;
totient 13;

(* Zad 8 *)
fun has_factor n l = if n mod l = 0 then true else if l * l < n then has_factor n (l + 2) else false;
fun is_prime 2 = true
|   is_prime 3 = true
|   is_prime p = if p mod 2 = 0 then false else if has_factor p 3 = false then true else false;

fun primes_util curr 1 lst = lst
|   primes_util curr n lst = if is_prime curr = true then primes_util (curr + 1) (n - 1) (lst @ [curr]) else primes_util (curr + 1) (n - 1) lst;

fun primes n = primes_util 2 n [];
val primes_list = primes 100;
(* Zad 5 *)
fun next_prime p = if is_prime p then p else next_prime (p + 1);
fun prime_factors_util curr n lst = if is_prime n then lst @ [n] 
                                    else if (n mod curr) = 0 then prime_factors_util curr (n div curr) (lst @ [curr])
                                    else prime_factors_util (next_prime (curr + 1)) n lst;

fun prime_factors n = if is_prime n then [n] else prime_factors_util 2 n [];
prime_factors 275;

(* Zad 7 *)
fun contains([], _) = false
|   contains(x :: xs, y) = if x = y then true else contains(xs, y);

fun unique_elements([]) = []
|   unique_elements(x::xs) = 
    if contains(xs, x) then
        unique_elements(xs)
    else
        x::unique_elements(xs);

fun loopList([], res) = res
|   loopList(x::tail, res) = loopList(tail, res * (1.0 - (1.0 / Real.fromInt x)));

fun totient2 1 = 1
|   totient2 n = let 
                    val factors = prime_factors n
                    val unique_factors = unique_elements factors
                    val result = Real.fromInt n
                in
                    Real.toInt IEEEReal.TO_NEAREST(loopList(unique_factors, result))
                end;
totient2 1;
totient2 19;
totient2 81;

(* (Zad 2) *)
fun sum_pairs(_, []) = []
|   sum_pairs(x1::restx, y1::resty) = (x1 + y1) :: sum_pairs(restx, resty);

fun pascal_row 0 row = row
|   pascal_row n row = let
                        val new_row = 1::(sum_pairs(row, tl row) @ [1])
                    in
                        pascal_row (n - 1) new_row
                    end;

fun listElement(x::rest, k, curr) = if k = curr then x else listElement(rest, k, (curr + 1));
fun binomial2 n k = listElement(pascal_row n [1], k, 0);
binomial2 10 2;

(* (Zad 3) *)
fun length([]) = 0
|   length(h :: t) = 1 + length(t);

fun merge(left, right) = 
    let 
        fun mergeHelper([], r) = r
        |   mergeHelper(l, []) = l
        |   mergeHelper(l as x::xs, r as y::ys) =
            if x <= y then x :: mergeHelper(xs, r)
            else y :: mergeHelper(l, ys)
    in
        mergeHelper(left, right)
    end;
fun mergesort_util(lst, l, r) = if l >= r then [List.nth(lst, l)] else 
    let 
        val mid = (l + r) div 2
        val left_sorted = mergesort_util(lst, l, mid)
        val right_sorted = mergesort_util(lst, mid + 1, r)
    in
        merge(left_sorted, right_sorted)
    end;
fun mergesort([]) = []
|   mergesort(lst) = mergesort_util(lst, 0, length(lst) - 1);

(* merge [2, 7, 8, 4, 5, 6] 0 2 5; *)
(* mergesort_util([1, 7, 4, 5], 0, 3); *)
val list1 = [7, 8, 2, 4, 6, 5, 10];
mergesort list1;