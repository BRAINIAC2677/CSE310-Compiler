# flex compilation
flex -o 1905004.c 1905004.l 
# build
g++ 1905004_SymbolInfo.cpp 1905004_ScopeTable.cpp 1905004_SymbolTable.cpp 1905004.c -lfl -o 1905004.out

# run

./1905004.out input1.txt 

# ./1905004.out "../testers/num_tester.txt"

# ./1905004.out "../testers/char_tester.txt"

# ./1905004.out "../testers/string_tester.txt"

# ./1905004.out "../testers/comment_tester.txt"


