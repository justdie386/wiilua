Don't use, this is an incomplete binding that i will never touch again, poorly written due to my lack of knowledge using the luajit ffi, it is very possible to make a proper one, but i just don't know how to use luajit's ffi properly just yet

This shouldn't be used at the moment, here's why:
I use luajit's ffi, yet i still need to make a library around the wiiuse library, because of some issue with userdata stuff, so you'd need 2 lib files and one lua file to get started, not practical indeed. The userdata issue should be fixable but i am not sure whetever i plan on doing it or not. It still does work tho, and def can be used, but its also incomplete atm, it can just tell you when butons are pressed and das it

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
