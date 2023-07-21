CXX = g++

all: scanner

scanner.c: scanner.l
	flex -o $@ $<

scanner : scanner.c 
	$(CXX) -o $@ $<

run:scanner 
	@ read -p "Enter the input file name: " input; \
	./scanner $$input
	@echo "ran the program"

clean:
	rm -f scanner scanner.c output.txt 