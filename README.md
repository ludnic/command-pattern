# command-pattern
Test implementation of the command design pattern in Fortran. 
The implementation follows the one proposed in [this](https://stackoverflow.com/questions/46956699/design-pattern-for-command-line-software-with-multiple-functionalities) stack overflow post. 

Can be built and run with [fpm](https://github.com/fortran-lang/fpm) with:

```shell
fpm run -- test
```

This toy code implements the command design pattern with two test commands: `test` 
and `copy`. Each command just prints a line to confirm which command has been called. 

# Development environment and debug config
This test project includes a development environment and debugger configuration used to 
demo the Fortran dev setup in VScode. 
The `.devcontainer` folder contains a Docker file that can be used by VScode to reproduce 
the same development environment I am using under linux and a `devcontainer.json` that 
further customises the dev environment with extensions needed for fortran development and 
debugging. If you use docker feel free to "open the project in a container" using the 
Dev Containers extension (requires docker to be installed), if you do not use docker
you can still look at the Dockerfile to see the full setup of the dev environment.

The `.vscode` folder contains configuration for the build task and the gdb debug setup following
the demo in the [youtube video by Lukas Lamm](https://youtu.be/XuNjA230e3k?si=oczy7-J1Pm87zm_O)
slightly modified to use fpm for the build task. This relies on the `build.sh` script 
in the project root directory, which can be used for regular builds in release or debug mode 
and for debugging through the VScode integration. 