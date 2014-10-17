addi $t1, $s1, -1
loop: slt $t0, $t1, $zero,  
bne $t0, $zero, exit
add $t2, $zero, $zero
add $t3, $zero, $zero
loop2: beq $t3, $t1, checkswap
sll $t0, $t3, 2
add $t0, $t0, $s0
lw $t4, 0($t0)
lw $t5, 4($t0)
slt $t6, $t5, $t4
beq $t6, $zero, next
sw $t5, 0($t0)
sw $t4, 4($t0)
addi $t2, $zero, 1
next: addi $t3, $t3, 1
j loop2
checkswap: beq $t2, $zero, exit
addi $t1, $t1, -1
j loop
exit: j exit