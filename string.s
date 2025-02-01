.extern empty_buffer

.section .text

.global string_compare
# Compares two strings: %rdi = string1, %rsi = string2
string_compare:
    pushq %rbp
    movq %rsp, %rbp

    movq $0, %rdx  # Initialize index to 0

    .strcmp_loop:
        movb (%rdi, %rdx), %al  # Load byte from string1
        movb (%rsi, %rdx), %cl  # Load byte from string2
        cmp %cl, %al            # Compare bytes
        jne .strcmp_exit        # Exit if bytes are not equal
        inc %rdx                # Increment index
        cmp $0, %cl             # Check for null terminator
        jne .strcmp_loop        # Continue loop if not end of string

    # Strings are equal
    movq $0, %rax  # Return 0

    movq %rbp, %rsp
    popq %rbp
    ret

    .strcmp_exit:
        movq $1, %rax  # Return 1 (strings are not equal)

        movq %rbp, %rsp
        popq %rbp
        ret

.global clear_enter
# Clears the newline character from a buffer: %rdi = buffer
clear_enter:
    pushq %rbp
    movq %rsp, %rbp

    movq $0, %rcx  # Initialize index to 0

    .clear_enter_loop:
        movb (%rdi, %rcx, 1), %al  # Load byte from buffer
        cmp $'\n', %al             # Check for newline character
        je .clear_enter_exit       # Exit if newline found
        testb %al, %al             # Check for null terminator ('\0')
        je .clear_enter_exit 
        inc %rcx                   # Increment index
        jmp .clear_enter_loop      # Continue loop
    
    .clear_enter_exit:
        cmp $0, %rcx               # Check if buffer is empty
        je empty_buffer            # Jump to empty_buffer if empty
        movb $0, (%rdi, %rcx)      # Replace newline with null terminator
        movq %rcx, %rax            # Return the index

        movq %rbp, %rsp
        popq %rbp
        ret
