(define-library (miruKanren utils)

  (import (scheme base)
          (srfi 95))

  (export assp
          filter
          concat-map
          type?
          sort)

  (include "utils.scm"))

