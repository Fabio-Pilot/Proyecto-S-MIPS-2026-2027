# t7: beq y bne tomados y no tomados, bucle con salto
# hacia atras, j, jal y jr con un procedimiento que
# llama a otro (guarda $ra en la pila), syscall 11 y 10

        .text
main:   li   $s0, 4
        li   $s1, 4
        li   $s2, 9
        li   $s3, 0

        beq  $s0, $s1, b1       # se toma
        addi $s3, $s3, 1
b1:     beq  $s0, $s2, b2       # no se toma
        addi $s3, $s3, 2
b2:     bne  $s0, $s2, b3       # se toma
        addi $s3, $s3, 4
b3:     bne  $s0, $s1, b4       # no se toma
        addi $s3, $s3, 8
b4:     move $a0, $s3           # 0000000A
        jal  imprimir

        li   $s4, 5
        li   $s5, 0
bucle:  add  $s5, $s5, $s4
        addi $s4, $s4, -1
        bne  $s4, $zero, bucle
        move $a0, $s5           # 0000000F
        jal  imprimir

        li   $s6, 7
        j    sigue
        li   $s6, 0
sigue:  move $a0, $s6           # 00000007
        jal  imprimir

        li   $a0, 21
        jal  doble              # 0000002A
        move $a0, $sp           # 00003FFC
        jal  imprimir

        li   $v0, 10
        syscall

# imprime el doble de $a0, llama a imprimir
doble:  addi $sp, $sp, -4
        sw   $ra, 0($sp)
        add  $a0, $a0, $a0
        jal  imprimir
        lw   $ra, 0($sp)
        addi $sp, $sp, 4
        jr   $ra

# imprime $a0 en hexadecimal y salta de linea
imprimir:
        move $t0, $a0
        li   $t1, 8
otro:   srl  $t2, $t0, 28
        slti $t3, $t2, 10
        beq  $t3, $zero, letra
        addi $a0, $t2, 48
        j    poner
letra:  addi $a0, $t2, 55
poner:  li   $v0, 11
        syscall
        sll  $t0, $t0, 4
        addi $t1, $t1, -1
        bne  $t1, $zero, otro
        li   $a0, 10
        li   $v0, 11
        syscall
        jr   $ra
