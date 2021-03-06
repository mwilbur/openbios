\  Test case:  a normal-size branch that takes place across the point
\      where the output buffer was expanded.
\  We will use a body generated by the "Verbal Bottles of Beer" script
\  To just almost but not quite fill up the buffer.
\  A parameter of 645 does it

fcode-version2          \  Sixteen-bit offsets.

headers

\  Try various tricks to force an allocation of the space
\      just above the output buffer so that the realloc of
\      the output buffer will be forced into a new space
f[
       fload LotsOfAliases.fth
  f]

: a-lot-of-beer
    ." We're about a third of the way into a school-bus trip" cr
    ." that started with a thousand bottles." cr

fload Almost_a_Buffer_of_Beer.fth

    0 if

fload No_Beer.fth

    then
    ." It's so over."
;

fcode-end

