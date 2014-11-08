.include "m8515def.inc"
.def a = r1
.def b = r2
.def tmpa = r18
.def tmpb = r19
.def selesai = r20
.def hasil = r17
ldi selesai, 0
mov tmpa, a
mov tmpb, b
loop: cpi selesai, 0
brne exit
cp tmpa, tmpb
brne gaksama
; tmpa == tmpb
mov hasil, tmpa
ldi selesai, 1
rjmp loop
gaksama: brlt kecil
; tmpa > tmpb
add tmpb, b
rjmp loop
; tmpa < tmpb
kecil: add tmpa, a
rjmp loop
exit: rjmp exit
