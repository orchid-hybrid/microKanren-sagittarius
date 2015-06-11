(define-library (miruKanren domains)

  (import (scheme base)
  (scheme write)
          (miruKanren utils)
          (miruKanren kanren)
          (miruKanren variables)
          (miruKanren unification)
	  (miruKanren sorted-int-set)
	  (miruKanren binary-trie))

  (export merge-domains
          domain-store-update-associations
          normalize-domain-store)

  (include "domains.scm"))
