(define-library (miruKanren record-inspection)
  (import (scheme base))

  (export register-record! record?)

  (begin

    (define record-table '())

    (define (register-record! predicate? constructor list-fields)
      (set! record-table (cond ((assq predicate? record-table) record-table)
			       (else
				(cons (cons predicate? (cons constructor list-fields))
				      record-table)))))
    
    (define (record? s)
      ;; if s is a registered record
      ;; this will return (constructor list-fields)
      (let loop ((entries record-table))
	(if (null? entries)
	    #f
	    (if ((caar entries) s)
		(cdar entries)
		(loop (cdr entries))))))
    
    ))
