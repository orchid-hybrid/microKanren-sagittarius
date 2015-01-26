(define-library (micro kanren)

  (import (scheme base)
	  (scheme read)
	  (scheme write))

  (export var var? var=? walk

	  make-kanren kanren?
	  counter substitution disequality-store
	  empty-state
	  
	  == =/=
	  
	  call/fresh
	  disj conj)

  (include "microKanren.scm"))
