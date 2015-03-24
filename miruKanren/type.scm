(define (normalize-type-store p k)
  ;; given a prefix and a kanren normalize
  ;; the type store
  ;;
  ;; the type store is just an assoc list
  ;; ((<fresh-var> . <type>) . ...)
  ;;
  ;; but it's important that the keys are
  ;; kept fresh, so for each key that
  ;; appears in the prefix, freshen it or
  ;; if it's now an actual term, make a
  ;; note of its type to unify against our
  ;; <type> at the end
  (let ((s (substitution k)))
    (let loop ((ty (type-store k))
               (r '())
               (u-left '())
               (u-right '()))
      (if (null? ty)
          (values (modified-type-store (lambda (_) r) k)
                  u-left
                  u-right)
          (let ((v (walk (caar ty) (substitution k)))
                (t (cdar ty)))
            (cond ((var? v)
                   (loop (cdr ty)
                         (cons (cons v t) r)
                         u-left
                         u-right))
                  ((type? v) =>
                   (lambda (type-name)
                     (loop (cdr ty)
                           r
                           (cons t u-left)
                           (cons type-name u-right))))
                  (else (error "invalid minikanren object"))))))))

(define (call/type-of-var v k f)
  ;; v must be a fresh variable (so that assoc will work)
  ;;
  ;; we will either find its type in the type store
  ;; or generate a fresh variable and add that to it
  (let ((ty (type-store k)))
    (cond ((assoc v ty) => (lambda (entry) (f (cdr entry))))
          (else (call/fresh (lambda (t-var)
                              (lambda (k)
                                ((f t-var)
                                 (modified-type-store
                                  (lambda (ty) (cons (cons v t-var) ty))
                                  k)))))))))
