(define-library (miruKanren eqeq-dom)

  (import (scheme base)
          (scheme write)
	  (srfi 95)
          (miruKanren variables)
          (miruKanren kanren)
          (miruKanren monad)
          (miruKanren unification)
          (miruKanren binary-trie)
          (miruKanren sorted-int-set)
	  (rename (miruKanren disequality)
	          (=/= =/=-original))
	  (miruKanren domains))

  (export == =/= domo)

  (include "eqeq-dom.scm"))
