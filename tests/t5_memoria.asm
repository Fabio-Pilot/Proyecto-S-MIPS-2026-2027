# t5: lw y sw con desplazamiento positivo y negativo,
# lb y lbu con bytes que tienen el bit 7 en 1 en las
# posiciones 0 y 2 de la palabra, syscall 11 y 10

        .data
datos:  .word 0x11112222, 0x33334444, 0x55556666
bytes:  .word 0x34F01285

        .text
main:   la   $s0, datos
        addi $s1, $s0, 8

        lw   $a0, 4($s0)        # 33334444
        jal  imprimir
        lw   $a0, -8($s1)       # 11112222
        jal  imprimir

        li   $s2, 100
        sw   $s2, 8($s0)
        lw   $a0, 0($s1)        # 00000064
        jal  imprimir
        li   $s2, -1
        sw   $s2, -4($s1)
        lw   $a0, 4($s0)        # FFFFFFFF
        jal  imprimir

        la   $s3, bytes
        lb   $a0, 0($s3)        # FFFFFF85
        jal  imprimir
        lbu  $a0, 0($s3)        # 00000085
        jal  imprimir
        lb   $a0, 2($s3)        # FFFFFFF0
        jal  imprimir
        lbu  $a0, 2($s3)        # 000000F0
        jal  imprimir

        li   $v0, 10
        syscall

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
