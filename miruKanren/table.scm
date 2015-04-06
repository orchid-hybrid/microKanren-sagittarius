(define (make-table g)
  ;; artifically limit to 100
  ;; to help avoid crashes (maybe?)
  (cons 'table (stream-take 100 (stream-map (lambda (k)
					      (walk* (var 0) (substitution k)))
					    ((call/fresh g) initial-kanren)))))

(define (table-membero t q)
  (unless (eq? (car t) 'table)
	  (error "not a table!"))
  (let loop ((t t))
    (if (null? t)
	(== 0 1)
	(begin
	  (when (procedure? (cdr t))
		(set-cdr! t (pull (cdr t))))
	  (disj (copy-termo (car t) q)
		(Zzz (loop (cdr t))))))))
