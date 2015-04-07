(define-library (examples relational-interpreter)
  
  (import (scheme base)
	  (test-check)

	  (miruKanren record-inspection)
	  (miruKanren mk-types))

  (export eval-expo)

  (begin

;; This code is based on

;; miniKanren Hangout #5: extending the Relational Scheme interpreter

;; and the hint William Byrd that we can avoid absento by using records

(define-record-type <closure> (closure x body env) closure?
  (x closure-x)
  (body closure-body)
  (env closure-env))

(register-record! closure? 'closure closure
		  (lambda (b) (list (closure-x b)
				    (closure-body b)
				    (closure-env b))))

(define (not-closureo s) (fresh (t) (typeo s t) (=/= t 'closure)))

;; (define lookup
;;   (lambda (x env)
;;     (pmatch env
;;       [() (error 'lookup "unbound variable")]
;;       [((,y . ,v) . ,env^) (guard (eq? x y))
;;        v]
;;       [((,y . ,_) . ,env^)
;;        (lookup x env^)])))

;; (define eval-exp*
;;   (lambda (expr* env)
;;     (cond
;;       [(null? expr*) '()]
;;       [else (cons
;;               (eval-exp (car expr*) env)
;;               (eval-exp* (cdr expr*) env))])))

;; (define eval-exp
;;   (lambda (expr env)
;;     (pmatch expr
;;       [,x (guard (symbol? x)) ;; variable
;;        (lookup x env)]
;;       [(quote ,datum) datum]
;;       [(list . ,expr*)
;;        ;; (map (lambda (expr) (eval-exp expr env)) expr*)
;;        (eval-exp* expr* env)]
;;       [(lambda (,x) ,body) ;; abstraction
;;        `(closure ,x ,body ,env)]
;;       [(,e1 ,e2) ;; application
;;        ;; eval e1 (better evaluate to a closure!) -> proc
;;        ;; eval e2 -> val
;;        ;; apply proc to val
;;        (let ((proc (eval-exp e1 env))
;;              (val (eval-exp e2 env)))
;;          (pmatch proc
;;            [(closure ,x ,body ,env^)
;;             ;; evaluate body in an extended environment
;;             ;; in which the environment of the closure is extended
;;             ;; with a binding between x and val
;;             (eval-exp body `((,x . ,val) . ,env^))]
;;            [,else (error 'eval-exp "e1 does not evaluate to a procedure")]))])))

(define lookupo
  (lambda (x env out)
    (fresh (y val env^)
      (== `((,y . ,val) . ,env^) env)
      (symbolo x)
      (symbolo y)
      (conde
        ((== x y) (== val out))
        ((=/= x y) (lookupo x env^ out))))))

(define unboundo
  (lambda (x env)
    (fresh ()
      (symbolo x)
      (conde
        ((== '() env))
        ((fresh (y v env^)
           (== `((,y . ,v) . ,env^) env)
           (=/= x y)
           (unboundo x env^)))))))

(define eval-expo
  (lambda (expr env out)
    (fresh ()
      (conde
        ((symbolo expr) ;; variable
         (lookupo expr env out))
        ((== `(quote ,out) expr)
	 (not-closureo out)
         (unboundo 'quote env))
        ((fresh (expr*)
           (== `(list . ,expr*) expr)
           (eval-exp*o expr* env out)
           (unboundo 'list env)))
        ((fresh (x body) ;; abstraction
           (== `(lambda (,x) ,body) expr)
           (== (closure x body env) out)
           (symbolo x)
           (unboundo 'lambda env)))
        ((fresh (e1 e2 val x body env^) ;; application
           (== `(,e1 ,e2) expr)
           (eval-expo e1 env (closure x body env^))
           (eval-expo e2 env val)
           (eval-expo body `((,x . ,val) . ,env^) out)))))))

(define eval-exp*o
  (lambda (expr* env out)
    (conde
      ((== '() expr*) (== '() out))
      ((fresh (a d res-a res-d)
         (== (cons a d) expr*)
         (== (cons res-a res-d) out)
         (eval-expo a env res-a)
         (eval-exp*o d env res-d))))))

))
