(import (miniKanren))

(define (appendo l s out)
  (conde
    ((== '() l) (== s out))
    ((fresh (a d res)
       (== `(,a . ,d) l)
       (== `(,a . ,res) out)
       (appendo d s res)))))

;; $ rlwrap sagittarius
;; sash> (load "microKanren.sld")
;; sash> (load "miniKanren.sld")
;; sash> (import (miniKanren))
;; sash> (load "play.scm")
;; #t
;; sash> (run* (lambda (q) (fresh (x y) (== q `(,x ,y)) (appendo x y '(a b c)))))
;; ((() (a b c)) ((a) (b c)) ((a b) (c)) ((a b c) ()))


;; larceny -r7rs -path .
;; then paste the import and definition in
