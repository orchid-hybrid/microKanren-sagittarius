(define-library (miruKanren variables)

  (import (scheme base)
          (miruKanren utils))

  (export var
          var?
          var=?
          var<)

  (include "variables.scm"))

