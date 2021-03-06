;if (a^3 > b^2){
;  if(c*d == a/b){
;     result = a AND b
;  } else{
;     result = c
;  }
;} else {
;  result = c*d+b
;}

model small
.stack 100h
.data
a dw 3
b dw 13
c dw 14
d dw 17

.code
start:
   MOV AX, @data
   MOV DS, AX
   
   MOV AX, a
   MUL a
   MUL a
   MOV BX, AX
   MOV AX, b
   MUL b
   
   CMP BX, AX  ; if(a^3 > b^2)
   JB next     ;goto next if
   
   MOV AX, c
   MUL d
   ADD AX, b
   JMP all	  
   
 next:
   MOV AX, c
   MUL d
   MOV BX, AX
   MOV AX, a
   DIV b
   
   CMP AX, BX     ;if(c*d == a/b)
   JZ firstresult ;return result = a AND b
   
   MOV AX, c      ;else retun result = c
   JMP all
   
 firstresult:
   MOV AX, a
   AND AX, b
   
 all:
   MOV AH, 4Ch
   INT 21h
end start
