lw $t0,0($s0)
lw $t1,4($s0)
bne $s1, $zero, balikin
add $t0, $t0, $a0
addi $t2, $t2, 6
slt $t2, $t0, $t2
beq $t2, $zero, gabisa
addi $s2, $zero, 1
sw $t0, 0($s0)
j exit
gabisa: add $s2, $zero, $zero
j exit
balikin: sub $t2, $a3, $a1
beq $t2, $zero, bulansama
slt $t3, $zero, $t2
beq $t3, $zero, lanjutgan
addi $t2, $t2, -1
sll $t3, $t2, 5
sub $t3, $t3, $t2
add $t3, $t3, $a2
addi $t3, $t3, 31
sub $t3, $t3, $a0
j lanjutgan
bulansama: slt $t3, $a0, $a2
beq $t3, $zero, lanjutgan
sub $t3, $a2, $a0
lanjutgan: addi $t0, $t0, -1
sw $t0, 0($s0)
add $t3, $t3, $t1
sw $t3, 4($s0)
exit: j exit
