(define-library (miruKanren streams)

  (import (scheme base))

  (export pull
          stream-map
          take
          take-all)

  (include "streams.scm"))
