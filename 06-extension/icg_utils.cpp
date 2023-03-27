#include <bits/stdc++.h>
using namespace std;

#include "icg_utils.hpp"

int code_segment_lineno = 0;
int label = 0;
fstream asmcode_file;
fstream code_segment_file;

void gen_starting_code()
{
    string code = "\
.MODEL SMALL\n\
\n\
.STACK 1000H\n\
\n\
.DATA\n\
\n\
CR EQU 0DH\n\
LF EQU 0AH\n\
NUMBER_PRINTLN DB '00000$'\n\
NEWLINE DB CR, LF, '$'\n";
    asmcode_file << code;
}

string gen_newline()
{
    string code = "\n\
PRINT_NEWLINE PROC\n\
    PUSH AX\n\
    PUSH DX\n\
    LEA DX, NEWLINE\n\
    MOV AH, 9\n\
    INT 21H\n\
    POP DX\n\
    POP AX\n\
    RET\n\
PRINT_NEWLINE ENDP\n";
    return code;
}

string gen_2scomp()
{
    string code = "\
2SCOMP PROC\n\
    ; WILL CALC 2S COMPLEMENT OF DX AND STORE IN DX\n\
    PUSH AX\n\
    MOV AX, 0FFFFH  ; NOT\n\
    SUB AX, DX\n\
    ADD AX, 01H\n\
    MOV DX, AX\n\
    POP AX\n\
    RET\n\
2SCOMP ENDP\n";
    return code;
}

string gen_print()
{
    string code = "\
PRINT_INT PROC  ;print what is in ax\n\
    PUSH AX\n\
    PUSH BX\n\
    PUSH CX\n\
    PUSH DX\n\
    PUSH SI\n\
    LEA SI,NUMBER_PRINTLN\n\
    MOV BX,10\n\
    ADD SI,4\n\
    CMP AX,0\n\
    JNGE NEGATE\n\
    PRINT:\n\
    XOR DX,DX\n\
    DIV BX\n\
    MOV [SI],DL\n\
    ADD [SI],'0'\n\
    DEC SI\n\
    CMP AX,0\n\
    JNE PRINT\n\
    INC SI\n\
    LEA DX,SI\n\
    MOV AH,9\n\
    INT 21H\n\
    POP SI\n\
    POP DX\n\
    POP CX\n\
    POP BX\n\
    POP AX\n\
    RET\n\
    NEGATE:\n\
    PUSH AX\n\
    MOV AH,2\n\
    MOV DL,'-'\n\
    INT 21H\n\
    POP AX\n\
    NEG AX\n\
    JMP PRINT\n\
PRINT_INT ENDP\n\n";

    return code;
}

string gen_scanf()
{
    string code = "\
SCANLN_INT PROC\n\
    ; TAKE A SIGNED INT INPUT AND STORE IN DX REG\n\
    PUSH AX\n\ 
    PUSH BX\n\
    PUSH CX\n\
    ; DX = 0\n\
    XOR DX, DX\n\
    XOR CX, CX\n\
    ; HANDLING NEGATIVE INT\n\
    MOV AH, 1\n\
    INT 21H\n\
    CMP AL, '-'\n\
    JNE SCANLN_INT_CHECK_CHAR\n\
    MOV CL, 01H ; CL = 1 MEANS NEGATIVE INT\n\        
    SCANLN_INT_LOOP_1:\n\
        ; CHARACTER BY CHARACTER INPUT\n\
        MOV AH,1\n\
        INT 21H\n\
        SCANLN_INT_CHECK_CHAR:\n\
            ; BREAK\n\
            CMP AL, '0'\n\
            JL SCANLN_INT_END_LOOP_1\n\
            CMP AL, '9'\n\
            JG SCANLN_INT_END_LOOP_1\n\
            ; STORING DIGIT TO BX\n\
            SUB AL, 30H\n\
            MOV BL, AL\n\
            XOR BH, BH\n\
            ; DX = DX*10 + BX\n\
            MOV AL, 10D\n\
            XOR AH, AH\n\
            MUL DX\n\
            ADD AX, BX\n\
            MOV DX, AX\n\ 
            JMP SCANLN_INT_LOOP_1\n\        
    SCANLN_INT_END_LOOP_1:\n\  
    ; IF NEG INT: DX = 2SCOMP(DX)\n\
    CMP CL, 01H\n\
    JNE SCANLN_INT_RESTORE_REG\n\
    CALL 2SCOMP\n\
    SCANLN_INT_RESTORE_REG:\n\
        CALL PRINT_NEWLINE\n\
        POP CX\n\ 
        POP BX\n\
        POP AX\n\
    RET\n\
SCANLN_INT ENDP\n";
    return code;
}

