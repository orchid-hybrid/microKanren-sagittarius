(define-library (miruKanren mk-diseq)

  (import (miruKanren mini)
          (miruKanren run)
          (miruKanren eqeq-diseq))

  (export == =/=
          fresh conde
          run^ run* runi))
