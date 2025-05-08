# Test Expressions in Bash

### Syntax

```bash
test [expression]
[ expression ]
[[ expression ]]
```

### Parameters

```
-f:  It returns True if the file exists as a common ( regular ) file.
-d: it returns True if directory exists.
-e: It returns True if any type of file exists.
-c: It returns True if the character file exists.
-r: It returns True if a readable file exists.
-w: It returns True if a writable file exists.
-x: It returns True if an executable file exists.
-p: It returns True if the file exists as a pipe.
-S: It returns True if the file exists as a socket.
-s: it returns True if a file exists and the size of the file is not zero.
-L: It returns True if the file of symbolic link exists.
-g: It returns True if the file exists and hold set group id flag is set..
-G: It returns True if the file exists and holds the same group id that is in process.
-k: It returns True if the file exists and the sticky bit flag is set.
```
