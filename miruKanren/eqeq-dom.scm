(define (== u v)
  (lambda (k)
    (let-values (((s p) (unify/prefix u v (substitution k))))
      (if s
	  (let ((k (domain-store-update-associations
		    (modified-substitution (lambda (_) s) k)
		    p)))
	    (if (domains k)
		(normalize-disequality-store k)
		mzero))
	  mzero))))

(define (=/= u v)
  (=/=-original u v))

(define (domo v d)
  ;; at the moment d must be a list of integers
  ;; it would be good to relax this and support any list of symbols
  ;; but we need a (fast) < operation on them
  (lambda (k)
    (let ((v (walk* v (substitution k))))
      (unit
       (modified-domains (lambda (dom)
			   (trie-insert/merge dom (var->int v) (sort d <) merge-domains))
			 k)))))

#|

(import (miruKanren mini) (miruKanren run) (miruKanren eqeq-dom))
(run^ 1 (lambda (q) (fresh (x) (domo q '(1 2 3 4)) (domo q '(4 2)))))



A start: intersecting domains

> (run^ 1 (lambda (q) (fresh (x) (domo q '(1 2 3 4)) (domo x '(4 2 5 6)) (== q x))))
((#(0) . #(1)))
((_.0 where (domo _.0 (2 4))))

> (run^ 1 (lambda (q) (fresh (x) (domo x '(4 2 5 6)) (== q x))))
((#(0) . #(1)))
((_.0 where (domo _.0 (2 4 5 6))))

> (run^ 1 (lambda (q) (fresh (x) (domo q '(1 2 3 4)) (== q x))))
((#(0) . #(1)))
((_.0 where (domo _.0 (1 2 3 4))))


> (run^ 1 (lambda (q) (fresh (x) (domo q '(1 2 3 4)) (domo x '(4 2 5 6)))))
((_.0 where
      (domo _.0 (1 2 3 4))
      (domo _.1 (2 4 5 6))))

> (run^ 1 (lambda (q) (fresh (x) (domo q '(1 2 3 4)) (domo q '(4 2 5 6)))))
((_.0 where (domo _.0 (2 4))))

> (run^ 1 (lambda (q) (fresh (x) (== q x) (domo q '(1 2 3 4)) (domo x '(4 2 5 6)))))
((#(0) . #(1)))
((_.0 where
      (domo _.0 (1 2 3 4))
      (domo _.0 (2 4 5 6))))
BUG!!! fixed

> (run^ 1 (lambda (q) (fresh (x) (domo x '(1 2 3 4)) (== x 3))))
((_.0 where))

> (run^ 1 (lambda (q) (fresh (x) (domo x '(1 2 3 4)) (== x 5))))
()



|#
