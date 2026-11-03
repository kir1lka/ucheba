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
mov RCAP2H, #high(65100)
mov RCAP2L, #low(65100)
mov TH2, RCAP2H
mov TL2, RCAP2L
;Timer 0 (PWM fill factor) settings
mov 30h, #255
mov 31h, #37
mov DPTR, #PWM_SIN_TABLE
mov TH0, 30h
mov TL0, 31h
;Start PWM
setb TR2
setb TR0
setb P1.0
jmp $

PWM_SIN_TABLE:
DB 255, 37
DB 255, 9
DB 254, 238
DB 254, 211
DB 254, 186
DB 254, 163
DB 254, 141
DB 254, 123
DB 254, 107
DB 254, 94
DB 254, 84
DB 254, 78
DB 254, 75
DB 254, 76
DB 254, 80
DB 254, 88
DB 254, 100
DB 254, 114
DB 254, 132
DB 254, 152
DB 254, 174
DB 254, 198
DB 254, 224
DB 254, 251
DB 255, 23
DB 255, 51
DB 255, 79
DB 255, 106
DB 255, 132
DB 255, 156
DB 255, 178
DB 255, 198
DB 255, 216
DB 255, 230
DB 255, 242
DB 255, 250
DB 255, 254
DB 255, 255
DB 255, 252
DB 255, 246
DB 255, 236
DB 255, 223
DB 255, 207
DB 255, 189
DB 255, 167
DB 255, 144
DB 255, 119
DB 255, 92
DB 255, 65
DB 255, 37
DB 255, 9
END