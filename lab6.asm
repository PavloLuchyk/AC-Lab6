IDEAL
MODEL small
STACK 256
;-----------------------------------------------------------------------------------------------------------
MACRO McROSS ; init macros
    mov ax, @data
    mov ds, ax
    mov es, ax
ENDM
;-----------------------------------------------------------------------------------------------------------
DATASEG
team_number db "team 5:", 10,13, '$' ; 
luchyk db "Luchyk Pavlo", 10,13, '$' ; 
yakubov db "Yakubov Dmytro", 10,13, '$' ; 
tajibaev db "Tajibaev Shamil", 10,13, '$' ; 
;-----------------------------------------------------------------------------------------------------------
CODESEG
Start: 
McROSS

push ds
mov ah, 25h
mov al, 55h                         ; номер вектора переривання
lea dx, Interrupt               	; 
mov bx, seg Interrupt                            
mov ds, bx
int 21h                             ; підключення 55h
pop ds

int 55h                              ; виклик переривання

mov ah, 4ch                          ; завантаження 4ch до ah
mov al, 0h                           ;	отримання коду виходу
int 21h                              ; виклик DOS 4ch для виходу

proc Interrupt far                ; процедура переривання
    mov dx, offset team_number        ; написання повідомлення в dx
    mov ah, 09h                      ; завантаження 09h до реєстру 
    int 21h                          ; виклик переривання для виведення повідомлення
    mov dx, offset luchyk
    int 21h
    mov dx, offset yakubov
    int 21h                                                                                                         
    mov dx, offset tajibaev
    int 21h

IRET                                 ; повернення з переривання за допомогою IRET
endp Interrupt
end Start