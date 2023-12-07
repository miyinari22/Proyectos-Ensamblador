STACKSEG SEGMENT PARA STACK 'STACK'
    DW 128 DUP (?)
STACKSEG Ends

DATASEG SEGMENT PARA 'DATA'
    LETRERO DB 'MAYUSCULAS A MINUSCULAS Y VICEVERSA', '$'
    CADENA DB 256 DUP (?)
DATASEG Ends

CODIGO SEGMENT PARA 'CODE'
    ASSUME CS:CODIGO, DS:DATASEG, SS:STACKSEG

    CADENA PROC FAR
    PUSH DS
    XOR AX, AX
    PUSH AX
    MOV AX, DATASEG
    MOV DS, AX
    LEA DX, LETRERO
    MOV AH, 09H
    INT 21H

    MOV DL, 0AH
    MOV AH, 02H
    INT 21H
    MOV DL, 0DH
    MOV AH, 02H
    INT 21H

    MOV SI, OFFSET CADENA
    MOV CX, 256

CONVERSION:
    LODSB              ; Carga el siguiente byte de la cadena en AL y avanza SI
    CMP AL, 0          ; Comprueba si es el final de la cadena
    JE FIN             ; Si es el final, salta a FIN

    CMP AL, 'a'
    JL MAYUSCULAS
    CMP AL, 'z'
    JG MAYUSCULAS
    XOR AL, 32         ; Convierte minúscula a mayúscula y viceversa

MAYUSCULAS:
    MOV AH, 02H
    INT 21H            ; Imprime el caracter en pantalla
    LOOP CONVERSION    ; Repite el bucle para el siguiente caracter de la cadena

FIN:
    RET
    CADENA ENDP

CODIGO ENDS
END CADENA
