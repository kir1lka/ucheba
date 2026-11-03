$MOD51
ORG 00h
jmp pre_start

ORG 0Bh ;T/C 0 interupt vector
jmp TC0_interupt_handler

ORG 1Bh ;T/C 1 interupt vector
jmp TC1_interupt_handler

ORG 2Bh
pre_start:
mov IE, #10001010b
mov TMOD, #00100010b
;mov TCON, #01010000b ;Enable all timers

mov R0, #60 ; Job loop count (cicle count)
mov R1, #32 ; Coef light 32=2sec, 16=1sec, 4=0.25sec, etc
mov R2, #16 ; Coef nolight 32=2sec, 16=1sec, 4=0.25sec, etc
mov R3, 1 ;Copy R1 
mov R4, 2 ;Copy R2
mov R5, #250 ; Constant for loop
mov R6, 5 ; Copy R6
mov P1, #0h ; Clear P1

mov TL0, #6
mov TH0, #6
mov TL1, #6
mov TH1, #6

setb TCON.4 ;T0 ON

start:
jmp start ;Do nothing

TC0_interupt_handler:
djnz R6, TC0_interupt_exit
mov R6, 5
djnz R3, TC0_interupt_exit

setb P1.3 ;Light OFF
setb TCON.6 ;T1 ON
clr TCON.4 ;T0 OFF
mov R4, 2
mov TL0, #0

TC0_interupt_exit:
clr TCON.5 ;Clear overflow flag
reti

TC1_interupt_handler:
djnz R6, TC1_interupt_exit
mov R6, 5
djnz R4, TC1_interupt_exit

clr P1.3 ;Light ON
setb TCON.4 ;T0 ON
clr TCON.6 ;T1 OFF
mov R3, 1
mov TL1, #0

djnz R0, TC1_interupt_exit
mov TCON, #0

TC1_interupt_exit:
clr TCON.7 ;Clear overflow flag
reti

jmp $
END