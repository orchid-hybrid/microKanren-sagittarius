(define-library (miruKanren)

  (import (scheme base)
	  (scheme read)
	  (scheme write))

  (export ==
	  fresh conde
	  mk-run run* runi)

  (include "miruKanren.scm"))
