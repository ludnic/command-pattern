# command-pattern
Test implementation of the command design pattern in Fortran. 
The implementation follows the one proposed in [this](https://stackoverflow.com/questions/46956699/design-pattern-for-command-line-software-with-multiple-functionalities) stack overflow post. 

Can be built and run with [fpm](https://github.com/fortran-lang/fpm) with:

```shell
fpm run -- test
```

This toy code implements the command design pattern with two test commands: `test` 
and `copy`. Each command just prints a line to confirm which command has been called. 
