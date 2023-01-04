#!/bin/bash

bison --header -o parser.c parser.y
echo 'Generated the parser C file as well the header file'
flex -o scanner.c --header=scanner.h scanner.l
echo 'Generated the scanner C file'
g++ -w -c -o parser.o parser.c
echo 'Generated the parser object file'
g++ -w -c -o scanner.o scanner.c
# if the above command doesn't work try g++ -fpermissive -w -c -o l.o lex.yy.c
echo 'Generated the scanner object file'
g++ parser.o scanner.o -lfl -o compiler 
echo 'All ready, running'
./compiler input.c 
