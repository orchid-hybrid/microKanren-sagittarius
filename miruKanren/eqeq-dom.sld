(define-library (miruKanren eqeq-dom)

  (import (scheme base)
          (miruKanren kanren)
          (miruKanren monad)
          (miruKanren unification)
          (miruKanren disequality)
	  (miruKanren domains))

  (export == =/= domo)

  (include "eqeq-dom.scm"))
