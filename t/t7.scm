(import (scheme base)
        (test-check)

        (miruKanren mk-basic)
	(miruKanren copy-term))

(test-check "copy-termo #1"
	    (run* (lambda (q)
		    (fresh (t1 t2 x y z)
		      (== q (list t1 t2))
		      (== t1 (list x y x))
		      (copy-termo t1 t2))))
	    '((((_.0 _.1 _.0) (_.2 _.3 _.2)) where)))
