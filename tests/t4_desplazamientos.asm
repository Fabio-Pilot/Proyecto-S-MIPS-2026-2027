# t4: sll y srl con shamt 0 y distinto de 0,
# srl sobre un negativo (entran ceros), syscall 11 y 10

        .text
main:   li   $s0, 0xF0000081

        sll  $a0, $s0, 0        # F0000081
        jal  imprimir
        sll  $a0, $s0, 4        # 00000810
        jal  imprimir
        srl  $a0, $s0, 0        # F0000081
        jal  imprimir
        srl  $a0, $s0, 4        # 0F000008
        jal  imprimir
        srl  $a0, $s0, 28       # 0000000F
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
