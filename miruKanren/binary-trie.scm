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

(define (trie-insert tri key value)
  ;; this overwrites/replaces what was already there
  (if (null? tri)
      (trie-insert (trie '() '() #f #f) key value)
      (if (zero? key)
	  (trie (trie-t-branch tri)
		(trie-f-branch tri)
		#t
		value)
	  (let-values (((b key) (next-bit key)))
	    (if b
		(trie (trie-insert (trie-t-branch tri)
				   key
				   value)
		      (trie-f-branch tri)
		      (trie-value? tri)
		      (trie-value tri))
		(trie (trie-t-branch tri)
		      (trie-insert (trie-f-branch tri)
				   key
				   value)
		      (trie-value? tri)
		      (trie-value tri)))))))

(define (trie-size tri)
  (if (null? tri)
      0
      (+ (if (trie-value? tri) 1 0)
         (trie-size (trie-t-branch tri))
         (trie-size (trie-f-branch tri)))))
