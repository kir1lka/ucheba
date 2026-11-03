$MOD51
ORG 0h
jmp pre_start

ORG 2Bh

pre_start:
mov P1, #0h
mov R0, #60 ; Job loop count (cicle count)
mov R1, #32 ; Coef light 32=2sec, 16=1sec, etc
mov R2, #16 ; Coef nolight 32=2sec, 16=1sec, etc
mov R3, 1
mov R4, 2

mov TL0, #low(3036)
mov TH0, #high(3036)
mov TL1, #low(3036)
mov TH1, #high(3036)

mov TMOD, #00010001b
;mov TCON, #01010000b
;mov IE, #10001010b

start:

clr P1.3 ;Light ON (1)
setb TCON.4 ;T0 ON (1)
clr TCON.6 ;T1 OFF (1)
mov R4, 2 ;(2)
light_loop:
jnb TCON.5, $ ;(2)
mov TL0, #low(3036);(2)
mov TH0, #high(3036) ;(2)
clr TCON.5
djnz R3, light_loop

setb P1.3 ;Light OFF (1)
setb TCON.6 ;T1 ON (1)
clr TCON.4 ;T0 OFF (1)
mov R3, 1
lightoff_loop:
jnb TCON.7, $ ;Continue (2)
mov TL1, #low(3036);(2)
mov TH1, #high(3036) ;(2)
clr TCON.7;(1)
djnz R4, lightoff_loop

djnz R0, start ;Job interval

jmp $
END