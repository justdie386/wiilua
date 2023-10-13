SHOULD NOT USE THIS FOR NOW READ BELOW

Currently rewritting in 100% C++ to be compatible with lua 5.1 - 5.4 and to get rid of the need to have the wiiuse file too, but licensing reasons (wiiuse the tool i used to built this has a GPL  license so idk if this means you need to use the license i'll have to check stuff) 

Wii remote library to control things on the wii, example in the test folder, i'll make a file that shows every possible function soon enough.

to get started

install xmake from xmake.io

in the root of the directory run

```
xmake
```
simple isn't it?


it'll create the wiidev folder, which will contain all the files you need to get started, the wiiffi.lua, a main.lua example folder and both the .dll/.so files  needed  to get started, you absolutely need those for it to work because wiiffi relies on wiilua which is a tiny bity wrapper around wiiuse so it is important that if you want to use wiilua outside of this folder, you also copy the two .dll/.so files or add them to somewhere in the LD_LIBRARY_PATH 
