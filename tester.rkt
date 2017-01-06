#lang racket
(require db xml)
(require racket/string racket/cmdline)
(require "clilib.rkt")

; ===================================

(printf "~a\n" (~a/red "this is red text"))
(printf "~a\n" (~a/color-u 'red "this is underined red text"))
(printf "~a\n" (~a/color-i 'red "this is italic red text"))
(printf "~a\n" (~a/color-iu 'red "this is underlined italic red text"))
(printf "~a\n" (~a/color-b 'red "this is bold red text"))
(printf "~a\n" (~a/color-bu 'red "this is underined bold red text"))
(printf "~a\n" (~a/color-bi 'red "this is bold italic red text"))
(printf "~a\n" (~a/color-biu 'red "this is underined bold italic red text"))

(printf "~a\n" (~a/decorate 'g "this is green on yellow" #:bg 'y))
(printf "~a\n" (~a/decorate 'b "this is italic blue on yellow" #:bg 'y #:bold #f #:italic #t #:under #t))

(cprintf 'b "~a ~a ~a" "blue" "cprintf" "test")

(cursor-hmove 30)
(printf "starting at column 30\n")
;(screen-clear)

(define logr (get-logger "delete_me.log"))
(logr "Log Line")
(logr "Log Partial Line..." 'continue)
(cursor-hmove 30)
(logr "C/R after this")




