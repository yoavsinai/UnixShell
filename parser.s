.extern clear_enter

.section .text

.global restore_args
restore_args:
    # Restore arguments by adjusting the stack pointer
    movq %rbp, %rdi
    subq MAX_INPUT_SIZE(%rip), %rdi
    movq %rdi, %rsi
    subq MAX_INPUT_SIZE(%rip), %rsi

    ret

.global get_argv
# %rdi = buffer
get_argv:
    pushq %rbp
    movq %rsp, %rbp

    # Initialize counters
    movq $0, %rcx
    movq $0, %r11
    movq $1, %rdx

    .spaces_loop:
        cmp $1, %rdx
        je .copy_addr

    .spaces_loop_continue:
        movq $0, %rdx

        # Read character from buffer
        movb (%rdi, %rcx, 1), %al
        testb %al, %al
        je .spaces_loop_exit
        cmp $' ', %al
        je .spaces_loop_null_terminator
        inc %rcx
        jmp .spaces_loop
        
    .spaces_loop_null_terminator:
        # Replace space with null terminator
        movq $1, %rdx
        inc %r11

        movb $0, (%rdi, %rcx)
        inc %rcx
        jmp .spaces_loop

    .copy_addr:
        # Copy address of the argument
        leaq (%rdi, %rcx, 1), %rax
        movq %rax, (%rsi, %r11, 8)

        jmp .spaces_loop_continue

    .spaces_loop_exit:
        # End of arguments
        inc %r11
        movq $0, (%rsi, %r11, 8)

        inc %rcx
        movb $0, (%rdi, %rcx)
        movq %rcx, %rax

    # Restore stack and return
    movq %rbp, %rsp
    popq %rbp
    ret

.global get_input
# %rdi = buffer 1024 bytes.
get_input:
    pushq %rbp
    movq %rsp, %rbp

    pushq %rdi
    # Read syscall from stdin:
    movq $0, %rax
    movq %rdi, %rsi
    movq $0, %rdi
    movq $MAX_INPUT_SIZE, %rdx
    syscall

    popq %rdi
    # Clear the newline character from the buffer.
    call clear_enter

    # Restore stack and return
    movq %rbp, %rsp
    popq %rbp
    ret
