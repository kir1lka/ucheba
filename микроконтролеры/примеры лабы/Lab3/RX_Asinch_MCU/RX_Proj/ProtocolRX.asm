$MOD51
;RX Controller
ORG 00h
jmp pre_start

ORG 23h ;Serial interupt vector
jb RI, receiving
clr TI
reti

ORG 2Bh
pre_start:
mov IE, #10010000b ;Enable only Serial interupt
mov SCON, #00010000b ;Enable receive

start:
mov 30h, #40h ;Address of BASE to receive
mov 32h, #0 ;Clear CSUM
jnb 0, $ ;Wait to end receive
acall calculate_control_sum
jmp $

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

receiving:
clr RI
jb 1, receive_data_byte
mov 31h, SBUF
setb 1
jmp receive_int_end

receive_data_byte:
mov R0, 30h
mov @R0, SBUF
inc 30h
dec 31h

receive_int_end:
reti
END