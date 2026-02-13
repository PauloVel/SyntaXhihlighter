# Racket
Test programs to learn about Functional and Concurrent programming

## Loading files

### From racket

To easily load files, create a file **~/.racketrc** with the content:
```
(require xrepl)
```
Then to enter a file, from the racket prompt type:
```
,en "<filename>"
```
Also possible to load a file (as for testing):
```
,ld "<filename>"
```


### From bash

Declare the functions contained within a file, adding to the racket file:
```
(provide <function_name>)
```
Then load the file from bash with:
```
racket -it <filename>
```

## Racket shell

After a recent change, it is now necessary to have the cursor at the end of
the command line before pressing `ENTER` to run an expression.

To help with this, you can use the shortcuts `Ctrl-A` to move to the beginning
of the line, and `Ctrl-E` to move to the end of the line.


## Style guide
- https://docs.racket-lang.org/style/Textual_Matters.html


## References

- XREPL docs: https://docs.racket-lang.org/xrepl/index.html
- Loading files: https://stackoverflow.com/questions/19875182/racket-execute-file-and-stay-in-interactive-mode
- Youtube videos:
    - https://www.youtube.com/watch?v=FoPW4Ji6EAM&list=PLHqz-wcqDQIEThNEXViEb1iFh9vbOtUD_
    - https://www.youtube.com/watch?v=n_7drg-R-YY
- Tutorials: https://beautifulracket.com/
