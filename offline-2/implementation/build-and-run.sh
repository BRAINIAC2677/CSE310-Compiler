# flex compilation
flex -o 1905004.c 1905004.l 
# build
g++ SymbolInfo.cpp ScopeTable.cpp SymbolTable.cpp 1905004.c -lfl -o 1905004.out
# run
./1905004.out input_lexical_errors_detection.txt

./1905004.out input_tokens_identification.txt


./1905004.out in.txt

# ./1905004.out "../testers/constant_tester.txt"

