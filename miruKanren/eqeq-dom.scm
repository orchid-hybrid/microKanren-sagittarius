(define (== u v)
  (lambda (k)
    (let-values (((s p) (unify/prefix u v (substitution k))))
      (if s
	  (bind
	   (normalize-disequality-store
	    (modified-substitution (lambda (_) s) k))
	   (domain-store-normalizer p))
	  mzero))))

(define (domain-store-normalizer p)
  (lambda (k)
    (let-values (((k eqs) (normalize-domain-store p k)))
      (if k
	  (let loop ((k k)
		     (eqs eqs))
	    (if (null? eqs)
		(unit k)
		(bind ((== (caar eqs) (cdar eqs)) k)
			(lambda (k)
			  (loop k (cdr eqs))))))
	  mzero))))

(define (domo v d)
  (lambda (k)
    ((domain-store-normalizer (list (cons v v)))
     (modified-domains (lambda (do) (cons (cons v d) do)) k))))

;;(import (miruKanren mini) (miruKanren run) (miruKanren eqeq-dom))


;; sash> (run* (lambda (q) (domo q '())))
;; ()
;; sash> (run* (lambda (q) (domo q '(o))))
;; (((o) where))
;; sash> (run* (lambda (q) (domo q '(o h))))
;; ((_.0 where))

;; sash> (run* (lambda (q) (fresh () (domo q '(o h)) (== q 'o))))
;; ((o where))
;; sash> (run* (lambda (q) (fresh () (domo q '(o h)) (== q 'h))))
;; ((h where))
;; sash> (run* (lambda (q) (fresh () (domo q '(o h)) (== q 'e))))
;; ()


;; need =/= next

;; dom intersection

;; sash> (run* (lambda (q) (fresh () (domo q '(o h k)) (domo q '(h i j k)))))
;; ((_.0 where (domo _.0 (h i j k)) (domo _.0 (h k))))


;; dom reification..
