(define (reify-name n)
  (string->symbol
   (string-append "_" "." (number->string n))))

(define (reify-s v s)
  ;; Given a term and substitution this extends
  ;; the substitution with nice names for each
  ;; fresh variable in v
  (let ((v (walk v s)))
    (cond
     ((var? v) (let ((n (reify-name (substitution-size s))))
                 (substitution-update (vector-ref v 0) n s)))
     ((pair? v) (reify-s (cdr v) (reify-s (car v) s)))
     (else s))))

(define (reify-term t s)
  ;; To reify a term:
  ;;
  ;; First use walk* so that we have a flat term
  ;; containing only fresh variables
  ;;
  ;; Then extend our substitution with good names
  ;; for all those variables
  ;;
  ;; walk* it again to reify all the fresh variables
  ;; in the term itself.
  ;;
  ;; Doing it in two steps like this means we use up
  ;; names for any variables that aren't in the final
  ;; term
  (let ((v (walk* t s)))
    (walk* v (reify-s v empty-substitution))))

(define (reify-kanren k)
  ;; The query variable will always be the very first
  ;; one so reify (var 0) along with all the constraints
  ;; or extra conditions that might need to be displayed
  (define (make-=/= eq) `(=/= ,(car eq) ,(cdr eq)))
  (reify-term `(,(var 0) where .
                ,(append (map (lambda (d)
                                `(or . ,(map make-=/= d)))
                              (disequality-store k))
                         (map (lambda (e)
                                (list (car e) ': (cdr e)))
                              (type-store k))
                         (map (lambda (constraint)
                                'unknown)
                              (surveillance k))
                         ))
              (substitution k)))
