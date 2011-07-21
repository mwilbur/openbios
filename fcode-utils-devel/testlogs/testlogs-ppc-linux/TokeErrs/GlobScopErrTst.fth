\  Test the Global-Scope directive and a few of its effects.
\       Updated Wed, 14 Dec 2005 at 09:59 PST by David L. Paktor
\  Inject a few erorrs...

fcode-version2

headers

[ifexists] coconuts
   [message]  Why a duck?
[endif]

alias [testdict]  [ifexists]

[testdict] coconuts
   [message]  Boy, can you get stucco!
[else]
   [message]  Why a fence?
[endif]

\  Bypass warning about Instance without altering LocalValuesSupport file
alias generic-instance  instance
overload [macro] instance  f[  noop  .( Shminstance!) f]  noop

\  This isn't right.  The "bypass" only has scope in the top-level device-node

global-definitions

fload LocalValuesSupport.fth

\  Replace normal meaning of  Instance
overload alias instance generic-instance

: $CAT   ( _max _str1 _len1 _str2 _len2 -- _max _str1 _len1' )
   { _max _str1 _len1 _str2 _len2 }
   _len1 _max < if                  \ there is room
      _str2 _str1 _len1 + _len2 _max _len1 - min move
   then
   _max _str1 _len1 _len2 + _max min \ always leave total length
;

instance variable fussel [message] Expected error; scope is still global.
h# 3afe fussel !

device-definitions

h# 5afe instance value dumont [message] Device scope in effect.  SB Legit.
: ducksoup ( n1 n2 n3 n4 -- m1 m2 )
	{ 	\  Declare some locals
	   _harpo  ( the quiet one) _chico
	    _groucho |   \  He's funny, right?
	     _zeppo  ( who? ) _karl  \  Is he part of the act?
	      }
    d# 64 _groucho dup count dup -> _zeppo
    _harpo dup count $cat
    dup -> _karl
    rot _karl = if  type exit then
    _groucho + swap _zeppo + 
;

global-definitions

: garbanzo
      ." Should be unrecognized." cr
      ducksoup
;

new-device    [message] Missing a finish-device

: fazooule!
     ."  Lima enter tain you..." cr
     ducksoup
     garbanzo
;

h# DEADc0de  instance value quaack   [message] Instance should be legit here.

global-definitions

: frijoles
    ." Holy ... beans?" cr
    fazooule!
    garbanzo
    ducksoup
;

finish-device

finish-device

fcode-end
