$MOD51
;TX controller
org 00h
jmp pre_start
org 23h
clr TI
reti
org 60h
tabl:
	DB 11001101b,2,3,4,5,06,07,08,09,10
pre_start:
	mov SCON, #01000010b ; Enable serial first mode
	;mov PCON, #10000000b ;Enable double speed
	mov TMOD, #00100000b ; Enable T/C1 2 mode
	mov IE, #10010000b ; Enable serial interupt
	mov IP, #00010000b ; Enable serial interupt priority
	mov TL1, #0FBh
	mov TH1, #0FBh
	setb TR1
	mov R1, #0h
	mov R0, #10
	mov DPTR, #tabl
met1:
	mov A, R1
	movc A, @A+DPTR
	inc DPTR
	mov SBUF, A
met2:
	jnb TI, met2
djnz R0, met1
exit:
	sjmp $
END