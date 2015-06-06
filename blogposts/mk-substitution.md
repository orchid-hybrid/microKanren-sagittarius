# Substitution Requirements

The substitution is an object used by unification (and the reifier) to store a mapping from variable to value. The operations you need are to associate a variable/value pair and to lookup the value using a variable as the key. Since minikanren does backtracking it has to be a persistent data structure.

# Assoc list implementation

In the simplest implementation of minikanren the substitution is an assoc list like this

```
((<variable> . <value>) (<variable> . <value>) ...)
```

Adding/updating an entry: O(1) - just cons the new entry onto it.
Looking up an entry: O(n) - you have to walk down the list (several times actually) to find the entry you are interested in.

# Binary Trie Implementation

Another choice of data structure for this is a binary trie. Variables in minikanren are implemented using a single element vector holding an integer. We can use the binary digits of the integer as the path in a tree whose shape is like this:

<img src="http://i.imgur.com/7TYNWeH.gif"></img>

and each node can optionally hold a value.

Adding/updating an entry: O(log(n)) - this is worse than assoc list, but not much worse. it has to copy a log(n) amount of "spine" of the tree to make an edit in order to stay persistent.
Looking up an entry: O(log(n)) - this is better than assoc list! if you were dealing with very large substitutions this could become a big win in efficiency.

# Benchmarking

In practice I tested this on generating lots of quines and it didn't help, but I tested it on running append in the relational interpreter (which was the example William Byrd showed us) and it went much much faster, 20x I think! It also speeded up some test programs involving oleg numbers.

# Source

Here is the implementation of unification:

* https://github.com/orchid-hybrid/microKanren-sagittarius/blob/master/miruKanren/unification-basic.scm

and the two different substitution implementations:

* https://github.com/orchid-hybrid/microKanren-sagittarius/blob/master/substitution/assoc/miruKanren/substitution-assoc.scm
* https://github.com/orchid-hybrid/microKanren-sagittarius/blob/master/substitution/binary-trie/miruKanren/substitution-binary-trie.scm
* https://github.com/orchid-hybrid/microKanren-sagittarius/blob/master/miruKanren/binary-trie.scm
