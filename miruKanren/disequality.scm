;; `disequality` fails (returns #f) if the things are
;; already equal.
;;
;; If they 


;; The way with triangular substitutions was to subtract
;; Using unify/prefix means we don't need to subtract
;;
;; (define (disequality u v s)
;;   (let ((s^ (unify u v s)))
;;     (if s^
;; 	(let ((d (subtract-s s^ s)))
;; 	  (if (null? d) #f d))
;; 	'())))

;; Originally disequality was similar to unify just
;; taking u,v.. but it is more useful to take a whole
;; assoc list
;; 
;; (define (disequality u v s)
;;   (let-values (((s^ p) (unify/prefix u v s)))
;;     (if s^
;;         (if (null? p) #f p)
;; 	'())))

(define (disequality l s)
  (if (null? l)
      )
  (let-values (((s^ p) (unify/prefix u v s)))
    (if s^
        (if (null? p) #f p)
	'())))

(define (normalize-disequality-store k)
  ;; the disequality store d is of the form
  ;;      (AND (OR (=/= ...) ...)
  ;;           (OR (=/= ...) ...) ...)
  ;; by de-morgan this can be interpreted as
  ;; (NOT (OR (AND (== ...) ...)
  ;;          (AND (== ...) ...) ...))
  ;; so to normalize we can normalize each
  ;; part of the OR individually (failing if
  ;; any one of them fails), but we need to
  ;; chain each unification in the AND's alt-
  ;; ernatively (and this is what we do here)
  ;; merge them into a single unification op
  (bind (mapm (lambda (es)
		(let ((d^ (disequality (map car es)
				       (map cdr es)
				       (substitution k))))
		  (if d^ (unit d^) mzero)))
	      (filter (lambda (l) (not (null? l)))
		      (disequality-store k)))
	(lambda (d)
	  (unit (make-kanren (counter k) (substitution k)
                             d (absento-store k) (symbolo-store k))))))
