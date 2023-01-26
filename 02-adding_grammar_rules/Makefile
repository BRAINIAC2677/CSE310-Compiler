CXX = g++

all: main

parser.c parser.h: parser.y
	bison --header=parser.h -o parser.c $<

scanner.c scanner.h: scanner.l
	flex -o scanner.c --header=scanner.h $<

parser.o: parser.c scanner.h
	$(CXX) -w -c -o $@ $<

scanner.o: scanner.c parser.h
	$(CXX) -w -c -o $@ $<

main : scanner.o parser.o 
	$(CXX) -o $@ $^

run: main
	./$< input.c 

clean:
	rm -f main scanner.c scanner.h parser.c parser.h *.o *.txt *.output