$MOD51
org 00h

clr P1.0
clr P1.1
mov dptr,#0C00h
mov r1,#12h

test:
mov a,r1
movx @dptr, a
movx a,@dptr
xrl a,r1
jnz error

inc dptr

mov a, dph
cjne a, #10h, test

setb P1.1
jmp program_end

error:
setb P1.0
program_end:
sjmp $
END