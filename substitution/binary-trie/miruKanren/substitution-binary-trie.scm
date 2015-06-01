(define (substitution-get k s)
  (trie-lookup s k))

(define (substitution-set k v s)
  (trie-insert s k v))

(define substitution-size trie-size)

(define empty-substitution '())
