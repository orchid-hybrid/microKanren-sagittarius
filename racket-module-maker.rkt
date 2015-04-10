#lang racket

;; rm -f racket/miruKanren/*rkt && rm -f racket/srfi/*rkt

(define (string->complete-path s) (path->complete-path (string->path s)))

(define (process place file)
  (let ((content (read (open-input-file (path->complete-path file (string->complete-path place)))))
        (output (path-replace-suffix (path->complete-path file (string->complete-path "racket/miruKanren"))
                                     #".rkt")))
    (match content
      
      (`(define-library (miruKanren ,name)
          (import . ,imports)
          (export . ,exports)
          (include ,filename))
       (with-output-to-file output
         (lambda ()
           (write (make-basic-module name imports exports filename))
           (newline))))
      
      (`(define-library (miruKanren ,name)
          (import . ,imports)
          (export . ,exports))
       (with-output-to-file output
         (lambda ()
           (write (make-basic-module^ name imports exports))
           (newline))))
    
      (else
       (print (list "I don't know how to handle the file " file))
       (newline)))))

(define (slashify names)
  (define (->string thing)
    (cond ((number? thing) (number->string thing))
          ((symbol? thing) (symbol->string thing))))
  (when (equal? (car names) 'miruKanren)
    (set! names (cdr names)))
  (string-append (apply string-append (add-between (map ->string names) "/"))
                 ".rkt"))

(define (useless i)
  (and (not (equal? i '(srfi 95)))
       (not (equal? i '(scheme write)))
       (not (equal? i '(scheme read)))))

(define (make-basic-module name imports exports filename)
  `(module ,name racket
     
     (provide . ,exports)
     
     (require . ,(map slashify (filter useless imports)))
     
     (include (file ,(string-append "../../miruKanren/" filename)))))

(define (make-basic-module^ name imports exports)
  `(module ,name racket
     
     (provide . ,exports)
     
     (require . ,(map slashify (filter useless imports)))))

(for-each (lambda (file)
            (when (equal? #"sld" (filename-extension file))
                (process "miruKanren" file)))
          (directory-list "miruKanren" #:build? #f))

(for-each (lambda (file)
            (when (equal? #"sld" (filename-extension file))
                (process "unification/basic/miruKanren" file)))
          (directory-list "unification/basic/miruKanren" #:build? #f))

