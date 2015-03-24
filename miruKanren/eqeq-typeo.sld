(define-library (miruKanren eqeq-typeo)

  (import (scheme base)
          (miruKanren utils)
          (miruKanren kanren)
          (miruKanren variables)
          (miruKanren monad)
          (miruKanren micro)
          (miruKanren mini)
          (miruKanren unification)
          (miruKanren disequality)
          (miruKanren type))

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
          not-pairo)

  (include "eqeq-typeo.scm"))
