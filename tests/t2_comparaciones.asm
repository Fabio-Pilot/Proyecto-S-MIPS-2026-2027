# t2: slt y slti con resultado 1 y 0, con un negativo
# (con signo y sin signo dan distinto), syscall 11 y 10

        .text
main:   li   $s0, -5
        li   $s1, 10

        slt  $a0, $s0, $s1      # 00000001
        jal  imprimir
        slt  $a0, $s1, $s0      # 00000000
        jal  imprimir
        slti $a0, $s0, 3        # 00000001
        jal  imprimir
        slti $a0, $s1, 3        # 00000000
        jal  imprimir
        slti $a0, $s1, -1       # 00000000
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
