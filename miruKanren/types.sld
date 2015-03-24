(define-library (miruKanren types)

  (import (miruKanren mini)
          (miruKanren run)
          (miruKanren eqeq-typeo))

  (export == =/= typeo
          symbolo
          numbero
          booleano
          nullo
          pairo
          not-symbolo
          not-numbero
          not-booleano
          not-nullo
          not-pairo
          
          fresh conde
          run^ run* runi))
