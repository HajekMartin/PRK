MAKE=make
GCC=gcc

FILENAME=lang
PRINT_OUTPUT="y"

PARSER_BIN="lang_parser"

ROOT_DIR=$(shell pwd)

BINDIR="./bin"
TESTDIR="./../../testfiles"
TEST_OK_FILE="test_ok.txt"
TEST_NOOK_FILE="test_nook.txt"

.PHONY: parser test_ok test_nook subclean clean all

all: clean parser test_ok test_nook
	@if [ $(PRINT_OUTPUT) ]; then cat $(BINDIR)/$(TEST_OK_FILE).report; fi
	@if [ $(PRINT_OUTPUT) ]; then cat $(BINDIR)/$(TEST_NOOK_FILE).report; fi

parser:
	yacc -d $(FILENAME).y
	flex $(FILENAME).lex
	$(GCC) lex.yy.c y.tab.c -o $(PARSER_BIN) -lm
	@mv $(PARSER_BIN) $(BINDIR)/
#	@make -s subclean

test_ok:
	@./$(BINDIR)/$(PARSER_BIN) < $(TESTDIR)/$(TEST_OK_FILE) >$(BINDIR)/$(TEST_OK_FILE).report
test_nook:
	@./$(BINDIR)/$(PARSER_BIN) < $(TESTDIR)/$(TEST_NOOK_FILE) >$(BINDIR)/$(TEST_NOOK_FILE).report

subclean:
	@rm -rf lex.yy.c
	@rm -rf y.tab.h y.tab.c

clean: subclean
	@rm -rf $(BINDIR)/*
