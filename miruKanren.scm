;; surveillance-state contains an assoc list of watch-list/goals
;;
;; The new primitive is (watch x g) which waits for x to become
;; fully ground. then executes the goal with its ground form.
;;
;; if we are asked to (watch x g) then take a list of all
;; variables inside x. If there are zero then it is ground
;; trigger g. Otherwise add those variables to a watch list
;;
;; every time a unification is performed compare the prefix
;; with each set of variables in the watch list. If there is an
;; intersection then fix that list up. If it becomes empty goal!

;; Invariant: every watch-list is nonempty


;; Jason Hemann and Dan Friedman
;; microKanren, final implementation from paper

;; utilities

(define (assp p l)
  ;; R6RS compatability
  (if (null? l)
      #f
      (if (p (caar l))
	  (car l)
	  (assp p (cdr l)))))

(define (filter p l)
  (if (null? l)
      '()
      (if (p (car l))
	  (cons (car l) (filter p (cdr l)))
	  (filter p (cdr l)))))


;; Variable representation

(define (var c) (vector c))
(define (var? x) (vector? x))
(define (var=? x1 x2) (= (vector-ref x1 0) (vector-ref x2 0)))

;; (define (ext-s-check x v s)
;;   (if (occurs-check x v s) #f `((,x . ,v) . ,s)))

(define (ext-s-check-prefix x v s p)
  (if (occurs-check x v s)
      (values #f #f)
      (values `((,x . ,v) . ,s) `((,x . ,v) . ,p))))

(define (walk u s)
  (let ((pr (and (var? u) (assp (lambda (v) (var=? u v)) s))))
    (if pr (walk (cdr pr) s) u)))

(define (occurs-check x v s)
  (let ((v (walk v s)))
    (cond
     ((var? v) (var=? v x))
     ((pair? v) (or (occurs-check x (car v) s)
                    (occurs-check x (cdr v) s)))
     (else #f))))



;; Unification and disequality

(define (unify-prefix u v s p)
  (let ((u (walk u s)) (v (walk v s)))
    (cond
     ((and (var? u) (var? v) (var=? u v)) (values s p))
     ((var? u) (ext-s-check-prefix u v s p))
     ((var? v) (ext-s-check-prefix v u s p))
     ((and (pair? u) (pair? v))
      (let-values (((s p) (unify-prefix (car u) (car v) s p)))
	(if s
            (unify-prefix (cdr u) (cdr v) s p)
            (values #f #f))))
     (else (if (eqv? u v)
               (values s p)
               (values #f #f))))))


;; Monad

(define (unit k) (cons k mzero))
(define (bind $ g)
  (cond
   ((null? $) mzero)
   ((procedure? $) (lambda () (bind ($) g)))
   (else (mplus (g (car $)) (bind (cdr $) g)))))

(define (mapm f l)
  (if (null? l)
      (unit '())
      (bind (f (car l))
	    (lambda (v)
	      (bind (mapm f (cdr l))
		    (lambda (vs)
		      (unit (cons v vs))))))))

(define mzero '())
(define (mplus $1 $2)
  (cond
   ((null? $1) $2)
   ((procedure? $1) (lambda () (mplus $2 ($1))))
   (else (cons (car $1) (mplus (cdr $1) $2)))))


;; the language constructs

(define-record-type <kanren>
  (make-kanren c s t)
  kanren?
  (c counter)
  (s substitution)
  (t surveillance))

(define empty-state (make-kanren 0 '() '()))

(define (concat-map f l)
  (apply append (map f l)))

(define (== u v)
  (lambda (k)
    (let-values (((s p) (unify-prefix u v (substitution k) '())))
      (if s
          (let ((actives (sort (map car p) <-var)))
            (let loop ((the-list (surveillance k))
                       (acc '())
                       (operations '()))
              (if (null? the-list)
                  (let loop ((operations operations)
                             (k (make-kanren (counter k) s acc)))
                    (if (null? operations)
                        (unit k)
                        (bind ((car operations) k)
                              (lambda (k)
                                (loop (cdr operations) k)))))
                  (let ((watch-list (caar the-list))
                        (g* (cdar the-list)))
                    (if (intersects? (lambda (i) (vector-ref i 0))
                                     actives
                                     (lambda (i) (vector-ref i 0))
                                      watch-list)
                        (let ((updated-list
                               (sort (concat-map (lambda (x)
                                                   (variables-in-term s x))
                                                 watch-list)
                                     <-var)))
                          (if (null? updated-list)
                              (begin
                                ;(display 'added-an-operations)
                                ;(newline)
                                (loop (cdr the-list)
                                      acc
                                      (cons g* operations)))
                              (loop (cdr the-list)
                                    (cons (cons updated-list g*) acc)
                                    operations)))
                        (loop (cdr the-list)
                              (cons (car the-list) acc)
                              operations))))))
	  mzero))))

(define (variables-in-term s x)
  (define (go* v s tl)
    (let ((v (walk v s)))
    (cond
     ((var? v) (cons v tl))
     ((pair? v) (go* (car v) s
                     (go* (cdr v) s
                          tl)))
     (else tl))))
  (go* x s '()))

(define <-var (lambda (i j)
                (< (vector-ref i 0)
                   (vector-ref j 0))))

(define (watch x g)
  (lambda (k)
    (let ((vs (variables-in-term (substitution k) x))
          (g* (lambda (k) ((g (walk* x (substitution k))) k))))
      (if (null? vs)
          (g* k)
          (unit (make-kanren (counter k)
                             (substitution k)
                             (cons (cons (sort vs <-var) g*)
                                   (surveillance k))))))))

(define (bijectiono f g)
  (lambda (x y)
    (fresh ()
      (watch x (lambda (x) (== y (f x))))
      (watch y (lambda (y) (== (g y) x)))
      )))

;; https://github.com/webyrd/peano-challenge/blob/master/peano.scm
(define (number->peano n)
  (if (= 0 n)
      'z
      `(s ,(number->peano (- n 1)))))

(define (peano->number n)
  (cond ((eq? n 'z) 0)
        ((and (list? n)
              (= 2 (length n))
              (eq? 's (car n)))
         (+ (peano->number (cadr n)) 1))
    (else (error "not a number in peano->number" n))))

(define peanoo (bijectiono number->peano peano->number))


(define (number->binary-aux len n m)
  (cond
   ((odd? n)
    (number->binary-aux (- len 1) (quotient (- n 1) 2) (cons 1 m)))
   ((and (not (zero? n)) (even? n))
    (number->binary-aux (- len 1) (quotient n 2) (cons 0 m)))
   ((zero? n) (values len m))))
(define (number->binary len)
  (lambda (n)
    (let-values (((len b) (number->binary-aux len n '())))
      (append (make-list len 0) b))))

(define (binary->number* b)
  (if (null? b)
      0
      (+ (car b)
         (* 2 (binary->number* (cdr b))))))

(define (binary->number b)
  (binary->number* (reverse b)))

(define (binaryo digits n b)
  ((bijectiono (number->binary digits)
               binary->number)
   n b))

(define (call/fresh f)
  (lambda (k)
    (let ((c (counter k)))
      ((f (var c)) (make-kanren (+ 1 c) (substitution k) (surveillance k))))))

(define (disj g1 g2) (lambda (k) (mplus (g1 k) (g2 k))))
(define (conj g1 g2) (lambda (k) (bind (g1 k) g2)))


;;;  all the stuff from microKanren wrappers




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
	   `(and . ,(map (lambda (constraint)
                           'unknown)
			 (surveillance k))))))

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


(define (mk-run n g)
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
