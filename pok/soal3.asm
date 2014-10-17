lw $t0, 0($s1)
lw $t1, 0($s2)
add $t3, $t0, $zero
add $t4, $t1, $zero
loop: beq $t0, $t1, save
slt $t2, $t0, $t1
beq $t2, $zero, lebih
add $t0, $t0, $t3
j loop
lebih: add $t1, $t1, $t4
j loop
save: sw $t0, 0($s3)