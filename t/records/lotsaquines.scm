(import (scheme base)
        (test-check)

        (miruKanren mk-types)
	(examples relational-interpreter))

(test-check "lots of quines"
	    (length (run^ 300 (lambda (q) (eval-expo q '() q))))
	    300)

;; binary trie seems to be a tiny bit SLOWER than assoc for this test
