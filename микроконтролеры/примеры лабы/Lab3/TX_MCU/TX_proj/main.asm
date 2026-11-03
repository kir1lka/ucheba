$MOD51
ORG 00h
jmp pre_start

ORG 23h ;Serial interupt vector
jb TI, transmiting
clr RI
reti

ORG 2Bh
pre_start:
mov IE, #10010000b ;Enable only Serial interupt

start:
mov 30h, #70h ;Address of BASE
mov 31h, #10 ;Number of bytes to transive
acall calculate_control_sum
mov SBUF, 31h ;init transmit

jmp $ ;Program end

calculate_control_sum:
mov R7, 30h ;Copy address of BASE
mov R6, 31h ;Copy number of bytes
mov DPTR, #0
loop:
mov A, R7
movc A, @A+DPTR
addc A, 32h
mov 32h, A
inc R7
djnz R6, loop
ret

transmiting:
djnz 31h, byte_transmit ;Bytes counter
;control_sum_transmit
mov SBUF, 32h
jmp transmit_int_end

byte_transmit:
mov DPTR, #0
mov A, 30h

;Transmit process
movc A, @A+DPTR ;get byte from ROM
mov SBUF, A
inc 30h

transmit_int_end:
clr TI
reti

ORG 70h
DB 1,2,3,4,5,6,7,8,9,10
ORG 80h
DB 2,4,8
END