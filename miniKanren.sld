(define-library (miniKanren)

  (import (scheme base)
	  (scheme read)
	  (scheme write)
	  (microKanren))

  (export == =/= absento
	  
	  fresh conde
	  mk-run run* runi)

  (include "miniKanren.scm"))

