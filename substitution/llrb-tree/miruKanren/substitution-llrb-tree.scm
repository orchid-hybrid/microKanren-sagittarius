(define (substitution-get k s)
  (let ((r (btree-lookup k s)))
    (if (btree-not-found? r)
        (values #f #f)
        (values #t r))))

(define substitution-set btree-update)

(define substitution-size btree-size)

(define empty-substitution empty-btree)
