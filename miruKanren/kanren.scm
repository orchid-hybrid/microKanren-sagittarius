;; The kanren structure holds all the state that is threaded
;; monadically

(define-record-type <kanren>
  (make-kanren c s d t)
  kanren?
  (c counter)
  (s substitution)
  (d disequality-store)
  (t surveillance))

(define initial-kanren
  (make-kanren 0 '() '() '()))


;; Using these modified-* functions instead of make-kanren
;; make-kanren let us add new fields without having to
;; change existing code

(define (modified-counter f k)
  (make-kanren (f (counter k))
               (substitution k)
               (disequality-store k)
               (surveillance k)))

(define (modified-substitution f k)
  (make-kanren (counter k)
               (f (substitution k))
               (disequality-store k)
               (surveillance k)))

(define (modified-disequality-store f k)
  (make-kanren (counter k)
               (substitution k)
               (f (disequality-store k))
               (surveillance k)))

(define (modified-surveillance f k)
  (make-kanren (counter k)
               (substitution k)
               (disequality-store k)
               (f (surveillance k))))

