#include <bits/stdc++.h>
using namespace std;

#include "icg_utils.hpp"

string gen_starting_code()
{
    string code = "\
.MODEL SMALL\n\
\n\
.STACK 100H\n\
\n\
.DATA\n\
\n\
CR EQU 0DH\n\
LF EQU 0AH\n\
NEWLINE DB CR, LF, '$'\n";
    return code;
}

string gen_newline()
{
    string code = "\n\
PRINT_NEWLINE PROC\n\
    \n\
    PUSH AX\n\
    PUSH DX\n\
    \n\
    LEA DX, NEWLINE\n\
    MOV AH, 9\n\
    INT 21H\n\
    \n\
    POP DX\n\
    POP AX\n\
    \n\
    RET\n\
PRINT_NEWLINE ENDP\n";
    return code;
}

string gen_2scomp()
{
    string code = "\n\
2SCOMP PROC\n\
    ; WILL CALC 2S COMPLEMENT OF DX AND STORE IN DX\n\
    \n\ 
    PUSH AX\n\
    \n\ 
    MOV AX, 0FFFFH  ; NOT\n\
    SUB AX, DX\n\
    ADD AX, 01H\n\
    MOV DX, AX\n\
    \n\
    POP AX\n\
    \n\
    RET\n\
2SCOMP ENDP\n";
    return code;
}

string gen_print()
{
    string code = "\n\
PRINT_INT PROC\n\
    ; PRINT SIGNED INTEGER FROM DX REG\n\
    \n\
    PUSH AX\n\
    PUSH BX\n\
    PUSH CX\n\
    PUSH DX\n\
    \n\ 
    ; CX WILL COUNT THE NUMBER OF DIGITS\n\
    XOR CX, CX\n\
    \n\ 
    ; IF DX NEGATIVE: 1|PRINT '-', 2|2S COMPLEMENT  DX\n\
    TEST DX, 08000H\n\
    JE PRINT_INT_LOOP_1\n\
    MOV BX, DX\n\
    MOV DL, '-'\n\
    MOV AH, 2\n\
    INT 21H\n\
    MOV DX, BX\n\
    CALL 2SCOMP\n\    
    \n\
    \n\
    PRINT_INT_LOOP_1:\n\    
        ; EXTRACTING AND STACKING DIGITS\n\
        \n\
        CMP DX, 0H\n\
        JE PRINT_INT_END_LOOP_1\n\
        \n\
        ; DX = DX/10, EXTRACT DX%10\n\
        MOV AX, DX\n\
        MOV BL, 10D\n\
        XOR BH, BH\n\
        XOR DX, DX      ; CLEARING DX\n\ 
        DIV BX\n\          
        ADD DX, 30H     ; DIGIT TO ASCII\n\  
        PUSH DX\n\
        ADD CX, 1\n\
        MOV DX, AX\n\      
        JMP PRINT_INT_LOOP_1\n\           
    PRINT_INT_END_LOOP_1:\n\
    \n\
    \n\
    PRINT_INT_LOOP_2:\n\
        ; UNSTACKING AND PRINTING DIGITS\n\
        \n\    
        CMP CX, 0H\n\
        JE PRINT_INT_END_LOOP_2\n\
        \n\
        POP DX\n\
        MOV AH, 2\n\
        INT 21H\n\
        \n\
        SUB CX, 1\n\
        JMP PRINT_INT_LOOP_2\n\    
    PRINT_INT_END_LOOP_2:\n\
    \n\
    \n\
    POP DX\n\
    POP CX\n\
    POP BX\n\
    POP AX\n\
    \n\
    RET\n\
PRINT_INT ENDP\n";
    return code;
}

string gen_println()
{
    string code = "\n\
PRINTLN_INT PROC\n\
    ; PRINT SIGNED INTEGER FROM DX REG\n\
    \n\
    PUSH AX\n\
    PUSH BX\n\
    PUSH CX\n\
    PUSH DX\n\
    \n\ 
    ; CX WILL COUNT THE NUMBER OF DIGITS\n\
    XOR CX, CX\n\
    \n\ 
    ; IF DX NEGATIVE: 1|PRINT '-', 2|2S COMPLEMENT  DX\n\
    TEST DX, 08000H\n\
    JE PRINTLN_INT_LOOP_1\n\
    MOV BX, DX\n\
    MOV DL, '-'\n\
    MOV AH, 2\n\
    INT 21H\n\
    MOV DX, BX\n\
    CALL 2SCOMP\n\    
    \n\
    \n\
    PRINTLN_INT_LOOP_1:\n\    
        ; EXTRACTING AND STACKING DIGITS\n\
        \n\
        CMP DX, 0H\n\
        JE PRINTLN_INT_END_LOOP_1\n\
        \n\
        ; DX = DX/10, EXTRACT DX%10\n\
        MOV AX, DX\n\
        MOV BL, 10D\n\
        XOR BH, BH\n\
        XOR DX, DX      ; CLEARING DX\n\ 
        DIV BX\n\          
        ADD DX, 30H     ; DIGIT TO ASCII\n\  
        PUSH DX\n\
        ADD CX, 1\n\
        MOV DX, AX\n\      
        JMP PRINTLN_INT_LOOP_1\n\           
    PRINTLN_INT_END_LOOP_1:\n\
    \n\
    \n\
    PRINTLN_INT_LOOP_2:\n\
        ; UNSTACKING AND PRINTING DIGITS\n\
        \n\    
        CMP CX, 0H\n\
        JE PRINTLN_INT_END_LOOP_2\n\
        \n\
        POP DX\n\
        MOV AH, 2\n\
        INT 21H\n\
        \n\
        SUB CX, 1\n\
        JMP PRINTLN_INT_LOOP_2\n\    
    PRINTLN_INT_END_LOOP_2:\n\
    CALL PRINT_NEWLINE\n\
    \n\
    \n\
    POP DX\n\
    POP CX\n\
    POP BX\n\
    POP AX\n\
    \n\
    RET\n\
PRINTLN_INT ENDP\n";

    return code;
}

string gen_ending_code()
{
    string code = gen_2scomp() + "\n" + gen_newline() + "\n" + gen_print() + "\n" + gen_println() + "END MAIN\n"; // must have a main function
    return code;
}

string gen_func_starting_code(string _func_name)
{
    string code = "\n" + _func_name + " PROC\n";
    if (_func_name == "main")
    {
        code += "\
    MOV AX, @DATA\n\
    MOV DS, AX\n";
    }
    else
    {
        code += "\
    PUSH BP\n";
    }
    code += "\
    MOV BP, SP\n";
    return code;
}

string gen_func_ending_code(string _func_name, int _arg_size)
{
    string code;
    int pop_size = _arg_size * 2;
    if (_func_name == "main")
    {
        code = "\
    MOV AX, 4CH\n\
    INT 21H\n";
    }
    else
    {
        code = "\
    POP BP\n\
    RET " + to_string(pop_size) +
               string("\n");
    }
    code += _func_name + " ENDP\n\n";
    return code;
}