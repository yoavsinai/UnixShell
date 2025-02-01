CC = gcc
CFLAGS = -Wall -Wextra -g
BUILD_DIR = ./build
BIN_DIR = ./
OUTPUT = $(BIN_DIR)/myshell
ZIP_FILE = ex6.zip

# Use wildcard to find all .s files in the current directory
SOURCES = $(wildcard *.s)
OBJECTS = $(addprefix $(BUILD_DIR)/, $(SOURCES:.s=.o))

all: $(OUTPUT)

$(OUTPUT): $(OBJECTS)
	# Ensure the binary directory exists
	mkdir -p $(BIN_DIR)
	# Link the object files into the final binary and place it in the current directory
	$(CC) $(CFLAGS) -o $@ $(OBJECTS)

$(BUILD_DIR)/%.o: %.s
	# Ensure the build directory exists
	mkdir -p $(BUILD_DIR)
	# Assemble the .s file into a .o file and place it in the build directory
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	# Remove the object files in the build directory and the binary in ./bin
	rm -rf $(BUILD_DIR)

zip:
	# Create a zip archive containing all source files and README.md
	zip -r $(ZIP_FILE) *.s README.md Makefile