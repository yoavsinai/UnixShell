.extern restore_args
.extern exist_permissions
.extern error_handler
.extern main_loop

.section .text

.global cd_command
cd_command:
    # Restore arguments
    call restore_args

    # Load the second argument (directory path) into %rdi
    movq $1, %rcx
    movq (%rsi, %rcx, 8), %rdi

    # Check if the directory exists and if permissions are sufficient
    call exist_permissions

    # Execute the chdir syscall (syscall number 80)
    movq $80, %rax
    syscall

    # Check if the syscall was successful (return value in %rax is 0)
    cmp $0, %rax
    # If the syscall failed (return value is not 0), jump to error_handler
    jne error_handler

    # Continue to main_loop if successful
    jmp main_loop
