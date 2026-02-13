#|
    Tests for the set of probles by Ariel Ortiz
    Using functions, conditions, recursion and lists

    Gilberto Echeverria
    23/02/2021
|#

; Import library for unit testing
(require rackunit)
; Import necesary to view the test results
(require rackunit/text-ui)

; Functions

(define test-fahrenheit-to-celsius
    (test-suite
        " Test function: fahrenheit-to-celsius"
        (check-= (fahrenheit-to-celsius 212.0) 100.0 0.01 "Positive value")
        (check-= (fahrenheit-to-celsius 32) 0 0.01 "Freezing point")
        (check-= (fahrenheit-to-celsius -40.0) -40.0 0.01 "Same temperature")
    ))

(define test-sign
    (test-suite
        " Test function: sign"
        (check-equal? (sign -5) -1 "Negative")
        (check-equal? (sign 10) 1 "Positive")
        (check-equal? (sign 0) 0 "Zero")
    ))

; Conditionals

(define test-roots
    (test-suite
        " Test function: roots"
        (check-= (roots 2 4 2) -1 0.01 "Negative root")
        (check-= (roots 1 0 0) 0 0.01 "Zero root")
        (check-= (roots 4 5 1) -1/4 0.01 "Fractional root")
    ))

(define test-bmi
    (test-suite
        " Test function: bmi"
        (check-equal? (bmi 47 1.7) 'underweight "Underweight")
        (check-equal? (bmi 55 1.5) 'normal "Normal")
        (check-equal? (bmi 76 1.7) 'obese1 "Obese1")
        (check-equal? (bmi 81 1.6) 'obese2 "Obese2")
        (check-equal? (bmi 120 1.6) 'obese3 "Obese3")
    ))

; Recursion

(define test-factorial
    (test-suite
        " Test function: factorial"
        (check-equal? (factorial 0) 1 "Base case")
        (check-equal? (factorial 5) 120 "5!")
        (check-equal? (factorial 40) 815915283247897734345611269596115894272000000000 "40!")
    ))

(define test-pow
    (test-suite
        " Test function: pow"
        (check-equal? (pow 5 0) 1 "Base case")
        (check-equal? (pow -5 3) -125 "-5 to the 3")
        (check-equal? (pow 15 12) 129746337890625 "15 to the 12")
    ))

(define test-fib
    (test-suite
        " Test function: fib"
        (check-equal? (fib 6) 8 "Single number")
        (check-equal? (map fib (range 10)) '(0 1 1 2 3 5 8 13 21 34) "Multiple numbers")
        (check-equal? (fib 42) 267914296 "Meaning of life")
    ))

; Lists

(define test-duplicate
    (test-suite
        " Test function: duplicate"
        (check-equal? (duplicate '()) '() "Empty list")
        (check-equal? (duplicate '(1 2 3 4 5)) '(1 1 2 2 3 3 4 4 5 5) "Five element list")
        (check-equal? (duplicate '(a b c d e f g h)) '(a a b b c c d d e e f f g g h h) "Eight element list")
    ))

(define test-enlist
    (test-suite
        " Test function: enlist"
        (check-equal? (enlist '()) '() "Empty list")
        (check-equal? (enlist '(a b c)) '((a) (b) (c)) "3 elements")
        (check-equal? (enlist '((1 2 3) 4  (5) 7 8)) '(((1 2 3)) (4) ((5)) (7) (8)) "nested lists")
    ))

(define test-positives
    (test-suite
        " Test function: positives"
        (check-equal? (positives '()) '() "Empty list")
        (check-equal? (positives '(12 -4 3 -1 -10 -13 6 -5)) '(12 3 6) "mixed elements")
        (check-equal? (positives '(-4 -1 -10 -13 -5)) '() "all negatives")
    ))

(define test-add-list
    (test-suite
        " Test function: add-list"
        (check-equal? (add-list '()) 0 "Empty list")
        (check-equal? (add-list '(2 4 1 3)) 10 "4 elements")
        (check-equal? (add-list '(1 2 3 4 5 6 7 8 9 10)) 55 "10 elements")
    ))

; HW
(define test-invert-pairs
    (test-suite
        " Test function: invert-pairs"
        (check-equal? (invert-pairs '()) '() "Empty list")
        (check-equal? (invert-pairs '((a 1) (a 2) (b 1) (b 2))) '((1 a) (2 a) (1 b) (2 b)) "4 pairs")
        (check-equal? (invert-pairs '((January 1) (February 2) (March 3))) '((1 January) (2 February) (3 March)) "3 pairs")
    ))

; HW
(define test-list-of-symbols?
    (test-suite
        " Test function: list-of-symbols?"
        (check-equal? (list-of-symbols? '()) #t "Empty list")
        (check-equal? (list-of-symbols? '(a b c d e)) #t "all symbols")
        (check-equal? (list-of-symbols? '(a b c d 42 e)) #f "a non symbol")
    ))

; HW
(define test-swapper
    (test-suite
        " Test function: swapper"
        (check-equal? (swapper 1 2 '()) '() "Empty list")
        (check-equal? (swapper 1 2 '(4 4 5 2 4 8 2 5 6 4 5 1 9 5 9 9 1 2 2 4)) '(4 4 5 1 4 8 1 5 6 4 5 2 9 5 9 9 2 1 1 4) "multiple swaps")
        (check-equal? (swapper 1 2 '(4 3 4 9 9 3 3 3 9 9 7 9 3 7 8 7 8 4 5 6)) '(4 3 4 9 9 3 3 3 9 9 7 9 3 7 8 7 8 4 5 6) "no swaps")
        (check-equal? (swapper 'purr 'kitty '(soft kitty warm kitty little ball of fur happy kitty sleepy kitty purr purr purr)) '(soft purr warm purr little ball of fur happy purr sleepy purr kitty kitty kitty) "big bang theory")
    ))

(define test-dot-product
    (test-suite
        " Test function: dot-product"
        (check-= (dot-product '() '()) 0 0 "Empty lists")
        (check-= (dot-product '(1 2 3) '(4 5 6)) 32 0.01 "3 element lists")
        (check-= (dot-product '(1.3 3.4 5.7 9.5 10.4) '(-4.5 3.0 1.5 0.9 0.0)) 21.45 0.01 "5 element lists")
    ))

(define test-average
    (test-suite
        " Test function: average"
        (check-= (average '()) 0 0 "Empty lists")
        (check-= (average '(4)) 4 0.01 "1 element lists")
        (check-= (average '(5 6 1 6 0 1 2)) 3 0.01 "7 element lists")
        (check-= (average '(1.7 4.5 0 2.0 3.4 5 2.5 2.2 1.2)) 2.5 0.01 "9 element lists")
    ))

(define test-standard-deviation
    (test-suite
        " Test function: standard-deviation"
        (check-= (standard-deviation '()) 0 0 "Empty lists")
        (check-= (standard-deviation '(4 8 15 16 23 42)) 12.3153 0.0001 "6 element lists")
        (check-= (standard-deviation '(110 105 90 100 95)) 7.07106 0.0001 "5 element lists")
        (check-= (standard-deviation '(9 2 5 4 12 7 8 11 9 3 7 4 12 5 4 10 9 6 9 4)) 2.983 0.001 "20 element lists")
    ))

; HW
(define test-replic
    (test-suite
        " Test function: replic"
        (check-equal? (replic 7 '()) '() "Empty list")
        (check-equal? (replic 0 '(a b c)) '() "0 repetitions")
        (check-equal? (replic 3 '(a)) '(a a a) "3 repetitions")
        (check-equal? (replic 4 '(1 2 3 4)) '(1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4) "4 repetitions")
    ))

(define test-expand
    (test-suite
        " Test function: expand"
        (check-equal? (expand '()) '() "Empty list")
        (check-equal? (expand '(a)) '(a) "1 element")
        (check-equal? (expand '(1 2 3 4)) '(1 2 2 3 3 3 4 4 4 4) "4 elements")
        (check-equal? (expand '(a b c d e)) '(a b b c c c d d d d e e e e e) "5 elements")
    ))

(define test-binary
    (test-suite
        " Test function: binary"
        (check-equal? (binary 0) '() "Empty list")
        (check-equal? (binary 30) '(1 1 1 1 0) "5 element")
        (check-equal? (binary 45123) '(1 0 1 1 0 0 0 0 0 1 0 0 0 0 1 1) "big number")
    ))

; Start the execution of the test suite
(displayln "Testing: fahrenheit-to-celsius")
(run-tests test-fahrenheit-to-celsius)
(displayln "Testing: sign")
(run-tests test-sign)
(displayln "Testing: roots")
(run-tests test-roots)
(displayln "Testing: bmi")
(run-tests test-bmi)
(displayln "Testing: factorial")
(run-tests test-factorial)
(displayln "Testing: pow")
(run-tests test-pow)
(displayln "Testing: fib")
(run-tests test-fib)
(displayln "Testing: duplicate")
(run-tests test-duplicate)
(displayln "Testing: enlist")
(run-tests test-enlist)
(displayln "Testing: positives")
(run-tests test-positives)
(displayln "Testing: add-list")
(run-tests test-add-list)
(displayln "Testing: invert-pairs")
(run-tests test-invert-pairs)
(displayln "Testing: swapper")
(run-tests test-swapper)
(displayln "Testing: dot-product")
(run-tests test-dot-product)
(displayln "Testing: average")
(run-tests test-average)
(displayln "Testing: standard-deviation")
(run-tests test-standard-deviation)
(displayln "Testing: replic")
(run-tests test-replic)
(displayln "Testing: expand")
(run-tests test-expand)
(displayln "Testing: binary")
(run-tests test-binary)
