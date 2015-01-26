(define-library (mini kanren)

  (import (scheme base)
	  (scheme read)
	  (scheme write)
	  (micro kanren))

  (export == =/=
	  
	  fresh conde
	  run run* runi)

  (include "miniKanren.scm"))

