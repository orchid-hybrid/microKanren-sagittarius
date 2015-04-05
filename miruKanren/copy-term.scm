;; copy term is difficult since copying the term:
;;   (_.0 _.1 _.0)
;;
;; will have to create:
;;   (_.2 _.3 _.2)
;;
;; to do this we will have to make a list of the
;; variables we create a long the way, and look
;; things up in that

(define (copy-termo in out)
  (copy-term '() in (lambda (s o) (== o out))))

(define (copy-term s tm c)
  (lambda (k)
    (let ((tm (walk tm (substitution k))))
      ((cond ((and (var? tm) ;; fresh
		    (assq tm s)) =>
		    (lambda (key/tm*)
		      (c s (cdr key/tm*))))
	      ((var? tm)
	       ;; not already seen
	       (call/fresh (lambda (v)
			     ;; so extend the table
			     (c (cons (cons tm v) s)
				v))))
	      ((or (symbol? tm)
		   (null? tm))
	       (c s tm))
	      ((pair? tm)
	       (copy-term s (car tm)
			  (lambda (s kar)
			    (copy-term s (cdr tm)
				       (lambda (s kdr)
					 (c s (cons kar kdr))))))))
       k))))
