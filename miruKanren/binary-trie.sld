(define-library (miruKanren binary-trie)

  (import (scheme base))

  (export trie-lookup trie-insert trie-size)

  (include "binary-trie.scm"))
