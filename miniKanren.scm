;; copied out of miniKanren-wrappers

(define-syntax Zzz
  (syntax-rules ()
    ((_ g) (lambda (s/c) (lambda () (g s/c))))))

(define-syntax conj+
  (syntax-rules ()
    ((_ g) (Zzz g))
    ((_ g0 g ...) (conj (Zzz g0) (conj+ g ...)))))

(define-syntax disj+
  (syntax-rules ()
    ((_ g) (Zzz g))
    ((_ g0 g ...) (disj (Zzz g0) (disj+ g ...)))))

(define-syntax fresh
  (syntax-rules ()
    ((_ () g0 g ...) (conj+ g0 g ...))
    ((_ (x0 x ...) g0 g ...)
     (call/fresh
      (lambda (x0)
        (fresh (x ...) g0 g ...))))))

(define-syntax conde
  (syntax-rules ()
    ((_ (g0 g ...) ...) (disj+ (conj+ g0 g ...) ...))))


;; Reification and run

(define (reify-1st k)
  (define (o t)
    (let ((v (walk* t (substitution k))))
      (walk* v (reify-s v '()))))
  (o (list (var 0)
	   `(and . ,(map (lambda (mini) `(or . ,(map (lambda (dis) `(=/= ,(car dis) ,(cdr dis))) mini)))
			 (disequality-store k))))))

(define (walk* v s)
  (let ((v (walk v s)))
    (cond
     ((var? v) v)
     ((pair? v) (cons (walk* (car v) s)
		      (walk* (cdr v) s)))
     (else  v))))

(define (reify-s v s)
  (let ((v (walk v s)))
    (cond
     ((var? v)
      (let  ((n (reify-name (length s))))
	(cons `(,v . ,n) s)))
     ((pair? v) (reify-s (cdr v) (reify-s (car v) s)))
     (else s))))

(define (reify-name n)
  (string->symbol
   (string-append "_" "." (number->string n))))

(define (pull $)
  (if (procedure? $) (pull ($)) $))

(define (take-all $)
  (let (($ (pull $)))
    (if (null? $) '() (cons (car $) (take-all (cdr $))))))

(define (take n $)
  (if (zero? n) '()
      (let (($ (pull $)))
	(if (null? $) '() (cons (car $) (take (- n 1) (cdr $)))))))


(define (run n g)
  (map reify-1st (take n ((call/fresh g) empty-state))))

(define (run* g)
  (map reify-1st (take-all ((call/fresh g) empty-state))))

(define (print s) (display s) (newline))

(define (runi g)
  (let loop (($ (pull ((call/fresh g) empty-state))))
    (newline)
    (if (null? $)
	(print 'thats-all!)
	(begin (print (reify-1st (car $)))
	       (print "another (y/n)?")
	       (if (equal? 'n (read))
		   (print 'bye)
		   (loop (pull (cdr $))))))))
