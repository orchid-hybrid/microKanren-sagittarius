(define-library (miruKanren mini)

  (import (scheme base)
          (miruKanren micro))

  (export Zzz
          conj+
          disj+
          fresh
          conde)

  (include "mini.scm"))

