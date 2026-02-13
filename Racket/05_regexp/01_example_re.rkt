#|
Basic example of using regular expressions in Racket

Gilberto Echeverria
2021-05-12
|#

#lang racket

(require racket/trace)

; Declare publicly available functions
(provide test split-file-extension date-DD/MM/YYYY->YYYY-MM-DD)

(define (test input-string)
  " Identify strings containing a fixed sequence "
  ; Identify the string hello, with any combination of upper/lower case
  (regexp-match #px"[hH][eE][lL][lL][oO]" input-string))

(define (split-file-extension input-string)
  " Extract only the name part of a file name "
  (let
    ; Define two groups: one for the name and one for the extension
    ; Store the results of the regular expression (a list) in variable 'matches'
    ([matches (regexp-match #px"([\\w-]+)(\\.\\w{1,4})" input-string)])
    ; Take only the first group
    (cadr matches)))

(define (date-DD/MM/YYYY->YYYY-MM-DD date-string)
  " Change the format of a date "
  ; Captured groupd (in parentheses) can be refered to by number
  (regexp-replace #px"(\\d{2})/(\\d{2})/(\\d{4})" date-string "\\3-\\2-\\1"))
