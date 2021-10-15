# command-pattern
Test implementation of the command design pattern in Fortran. 

Can be run with `fpm` with: 

```shell
fpm run -- test
```

This toy code implements the command design pattern with two test commands: `test` 
and `copy`. Each command just prints a line to confirm which command has been called. 
