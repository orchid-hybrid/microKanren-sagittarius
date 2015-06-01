(define-record-type <btree-branch>
  (btree-branch color key val left right)
  btree-branch?
  (color color)
  (key key)
  (val val)
  (left left)
  (right right))

(define-record-type <btree-empty>
  (btree-empty)
  btree-empty?)

(define-record-type <btree-not-found>
  (make-btree-not-found)
  btree-not-found?)

(define empty-btree (btree-empty))
(define btree-not-found (make-btree-not-found))
(define red #t)
(define black #f)

(define (btree-lookup k btree)
  (cond ((btree-empty? btree) btree-not-found)
        ((= k (key btree)) (val btree))
        ((> k (key btree)) (btree-lookup k (right btree)))
        (else (btree-lookup k (left btree)))))

(define (red? btree)
  (if (btree-empty? btree)
      #f
      (color btree)))

(define (color-flip btree)
  (let ((l (left btree))
        (r (right btree)))
    (let ((left^ (btree-branch (not (color l)) (key l) (val l) (left l) (right l)))
          (right^ (btree-branch (not (color r)) (key r) (val r) (left r) (right r))))
      (btree-branch (not (color btree)) (key btree) (val btree) left^ right^))))

(define (rotate-left btree)
  (let ((r (right btree)))
    (let ((h (btree-branch red (key btree) (val btree) (left btree) (left r))))
      (btree-branch (color btree) (key r) (val r) h (right r)))))

(define (rotate-right btree)
  (let ((l (left btree)))
    (let ((h (btree-branch red (key btree) (val btree) (right l) (right btree))))
      (btree-branch (color btree) (key l) (val l) (left l) h))))

(define (btree-update k v btree)
  (let ((h (btree-update-aux k v btree)))
    (btree-branch black (key h) (val h) (left h) (right h))))

(define (btree-update-aux k v btree)
  (if (btree-empty? btree)
      (btree-branch red k v empty-btree empty-btree)
      (let* ((btree (if (and (red? (left btree)) (red? (right btree)))
                        (color-flip btree)
                        btree))
             (btree (cond ((= k (key btree))
                           (btree-branch (color btree) k v (left btree) (right btree)))
                          ((> k (key btree))
                           (let ((right^ (btree-update-aux k v (right btree))))
                             (btree-branch (color btree) (key btree) (val btree) (left btree) right^)))
                          (else
                           (let ((left^ (btree-update-aux k v (left btree))))
                             (btree-branch (color btree) (key btree) (val btree) left^ (right btree))))))
             (btree (if (and (red? (right btree)) (not (red? (left btree))))
                        (rotate-left btree)
                        btree))
             (btree (if (and (red? (left btree)) (red? (left (left btree))))
                        (rotate-right btree)
                        btree)))
        btree)))

(define (btree-size btree)
  (if (btree-branch? btree)
      (+ 1 (btree-size (left btree)) (btree-size (right btree)))
      0))


(define (btree->alist btree)
  (cond ((btree-empty? btree) '())
        ((btree-branch? btree) (append (btree->alist (left btree))
                                       (list (cons (key btree) (val btree)))
                                       (btree->alist (right btree))))
        (else (error 'btree->alist "bad btree" btree))))


