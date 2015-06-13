(import (scheme base)
        (test-check)

	(miruKanren mini)
	(miruKanren run)
        (miruKanren eqeq-dom))

(test-check "dom #1 domain"
	    (run^ 1 (lambda (q) (fresh ()
				  (domo q '(1 2 3 4)))))
	    '((_.0 where (domo _.0 (1 2 3 4)))))

(test-check "dom #2 domain intersection"
	    (run^ 1 (lambda (q) (fresh ()
				  (domo q '(1 2 3 4))
				  (domo q '(3 4 5 6)))))
	    '((_.0 where (domo _.0 (3 4)))))

(test-check "dom #3 empty intersection"
	    (run^ 1 (lambda (q) (fresh ()
				  (domo q '(2 4 6 8))
				  (domo q '(1 3 5 7)))))
	    '())

(test-check "dom #4 single intersection"
	    (run^ 1 (lambda (q) (fresh ()
				  (domo q '(1 2 3))
				  (domo q '(3 4 5)))))
	    '((3 where)))

(test-check "dom #2b domain intersection post"
	    (run^ 1 (lambda (q) (fresh (x)
				  (domo q '(1 2 3 4))
				  (domo x '(3 4 5 6))
				  (== q x))))
	    '((_.0 where (domo _.0 (3 4)))))

(test-check "dom #3b empty intersection post"
	    (run^ 1 (lambda (q) (fresh (x)
				  (domo q '(2 4 6 8))
				  (domo x '(1 3 5 7))
				  (== q x))))
	    '())

(test-check "dom #4b single intersection post"
	    (run^ 1 (lambda (q) (fresh (x)
				  (domo q '(1 2 3))
				  (domo x '(3 4 5))
				  (== q x))))
	    '((3 where)))

(test-check "dom #2c domain intersection pre"
	    (run^ 1 (lambda (q) (fresh (x)
				  (== q x)
				  (domo q '(1 2 3 4))
				  (domo x '(3 4 5 6)))))
	    '((_.0 where (domo _.0 (3 4)))))

(test-check "dom #3c empty intersection pre"
	    (run^ 1 (lambda (q) (fresh (x)
				  (== q x)
				  (domo q '(2 4 6 8))
				  (domo x '(1 3 5 7)))))
	    '())

(test-check "dom #4c single intersection pre"
	    (run^ 1 (lambda (q) (fresh (x)
				  (== q x)
				  (domo q '(1 2 3))
				  (domo x '(3 4 5)))))
	    '((3 where)))

(test-check "dom #5 memberchk 1"
	    (run^ 1 (lambda (q) (fresh ()
				  (domo q '(1 2 3))
				  (== q 1))))
	    '((1 where)))

(test-check "dom #6 memberchk 2"
	    (run^ 1 (lambda (q) (fresh ()
				  (domo q '(1 2 3))
				  (== q 2))))
	    '((2 where)))

(test-check "dom #7 memberchk 3"
	    (run^ 1 (lambda (q) (fresh ()
				  (domo q '(1 2 3))
				  (== q 3))))
	    '((3 where)))

(test-check "dom #8 memberchk 4"
	    (run^ 1 (lambda (q) (fresh ()
				  (domo q '(1 2 3))
				  (== q 4))))
	    '())

(test-check "dom #9 memberchk ground 1"
	    (run^ 1 (lambda (q) (fresh ()
				  (domo 1 '(1)))))
	    '((_.0 where)))

(test-check "dom #9 memberchk ground 2"
	    (run^ 1 (lambda (q) (fresh ()
				  (domo 1 '(2)))))
	    '())

(test-check "dom #10 diseq delete"
	    (run^ 1 (lambda (q) (fresh ()
				  (domo q '(1 2 3 4))
				  (domo q '(2 3 5 6))
				  (=/= q 3))))
	    '((2 where)))

(test-check "dom #11 diseq delete"
	    (run^ 1 (lambda (q) (fresh ()
				  (domo q '(1 2 3 4))
				  (domo q '(2 3 5 6))
				  (=/= q 3)
				  (=/= q 2))))
	    '())

(test-check "dom #12 jasons bool example"
	    (run^ 1 (lambda (q) (fresh () (domo q '(0 1)) (=/= q 0) (=/= q 1))))
	    '())

