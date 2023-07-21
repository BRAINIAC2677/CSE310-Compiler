# CSE310 | Compiler

## Assignment Specifications
- [x] [Assignment 1](/assignment_specs/offline-1.pdf)
- [x] [Assignment 2](/assignment_specs/offline-2.pdf)
- [x] [Assignment 3](/assignment_specs/offline-3.pdf)

_*But I have broken the assignments into 5 stages and done some extensions in the last stage.*_

## Stages 
- [x] [Lexical Analysis](/01-lexical_analyzer/)
- [x] [Adding Grammar Rules](/02-adding_grammar_rules/)
- [x] [Syntaxt Analysis](/03-symboltable_and_parsetree/) | Symbol Table and Parse Tree
- [x] [Semantic Analysis](/04-semantic_analysis/) 
- [x] [Code Generation](/05-code_generation/) | Generating Assembly Code
- [x] [Extension](/06-extension/) | Covering more syntax

## How to run on Linux
- Install `flex` and `bison` using 
> `sudo apt install flex bison`
- Install `gcc` using
> `sudo apt install gcc`
- Clone the repo using git clone or download the zip file.
- Go to the directory of the stage you want to run.
- Run the following commands
> `make run`  
- After compilation you will be prompted to enter the input file name. Check out the [example input files](/example_ios/). 
- The input file should be 
    - In the same directory as the stage directory
    - Have the syntax supported by this [context free grammar](/assets/cfg.pdf)
- The output will be generated in the same directory as the stage directory.
- To clean the directory run
> `make clean`

## Example Input/Output 
- Lexical Analysis
    - [input](/example_ios/stage01/input.c)
    - [output](/example_ios/stage01/output.txt) | tokens
- Adding Grammar Rules
    - [input](/example_ios/stage02/input.c)
- Syntax Analysis
    - [input](/example_ios/stage03/input.c)
    - [output](/example_ios/stage03/parsetree.txt) | parse tree
- Semantic Analysis
    - [input](/example_ios/stage04/input.c)
    - [output 1](/example_ios/stage04/errors.txt) | semantic errors
    - [output 2](/example_ios/stage04/parsetree.txt) | parse tree 
- Code Generation
    - [input](/example_ios/stage05/input.c)
    - [output 1](/example_ios/stage05/assembly_code.asm) | assembly code
    - [output 2](/example_ios/stage05/optimized_assembly_code.txt) | optimized assembly code
- Extension
    - [input](/example_ios/stage06/input.c)
    - [output 1](/example_ios/stage06/assembly_code.asm) | assembly code
    - [output 2](/example_ios/stage06/optimized_assembly_code.txt) | optimized assembly code


## Resources: 
- [github repo | c-compiler](https://github.com/AnjaneyaTripathi/c-compiler)
- [compiler-explorer](https://godbolt.org/)
- [Tutorial on LEX and internal working of lex](https://rjtjdm.medium.com/tutorial-on-lex-and-internal-working-of-lex-5537c063ee#:~:text=Alternatively%20we%20can%20use%20%25option,define%20yywrap%20internally%20by%20lex.&text=There%20are%20majorly%20three%20type%20of%20variables%20in%20lex.&text=yyin%20is%20a%20variable%20of,character%20stream%20from%20that%20file.)

## Relevant QnA
- [Why separate class definition and implementation in different files?](http://www.math.uaa.alaska.edu/~afkjm/csce211/handouts/SeparateCompilation.pdf)
- [Declaring variables in header files c++](https://stackoverflow.com/a/38942057/13148347)
- [munmap_chunk(): invalid pointer](https://stackoverflow.com/questions/32118545/munmap-chunk-invalid-pointer)

- [%option noinput nounput: what are they for?](https://stackoverflow.com/a/39083223/13148347)
- [Circular dependency](https://stackoverflow.com/questions/64085054/error-class-name-does-not-name-a-type-in-c)

## Tools
- [regexr](https://regexr.com/) | regex tester