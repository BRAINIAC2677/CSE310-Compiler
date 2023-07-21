.MODEL SMALL

.STACK 1000H

.DATA

CR EQU 0DH
LF EQU 0AH
NUMBER_PRINTLN DB '00000$'
NEWLINE DB CR, LF, '$'
w DW 10 DUP(0)	;line no: 1

.CODE

main PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV BP, SP
    SUB SP, 4	;line no: 5
label_0:
    MOV AX, 0	;line no: 6
    PUSH AX	;line no: 6
    POP SI	;line no: 6
	SHL SI, 1	;line no: 6
    SUB SI, 4	;line no: 6
    PUSH SI	;line no: 6
    MOV AX, 8	;line no: 6
    PUSH AX	;line no: 6
    MOV AX, 2	;line no: 6
    PUSH AX	;line no: 6
    POP BX	;line no: 6
    POP AX	;line no: 6
	CWD	;line no: 6
    IDIV BX	;line no: 6
    POP SI	;line no: 6
    MOV [BP+SI], AX	;line no: 6
label_1:
    POP AX	;line no: 7
label_2:
    MOV AX, 1	;line no: 8
    PUSH AX	;line no: 8
    POP SI	;line no: 8
	SHL SI, 1	;line no: 8
    SUB SI, 4	;line no: 8
    PUSH SI	;line no: 8
    MOV AX, 8	;line no: 8
    NEG AX	;line no: 8
    PUSH AX	;line no: 8
    MOV AX, 2	;line no: 8
    PUSH AX	;line no: 8
    POP BX	;line no: 8
    POP AX	;line no: 8
	CWD	;line no: 8
    IDIV BX	;line no: 8
    POP SI	;line no: 8
    MOV [BP+SI], AX	;line no: 8
label_3:
    POP AX	;line no: 9
label_4:
    MOV AX, 0	;line no: 11
    ADD SP, 4	;line no: 11
    MOV AX, 4CH
    INT 21H
label_5:
    ADD SP, 4	;line no: 5-11
    MOV AX, 4CH
    INT 21H
main ENDP

PRINT_NEWLINE PROC
    PUSH AX
    PUSH DX
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H
    POP DX
    POP AX
    RET
PRINT_NEWLINE ENDP

PRINTLN_INT PROC  ;print what is in ax
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    LEA SI,NUMBER_PRINTLN
    MOV BX,10
    ADD SI,4
    CMP AX,0
    JNGE NEGATE
    PRINT:
    XOR DX,DX
    DIV BX
    MOV [SI],DL
    ADD [SI],'0'
    DEC SI
    CMP AX,0
    JNE PRINT
    INC SI
    LEA DX,SI
    MOV AH,9
    INT 21H
    CALL PRINT_NEWLINE
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
    NEGATE:
    PUSH AX
    MOV AH,2
    MOV DL,'-'
    INT 21H
    POP AX
    NEG AX
    JMP PRINT
PRINTLN_INT ENDP

END MAIN
