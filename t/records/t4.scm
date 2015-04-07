(import (scheme base)
        (test-check)

        (miruKanren mk-types)
	(examples relational-interpreter))

(test-check "relational interp #1"
	    (run* (lambda (q) (eval-expo ''x '() q)))
	    '((x where)))

(test-check "relational interp #2"
	    (run^ 1 (lambda (q) (eval-expo q '() q)))
	    '((((lambda (_.0) (list _.0 (list 'quote _.0)))
		'(lambda (_.0) (list _.0 (list 'quote _.0))))
	       where
	       (or (=/= _.0 list))
	       (or (=/= _.0 list))
	       (or (=/= _.0 quote))
	       (typeo _.0 symbol)
	       (typeo _.0 symbol)
	       (typeo _.0 symbol))))
