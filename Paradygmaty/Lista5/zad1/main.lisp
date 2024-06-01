
(defun binomial (n k)
    (cond 
        ((= k 0) 1)
        ((= k n) 1)
        (t  (+ (binomial (- n 1) k) (binomial (- n 1) (- k 1))))
    )
)
; Oblicza nowe wspolczynniki na podstawie poprzedniego wiersza tr.
(defun next_row (curr_row)
    (cons 1
        (append (mapcar #'+ curr_row (cdr curr_row)) '(1))))

(defun pascal_row (n) 
    (let ((row '(1)))
        (dotimes (i n row) ; n iteracji dla i = 0 row konczy sie na (1, 1) dla i = n - 1 to będzie n-ty wiersz tr.Pascala
            (setf row (next_row row))
        )
    )
)
(defun bionomial2 (n k)
    (nth k (pascal_row n))
)

(print "Welcome to my World!")
(print(binomial 10 2))
(print(bionomial2 10 2))
; TO DO - Porównanie szybkości i zasięgu obu rozwiązań

(defun gcd_ (a b) ; GCD func
    (cond
        ((< b a) (gcd b a))
        ((= a 0) b)
        (t  (gcd (mod b a) a))
    )
)

(defun totient_util (n curr res) ; Totient util 
    (cond 
        ((= curr n) res)
        ((= (gcd_ curr n) 1) (totient_util n (+ curr 1) (+ res 1)))
        (t  (totient_util n (+ curr 1) res))
    )
)
(defun totient (n)
    (totient_util n 2 1)
)
(print "Totient:")
(print(totient 23))

(defun is_prime (p)
    (cond
        ((= p 2) t)
        ((= p 3) t)
        ((= (mod p 2) 0) nil)
        (t (not (has_factor p 3)))
    )
)
(defun has_factor (n l)
    (cond
        ((= (mod n l) 0) t) ; Jeśli n jest podzielne przez l, to znaleziono czynnik
        ((< (* l l) n) (has_factor n (+ l 2)))
        (t nil)
    )
)
(defun next_prime (p)
    (cond 
        ((is_prime p) p)
        (t (next_prime (+ p 1)))
    )
)

(defun primes_util (curr n lst)
    (cond 
        ((= curr n) lst)
        ((is_prime curr) (if lst (primes_util (+ curr 1) n (cons lst curr)) (primes_util (+ curr 1) n (cons curr lst))))
        (t (primes_util (+ curr 1) n lst))
    )
)
(defun primes (n) 
    (primes_util 2 n '())
)
(print(primes 100))

(print "GCD EXTENDED")
(defun de (a b)
    (cond
        ((< a b) (de b a)) 
        ((= b 0) (list 1 0 a))
        (t (let*
            (
                (newb (mod a b))
                (result (de b newb))
                (gcd (nth 2 result))
                (x1 (nth 0 result))
                (y1 (nth 1 result))
            )
            (list y1 (- x1 (* (floor a b) y1)) gcd)
        ))
    )
)

(defun prime_factors_util (curr n lst)
    (cond 
        ((is_prime n) (cons n lst))
        ((= (mod n curr) 0) (prime_factors_util curr (/ n curr) (cons curr lst)))
        (t (prime_factors_util (next_prime (+ curr 1)) n lst))
    )
)
(defun prime_factors (n)
    (cond 
        ((is_prime n) (cons n '()))
        (t (reverse(prime_factors_util 2 n '())))
    )
)

; Done - 1.binomial, 2.binomial2, 6.totient, 8.primes, 4.de, 5.prime_factors, 7.totient2, 3.merge
(print(de 40 18))
(print (prime_factors 10))
(print (prime_factors 20))

(defun unique_elements (lst)
    (let 
        (
            (result '())
        )
        (dolist (element lst result)
            (setq result (adjoin element result)))
    )
)
(defun totient2 (n)
    (let*
        (
            (factors (prime_factors n))
            (unique_factors (unique_elements factors))
            (result n)
        )
        (dolist (element unique_factors result)
            (setq result (* (- 1 (/ 1 element)) result))
        )
        (round result)
    )
)
(print "Totient 2")
(print (totient2 20))
(print (totient2 91))

(defun merge_ (lst l mid r)
    (let* 
        (
            (left_len (+ (- mid l) 1))
            (right_len (- r mid))
            (left_arr (subseq lst l (+ mid 1)))
            (right_arr (subseq lst (+ mid 1) (+ r 1)))
        )
        (labels 
            (
                (merge_helper (left right result)
                  (cond 
                    ((and (null left) (null right)) (nreverse result))
                    ((null left) (merge_helper left (cdr right) (cons (car right) result)))
                    ((null right) (merge_helper (cdr left) right (cons (car left) result)))
                    ((<= (car left) (car right))
                        (merge_helper (cdr left) right (cons (car left) result))
                    )
                    (t (merge_helper left (cdr right) (cons (car right) result)))
                  )
                )
            )
            (let 
                (
                    (merged (merge_helper left_arr right_arr '()))
                )
                (dotimes (i (length merged) lst)
                    (setf (nth (+ l i) lst) (nth i merged))
                )
            )
        )
    )
)

(defun mergesort_util (lst l r)
    (cond 
        ((>= l r) nil)
        (t (let ((mid (floor (+ l r) 2)))
            (mergesort_util lst l mid)
            (mergesort_util lst (+ mid 1) r)
            (merge_ lst l mid r))))
)
(defun mergesort (lst)
    (mergesort_util lst 0 (- (length lst) 1))
)

(print "Merge Sort:")
(print(mergesort (list 5 2 10 4 8 11 13 9 22 1)))