$MOD52
ORG 00h
jmp pre_start

ORG 0Bh
jmp TC_0_interupt_handler

ORG 2Bh
jmp TC_2_interupt_handler

ORG 33h
pre_start:
mov TH2, #HIGH(33441) ;Period time correct (for 11 MHz)
mov TL2, #LOW(33441)
mov RCAP2H, TH2
mov RCAP2L, TL2
mov TMOD, #00000010b ;Set T/C0 to autoreload
mov IE, #10100010b ;Enable global and timers interupt
setb TR2 ;Enable timer
jmp $ ;Do nothing


TC_0_interupt_handler:
clr TF0 ;Clear overflow flag
reti

TC_2_interupt_handler:
jb P1.0, bit_off
setb P1.0
jmp TC_2_interupt_exit
bit_off:
clr P1.0
TC_2_interupt_exit:
clr TF2 ;Clear overflow flag
clr EXF2
reti
END