.text
main:
    # pass the first argument to a0
    addi a0, x0, 110
    # pass the second argument to a1
    addi a1, x0, 50
    jal mult # goto mult

    mv a1, a0
    addi a0, x0, 1
    ecall

    # exit cleanly
    addi a0, x0, 10
    ecall

mult:
    # base case
    # compare a1 with 1. if the two are equal you exit the mult function
    li t0, 1
    beq a1, t0, exit_base_case

    # recursive case
    addi sp, sp, -4
    sw ra, 0(sp)    # storing the ra value on the stack

    # mult(a, b-1)
    addi sp, sp, -4
    sw a0, 0(sp)
    addi a1, a1, -1    # b-1
    jal mult

    # a + mult(a, b-1)
    mv t1, a0
    lw a0, 0(sp)
    addi sp, sp, 4
    add a0, a0, t1 # where t1 is the result from mult(a, b-1)

    lw ra, 0(sp)
    addi sp, sp, 4
    jr ra


 exit_base_case:
    jr ra
