;; The disequality store d is of the form:
;;
;;      (AND (OR (=/= ...) ...)
;;           (OR (=/= ...) ...) ...)
;;
;; by de-morgan this can be interpreted as:
;;
;; (NOT (OR (AND (== ...) ...)
;;          (AND (== ...) ...) ...))
;;
;; so to normalize such a structure we can
;; normalize each AND, that is the job of
;; the helper function `disequality/assoc`

(define (disequality u v s)
  ;; The `disequality` procedure is sort of the
  ;; dual of `unify`.
  ;;
  ;; If fails (returns #f) if the objects are
  ;; already equal.
  ;;
  ;; If they can never be equal it will return ()
  ;;
  ;; It is defined in terms of a more generalized
  ;; version that takes a big OR assoc list of
  ;; objects to "disunify".

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
  
  (disequality/assoc (list (cons u v)) s))

(define (disequality/assoc e s)
  ;; disequality/assoc is functionally equivalent
  ;; to (disequality (map car e) (map cdr e) s)
  ;;
  ;; so if e is () then it returns #f
  ;;
  ;; the way the recursion works is to consider case
  ;; lets say e = ((x . y) . es) then
  ;; * if x and y are already equal then
  ;;   it's all down to es
  ;; * if x and y are distinct then
  ;;   we can return ()
  ;; * if x and y unify then we get a prefix
  ;;   which we consider an OR, we'll append it
  ;;   to ds
  ;;
  (let loop ((e e) (ds #f))
    (if (null? e)
        ds
        (let ((u (caar e)) (v (cdar e)))
          (let-values (((s^ p) (unify/prefix u v s)))
            (if s^
                (if (null? p)
                    (loop (cdr e) ds)
                    (loop (cdr e) (if ds (append p ds) p)))
                '()))))))

(define (normalize-disequality-store k)
  (bind (mapm (lambda (e)
                (let ((d^ (disequality/assoc e (substitution k))))
                  (if d^ (unit d^) mzero)))
              (disequality-store k))
        (lambda (d)
          (unit (modified-disequality-store
                 (lambda (_)
                   ;; you could return d here..
                   ;; the filter is just to remove (or)'s
                   ;; from the reified constraint store
                   (filter (lambda (e) (not (null? e))) d))
                 k)))))

(define (=/= u v)
  (lambda (k)
    (let ((d^ (disequality u v (substitution k))))
      (if d^
          (if (null? d^)
              (unit k)
              (unit (modified-disequality-store
                     (lambda (_)
                       (cons d^ (disequality-store k)))
                     k)))
          mzero))))
