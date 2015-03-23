(define (print s) (display s) (newline))


(define (run^ n g)
  ;; Compute up to a set limit of results
  (map reify-kanren (take n ((call/fresh g) initial-kanren))))

(define (run* g)
  ;; Compute every result
  (map reify-kanren (take-all ((call/fresh g) initial-kanren))))

(define (runi g)
  ;; This version of run returns one result from the
  ;; stream at a time interactively asking if you
  ;; want more or not
  (let (($ ((call/fresh g) initial-kanren)))
    (let loop (($ (pull $)))
      (if (null? $)
          (print 'thats-all!)
          (begin (print (reify-kanren (car $)))
                 (print '(another? y/n))
                 (case (read)
                   ((y yes) (loop (pull (cdr $))))
                   (else (print 'bye!))))))))
