.section .text

# rdi = command name 
# rsi = argv
.global execute
execute:
    pushq %rbp
    movq %rsp, %rbp

    # Fork the process.
    movq $57, %rax          # syscall number for fork
    syscall

    # Check if we are in the child process.
    cmp $0, %rax
    je child_process        # Jump to child_process if in child

    # Parent process.
    # Wait for the child process to finish.
    movq %rax, %rdi         # PID of child process
    movq $61, %rax          # syscall number for wait4
    leaq status(%rip), %rsi # Pointer to status
    movq $0, %rdx           # No options
    movq $0, %r10           # No rusage
    syscall

    # Restore stack and return.
    movq %rbp, %rsp
    popq %rbp
    ret

# Child process
.global child_process
child_process:
    # Execve syscall (execute the command)
    movq $59, %rax          # syscall number for execve
    movq %rsi, %rsi         # argv
    syscall

    # If execve fails, jump to error_handler.
    jmp error_handler

