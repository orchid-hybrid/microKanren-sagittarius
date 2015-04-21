;; The kanren structure holds all the state that is threaded
;; monadically

(define-record-type <kanren>
  (make-kanren c s d ty t do)
  kanren?
  (c counter)
  (s substitution)
  (d disequality-store)
  (ty type-store)
  (t surveillance)
  (do domains))

(define initial-kanren
  (make-kanren 0 '() '() '() '() '()))


;; Using these modified-* functions instead of make-kanren
;; make-kanren let us add new fields without having to
;; change existing code

(define (modified-counter f k)
  (make-kanren (f (counter k))
               (substitution k)
               (disequality-store k)
               (type-store k)
               (surveillance k)
	       (domains k)))

(define (modified-substitution f k)
  (make-kanren (counter k)
               (f (substitution k))
               (disequality-store k)
               (type-store k)
               (surveillance k)
	       (domains k)))

(define (modified-disequality-store f k)
  (make-kanren (counter k)
               (substitution k)
               (f (disequality-store k))
               (type-store k)
               (surveillance k)
	       (domains k)))

(define (modified-type-store f k)
  (make-kanren (counter k)
               (substitution k)
               (disequality-store k)
               (f (type-store k))
               (surveillance k)
	       (domains k)))

(define (modified-surveillance f k)
  (make-kanren (counter k)
               (substitution k)
               (disequality-store k)
               (type-store k)
               (f (surveillance k))
	       (domains k)))

(define (modified-domains f k)
  (make-kanren (counter k)
               (substitution k)
               (disequality-store k)
               (type-store k)
               (surveillance k)
	       (f (domains k))))

