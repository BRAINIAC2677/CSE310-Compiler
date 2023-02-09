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
    CMP CX, 0\n\
    JNE PRINTLN_INT_LOOP_2\n\
    MOV DX, 30H\n\
    MOV AH, 2\n\
    INT 21H\n\
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
    CMP CX, 0\n\
    JNE PRINTLN_INT_LOOP_2\n\
    MOV DX, 30H\n\
    MOV AH, 2\n\
    INT 21H\n\
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

string gen_code(string _code)
{
    string code = "\t" + _code + "\n";
    return code;
}

string gen_code(string _code, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\t" + _code + _comment + "\n";
    return code;
}

string gen_push(string _reg)
{
    string code = "\
    PUSH " + _reg +
                  "\n";
    return code;
}

string gen_push(string _reg, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    PUSH " + _reg +
                  _comment + "\n";
    return code;
}

string gen_push(int _val)
{
    string code = "\
    PUSH " + to_string(_val) +
                  "\n";
    return code;
}

string gen_push(int _val, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    PUSH " + to_string(_val) +
                  _comment + "\n";
    return code;
}

string gen_pop(string _reg)
{
    string code = "\
    POP " + _reg + "\n";
    return code;
}

string gen_pop(string _reg, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    POP " + _reg + _comment +
                  "\n";
    return code;
}

string gen_mov(string _reg1, string _reg2)
{
    string code = "\
    MOV " + _reg1 +
                  ", " + _reg2 + "\n";
    return code;
}

string gen_mov(string _reg1, string _reg2, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    MOV " + _reg1 +
                  ", " + _reg2 + _comment + "\n";
    return code;
}

string gen_mov(string _reg1, int _val)
{
    string code = "\
    MOV " + _reg1 +
                  ", " + to_string(_val) + "\n";
    return code;
}

string gen_mov(string _reg1, int _val, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    MOV " + _reg1 +
                  ", " + to_string(_val) + _comment + "\n";
    return code;
}

string gen_call(string _func_name)
{
    string code = "\
    CALL " + _func_name +
                  "\n";
    return code;
}

string gen_call(string _func_name, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    CALL " + _func_name +
                  _comment + "\n";
    return code;
}

string gen_sub(string _reg1, string _reg2)
{
    string code = "\
    SUB " + _reg1 +
                  ", " + _reg2 + "\n";
    return code;
}

string gen_sub(string _reg1, string _reg2, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    SUB " + _reg1 +
                  ", " + _reg2 + _comment + "\n";
    return code;
}

string gen_sub(string _reg, int _val)
{
    string code = "\
    SUB " + _reg + ", " +
                  to_string(_val) + "\n";
    return code;
}

string gen_sub(string _reg, int _val, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    SUB " + _reg + ", " +
                  to_string(_val) + _comment + "\n";
    return code;
}

string gen_add(string _reg1, string _reg2)
{
    string code = "\
    ADD " + _reg1 +
                  ", " + _reg2 + "\n";
    return code;
}

string gen_add(string _reg1, string _reg2, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    ADD " + _reg1 +
                  ", " + _reg2 + _comment + "\n";
    return code;
}

string gen_add(string _reg, int _val)
{
    string code = "\
    ADD " + _reg + ", " +
                  to_string(_val) + "\n";
    return code;
}

string gen_add(string _reg, int _val, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    ADD " + _reg + ", " +
                  to_string(_val) + _comment + "\n";
    return code;
}

string gen_neg(string _reg)
{
    string code = "\
    NEG " + _reg + "\n";
    return code;
}

string gen_neg(string _reg, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    NEG " + _reg + _comment +
                  "\n";
    return code;
}

string gen_cmp(string _reg1, string _reg2)
{
    string code = "\
    CMP " + _reg1 +
                  ", " + _reg2 + "\n";
    return code;
}

string gen_cmp(string _reg1, string _reg2, string _comment)
{
    string code = "\
    CMP " + _reg1 +
                  ", " + _reg2 + "\n";
    return code;
}

string gen_cmp(string _reg1, int _val)
{
    string code = "\
    CMP " + _reg1 +
                  ", " + to_string(_val) + "\n";
    return code;
}

string gen_cmp(string _reg1, int _val, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    CMP " + _reg1 +
                  ", " + to_string(_val) + _comment + "\n";
    return code;
}

string gen_label(string _label)
{
    string code = "\
    " + _label + ":\n";
    return code;
}

string gen_label(string _label, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    " + _label + ":" +
                  _comment + "\n";
    return code;
}

string gen_imul(string _reg)
{
    string code = "\
    IMUL " + _reg +
                  "\n";
    return code;
}

string gen_imul(string _reg, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    IMUL " + _reg +
                  _comment + "\n";
    return code;
}

string gen_idiv(string _reg)
{
    string code = "\
    IDIV " + _reg +
                  "\n";
    return code;
}

string gen_idiv(string _reg, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    IDIV " + _reg +
                  _comment + "\n";
    return code;
}

string gen_xor(string _reg1, string _reg2)
{
    string code = "\
    XOR " + _reg1 +
                  ", " + _reg2 + "\n";
    return code;
}

string gen_xor(string _reg1, string _reg2, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    XOR " + _reg1 +
                  ", " + _reg2 + _comment + "\n";
    return code;
}

string gen_and(string _reg1, string _reg2)
{
    string code = "\
    AND " + _reg1 +
                  ", " + _reg2 + "\n";
    return code;
}

string gen_and(string _reg1, string _reg2, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    AND " + _reg1 +
                  ", " + _reg2 + _comment + "\n";
    return code;
}

string gen_or(string _reg1, string _reg2)
{
    string code = "\
    OR " + _reg1 +
                  ", " + _reg2 + "\n";
    return code;
}

string gen_or(string _reg1, string _reg2, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    OR " + _reg1 +
                  ", " + _reg2 + _comment + "\n";
    return code;
}

string get_lineno_comment(int _lineno)
{
    return "line no: " + to_string(_lineno);
}