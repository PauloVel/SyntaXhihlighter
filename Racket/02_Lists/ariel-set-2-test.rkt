#|
    Tests for the set of probles by Ariel Ortiz
    Applications of the general concepts of functional programming

    Gilberto Echeverria
    24/02/2021
|#

; Import library for unit testing
(require rackunit)
; Import necesary to view the test results
(require rackunit/text-ui)

; Functions

(define test-insert
    (test-suite
        " Test function: insert"
        (check-equal? (insert 14 '()) '(14) "Insert in empty list")
        (check-equal? (insert 4 '(5 6 7 8)) '(4 5 6 7 8) "Insert at beginning")
        (check-equal? (insert 5 '(1 3 6 7 9 16)) '(1 3 5 6 7 9 16) "Insert at middle")
        (check-equal? (insert 10 '(1 5 6)) '(1 5 6 10) "Insert at end")
    ))

(define test-insertion-sort
    (test-suite
        " Test function: insertion-sort"
        (check-equal? (insertion-sort '()) '() "Empty list")
        (check-equal? (insertion-sort '(4 3 6 8 3 0 9 1 7)) '(0 1 3 3 4 6 7 8 9) "Unsorted list")
        (check-equal? (insertion-sort '(1 2 3 4 5 6)) '(1 2 3 4 5 6) "Sorted list")
        (check-equal? (insertion-sort '(5 5 5 1 5 5 5)) '(1 5 5 5 5 5 5) "One unsorted")
    ))

(define test-rotate-left
    (test-suite
        " Test function: rotate-left"
        (check-equal? (rotate-left 5 '()) '() "Empty list")
        (check-equal? (rotate-left 0 '(a b c d e f g)) '(a b c d e f g) "No rotation")
        (check-equal? (rotate-left 1 '(a b c d e f g)) '(b c d e f g a) "Positive rotation")
        (check-equal? (rotate-left -1 '(a b c d e f g)) '(g a b c d e f) "Negative rotation")
        (check-equal? (rotate-left 3 '(a b c d e f g)) '(d e f g a b c) "Positive 3 rotation")
        (check-equal? (rotate-left -3 '(a b c d e f g)) '(e f g a b c d) "Negative 3 rotation")
        (check-equal? (rotate-left 8 '(a b c d e f g)) '(b c d e f g a) "Positive 8 rotation")
        (check-equal? (rotate-left -8 '(a b c d e f g)) '(g a b c d e f) "Negative 8 rotation")
        (check-equal? (rotate-left 45 '(a b c d e f g)) '(d e f g a b c) "Positive 45 rotation")
        (check-equal? (rotate-left -45 '(a b c d e f g)) '(e f g a b c d) "Negative 45 rotation")
    ))

(define test-prime-factors
    (test-suite
        " Test function: prime-factors"
        (check-equal? (prime-factors 1) '() "Empty list")
        (check-equal? (prime-factors 6) '(2 3) "6")
        (check-equal? (prime-factors 96) '(2 2 2 2 2 3) "96")
        (check-equal? (prime-factors 666) '(2 3 3 37) "666")
    ))

(define test-my-gcd
    (test-suite
        " Test function: my-gcd"
        (check-equal? (my-gcd 0 0) 0 "both numbers are 0")
        (check-equal? (my-gcd 3 0) 3 "second number is 0")
        (check-equal? (my-gcd 0 2) 2 "first number is 0")
        (check-equal? (my-gcd 2 2) 2 "both numbers equal")
        (check-equal? (my-gcd 10 8) 2 "10 and 8")
        (check-equal? (my-gcd 8 10) 2 "8 and 10")
        (check-equal? (my-gcd 270 192) 6 "270 and 192")
        (check-equal? (my-gcd 13 7919) 1 "13 and 7919")
        (check-equal? (my-gcd 20 16) 4 "20 and 16")
        (check-equal? (my-gcd 54 24) 6 "54 and 24")
        (check-equal? (my-gcd 6307 1995) 7 "6307 and 1995")
    ))

(define test-deep-reverse
    (test-suite
      "Function deep-reverse"
      (check-equal? (deep-reverse '()) '() "Empty list")
      (check-equal? (deep-reverse '(a b)) '(b a) "Two element list")
      (check-equal? (deep-reverse '(a b c)) '(c b a) "Three element list")
      (check-equal? (deep-reverse '(a (b c d) 3)) '(3 (d c b) a) "Nested lists")
      (check-equal? (deep-reverse '((1 2) 3 (4 (5 6)))) '(((6 5) 4) 3 (2 1)) "Double nested lists")
    ))

(define test-insert-everywhere
    (test-suite
      "Function insert-everywhere"
      (check-equal? (insert-everywhere 1 '()) '((1)) "Empty list")
      (check-equal? (insert-everywhere 1 '(a)) '((1 a) (a 1)) "One element list")
      (check-equal? (insert-everywhere 1 '(a b c)) '((1 a b c) (a 1 b c) (a b 1 c) (a b c 1)) "Three element list")
      (check-equal? (insert-everywhere 1 '(a b c d e)) '((1 a b c d e) (a 1 b c d e) (a b 1 c d e) (a b c 1 d e) (a b c d 1 e) (a b c d e 1)) "Three element list")
    ))

(define test-pack
    (test-suite
      "Function pack"
      (check-equal? (pack '()) '() "Empty list")
      (check-equal? (pack '(a)) '((a)) "Single element list")
      (check-equal? (pack '(a a a a b c c a a d e e e e)) '((a a a a) (b) (c c) (a a) (d) (e e e e)) "Multi element list")
      (check-equal? (pack '(1 2 3 4 5)) '((1) (2) (3) (4) (5)) "No repeating element list")
      (check-equal? (pack '(9 9 9 9 9)) '((9 9 9 9 9)) "Single repeating element list")
    ))

(define test-compress
    (test-suite
      "Function compress"
      (check-equal? (compress '()) '() "Empty list")
      (check-equal? (compress '(a)) '(a) "Single element list")
      (check-equal? (compress '(a a a a b c c a a d e e e e)) '(a b c a d e) "Multi element list")
      (check-equal? (compress '(1 2 3 4 5)) '(1 2 3 4 5) "No repeating element list")
      (check-equal? (compress '(9 9 9 9 9)) '(9) "Single repeating element list")
    ))

(define test-encode
    (test-suite
      "Function encode"
      (check-equal? (encode '()) '() "Empty list")
      (check-equal? (encode '(a)) '((1 a)) "Single element list")
      (check-equal? (encode '(a a a a b c c a a d e e e e)) '((4 a) (1 b) (2 c) (2 a) (1 d) (4 e)) "Multi element list")
      (check-equal? (encode '(1 2 3 4 5)) '((1 1) (1 2) (1 3) (1 4) (1 5)) "No repeating element list")
      (check-equal? (encode '(9 9 9 9 9)) '((5 9)) "Single repeating element list")
    ))

(define test-encode-modified
    (test-suite
      "Function encode-modified"
      (check-equal? (encode-modified '()) '() "Empty list")
      (check-equal? (encode-modified '(a)) '(a) "Single element list")
      (check-equal? (encode-modified '(a a a a b c c a a d e e e e)) '((4 a) b (2 c) (2 a) d (4 e)) "Multi element list")
      (check-equal? (encode-modified '(1 2 3 4 5)) '(1 2 3 4 5) "No repeating element list")
      (check-equal? (encode-modified '(9 9 9 9 9)) '((5 9)) "Single repeating element list")
    ))

(define test-decode
    (test-suite
      "Function decode"
      (check-equal? (decode '()) '() "Empty list")
      (check-equal? (decode '(a)) '(a) "Single element list")
      (check-equal? (decode '((4 a) b (2 c) (2 a) d (4 e))) '(a a a a b c c a a d e e e e) "Multi element list")
      (check-equal? (decode '(1 2 3 4 5)) '(1 2 3 4 5) "No repeating element list")
      (check-equal? (decode '((5 9))) '(9 9 9 9 9) "Single repeating element list")
    ))

(define test-arg-swap
    (test-suite
      "Function arg-swap"
      (check-equal? ((arg-swap list) 1 2) '(2 1) "Swap list")
      (check-equal? ((arg-swap /) 8 2) 1/4 "Swap division")
      (check-equal? ((arg-swap cons) '(1 2 3) '(4 5 6)) '((4 5 6) 1 2 3) "Swap cons")
      (check-equal? ((arg-swap map) '(-1 1 2 5 10) /) '(-1 1 1/2 1/5 1/10) "Swap cons")
    ))

(define test-there-exists-one?
    (test-suite
      "Function there-exists-one?"
      (check-equal? (there-exists-one? positive? '()) #f "No positives")
      (check-equal? (there-exists-one? positive? '(-1 -10 4 -5 -2 -1)) #t "One positive")
      (check-equal? (there-exists-one? positive? '(-1 -10 4 -5 2 -1)) #f "Two positives")
      (check-equal? (there-exists-one? negative? '(-1)) #t "One negative")
      (check-equal? (there-exists-one? symbol? '(4 8 15 16 23 42)) #f "No symbols")
      (check-equal? (there-exists-one? symbol? '(4 8 15 sixteen 23 42)) #t "One symbol")
    ))

(define test-linear-search
    (test-suite
      "Function linear-search"
      (check-equal? (linear-search '() 5 =) #f "Not found")
      (check-equal? (linear-search '(48 77 30 31 5 20 91 92 69 97 28 32 17 18 96) 5 =) 4 "Found")
      (check-equal? (linear-search '("red" "blue" "green" "black" "white") "black" string=?) 3 "Found")
      (check-equal? (linear-search '(a b c d e f g h) 'h equal?) 7 "Found")
    ))

; Start the execution of the test suite
(displayln "Testing: insert")
(run-tests test-insert)
(displayln "Testing: insertion-sort")
(run-tests test-insertion-sort)
(displayln "Testing: rotate-left")
(run-tests test-rotate-left)
(displayln "Testing: prime-factors")
(run-tests test-prime-factors)
(displayln "Testing: my-gcd")
(run-tests test-my-gcd)
(displayln "Testing: deep-reverse")
(run-tests test-deep-reverse)
(displayln "Testing: insert-everywhere")
(run-tests test-insert-everywhere)
(displayln "Testing: pack")
(run-tests test-pack)
(displayln "Testing: compress")
(run-tests test-compress)
(displayln "Testing: encode")
(run-tests test-encode)
(displayln "Testing: encode-modified")
(run-tests test-encode-modified)
(displayln "Testing: decode")
(run-tests test-decode)
(displayln "Testing: arg-swap")
(run-tests test-arg-swap)
(displayln "Testing: there-exists-one?")
(run-tests test-there-exists-one?)
(displayln "Testing: linear-search")
(run-tests test-linear-search)
