(use data-structures)
(use matchable)

;; find . -name '*.sld' | csi -q chicken-r7rs-sld-topsort.scm > chicken.scm

(define (parse-sld sld)
  (match sld ((('define-library name body ...))
              (cons name (cond ((assoc 'import body) => (lambda (entry) (cdr entry)))
                               (else '()))))))

(let* ((files (map (lambda (name)
                     (cons name (parse-sld (read-file name))))
                   (read-lines)))
       (lookup-table (map (lambda (entry) (cons (cadr entry) (car entry))) files))
       (graph (map cdr files))
       (ordering (reverse (topological-sort graph equal?))))
  (for-each (lambda (lib)
              (cond ((assoc lib lookup-table) => (lambda (entry)
                                                   (write `(include ,(cdr entry)))
                                                   (newline)))))
            ordering))

(exit)
