(define-library (miruKanren)

  (import (scheme base)
	  (scheme read)
          (scheme cxr)
	  (scheme write)
          (srfi 95)
          (sorted-int-set))

  (export ==
	  fresh conde
          symbolo
	  mk-run run* runi)

  (include "miruKanren.scm"))
