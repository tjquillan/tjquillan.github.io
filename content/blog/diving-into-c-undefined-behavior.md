---
title: Diving Into C Unspecified Behavior
date: 2024-01-11
draft: true
categories: ["Development"]
tags: ["C"]
---

## What is unspecified behavior?

Unspecified behavior, according to
[cppreference.com](https://en.cppreference.com), is defined to be when:

> Two or more behaviors are permitted and the implementation is not required to
> document the effects of each behavior. [^1]

## Evaluation order of function arguments

One example of unspecified behavior, as specified by ISO/IEC 9899:201x, is:

> The order in which the function designator, arguments, and subexpressions
> within the arguments are evaluated in a function call (6.5.22) [^2]

What this mean is that given the followint code:

```C
#include <stdio.h>

int foo() {
    static int bar = 0;
    return bar++;
}

int main(void) {
    printf("%d %d %d\n", foo(), foo(), foo());
}
```

The compiler could decide to evaluate the calls to `foo` in such an order that
the output is either `0 1 2`, `2 1 0`, or even theoretically `0 2 1`
([Godbolt Example](https://godbolt.org/z/hMTEbdaPP)). At first this may be
confusing to those coming from other languages such as Java
([Godbolt Example](https://godbolt.org/z/fadaqz4vG)), where this is less of a
problem as, to my knowledge, there is only OpenJDK so even if this behavior is
also unspecified in Java it isn't nearly as problematic as with C/C++ where it
is not uncommon to be targeting `gcc`, `clang`, and `mscv` all at once if you're
a library.

[^1]: <https://en.cppreference.com/w/c/language/behavior>
[^2]: <https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf>
