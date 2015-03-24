(define-library (srfi 95)
  (export ;sorted? merge merge!
          sort
          ;sort!
          )
  (import
   (except (scheme base)))
  (include "95.body.scm"))
