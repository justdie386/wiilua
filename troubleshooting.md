If you are getting this after running luajit main.lua in the wiidev folder (make sure to actually BE in the wiidev folder) then this means the issues relies on the ld_path


The error in question or similar:
```
luajit: ./wiiffi.lua:47: libwiilua.so: cannot open shared object file: No such file or directory
```

To fix this you must set the path for programs to serch for such .so files
```
export LD_LIBRARY_PATH=.
```


Beware as you will have to run this every time you run close the terminal, because if you set it permanently then apps might start breaking because they won't be able to find the .so files they need

Having said this, launching apps form the same terminal in which this command was ran, things could decide not to launch, do not panic, just close and re-open the terminal, because nothing we did before was permanent, the LD_LIBRARY_PATH will be reset back to what it used to be.