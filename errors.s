
// External functions
.extern execution_failed
.extern main_loop

// Section for code
.section .text

// Error handler function
.global error_handler
error_handler:
    // Compare rax with 0, jump to execution_failed if less
    cmp $0, %rax
    jl execution_failed

    // Shift rax left by 3 bits, load address of err_codes_table
    shlq $3, %rax
    leaq err_codes_table(%rip), %rdi
    addq %rax, %rdi
    // Jump to the address in rdi
    jmp *(%rdi)

// Execution failed function
.global execution_failed
execution_failed:
    // Write error message to stderr
    movq $1, %rax
    movq $2, %rdi # stderr
    leaq ERROR_MSG(%rip), %rsi
    movl LEN_ERROR_MSG(%rip), %edx
    syscall

    // Jump to main_loop
    jmp main_loop

// Check existence and permissions function
.global exist_permissions
# rdi = path
exist_permissions:
    pushq %rbp
    movq %rsp, %rbp

    // Access syscall to check existence
    movq $21, %rax
    movq $0, %rsi
    syscall

    // Compare rax with 0, set error code if not exist
    cmp $0, %rax
    movl NOT_EXIST(%rip), %eax
    jne error_handler

    // Access syscall to check permissions
    movq $21, %rax
    movq $1, %rsi
    syscall

    // Compare rax with 0, set error code if no permissions
    cmp $0, %rax
    movl NOT_PERMISSIONS(%rip), %eax
    jne error_handler

    // Restore stack and return
    movq %rbp, %rsp
    popq %rbp
    ret

// Not exist error handler
.global not_exist_1
not_exist_1:
    // Write not exist message to stderr
    movq $1, %rax
    movq $2, %rdi
    leaq NOT_EXIST_MSG(%rip), %rsi
    movl LEN_NOT_EXIST_MSG(%rip), %edx
    syscall
    jmp main_loop

// Not permissions error handler
.global not_permissions_2
not_permissions_2:
    // Write not permissions message to stderr
    movq $1, %rax
    movq $2, %rdi
    leaq NOT_PERMISSIONS_MSG(%rip), %rsi
    movl LEN_NOT_PERMISSIONS_MSG(%rip), %edx
    syscall
    jmp main_loop

// Empty buffer error handler
.global empty_buffer
empty_buffer:
    // Write empty buffer message to stderr
    movq $1, %rax
    movq $2, %rdi # stderr
    leaq EMPTY_MSG(%rip), %rsi
    movl LEN_EMPTY_MSG(%rip), %edx
    syscall

    // Jump to main_loop
    jmp main_loop
