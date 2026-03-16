# Test Expressions in Bash

https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html

### Syntax

```bash
test [expression]
[ expression ]
[[ expression ]]
```

## Types of Test Conditions

### File Tests:

```
-e: Checks if a file exists.
-f: Checks if it is a regular file.
-d: Checks if it is a directory.
-r: Checks if it is readable.
-w: Checks if it is writable.
-x: Checks if it is executable.
-L: Checks if it is a symbolic link.

-c: Returns True if the character file exists.
-r: Returns True if a readable file exists.
-w: Returns True if a writable file exists.
-x: Returns True if an executable file exists.
-p: Returns True if the file exists as a pipe.
-S: Returns True if the file exists as a socket.
-s: Returns True if a file exists and the size of the file is not zero.
-L: Returns True if the file of symbolic link exists.
-g: Returns True if the file exists and hold set group id flag is set..
-G: Returns True if the file exists and holds the same group id that is in process.
-k: Returns True if the file exists and the sticky bit flag is set.
```

### String Tests:

```
=:  Checks for equality.
==: Checks for equality.
!=: Checks for inequality.
-z: Checks if a string is empty.
-n: Checks if a string is not empty.
<:  Checks if the first string sorts before the second lexicographically.
>:  Checks if the first string sorts after the second lexicographically.
```

### Numeric Tests:

```
-eq: Checks for equality.
-ne: Checks for inequality.
-gt: Checks if the first number is greater than the second.
-lt: Checks if the first number is less than the second.
-ge: Checks if the first number is greater than or equal to the second.
-le: Checks if the first number is less than or equal to the second.
```