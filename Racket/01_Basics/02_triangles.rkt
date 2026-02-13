#|
Functions to work with triangles

Gilberto Echeverria
01/09/2019
13/08/2020  Add trigonometric functions
|#

#lang racket

(define (hypot side-A side-B)
    " Compute the hypotenuse of a triangle, given its sides "
    (sqrt (+ (* side-A side-A) (* side-B side-B))))

(define (far-side hypot-length theta)
    " Find the leangth of the far side,
    given the length of the hypotenuse and the angle in degrees "
    (* hypot-length (sin (degrees->radians theta))))

(define (near-side hypot-length theta)
    " Find the leangth of the near side,
    given the length of the hypotenuse and the angle in degrees "
    (* hypot-length (cos (degrees->radians theta))))

#|
(define (sides->area a b c)
    " Area of a triangle, given its sides "
    (sqrt (* (half-perimeter a b c) (- (half-perimeter a b c) a) (- (half-perimeter a b c) b) (- (half-perimeter a b c) c))))

(define (half-perimeter a b c)
    " Compute the half perimeter of the triangle "
    (/ (+ a b c) 2))
|#

(define (sides->area a b c)
    " Shorter version of the function, using let "
    (let 
        ; definitions
        ([s (/ (+ a b c) 2)])
        ; expression
        (sqrt (* s (- s a) (- s b) (- s c)))))
