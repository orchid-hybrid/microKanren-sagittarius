(define (normalize-domain-store p k)
  ;; the domain store is an assoc list of
  ;;   (<var> . <values>)
  ;; where <values> are all ground.
  ;;
  ;; to normalize it we need to do a couple things
  ;;
  ;; (A)
  ;; * if you see (<var> . ()) we fail immediately,
  ;;   there's nothing in the empty domain
  ;; * if you see (<var> <single>) make a note of that
  ;;   to unify (== <var> <single>) later
  ;; * if <var> has become ground then fail if it isn't
  ;;   something in the domain (otherwise remove it)
  ;;
  ;; (B)
  ;; then the hard bit is keeping each <var> fresh
  ;; (we know that only things in p need to be updated
  ;;  so take (map car p) as the list of vars to check)
  ;; and when a duplicate is found we need to intersect
  ;; their domains.
  ;;
  ;; (C) TODO
  ;; we also need to search for disequality constraints
  ;; regarding each variable in p, ((=/= var g))
  ;; where g is ground.. then remove g from the set
  ;;
  ;; we should do B first because the result of that
  ;; might enable new A type things to happen.
  (let ((s (substitution k))
	(vars (map car p)))
    (let loop ((do (domains k))
	       (out '()))
      (if (null? do)
	  ;; done
	  (normalize-domain-store-part2 out k)
	  (let ((v (caar do))
		(d (cdar do)))
	    (if (member v vars)
		(let ((v (walk v s)))
		  ;(display (list '< v '>)) (newline)
		  (if (symbol? v)
		      (begin
			;(display (list "hi" v d "ok"))
			(if (not (member v d))
			    (values #f #f)
			    (loop (cdr do)
				  out)))
		      (cond ((assoc v out) =>
			     (lambda (e)
			       ;; TODO this actually just adds on
			       ;; the smaller domain constraint
			       ;; it needs to also remove the found 'e'
			       (let ((d^ (cdr e)))
				 (loop (cdr do)
				       (cons (cons v (intersect d d^))
					     out)))))
			    (else (loop (cdr do)
					(cons (cons v d)
					      out))))))
		(loop (cdr do)
		      (cons (car do)
			    out))))))))

(define (normalize-domain-store-part2 do k)
  (let loop ((do do)
	     (acc '())
	     (eqs '()))
    (if (null? do)
	(values (modified-domains (lambda (_) acc) k)
		eqs)
	(let ((v (caar do))
	      (d (cdar do)))
	  (cond ((null? d) (values #f #f))
		((null? (cdr d)) (loop (cdr do)
				       acc
				       (cons (cons v d) eqs)))
		(else (loop (cdr do)
			    (cons (car do) acc)
			    eqs)))))))
