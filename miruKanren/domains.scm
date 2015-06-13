(define (merge-domains d1 d2)
  (intersection (lambda (i) i) d1 d2))

(define (domain-store-update-associations k p)
  ;; sets the domain to #f if memberchk fails
  (modified-domains
   (lambda (dom)
     (let loop ((dom dom) (p p))
       (if (null? p)
	   dom
	   (let ((u (caar p)) (v (cdar p)))
	     (let-values (((dom found? found) (trie-lookup/delete dom (var->int u))))
	       (if (and (var? u) (var? v))
		   (if found?
		       (loop (trie-insert/merge dom (var->int v) found merge-domains) (cdr p))
		       (loop dom (cdr p)))
		   ;; this is the case where the var was
		   ;; unified with a ground value
		   (if found?
		       (if (member v found)
			   (loop dom (cdr p))
			   #f)
		       (loop dom (cdr p)))))))))
   k))
;; TODO: This depends on the CDRs of the prefix being fully walked. Does that hold?

(define (primitive? diseq)
  (and (= 1 (length diseq))
       (not (var? (cdar diseq)))))

(define (delete item list)
  (cond ((null? list) '())
	((equal? item (car list)) (cdr list))
	(else (cons (car list) (delete item (cdr list))))))

(define (subtract-disequalities-from-domains k)
  (let loop ((dis (disequality-store k))
	     (acc '())
	     (dom (domains k)))
    (if (null? dis)
	(modified-domains (lambda (_) dom) (modified-disequality-store (lambda (_) acc) k))
	(if (primitive? (car dis))
	    (let-values (((dom found? found) (trie-lookup/delete dom (var->int (caaar dis)))))
	      (if found?
		  (begin
		    (loop (cdr dis) acc (trie-insert dom (var->int (caaar dis)) (delete (cdaar dis) found))))
		  (loop (cdr dis) (cons (car dis) acc) dom)))
	    (loop (cdr dis) (cons (car dis) acc) dom)))))

(define (normalize-domain-store == k)
  (let ((dom (domains k)))
    (let-values (((dom todo)
		  (trie-filter (lambda (nodes)
				 (or (null? nodes)
				     (null? (cdr nodes))))
			       dom)))
    (let loop ((todo todo) (k (modified-domains (lambda (_) dom) k)))
	(if (null? todo)
	    (unit k)
	    (let ((v (caar todo))
		  (u (cdar todo)))
	      (if (null? u)
		  mzero
		  (bind ((== (var v) (car u)) k) ;; it might be safer to do one big unification rather than looping through the list
			(lambda (k)
			  (loop (cdr todo) k))))))))))

