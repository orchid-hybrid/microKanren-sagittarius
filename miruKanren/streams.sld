(define-library (miruKanren streams)

  (import (scheme base))

  (export pull
          stream-map
          stream-take
          take
          take-all)

  (include "streams.scm"))
