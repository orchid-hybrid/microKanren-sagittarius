(define-library (examples closure)
  (import (scheme base)
	  (miruKanren record-inspection))
  (export closure closure? closure-value)
  (begin
    
    (define-record-type <closure> (closure v) closure? (v closure-value))
    
    (register-record! closure? closure (lambda (b) (list (closure-value b))))
    
    ))

