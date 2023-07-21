# This Makefile is designed to be simple and readable.  It does not
# aim at portability.  It requires GNU Make.

CXX = g++ 

all: main

parser.c parser.h: parser.y 
	bison --header -o parser.c $<

scanner.c scanner.h: scanner.l
	flex -o scanner.c --header=scanner.h $<

parser.o: parser.c scanner.h 
	$(CXX) -w -c -o $@ $<

scanner.o: scanner.c parser.h
	$(CXX) -w -c -o $@ $<

SymbolInfo.o: SymbolInfo.cpp
	$(CXX) -w -c -o $@ $<

ScopeTable.o: ScopeTable.cpp
	$(CXX) -w -c -o $@ $<

SymbolTable.o: SymbolTable.cpp
	$(CXX) -w -c -o $@ $<

ParseTree.o: ParseTree.cpp
	$(CXX) -w -c -o $@ $<

main: parser.o scanner.o SymbolTable.o  SymbolInfo.o ScopeTable.o ParseTree.o 
	$(CXX) -o $@ $^ 

run: main
	@ read -p "Enter the input file name: " input; \
	./main $$input
	@echo "ran the program"

clean:
	rm -f main parser.c parser.h scanner.c scanner.h *.o *.txt *.output


