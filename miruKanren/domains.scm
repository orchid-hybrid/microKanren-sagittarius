(define (merge-domains d1 d2)
  (intersection (lambda (i) i) d1 d2))

(define (domain-store-update-associations k p)
  (modified-domains
   (lambda (dom)
     (let loop ((dom dom) (p p))
       (if (null? p)
	   dom
	   (let ((u (caar p)) (v (cdar p)))
	     (if (and (var? u) (var? v))
		 (let-values (((dom found? found) (trie-lookup/delete dom (var->int u))))
		   (if found?
		       (loop (trie-insert/merge dom (var->int v) found merge-domains) (cdr p))
		       (loop dom (cdr p))))
		 ;; TODO: this case
		 (loop dom (cdr p)))))))
   k))
;; TODO: This depends on the CDRs of the prefix being fully walked. Does that hold?

(define (normalize-domain-store dom)
  dom)
