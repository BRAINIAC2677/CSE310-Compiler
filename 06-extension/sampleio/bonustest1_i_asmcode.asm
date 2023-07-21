.MODEL SMALL

.STACK 1000H

.DATA

CR EQU 0DH
LF EQU 0AH
NUMBER_PRINTLN DB '00000$'
NEWLINE DB CR, LF, '$'

.CODE

foo PROC
    PUSH BP
    MOV BP, SP
    PUSH 6	;line no: 2
    POP SI	;line no: 2
    PUSH [BP+SI]	;line no: 2
    PUSH 4	;line no: 2
    POP SI	;line no: 2
    PUSH [BP+SI]	;line no: 2
    POP AX	;line no: 2
    POP BX	;line no: 2
    ADD AX, BX	;line no: 2
    PUSH AX	;line no: 2
    MOV AX, 5	;line no: 2
    PUSH AX	;line no: 2
    POP AX	;line no: 2
    POP BX	;line no: 2
    CMP BX, AX
	JLE label_0
	JMP label_2
label_0:
    MOV AX, 7	;line no: 3
    PUSH AX	;line no: 3
    POP AX	;line no: 3
    POP BP
    RET 4
label_1:
label_2:
    PUSH 6	;line no: 5
    POP SI	;line no: 5
    PUSH [BP+SI]	;line no: 5
    MOV AX, 2	;line no: 5
    PUSH AX	;line no: 5
    POP AX	;line no: 5
    POP BX	;line no: 5
    SUB BX, AX	;line no: 5
    MOV AX, BX	;line no: 5
    PUSH AX	;line no: 5
    PUSH 4	;line no: 5
    POP SI	;line no: 5
    PUSH [BP+SI]	;line no: 5
    MOV AX, 1	;line no: 5
    PUSH AX	;line no: 5
    POP AX	;line no: 5
    POP BX	;line no: 5
    SUB BX, AX	;line no: 5
    MOV AX, BX	;line no: 5
    PUSH AX	;line no: 5
    CALL foo
    PUSH AX	;line no: 5
    MOV AX, 2	;line no: 5
    PUSH AX	;line no: 5
    PUSH 6	;line no: 5
    POP SI	;line no: 5
    PUSH [BP+SI]	;line no: 5
    MOV AX, 1	;line no: 5
    PUSH AX	;line no: 5
    POP AX	;line no: 5
    POP BX	;line no: 5
    SUB BX, AX	;line no: 5
    MOV AX, BX	;line no: 5
    PUSH AX	;line no: 5
    PUSH 4	;line no: 5
    POP SI	;line no: 5
    PUSH [BP+SI]	;line no: 5
    MOV AX, 2	;line no: 5
    PUSH AX	;line no: 5
    POP AX	;line no: 5
    POP BX	;line no: 5
    SUB BX, AX	;line no: 5
    MOV AX, BX	;line no: 5
    PUSH AX	;line no: 5
    CALL foo
    PUSH AX	;line no: 5
    POP BX	;line no: 5
    POP AX	;line no: 5
    IMUL BX	;line no: 5
    PUSH AX	;line no: 5
    POP AX	;line no: 5
    POP BX	;line no: 5
    ADD AX, BX	;line no: 5
    PUSH AX	;line no: 5
    POP AX	;line no: 5
    POP BP
    RET 4
label_3:
    POP BP
    RET 4
foo ENDP

main PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV BP, SP
    MOV SP, BP	;line no: 10
    SUB SP, 6	;line no: 10
label_4:
    PUSH -2	;line no: 11
    MOV AX, 7	;line no: 11
    PUSH AX	;line no: 11
    POP AX	;line no: 11
    POP SI	;line no: 11
    MOV [BP+SI], AX	;line no: 11
    PUSH AX	;line no: 11
    POP AX	;line no: 11
label_5:
    PUSH -4	;line no: 12
    MOV AX, 3	;line no: 12
    PUSH AX	;line no: 12
    POP AX	;line no: 12
    POP SI	;line no: 12
    MOV [BP+SI], AX	;line no: 12
    PUSH AX	;line no: 12
    POP AX	;line no: 12
label_6:
    PUSH -6	;line no: 14
    PUSH -2	;line no: 14
    POP SI	;line no: 14
    PUSH [BP+SI]	;line no: 14
    PUSH -4	;line no: 14
    POP SI	;line no: 14
    PUSH [BP+SI]	;line no: 14
    CALL foo
    PUSH AX	;line no: 14
    POP AX	;line no: 14
    POP SI	;line no: 14
    MOV [BP+SI], AX	;line no: 14
    PUSH AX	;line no: 14
    POP AX	;line no: 14
label_7:
    PUSH -6	;line no: 15
    POP SI	;line no: 15
    MOV AX, [BP+SI]	;line no: 15
    CALL PRINT_INT	;line no: 15
    CALL PRINT_NEWLINE	;line no: 15
label_8:
    MOV AX, 0	;line no: 17
    PUSH AX	;line no: 17
    POP AX	;line no: 17
    ADD SP, 6	;line no: 17
    MOV AX, 4CH
    INT 21H
label_9:
    ADD SP, 6	;line no: 10-17
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

2SCOMP PROC
    ; WILL CALC 2S COMPLEMENT OF DX AND STORE IN DX
    PUSH AX
    MOV AX, 0FFFFH  ; NOT
    SUB AX, DX
    ADD AX, 01H
    MOV DX, AX
    POP AX
    RET
2SCOMP ENDP

SCANLN_INT PROC
    ; TAKE A SIGNED INT INPUT AND STORE IN DX REG
    PUSH AX
    PUSH BX
    PUSH CX
    ; DX = 0
    XOR DX, DX
    XOR CX, CX
    ; HANDLING NEGATIVE INT
    MOV AH, 1
    INT 21H
    CMP AL, '-'
    JNE SCANLN_INT_CHECK_CHAR
    MOV CL, 01H ; CL = 1 MEANS NEGATIVE INT
    SCANLN_INT_LOOP_1:
        ; CHARACTER BY CHARACTER INPUT
        MOV AH,1
        INT 21H
        SCANLN_INT_CHECK_CHAR:
            ; BREAK
            CMP AL, '0'
            JL SCANLN_INT_END_LOOP_1
            CMP AL, '9'
            JG SCANLN_INT_END_LOOP_1
            ; STORING DIGIT TO BX
            SUB AL, 30H
            MOV BL, AL
            XOR BH, BH
            ; DX = DX*10 + BX
            MOV AL, 10D
            XOR AH, AH
            MUL DX
            ADD AX, BX
            MOV DX, AX
            JMP SCANLN_INT_LOOP_1
    SCANLN_INT_END_LOOP_1:
    ; IF NEG INT: DX = 2SCOMP(DX)
    CMP CL, 01H
    JNE SCANLN_INT_RESTORE_REG
    CALL 2SCOMP
    SCANLN_INT_RESTORE_REG:
        CALL PRINT_NEWLINE
        POP CX
        POP BX
        POP AX
    RET
SCANLN_INT ENDP

PRINT_INT PROC  ;print what is in ax
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
PRINT_INT ENDP

END MAIN
