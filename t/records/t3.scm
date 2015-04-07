(import (scheme base)
        (test-check)

        (miruKanren mk-types)
	(examples closure))

(test-check "record typeo #1"
	    (run* (lambda (q) (typeo (closure 'x) q)))
	    '((closure where)))

(test-check "record typeo #2"
	    (run* (lambda (q)
		    (fresh (h)
		      (== q 'x)
		      (typeo h 'closure)
		      (== h (closure q)))))
	    '((x where)))

(test-check "record typeo #3"
	    (run* (lambda (q)
		    (fresh (h)
		      (== q 'x)
		      (typeo h 'boolean)
		      (== h (closure q)))))
	    '())
