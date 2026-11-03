$MOD51
; Laboratory 1 / handbook laboratory 2 / ROM option 10.
; 8051: 4 KiB internal program ROM; external 8 KiB EPROM in XDATA.
; EA must be HIGH. External EPROM /OE = /RD, /CE = GND.
; Load ROM8K.bin or ROM8K.hex INTO THE EXTERNAL EPROM component.
; Sum 150 bytes at 0C00H..0C95H, modulo 256.
; Data: 01 02 03 04 05 at 0C00H..0C04H, all other ROM bytes = 00.
; MOVX selects XDATA; MOVC below 1000H would select internal CODE ROM.
; P1.0 = active-high ERROR probe; P1.1 = active-high PASS probe.
ORG 0000H
    LJMP START

ORG 0030H
START:
    CLR P1.0             ; Clear ERROR indication.
    CLR P1.1             ; Clear PASS indication.
    MOV P0,#0FFH         ; Release external address/data bus.
    MOV P2,#0FFH         ; Enable high-address bus functions.
    SETB P3.7            ; Release /RD for hardware XDATA read control.
    MOV DPTR,#0C00H      ; First external EPROM address in XDATA space.
    MOV R5,#00H          ; Eight-bit running checksum.
    MOV R6,#00H          ; Unused in this single-byte-count test.
    MOV R7,#096H         ; Exactly 150 bytes, 096H = 150 decimal.
ROM_LOOP:
    MOVX A,@DPTR         ; Read external EPROM through /RD in XDATA space.
    ADD A,R5             ; Carry beyond bit 7 is intentionally discarded.
    MOV R5,A             ; Save checksum modulo 256.
    INC DPTR
    DJNZ R7,ROM_LOOP     ; End of range: DPTR = 0C96H after 150 reads.
    MOV DPTR,#REFERENCE  ; Reference is inside internal program ROM.
    CLR A
    MOVC A,@A+DPTR       ; Read the resident reference byte, not external ROM.
    XRL A,R5             ; Zero means checksum matches reference.
    JNZ ROM_ERROR
    SETB P1.1            ; PASS: R5 = 0FH, A = 0, R6 = R7 = 0.
    SJMP ROM_HALT
ROM_ERROR:
    SETB P1.0            ; ERROR: nonzero XOR difference, P1.1 stays 0.
ROM_HALT:
    SJMP ROM_HALT        ; Stable state for observing checksum/probes.

ORG 0300H                ; 0300H is within the 8051 internal 4 KiB ROM.
REFERENCE:
    DB 0FH               ; (1 + 2 + 3 + 4 + 5) modulo 256 = 15.
END
