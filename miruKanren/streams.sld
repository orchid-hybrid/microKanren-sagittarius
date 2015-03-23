(define-library (miruKanren streams)

  (import (scheme base))

  (export pull
          take
          take-all)

  (include "streams.scm"))
