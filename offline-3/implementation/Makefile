# This Makefile is designed to be simple and readable.  It does not
# aim at portability.  It requires GNU Make.

BASE = 1905004
PARSER = parser
SCANNER = scanner
INPUT = input.c

BISON = bison
FLEX = flex
CXX = g++ 

all: $(BASE)

$(PARSER).c $(PARSER).h: $(PARSER).y 
	$(BISON) --header -o $(PARSER).c $<

$(SCANNER).c $(SCANNER).h: $(SCANNER).l
	$(FLEX) -o $(SCANNER).c --header=$(SCANNER).h $<

$(PARSER).o: $(PARSER).c $(SCANNER).h 
	echo "Compiling $(PARSER).c"
	$(CXX) -w -c -o $@ $<

$(SCANNER).o: $(SCANNER).c $(PARSER).h
	$(CXX) -w -c -o $@ $<

ast.o: ast.cpp 
	echo "Compiling $(AST).cpp"
	$(CXX) -w -c -o $@ $<

SymbolInfo.o: SymbolInfo.cpp
	echo "Compiling $(SymbolInfo).cpp"
	$(CXX) -w -c -o $@ $<

$(BASE): $(PARSER).o $(SCANNER).o ast.o SymbolInfo.o
	echo "Compiling $(BASE)"
	$(CXX) -o $@ $^ 
run: $(BASE)
	echo "Running $(BASE) on $(INPUT)"
	./$< $(INPUT)

clean:
	rm -f $(BASE) $(PARSER).c $(PARSER).h $(SCANNER).c $(SCANNER).h *.o *.txt *.output


