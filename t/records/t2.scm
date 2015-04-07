(import (scheme base)
        (test-check)

        (miruKanren mk-diseq)
	(examples closure))

(test-check "record disequ #1"
	    (run* (lambda (q) (=/= (closure 'x) (closure 'x))))
	    '())

(test-check "record disequ #2"
	    (run* (lambda (q) (=/= (closure 'x) (closure 'y))))
	    '((_.0 where)))

(test-check "record disequ #3"
	    (run* (lambda (q) (=/= (closure q) (closure 'y))))
	    '((_.0 where (or (=/= _.0 y)))))

