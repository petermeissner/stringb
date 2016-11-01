I am very sorry for updating the package already (I am aware that this should 
not be done).

BUT I discovered that although the package states that it runs on R 3.0.0 
onwards this is actually not true. Since it depends on base::strrep() which was 
only introduced recently. The package would not build e.g. for R 3.2.5. 
(at https://cran.r-project.org/web/packages/stringb/index.html the r-oldrel 
build is missing)

I fixed this using the backports package, increased the version number and run 
tests again.



## Test environments

- x86_64-w64-mingw32 (R 3.2.5)
- linux-x86_64-fedora-clang (R devel)
- linux-x86_64-ubuntu-gcc (R 3.3.1)

- http://builder.r-hub.io/status/stringb_0.1.13.tar.gz-98e15c74baaa4046a2991c3e964450a5
- http://builder.r-hub.io/status/stringb_0.1.13.tar.gz-d095f0c125e14c01937e1ea54187cf01
- http://builder.r-hub.io/status/stringb_0.1.13.tar.gz-1c6babefa05d4c96bf2c2c934bc71338


## Test results 

no errors, no warnings, no notes - except expected one note each about too short a time since last submission. 
