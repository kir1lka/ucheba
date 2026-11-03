$MOD52
ORG 00h
jmp pre_start

ORG 0Bh
jmp TC_0_interupt_handler

ORG 2Bh
jmp TC_2_interupt_handler

ORG 32h
TC_0_interupt_handler:
clr P1.0
clr TR0
clr TF0
reti

TC_2_interupt_handler:
setb P1.0
mov TH0, 30h
mov TL0, 31h
setb TR0
mov A, 32h
movc A, @A+DPTR
mov 30h, A
inc 32h
mov A, 32h
movc A, @A+DPTR
mov 31h, A
inc 32h
mov A, 32h
cjne A, #100, TC_2_interupt_exit
mov 32h, #0

TC_2_interupt_exit:
clr TF2
reti

pre_start:
;Global settings
mov IE, #10100010b
mov TMOD, #00000001b ;Set Timer 0 to 16bit
;Timer 2 (period timer) settings
;mov T2CON, #0
mov RCAP2H, #high(20000)
mov RCAP2L, #low(20000)
mov TH2, RCAP2H
mov TL2, RCAP2L
;Timer 0 (PWM fill factor) settings
mov 30h, #high(42767)
mov 31h, #low(42767)
mov DPTR, #PWM_SIN_TABLE
mov TH0, 30h
mov TL0, 31h
;Start PWM
setb TR2
setb TR0
setb P1.0
jmp $

PWM_SIN_TABLE:
DB 167, 15
DB 155, 233
DB 144, 241
DB 134, 82
DB 124, 54
DB 114, 200
DB 106, 45
DB 98, 136
DB 91, 247
DB 86, 150
DB 82, 121
DB 79, 178
DB 78, 76
DB 78, 76
DB 79, 178
DB 82, 121
DB 86, 150
DB 91, 247
DB 98, 136
DB 106, 45
DB 114, 200
DB 124, 54
DB 134, 82
DB 144, 241
DB 155, 233
DB 167, 15
DB 178, 53
DB 189, 45
DB 199, 204
DB 209, 232
DB 219, 86
DB 227, 241
DB 235, 150
DB 242, 39
DB 247, 136
DB 251, 165
DB 254, 108
END