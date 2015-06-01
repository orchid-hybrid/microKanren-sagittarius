(import (scheme base)
        (scheme write)
        (test-check)

        (miruKanren mk-types)
	(examples relational-interpreter-plus)

        (larceny benchmarking))

;; https://github.com/webyrd/miniKanren-uncourse/blob/07c3812463d157450ac70199731e6a4a8c5db180/hangouts-by-date/02014-12-21/interp.scm#L388

(define (append-form x y)
 `((((lambda (f)
       ((lambda (x)
	  (f (x x)))
	(lambda (x)
	  (lambda (y) ((f (x x)) y)))))
     (lambda (my-append)
       (lambda (l)
	 (lambda (s)
	   (if (null? l)
	       s
	       (cons (car l) ((my-append (cdr l)) s)))))))
    (quote ,x))
   (quote ,y)))

(define (bench1)
  (run^ 1 (lambda (q) (eval-expo (append-form '(a b c d e f g h i j k l m n o p q
                                                  r s t u v w x y z
                                                  a b c d e f g h i j k l m n o p q
                                                  r s t u v w x y z
                                                  a b c d e f g h i j k l m n o p q
                                                  r s t u v w x y z)
                                              '(1 2 3 4 5 6 7 8 9))
                                 '() q)))
  '(((a b c d e f g h i j k l m n o p q r s t u v w x y z a b c d e f g h i j k l m n o p q r s t u v w x y z a b c d e f g h i j k l m n o p q r s t u v w x y z 1 2 3 4 5 6 7 8 9) where)))

;; big speed increase with trie!!

(display (time (begin (bench1) '())))
