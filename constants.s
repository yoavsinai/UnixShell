.section .rodata
    .global MAX_INPUT_SIZE
    MAX_INPUT_SIZE: .quad 1024

    .global EXIT_STRING
    EXIT_STRING: .string "exit"

    .global PREFIX
    PREFIX: .string "myshell> "

    .global LEN_PREFIX
    LEN_PREFIX: .long 9

    .global CMD_CD_STRING
    CMD_CD_STRING: .string "cd"

    .global CMD_CD_PATH
    CMD_CD_PATH: .string "/bin/cd"

    .global ERROR_MSG
    ERROR_MSG: .string "Error: Execution failed\n"

    .global LEN_ERROR_MSG
    LEN_ERROR_MSG: .long 25

    .global NOT_EXIST
    NOT_EXIST: .long 1

    .global NOT_EXIST_MSG
    NOT_EXIST_MSG: .string "Error: No such file or directory\n"

    .global EMPTY_MSG
    EMPTY_MSG: .string "Error: Empty command\n"

    .global LEN_EMPTY_MSG
    LEN_EMPTY_MSG: .long 22

    .global LEN_NOT_EXIST_MSG
    LEN_NOT_EXIST_MSG: .long 33

    .global NOT_PERMISSIONS
    NOT_PERMISSIONS: .long 2

    .global NOT_PERMISSIONS_MSG
    NOT_PERMISSIONS_MSG: .string "Error: Permission denied\n"

    .global LEN_NOT_PERMISSIONS_MSG
    LEN_NOT_PERMISSIONS_MSG: .long 25

    .global err_codes_table
    err_codes_table:
        .quad 0
        .quad not_exist_1
        .quad not_permissions_2

.section .data
    .global status
    status: .quad 0
