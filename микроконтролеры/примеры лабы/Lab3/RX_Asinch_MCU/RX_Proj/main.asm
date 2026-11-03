$MOD51	; This includes 8051 definitions for the Metalink assembler
;RX controller
ORG 00h
jmp pre_start
ORG 23h
clr RI
reti
ORG 2Bh
pre_start:
    mov SCON, #01000000b
	;mov PCON, #10000000b ;Enable double speed
	setb REN
	mov TMOD, #00100000b 
    mov IE, #10010000b 
	setb TCON.6
	setb IP.4  
    mov R0, #14h  
    mov R1, #60h  
	mov TL1, #0FBh
	mov TH1, #0FBh
	setb TR1  
met:
    jnb RI, met
    mov A,SBUF  
    mov @R1, A   
    inc R1   
    djnz R0, met    
sjmp $
END