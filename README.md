# MyShell Project - Yoav Sinai

## How I Built the Shell

This shell was built using AT&T x64 Assembly. The development process involved the following steps:
1. **Initialization**: Setting up the basic structure and initializing necessary variables.
2. **Input Handling**: Reading user input and parsing commands.
3. **Execution**: Implementing the logic to execute built-in commands and external programs.
4. **Error Handling**: Adding error messages and handling various edge cases.
5. **Testing**: Running multiple test cases to ensure the shell works as expected.

## Structure of the Project

The project is organized into the following files and directories:
- `main.s`: The entry point of the shell program, which contains an indefinite loop that runs until the `exit` command occurs.
- `parser.s`: Functions for parsing user input and manipulating it.
- `executor.s`: Functions for forking the process and executing commands.
- `string.s`: Implementation of some string-related functions.
- `constants.s`: The constant strings, error codes, error messages, etc.
- `cd.s`: Implementation of the `cd` command in the shell.
- `exit.s`: Implementation of the `exit` command in the shell (exits from it).
- `errors.s`: Handles errors and prints the details to stderr.
- `Makefile`: Script to compile the project.
- `README.md`: Documentation of the project.

## Decision Process

### Implementation Steps:
1. **Basic Input Reading**: Initially, the project started with implementing the basic functionality to read user input.
2. **Command Execution**: After successfully reading input, the next step was to execute commands.
3. **Error Handling**: Once command execution was in place, error handling was introduced using a switch table method with custom error codes.
4. **Project Restructuring**: To improve maintainability and readability, the project was restructured by splitting it into multiple files, making it more modular instead of having one long file.

## Detailed Summary of Error Messages and Codes

The shell handles various errors and provides the following messages and codes:

- **Command/File/Directory Not Found**: If a command/file/dir is not found, the shell prints `Error: No such file or directory` and continues.
- **Empty Command**: If the user inputs an empty command, the shell prints `Error: Empty command` and continues.
- **Permission Denied**: If a command cannot be executed due to permission issues, the shell prints `Error: Permission denied` and continues.
- **Execution Failure**: If a command fails to execute, the shell prints `Error: Execution failed`.

These error messages and codes help in diagnosing issues and understanding the shell's behavior.

## Additional Information

- **Redirections**: The shell does not support redirections (`<` and `>` operators).
- **Piping**: The shell does not support piping (`|` operator).
- **Maximum Command Length**: The maximum length of a command is 1024 characters.
