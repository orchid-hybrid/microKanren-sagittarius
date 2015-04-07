(define-library (miruKanren utils)

  (import (scheme base)
          (srfi 95)
	  (miruKanren record-inspection))

  (export assp
          filter
	  any
          concat-map
          type?
          sort)

  (include "utils.scm"))

