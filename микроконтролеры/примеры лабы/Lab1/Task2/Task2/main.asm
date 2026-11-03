$MOD51
ORG 00h

clr P1.0
clr P1.1
mov dptr, #2000h
mov r7, #244
mov r6, #2
mov r5, #00h

loop:
clr a
movc a, @a+dptr
add a, r5
mov r5, a
inc dptr

djnz r7, loop
;mov r7, #100
djnz r6, loop

cjne r5,#15,error
setb P1.1
jmp program_end

error:
setb P1.0
program_end:
sjmp $
ORG 2000h
DB 1,2,3,4,5
END