;; Replace the assoc list for substitutions with a persistent
;; trie that is keyed by the binary digits of a counter.

(define (next-bit n)
  (values
   (= 1 (remainder n 2))
   (quotient n 2)))

;; also: nil is the empty trie
(define-record-type <trie>
  (trie t f v? v) trie?
  (t trie-t-branch)
  (f trie-f-branch)
  (v? trie-value?)
  (v trie-value))

(define (trie-lookup tri key)
  (if (null? tri)
      (values #f #f)
      (if (zero? key)
	  (values (trie-value? tri)
		  (trie-value tri))
	  (let-values (((b key) (next-bit key)))
	    (trie-lookup (if b
			     (trie-t-branch tri)
			     (trie-f-branch tri))
			 key)))))

(define (trie-fold f tri key)
  (if (null? tri)
      (trie-fold f (trie '() '() #f #f) key)
      (if (zero? key)
	  (let-values (((value? value) (f (trie-value? tri)
					  (trie-value tri))))
	    (trie (trie-t-branch tri)
		  (trie-f-branch tri)
		  value?
		  value))
	  (let-values (((b key) (next-bit key)))
	    (if b
		(trie (trie-fold f (trie-t-branch tri) key)
		      (trie-f-branch tri)
		      (trie-value? tri)
		      (trie-value tri))
		(trie (trie-t-branch tri)
		      (trie-fold f (trie-f-branch tri) key)
		      (trie-value? tri)
		      (trie-value tri)))))))

(define (trie-insert tri key value)
  ;; this overwrites/replaces what was already there
  (trie-fold (lambda (v? v)
	       (values #t value))
	     tri
	     key))

(define (trie-insert/merge tri key value merger)
  ;; this merges with what was already there
  (trie-fold (lambda (v? v)
	       (if v?
		   (values #t (merger value v))
		   (values #t value)))
	     tri
	     key))

(define (trie-lookup/delete tri key)
  (let ((found? #f)
	(found #f))
    (let ((tri (trie-fold (lambda (v? v)
			    (when v?
				  (set! found? #t)
				  (set! found v))
			    (values #f #f))
			  tri
			  key)))
      (values tri found? found))))

(define (trie-size tri)
  (if (null? tri)
      0
      (+ (if (trie-value? tri) 1 0)
         (trie-size (trie-t-branch tri))
         (trie-size (trie-f-branch tri)))))
