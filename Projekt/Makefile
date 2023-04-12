# compiler options
CC = gcc
CCFLAGS = 

# directories
SRCDIR = .
BINDIR = bin
# source and binary files
SOURCES = $(wildcard $(SRCDIR)/*.c)
BINARIES = $(patsubst $(SRCDIR)/%.c,$(BINDIR)/%,$(SOURCES))

# targets
.PHONY: all asm clean

all: clean cc asm

cc: $(BINARIES)

$(BINDIR)/%: $(SRCDIR)/%.c | $(BINDIR)
	$(CC) $(CCFLAGS) $< -o $@

asm: $(SRCDIR)/hello.c | $(BINDIR)
	$(CC) $(CCFLAGS) -S $< -o $(BINDIR)/hello.s

$(BINDIR):
	if ! [ -e $(BINDIR) ]; then mkdir $(BINDIR); else echo "$(BINDIR) already exists."; fi;

clean:
	rm -rf $(BINDIR)/*