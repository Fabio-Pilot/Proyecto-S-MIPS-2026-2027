# t3: addi con inmediato negativo, li (addiu) con -32768
# y 32767, move (addu), andi, ori y lui con el bit 15
# del inmediato en 1, syscall 11 y 10

        .text
main:   li   $s0, 20
        li   $s1, -1

        addi $a0, $s0, -25      # FFFFFFFB
        jal  imprimir
        li   $a0, -32768        # FFFF8000
        jal  imprimir
        li   $a0, 32767         # 00007FFF
        jal  imprimir
        move $a0, $s0           # 00000014
        jal  imprimir
        andi $a0, $s1, 0x8F00   # 00008F00
        jal  imprimir
        ori  $a0, $s0, 0x8000   # 00008014
        jal  imprimir
        lui  $a0, 0xF00F        # F00F0000
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
