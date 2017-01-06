# racket-clilib
Utilities for cli applications in Racket: Colored output, cursor movement, logging

This code can easily be copied right into a project since it is only one small file.

It does a few simple things that are meant to help out with small cli tools.

- A simple logger
- ANSI colored and formatted output, including horizontal cursor movement
- Interactive CLI support, so you can have lots of different commands in the same program.


##Simple Logger
Use the get-logger function to set up a simple log file. The log file will replace an existing one of the same name.

Log with the function by calling it and providing a string, a newline will be appended by default; suppying a 'continue for the optional newline-mode argument will suppress the newline. The function will log to the console as well as to the file, stripping out any ansi color commands from the file but leaving them for the console. That way, you can have colored console output and still have a clean text-only logfile.

Example:

```
(define logr (get-logger "mylogfile.txt"))
(logr (format "Started at ~a" now))
```

##Console Color and Control Commands
The ~a function is used as a template for new functions like ~a/red. The most generic version is called ~a/decorate and will take a color argument as well as optional background color, bolding, italicizing, and underlining:

```
(displayln (~a/decorate 'green "My Message" #:bg 'white #:bold #t #:italic #t #:under #t))
```

There are several other simpler functions for specific effects:

- Simple colored text: `(~a/red "text")` or `(~a/color 'green "text")`
- Text combined with bolding: `(~a/color-b 'red "bold red text")` etc. for -i, -u, -bi, -bu, -iu

Colors can be specified with short or long names:

- 'black or 'k
- 'blue or 'b
- 'white or 'w
- 'red or 'r
- 'green or 'g
- 'magenta or 'm
- 'cyan or 'c
- 'yellow or 'y

There is a convenience function, `cprintf`, which will let you color a formatted string like:

```
(cprintf 'red "Here is ~a and ~a" "foo" "bar")
```

The function `uncolor` can be used to strip ansi control characters. It is used by the `get-logger` function to clean the text before output to a file.

Console cursor control is provided by three functions:

```
(cursor-hmove num)
(cursor-upscroll num)
(screen-clear)
```

##Interactive Command-Line
Finally, there is a general facility for looping to handle an interactive command line. To use it, you supply a function that handles the commands you want. Here is an example:

```
(define (act tokens)
  (and (not (cli-exit-interactive tokens))
    (match tokens
      [(or ("Done" ...) ("Finish" ...)) #f] ; other exit codes if desired
      ;; put your various commands here, must evaluate to #t or else youll exit
      ;; in the example below, entering "list acting" will call (list-acting x) on the remainder of the line
      [(list (regexp #rx"lis.*") (regexp #rx"act.*") a) (list-acting a)]
      [_ (~a/red "Huh?\n")])))
```

Note that the example includes `cli-exit-interactive` which will handle common exit commands like "quit".

Once you've defined a procedure like 'act' above, start the interactive prompt like this:

```
(cli-run-interactive act)
```

This will use the default prompt, ">>", which you can change.

This is compatible with Racket's `command-line` procedure, so you can pay attention to a command-line option like "-i" to enter interactive mode, or just run one command and exit.


