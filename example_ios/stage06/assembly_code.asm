.MODEL SMALL

.STACK 1000H

.DATA

CR EQU 0DH
LF EQU 0AH
NUMBER_PRINTLN DB '00000$'
NEWLINE DB CR, LF, '$'

.CODE

main PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV BP, SP
    MOV SP, BP	;line no: 3
    SUB SP, 200	;line no: 3
label_0:
    MOV SP, BP	;line no: 4
    SUB SP, 204	;line no: 4
label_1:
    PUSH -204	;line no: 5
    CALL SCANLN_INT	;line no: 5
    MOV AX, DX	;line no: 5
    POP SI	;line no: 5
    MOV [BP+SI], AX	;line no: 5
label_2:
    PUSH -202	;line no: 6
    MOV AX, 0	;line no: 6
    PUSH AX	;line no: 6
    POP AX	;line no: 6
    POP SI	;line no: 6
    MOV [BP+SI], AX	;line no: 6
    PUSH AX	;line no: 6
    POP AX	;line no: 6
label_3:
    PUSH -202	;line no: 6
    POP SI	;line no: 6
    PUSH [BP+SI]	;line no: 6
    PUSH -204	;line no: 6
    POP SI	;line no: 6
    PUSH [BP+SI]	;line no: 6
    POP AX	;line no: 6
    POP BX	;line no: 6
    CMP BX, AX
	JL label_5
	JMP label_7
label_4:
    PUSH -202	;line no: 6
    POP SI	;line no: 6
    PUSH [BP+SI]	;line no: 6
	INC W. [BP+SI]	;line no: 6
    POP AX	;line no: 6
	JMP label_3	;line no: 6
label_5:
    PUSH -202	;line no: 8
    POP SI	;line no: 8
    PUSH [BP+SI]	;line no: 8
    POP SI	;line no: 8
	SHL SI, 1	;line no: 8
    SUB SI, 200	;line no: 8
    PUSH SI	;line no: 8
    MOV AH, 1	;line no: 8
	INT 21H	;line no: 8
    XOR AH, AH	;line no: 8
    POP SI	;line no: 8
    MOV [BP+SI], AX	;line no: 8
label_6:
	JMP label_4	;line no: 6
label_7:
    CALL PRINT_NEWLINE	;line no: 10
label_8:
    PUSH -202	;line no: 11
    MOV AX, 0	;line no: 11
    PUSH AX	;line no: 11
    POP AX	;line no: 11
    POP SI	;line no: 11
    MOV [BP+SI], AX	;line no: 11
    PUSH AX	;line no: 11
    POP AX	;line no: 11
label_9:
    PUSH -202	;line no: 11
    POP SI	;line no: 11
    PUSH [BP+SI]	;line no: 11
    PUSH -204	;line no: 11
    POP SI	;line no: 11
    PUSH [BP+SI]	;line no: 11
    POP AX	;line no: 11
    POP BX	;line no: 11
    CMP BX, AX
	JL label_11
	JMP label_13
label_10:
    PUSH -202	;line no: 11
    POP SI	;line no: 11
    PUSH [BP+SI]	;line no: 11
	INC W. [BP+SI]	;line no: 11
    POP AX	;line no: 11
	JMP label_9	;line no: 11
label_11:
    PUSH -202	;line no: 13
    POP SI	;line no: 13
    PUSH [BP+SI]	;line no: 13
    POP SI	;line no: 13
	SHL SI, 1	;line no: 13
    SUB SI, 200	;line no: 13
    PUSH SI	;line no: 13
    POP SI	;line no: 13
    MOV AX, [BP+SI]	;line no: 13
    MOV DL, AL	;line no: 13
    MOV AH, 2	;line no: 13
	INT 21H	;line no: 13
label_12:
	JMP label_10	;line no: 11
label_13:
    MOV AX, 0	;line no: 15
    PUSH AX	;line no: 15
    POP AX	;line no: 15
    ADD SP, 204	;line no: 15
    MOV AX, 4CH
    INT 21H
label_14:
    ADD SP, 204	;line no: 3-15
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
