(import (scheme base)
        (test-check)

        (miruKanren mk-basic)
	(examples closure))

(test-check "record #1"
	    (run* (lambda (q) (== q 'x)))
	    '((x where)))

(test-check "record #2"
	    (run* (lambda (q) (== (closure q) 'x)))
	    '())

(test-check "record #3"
	    (run* (lambda (q) (== (closure q) q)))
	    '())

;; It's impossible to check if records are EQUAL?
;; because R7RS does not specify what happens....
;; 
;; (test-check "record #4"
;; 	    (run* (lambda (q) (== (closure 'x) q)))
;; 	    `((,(closure 'x) where)))

(test-check "record #5"
	    (run* (lambda (q) (== (closure q) (closure 'y))))
	    '((y where)))

