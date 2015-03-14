(define-library (miniKanren)

  (import (scheme base)
	  (scheme read)
	  (scheme write)
	  (microKanren))

  (export == =/= absento symbolo
	  
	  fresh conde
	  mk-run run* runi)

  (include "miniKanren.scm"))

