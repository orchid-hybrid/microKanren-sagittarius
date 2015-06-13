(define-library (miruKanren binary-trie)

  (import (scheme base))

  (export trie-lookup trie-insert trie-size
          trie-insert/merge trie-lookup/delete
	  binary-trie->assoc-list
          trie-filter)

  (include "binary-trie.scm"))
