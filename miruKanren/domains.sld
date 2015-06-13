(define-library (miruKanren domains)

  (import (scheme base) (scheme cxr)
  (scheme write)
          (miruKanren utils)
          (miruKanren kanren)
          (miruKanren monad)
          (miruKanren variables)
          (miruKanren unification)
	  (miruKanren sorted-int-set)
	  (miruKanren binary-trie))

  (export merge-domains
          domain-store-update-associations
	  subtract-disequalities-from-domains
          normalize-domain-store)

  (include "domains.scm"))