void gen_ending_code()
{
    string code = gen_newline() + "\n" + gen_2scomp() + "\n" + gen_scanf() + "\n" + gen_print() + "END MAIN\n"; // must have a main function
    asmcode_file << code;
}

void gen_func_starting_code(string _func_name)
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
    code_segment_file << code;
    code_segment_lineno = code_segment_lineno + 4 + (_func_name == "main");
}

void gen_func_ending_code(bool _is_main_func, int _arg_size)
{
    string code;
    int pop_size = _arg_size * 2;
    if (_is_main_func)
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
    code_segment_file << code;
    code_segment_lineno += 2;
}

void gen_code(string _code)
{
    string code = "\t" + _code + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_code(string _code, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\t" + _code + _comment + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_push(string _reg)
{
    string code = "\
    PUSH " + _reg +
                  "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_push(string _reg, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    PUSH " + _reg +
                  _comment + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_push(int _val)
{
    string code = "\
    PUSH " + to_string(_val) +
                  "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_push(int _val, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    PUSH " + to_string(_val) +
                  _comment + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_pop(string _reg)
{
    string code = "\
    POP " + _reg + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_pop(string _reg, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    POP " + _reg + _comment +
                  "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_mov(string _reg1, string _reg2)
{
    string code = "\
    MOV " + _reg1 +
                  ", " + _reg2 + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_mov(string _reg1, string _reg2, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    MOV " + _reg1 +
                  ", " + _reg2 + _comment + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_mov(string _reg1, int _val)
{
    string code = "\
    MOV " + _reg1 +
                  ", " + to_string(_val) + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_mov(string _reg1, int _val, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    MOV " + _reg1 +
                  ", " + to_string(_val) + _comment + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_call(string _func_name)
{
    string code = "\
    CALL " + _func_name +
                  "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_call(string _func_name, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    CALL " + _func_name +
                  _comment + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_sub(string _reg1, string _reg2)
{
    string code = "\
    SUB " + _reg1 +
                  ", " + _reg2 + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_sub(string _reg1, string _reg2, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    SUB " + _reg1 +
                  ", " + _reg2 + _comment + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_sub(string _reg, int _val)
{
    string code = "\
    SUB " + _reg + ", " +
                  to_string(_val) + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_sub(string _reg, int _val, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    SUB " + _reg + ", " +
                  to_string(_val) + _comment + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_add(string _reg1, string _reg2)
{
    string code = "\
    ADD " + _reg1 +
                  ", " + _reg2 + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_add(string _reg1, string _reg2, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    ADD " + _reg1 +
                  ", " + _reg2 + _comment + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_add(string _reg, int _val)
{
    string code = "\
    ADD " + _reg + ", " +
                  to_string(_val) + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_add(string _reg, int _val, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    ADD " + _reg + ", " +
                  to_string(_val) + _comment + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_neg(string _reg)
{
    string code = "\
    NEG " + _reg + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_neg(string _reg, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    NEG " + _reg + _comment +
                  "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_cmp(string _reg1, string _reg2)
{
    string code = "\
    CMP " + _reg1 +
                  ", " + _reg2 + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_cmp(string _reg1, string _reg2, string _comment)
{
    string code = "\
    CMP " + _reg1 +
                  ", " + _reg2 + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_cmp(string _reg1, int _val)
{
    string code = "\
    CMP " + _reg1 +
                  ", " + to_string(_val) + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_cmp(string _reg1, int _val, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    CMP " + _reg1 +
                  ", " + to_string(_val) + _comment + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_label(string _label)
{
    string code = _label + ":\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_label(string _label, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = _label + ":" +
                  _comment + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_imul(string _reg)
{
    string code = "\
    IMUL " + _reg +
                  "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_imul(string _reg, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    IMUL " + _reg +
                  _comment + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_idiv(string _reg)
{
    string code = "\
    IDIV " + _reg +
                  "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_idiv(string _reg, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    IDIV " + _reg +
                  _comment + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_xor(string _reg1, string _reg2)
{
    string code = "\
    XOR " + _reg1 +
                  ", " + _reg2 + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_xor(string _reg1, string _reg2, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    XOR " + _reg1 +
                  ", " + _reg2 + _comment + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_and(string _reg1, string _reg2)
{
    string code = "\
    AND " + _reg1 +
                  ", " + _reg2 + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_and(string _reg1, string _reg2, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    AND " + _reg1 +
                  ", " + _reg2 + _comment + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_or(string _reg1, string _reg2)
{
    string code = "\
    OR " + _reg1 +
                  ", " + _reg2 + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_or(string _reg1, string _reg2, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code = "\
    OR " + _reg1 +
                  ", " + _reg2 + _comment + "\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_endp(string _func_name)
{
    string code = _func_name + " ENDP\n";
    code_segment_file << code;
    code_segment_lineno++;
}

void gen_global_var(string _var_name, int _array_size, string _comment)
{
    if (_comment != "")
    {
        _comment = "\t;" + _comment;
    }
    string code;
    if (_array_size > 0)
    {
        code = "\
" + _var_name +
               " DW " + to_string(_array_size) + " DUP(0)" + _comment + "\n";
    }
    else
    {
        code = "\
" + _var_name +
               " DW 0" + _comment + "\n";
    }
    asmcode_file << code;
}

string get_lineno_comment(int _lineno)
{
    return "line no: " + to_string(_lineno);
}

string get_lineno_comment(int _start_lineno, int _end_lineno)
{
    return "line no: " + to_string(_start_lineno) + "-" + to_string(_end_lineno);
}

string get_newlabel()
{
    return "label_" + to_string(label++);
}

void peephole_optimization(string _source_file_name, string _dest_file_name)
{
    int erased_line_count = 0;
    fstream source_file, dest_file, log_file;
    source_file.open(_source_file_name, ios::in);
    dest_file.open(_dest_file_name, ios::out | ios::trunc);
    log_file.open("optimization_log.txt", ios::out | ios::trunc);

    vector<string> lines;
    string line;
    while (getline(source_file, line))
    {
        lines.push_back(line);
    }

    log_file << "Erased lines:\n";

    for (int i = 0; i < lines.size(); i++)
    {
        line = line_preprocess(lines[i]);

        string op = line.substr(0, line.find(" "));

        if (op == "PUSH" && i < lines.size() - 1)
        {
            string next_line = line_preprocess(lines[i + 1]);
            string next_op = next_line.substr(0, next_line.find(" "));
            if (next_op == "POP")
            {
                string arg1 = line.substr(line.find(" ") + 1);
                string next_arg1 = next_line.substr(next_line.find(" ") + 1);
                if (arg1 == next_arg1)
                {
                    i++;
                    log_file << "line " << i << ": " << line << endl;
                    log_file << "line " << i + 1 << ": " << next_line << endl;
                    erased_line_count += 2;
                    continue;
                }
            }
        }

        if (op == "MOV" && i < lines.size() - 1)
        {
            string next_line = line_preprocess(lines[i + 1]);
            string next_op = next_line.substr(0, next_line.find(" "));
            if (next_op == "MOV")
            {
                string arg1 = line.substr(line.find(" ") + 1, line.find(",") - line.find(" ") - 1);
                string arg2 = line.substr(line.find(",") + 2);
                string next_arg1 = next_line.substr(next_line.find(" ") + 1, next_line.find(",") - next_line.find(" ") - 1);
                string next_arg2 = next_line.substr(next_line.find(",") + 2);

                if (arg1 == next_arg2 && arg2 == next_arg1)
                {
                    dest_file << lines[i] << endl;
                    i++;
                    log_file << "line " << i + 1 << ": " << next_line << endl;
                    erased_line_count += 1;
                    continue;
                }
            }
        }

        dest_file << lines[i] << endl;
    }
    log_file << "\nErased line count: " << erased_line_count << endl;
    source_file.close();
    dest_file.close();
}

string line_preprocess(string _line)
{
    _line.erase(0, _line.find_first_not_of(" \t"));
    if (_line.find(";") != string::npos)
    {
        _line.erase(_line.find(";"));
    }
    _line.erase(_line.find_last_not_of(" \t") + 1);
    return _line;
}
