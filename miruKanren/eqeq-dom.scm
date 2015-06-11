(define (== u v)
  (lambda (k)
    (let-values (((s p) (unify/prefix u v (substitution k))))
      (if s
	  (bind
	   (normalize-disequality-store
	    (modified-substitution (lambda (_) s) k))
	   (domain-store-normalizer p))
	  mzero))))

(define (=/= u v)
  (lambda (k)
    (bind ((=/=-original u v) k)
	  (lambda (k)
	    ((domain-store-normalizer '()) k)))))

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


;; There is a potential issue with =/=
;; it may update the disequality store without performing
;; a new unification
;;
;; but unification is the only thing that triggers
;; normalizing the domain store
;;
;; one solution would be to normalize the domain store
;; after disequality as well as equality
;;
;; right now you seem to be able to cheat it by doing
;; (== q q)
;;
;; because of this problem we have the first working
;; the second not



;; > (run* (lambda (q) (fresh () (=/= q 'h) (domo q '(o h)))))
;; (checking (#(0)) (((#(0) . h))))
;; (ok ((#(0) . h)))
;; (relevant-disequalities (((#(0) . h))))
;; ((_.0 where (or (=/= _.0 h)) (domo _.0 (o h))))

;; > (run* (lambda (q) (fresh () (domo q '(o h)) (=/= q 'h))))
;; (checking (#(0)) ())
;; (relevant-disequalities ())
;; ((_.0 where (or (=/= _.0 h)) (domo _.0 (o h))))
