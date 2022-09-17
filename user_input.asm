; Author: Sami Hindi
; Date: 09-17-2022 (MM-DD-YYYY)

; My first actual assembly program
; This will ask the User for their name and print it out to standard output


; Defining the needed system calls
SYS_READ   equ     0          ; read text from stdin
SYS_WRITE  equ     1          ; write text to stdout
SYS_EXIT   equ     60         ; terminate the program
STDIN      equ     0          ; standard input
STDOUT     equ     1          ; standard output

; .bss section where variables can change
section .bss
    inputLen: equ 24             ; Length of bytes for the input variable
    input: resb inputLen         ; Allocate the 24 bytes of space to the input variable

; .data section where constants are defined
section .data
    prompt: db "Please enter your name: "            ; Prompt the user for their name
    promptLen: equ $-prompt                          ; Allocate space for prompt variable

    output: db 0xA, "Your name is: "                 ; 0xA for newline ASCII Character
    outputLen: equ $-output                          ; Allocate space


; .text section where the instructions for the program are
section .text
    global _start

_start:
    ; Move prompt to top
    mov rdx, promptLen
    mov rsi, prompt
    mov rdi, STDOUT
    mov rax, SYS_WRITE
    syscall

    ; Reading input from User
    mov rdx, inputLen
    mov rsi, input
    mov rdi, STDIN
    mov rax, SYS_READ
    syscall
    push rax

    ; Giving back name
    mov rsi, outputLen
    mov rdx, output
    mov rdi, STDOUT
    mov rax, SYS_WRITE
    syscall

    ; Display the name
    pop rdx
    mov rsi, input
    mov rdi, STDOUT
    mov rax, SYS_WRITE
    syscall

    ; To not get a segmentation fault, we exit the program
    xor     edi, edi             ; successful exit
    mov     rax, SYS_EXIT
    syscall                 ; Call Kernel
