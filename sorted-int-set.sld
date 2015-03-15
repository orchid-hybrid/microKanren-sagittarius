(define-library (sorted-int-set)

  (import (scheme base))

  (export intersects?)
  
  (include "sorted-int-set.scm"))

;; A set is represented by a sorted list of increasing integers

;; the algorithm is shown correct here:

;; https://github.com/orchid-hybrid/orchid-hybrid.github.io/blob/master/_posts/2015-02-10-a-correctness-proof-in-coq.md
;; https://github.com/orchid-hybrid/SF/blob/master/unrelated/intersectp.v
