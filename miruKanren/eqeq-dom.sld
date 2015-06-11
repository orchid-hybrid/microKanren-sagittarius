(define-library (miruKanren eqeq-dom)

  (import (scheme base)
          (miruKanren kanren)
          (miruKanren monad)
          (miruKanren unification)
	  (rename (miruKanren disequality)
	          (=/= =/=-original))
	  (miruKanren domains))

  (export == =/= domo)

  (include "eqeq-dom.scm"))
