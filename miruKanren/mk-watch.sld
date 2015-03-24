(define-library (miruKanren mk-watch)

  (import (miruKanren mini)
          (miruKanren run)
          (miruKanren eqeq-watch))

  (export == watch
          bijectiono
          peanoo binaryo
          
          fresh conde
          run^ run* runi))
