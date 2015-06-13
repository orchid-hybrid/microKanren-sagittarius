(define (== u v)
  (lambda (k)
    (let-values (((s p) (unify/prefix u v (substitution k))))
      (if s
	  (let ((k (domain-store-update-associations
		    (modified-substitution (lambda (_) s) k)
		    p)))
	    (if (domains k)
		(bind (normalize-disequality-store k)
		      (lambda (k)
			(normalize-domain-store == (subtract-disequalities-from-domains k))))
		mzero))
	  mzero))))

(define (=/= u v)
  (lambda (k)
    (bind ((=/=-original u v) k)
	  (lambda (k)
	    (normalize-domain-store == (subtract-disequalities-from-domains k))))))

(define (domo v d)
  ;; at the moment d must be a list of integers
  ;; it would be good to relax this and support any list of symbols
  ;; but we need a (fast) < operation on them
  ;;
  ;; TODO: deal with d length 0 or 1
  (lambda (k)
    (let ((v (walk* v (substitution k))))
      (if (var? v)
	  ((== 'x 'x) ;; this is a hack to get normalization to happen
	   (modified-domains (lambda (dom)
			       (let ((r
				      (trie-insert/merge dom (var->int v) (sort d <) merge-domains)))
				 r))
			     k))
	  (if (member v d)
	      (unit k)
	      mzero)))))
