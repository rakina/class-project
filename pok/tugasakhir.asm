.include "m8515def.inc"
.
.def temp =r16	; Define temporary variable -> will be used to mark row
.def temp2 = r17 ; second temporary variable -> will be used for column mask
.def temp3 = r15 ; third temporary variable -> to backup other variables
.def PB = r18	; for PORTB
.def A  = r19
.def baris1 = r20
.def baris2 = r21
.def baris3 = r22
.def kepake1 = r23
.def kepake2 = r24
.def kepake3 = r25

; PORTB as DATA
; PORTA.0 as EN
; PORTA.1 as RS
; PORTA.2 as RW

;.cseg
;.org $e50f


START:	
	ldi	temp,low(RAMEND) ; Set stack pointer to -
	out	SPL,temp		 ; -- last internal RAM location
	ldi	temp,high(RAMEND)
	out	SPH,temp

	rcall INIT_LCD
	rcall CLEAR_LCD

	ldi	temp,$ff
	out	DDRA,temp	; Set port A as output
	out	DDRB,temp	; Set port B as output

	ldi	ZH,high(2*message)	; Load high part of byte address into ZH
	ldi	ZL,low(2*message)	; Load low part of byte address into ZL
	
INIT_TICTACTOE:	
	ldi baris1, 0b100
	ldi baris2, 0b000
	ldi baris3, 0b100
	ldi kepake1, 0b010
	ldi kepake2, 0b010
	ldi kepake3, 0b010
	ldi temp, 1
	ldi temp2, 1

LOADBYTE:
	lpm				; Load byte from program memory into r0
	tst	r0			; Check if we've reached the end of the message
	breq quit		; If so, quit
	mov A, r0		; Put the character onto Port B
	cpi A, 32
	breq enter
	rcall WRITE_TEXT
	adiw ZL,1		; Increase Z registers
	rjmp LOADBYTE


QUIT:	rjmp QUIT

WAIT_LCD:
;	ldi	r20, 255
;	ldi	r21, 255
;	ldi	r22, 255

CONT:	
;	dec	r22
;	brne	CONT
;	ldi	r22, 2
;	dec	r21
;	brne	CONT
;	ldi	r21, 2
;	dec	r20
;	brne	CONT
;	ldi	r20, 2
	ret

INIT_LCD:
	cbi PORTA,1	; CLR RS
	ldi PB,0x38	; MOV DATA,0x38 --> 8bit, 2line, 5x7
	out PORTB,PB
	sbi PORTA,0	; SETB EN
	cbi PORTA,0	; CLR EN
	rcall WAIT_LCD
	cbi PORTA,1	; CLR RS
	ldi PB,$0E	; MOV DATA,0x0E --> disp ON, cursor ON, blink OFF
	out PORTB,PB
	sbi PORTA,0	; SETB EN
	cbi PORTA,0	; CLR EN
	rcall WAIT_LCD
	cbi PORTA,1	; CLR RS
	ldi PB,$06	; MOV DATA,0x06 --> increase cursor, display sroll OFF
	out PORTB,PB
	sbi PORTA,0	; SETB EN
	cbi PORTA,0	; CLR EN
	rcall WAIT_LCD
	ret

CLEAR_LCD:
	cbi PORTA,1	; CLR RS
	ldi PB,$01	; MOV DATA,0x01
	out PORTB,PB
	sbi PORTA,0	; SETB EN
	cbi PORTA,0	; CLR EN
	rcall WAIT_LCD
	ret

enter:
	adiw ZL,1
	cbi PORTA, 1
	mov temp3, temp2
	ldi temp2, 0b10010100
	cpi temp,2
	breq enter2
 	ldi temp2, 0b11000000 ; rewrite previous, dia bukan dari baris 2 soalnya
	enter2: 
    out PORTB, temp2
	sbi PORTA, 0
	cbi PORTA, 0
	subi temp, -1; temp++
	mov temp2, temp3
	ldi temp2, 1; temp2 = 1
	rjmp LOADBYTE	
	
WRITE_TEXT:
	sbi PORTA,1	; SETB RS
	mov temp3, temp2
	
	cpi temp, 2
	breq dibaris2
	cpi temp, 3
	breq dibaris3
	
	dibaris1:
		mov temp2, kepake1
		and temp2, temp3
		cpi temp2, 0
		breq underscore
		mov temp2, baris1
		and temp2, temp3
		cpi temp2, 0
		breq outputO
		rjmp outputX
		
	dibaris2:
		mov temp2, kepake2
		and temp2, temp3
		cpi temp2, 0
		breq underscore
		mov temp2, baris2
		and temp2, temp3
		cpi temp2, 0
		breq outputO
		rjmp outputX
		
	dibaris3:
		mov temp2, kepake3
		and temp2, temp3
		cpi temp2, 0
		breq underscore
		mov temp2, baris3
		and temp2, temp3
		cpi temp2, 0
		breq outputO
		rjmp outputX
		
	outputO:
		ldi A, 79
		rjmp udahan
	outputX:
		ldi A, 88
		rjmp udahan
	underscore:
		ldi A, 95
	udahan:
	out PORTB, A
	sbi PORTA,0	; SETB EN
	cbi PORTA,0	; CLR EN
	mov temp2, temp3
	add temp2, temp2 ; temp2 = temp2 * 2
;	rcall WAIT_LCD
	ret


message:
.db	"xxx xxx xxx"
.db	0,0

