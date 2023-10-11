SHOULD NOT USE THIS FOR NOW READ BELOW

I plan to rewrite it in C or C++ instead of ffi because its inefficient the way it is currently done, but it is still very usable, just beware.

Wii remote library to control things on the wii, example in the test folder, i'll make a file that shows every possible function soon enough.

to get started

install xmake from xmake.io

in the root of the directory run

```
xmake
```
simple isn't it?


it'll create the wiidev folder, which will contain all the files you need to get started, the wiiffi.lua, a main.lua example folder and both the .dll/.so files  needed  to get started, you absolutely need those for it to work because wiiffi relies on wiilua which is a tiny bity wrapper around wiiuse so it is important that if you want to use wiilua outside of this folder, you also copy the two .dll/.so files or add them to somewhere in the LD_LIBRARY_PATH 
