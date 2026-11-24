# t1: add y sub con positivos y con negativos,
# and y or con unos en los 16 bits altos,
# escribir en $zero, syscall 11 y 10

        .text
main:   li   $s0, 50
        li   $s1, 8
        li   $s2, -3

        add  $a0, $s0, $s1      # 0000003A
        jal  imprimir
        add  $a0, $s0, $s2      # 0000002F
        jal  imprimir
        sub  $a0, $s0, $s1      # 0000002A
        jal  imprimir
        sub  $a0, $s1, $s0      # FFFFFFD6
        jal  imprimir
        sub  $a0, $s0, $s2      # 00000035
        jal  imprimir

        li   $s3, 0xFFFF0F0F
        li   $s4, 0x12345678
        and  $a0, $s3, $s4      # 12340608
        jal  imprimir
        or   $a0, $s3, $s4      # FFFF5F7F
        jal  imprimir

        add  $zero, $s0, $s1
        move $a0, $zero         # 00000000
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
