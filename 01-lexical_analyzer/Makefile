CXX = g++

all: scanner

scanner.c: scanner.l
	flex -o $@ $<

scanner : scanner.c 
	$(CXX) -o $@ $<

run: scanner
	./$< input.c 

clean:
	rm -f scanner scanner.c output.txt 