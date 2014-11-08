.include "m8515def.inc"
.def a = r17
.def b = r18
.def c = r19
.def tmp = r20
; b^2
muls b,b
; sekarang r1r0 isinya b^2
; terus karena perkaliannya hasilnya maks 8 bit
; cuman r0 yang guna~
mov b, r0 ; sekarang isinya b adalah b^2
ldi tmp,4 ; tmp = 4
muls tmp,a
mov tmp, r0; tmp = 4*a
muls tmp, c
mov tmp, r0; tmp = 4*a*c
cp b, tmp
brne gaksama
; sama! berarti b^2 - 4ac = 0
ldi tmp, 1
rjmp forever
gaksama:
brlt kecil
; gak lebih kecil, berarti b^2 - 4ac > 0
ldi tmp, 2
rjmp forever
kecil: ldi tmp, 0 ; b^2 - 4ac < 0
forever: rjmp forever
