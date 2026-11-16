$MOD51
; Laboratory 1 / handbook laboratory 2 / RAM option 4.
; 8051: internal program ROM, external 8 KiB SRAM.
; Test 1024 bytes: 1000H through 13FFH, pattern FFH.
; P1.0 = active-high ERROR probe; P1.1 = active-high PASS probe.
; All other P1 bits are left unchanged.
ORG 0000H
    LJMP START

ORG 0030H
START:
    CLR P1.0             ; Clear ERROR indication.
    CLR P1.1             ; Clear PASS indication.
    MOV P0,#0FFH         ; Release external multiplexed address/data bus.
    MOV P2,#0FFH         ; Enable external high-address bus functions.
    SETB P3.6            ; Release /WR for hardware bus control.
    SETB P3.7            ; Release /RD for hardware bus control.
    MOV DPTR,#1000H      ; First address to test.
    MOV R6,#04H          ; Four blocks of 256 bytes.
    MOV R7,#00H          ; DJNZ from zero produces 256 iterations.
RAM_LOOP:
    MOV A,#0FFH          ; Required pattern for option 4.
    MOVX @DPTR,A         ; Write one byte to external SRAM.
    MOVX A,@DPTR         ; Read the same byte back.
    XRL A,#0FFH          ; Zero means actual byte equals pattern.
    JNZ RAM_ERROR        ; Stop at first mismatch, DPTR = failing address.
    INC DPTR             ; Advance only after successful verification.
    DJNZ R7,RAM_LOOP     ; 256 bytes per block; R7 finishes at zero.
    DJNZ R6,RAM_LOOP     ; Reuse zero R7 for the next 256-byte block.
    SETB P1.1            ; PASS: all 1024 comparisons succeeded.
    SJMP RAM_HALT        ; DPTR = 1400H, R6 = R7 = A = 0.
RAM_ERROR:
    SETB P1.0            ; ERROR: A is the XOR difference, P1.1 stays 0.
RAM_HALT:
    SJMP RAM_HALT        ; Stable final state for Memory view/probes.
END
