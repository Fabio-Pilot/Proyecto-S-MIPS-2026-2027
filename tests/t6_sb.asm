# t6: sb en las 4 posiciones de una palabra y lw
# despues de cada una para ver que los otros bytes
# no cambian, syscall 11 y 10

        .data
palabra: .word 0x11223344

        .text
main:   la   $s0, palabra

        li   $s1, 0xAA
        sb   $s1, 0($s0)
        lw   $a0, 0($s0)        # 112233AA
        jal  imprimir
        li   $s1, 0xBB
        sb   $s1, 1($s0)
        lw   $a0, 0($s0)        # 1122BBAA
        jal  imprimir
        li   $s1, 0xCC
        sb   $s1, 2($s0)
        lw   $a0, 0($s0)        # 11CCBBAA
        jal  imprimir
        li   $s1, 0xDD
        sb   $s1, 3($s0)
        lw   $a0, 0($s0)        # DDCCBBAA
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
