(define (walk u s)
  ;; Walking a variable or term in a substitution will
  ;; give either the value it points to, or a fresh variable
  ;;
  ;; it is sort of like `weak-head normal form`
  (let ((pr (and (var? u) (assp (lambda (v) (var=? u v)) s))))
    (if pr (walk (cdr pr) s) u)))

(define (walk* v s)
  ;; walk* recursively walks a term to put it into a
  ;; normalized/completely evaluated form
  (let ((v (walk v s)))
    (cond
     ((var? v) v)
     ((pair? v) (cons (walk* (car v) s)
                      (walk* (cdr v) s)))
     (else v))))

(define (occurs-check x v s)
  ;; Performing occurs check of a variable in a term
  ;; given a substitution.
  ;; This lets us fail on cyclic/unfounded unifications
  (let ((v (walk v s)))
    (cond
     ((var? v) (var=? v x))
     ((pair? v) (or (occurs-check x (car v) s)
                    (occurs-check x (cdr v) s)))
     (else #f))))

(define (extend-substitution/prefix x v s p)
  (if (occurs-check x v s)
      (values #f
              #f)
      (values `((,x . ,v) . ,s)
              `((,x . ,v) . ,p))))

(define (unify/prefix u v s p)
  ;; This version of unification builds up a `prefix`
  ;; which contains all the variables that were involved
  ;; in unification that are no longer fresh
  ;;
  ;; This is not needed for pure minikanren but it is
  ;; useful for implementing constraints.
  (let ((u (walk u s)) (v (walk v s)))
    (cond
     ((and (var? u) (var? v) (var=? u v)) (values s p))
     ((var? u) (extend-substitution/prefix u v s p))
     ((var? v) (extend-substitution/prefix v u s p))
     ((and (pair? u) (pair? v))
      (let-values (((s p) (unify/prefix (car u) (car v) s p)))
	(if s
            (unify/prefix (cdr u) (cdr v) s p)
            (values #f #f))))
     (else (if (eqv? u v)
               (values s p)
               (values #f #f))))))

(define (unify u v s)
  (let-values (((s p) (unify/prefix u v s '())))
    s))
