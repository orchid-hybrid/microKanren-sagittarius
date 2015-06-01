(define-library (examples numbers)

  (import (scheme base)
          (miruKanren mk-basic))

  (export build-num
          zeroo
          poso
          pluso
          minuso
          *o
          <o
          <=o
          /o
          logo
          expo)

  (include "numbers.scm"))
