(define-library (miruKanren)

  (import (scheme base)
	  (scheme read)
	  (scheme write)
          (srfi 95)
          (sorted-int-set))

  (export ==
          watch
          peanoo
	  fresh conde
	  mk-run run* runi)

  (include "miruKanren.scm"))
