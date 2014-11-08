.include "m8515def.inc"
.def a = r16
.def amin1 = r15
.def hasil = r0
; program ini ngecek apakah a = 2^k u/ k bilangan bulat dan a positif
; berdasarkan teorema gatau dari mana, a = 2^k jika dan hanya jika
; a & (a-1) = 0 yaudah jadi kita ngecek itu
ldi a, 13 ; masukin nilai a, harus positif
mov amin1, a
dec amin1
and amin1, a ; amin1 &= a
clr hasil
or hasil, amin1 ; kalau hasil != 0, berarti a itu != 2^k, kalau iya berarti a = 2^k
forever:
rjmp forever
