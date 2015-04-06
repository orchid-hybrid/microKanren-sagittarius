(define-library (miruKanren utils)

  (import (scheme base)
          (srfi 95))

  (export assp
          filter
	  any
          concat-map
          type?
          sort)

  (include "utils.scm"))

