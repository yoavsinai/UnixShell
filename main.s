.extern cd_command
.extern restore_args
.extern get_argv
.extern exist_permissions
.extern execute
.extern error_handler
.extern get_input
.extern string_compare
.extern exit_command

.section .text

.global main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq MAX_INPUT_SIZE(%rip), %rsp  # Allocate space for input buffer
    subq MAX_INPUT_SIZE(%rip), %rsp  # Allocate additional space for argv

.global main_loop
main_loop:
    # Print the command prompt prefix
    movq $1, %rax
    movq $1, %rdi
    leaq PREFIX(%rip), %rsi
    movl LEN_PREFIX(%rip), %edx
    syscall

    # Get user input
    movq %rbp, %rdi
    subq MAX_INPUT_SIZE(%rip), %rdi
    call get_input

    # Compare the input with "exit"
    movq %rbp, %rdi
    subq MAX_INPUT_SIZE(%rip), %rdi
    movq $EXIT_STRING, %rsi
    call string_compare
    cmp $0, %rax
    je exit_command  # If input is "exit", jump to exit_command

    # Restore arguments for further processing
    call restore_args

    # Get command and arguments
    call get_argv

    # Compare the input with "cd"
    movq $CMD_CD_STRING, %rsi
    call string_compare
    cmp $0, %rax
    je cd_command  # If input is "cd", jump to cd_command

    # Restore arguments for further processing
    call restore_args

    # Check if the command exists and has the necessary permissions
    call exist_permissions

    # Restore arguments for further processing
    call restore_args

    # Execute the command
    call execute

    # Loop back to main_loop to wait for the next command
    jmp main_loop

cd_command:
    # Restore arguments for "cd" command
    call restore_args

    # Get the directory path from arguments
    movq $1, %rcx
    movq (%rsi, %rcx, 8), %rdi

    # Check permissions and existence of the directory
    call exist_permissions

    # Execute chdir syscall to change directory
    movq $80, %rax
    movq %rdi, %rdi
    syscall

    # If chdir fails, handle the error
    cmp $0, %rax
    jne error_handler

    # Loop back to main_loop to wait for the next command
    jmp main_loop
