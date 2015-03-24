(define (variables-in-term s x)
  (define (go v s tl)
    (let ((v (walk v s)))
      (cond
       ((var? v) (cons v tl))
       ((pair? v) (go (car v) s
                      (go (cdr v) s
                          tl)))
       (else tl))))
  (go x s '()))

(define (update-watch-list s l)
  (sort (concat-map (lambda (x)
                      (variables-in-term s x))
                    l)
        var<))

(define (execute-goals gs)
  (lambda (k)
    (if (null? gs)
        (unit k)
        (bind ((car gs) k)
              (execute-goals (cdr gs))))))

(define (normalize-surveillance p k)
  ;; After a unification has been performed we have a list of
  ;; all the variables that are no longer fresh, make it into
  ;; a set `active` for fast searching
  (let ((active (sort (map car p) var<)))
    ;; now we need to loop through the surveillance state
    ;; if a watch list intersects the active list then we
    ;; will have to update it, otherwise leave it alone
    ;;
    ;; to update a watch list we just replace each of
    ;; the variables that are no longer fresh with the
    ;; list of variables inside that term. If the result
    ;; list is () then we have a ground term so make a
    ;; note to trigger that at the end
    (let loop ((the-list (surveillance k))
               (acc '())
               (triggers '()))
      (if (null? the-list)
          ((execute-goals triggers)
           (modified-surveillance (lambda (_) acc) k))
          (let ((watch-list (caar the-list))
                (trigger (cdar the-list)))
            (if (intersects? (lambda (v) (vector-ref v 0))
                             active watch-list)
                (let ((watch-list (update-watch-list
                                   (substitution k) watch-list)))
                  (if (null? watch-list)
                      (loop (cdr the-list)
                            acc
                            (cons trigger triggers))
                      (loop (cdr the-list)
                            (cons (cons watch-list trigger) acc)
                            triggers)))
                (loop (cdr the-list)
                      (cons (car the-list) acc)
                      triggers)))))))
