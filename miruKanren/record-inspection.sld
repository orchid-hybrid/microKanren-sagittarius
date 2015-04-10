(define-library (miruKanren record-inspection)
  (import (scheme base))

  (export register-record! record?)

  (include "record-inspection.scm"))
