(define-library (miruKanren domains)

  (import (scheme base)
  (scheme write)
          (miruKanren utils)
          (miruKanren kanren)
          (miruKanren variables)
          (miruKanren unification)
	  (miruKanren sorted-int-set))

  (export normalize-domain-store)

  (include "domains.scm"))
