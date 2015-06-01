(define-library (llrb-tree llrb-tree)
  (export empty-btree
          btree-not-found?
          btree-lookup
          btree-update
          btree->alist
          btree-size)
  (import (except (scheme base)))
  (include "llrb-tree.scm"))
