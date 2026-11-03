$MOD51
;RX Controller
ORG 00h
jmp start
ORG 23h
clr RI
reti
ORG 2Bh
start:
mov SCON, #01010000b ;Switch to Serail mode 1
mov PCON, #10000000b ;Enable double speed
mov TMOD, #00100000b ;Switch to T/C1 mode 2
mov IE, #10010000b ; Enable serial interupt
mov IP, #00010000b ; Enable serial interupt priority
mov TL1, #0FFh ;
mov TH1, #0FFh ;Max serial speed
mov TCON, #01000000b ;Enable T/C1 (and serial too)

loop:
jnb RI, $
mov A, SBUF
jmp loop
END