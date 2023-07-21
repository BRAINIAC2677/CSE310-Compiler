
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
	JLE
	JMP
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
