.section .text

.global exit_command
exit_command:
    call exit

.global exit
exit:
    # Clear the return value in %rax
    movq $0, %rax
    
    # Restore the stack pointer from the base pointer
    movq %rbp, %rsp
    
    # Restore the previous base pointer
    popq %rbp
    
    # Prepare for the exit syscall
    # Set the syscall number for exit (60) in %rax
    movq $60, %rax
    
    # Set the exit status to 0 by clearing %rdi
    xorq %rdi, %rdi
    
    # Invoke the syscall
    syscall
