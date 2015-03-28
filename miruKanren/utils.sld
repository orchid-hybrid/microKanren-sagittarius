(define-library (miruKanren utils)

  (import (scheme base)
          (srfi 95))

  (export filter
          concat-map
          type?
          sort)

  (include "utils.scm"))

