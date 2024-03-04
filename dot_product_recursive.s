.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
size: .word 5
text: .string "The dot product is: "
newline: .string "\n"

.text
main:
    # pass the first argument to a0
    la a0, a
    # pass the second argument to a1
    la a1, b
    # pass the third argument to a2
    lw a2, size
    jal dot # goto dot

    # store r0(result)
    mv t1, a0

    # print a text character; use print_string
    addi a0, x0, 4
    la a1, text
    ecall

    # print the result
    mv a1, t1
    li a0, 1
    ecall

    # exit cleanly
    addi a0, x0, 10
    ecall

dot:
    # base case
    # compare a1 with 1. if the two are equal you exit the mult function
    li t0, 1
    beq a2, t0, exit_base_case

    # recursive case
    addi sp, sp, -4
    sw ra, 0(sp)    # storing the ra value on the stack

    # dot_product_recursive(a+1, b+1, size-1)
    addi sp, sp, -4
    sw a0, 0(sp)
    addi sp, sp, -4
    sw a1, 0(sp)
    addi a0, a0, 4  # a+1(4 bytes)
    addi a1, a1, 4  # b+1(4 bytes)
    addi a2, a2, -1 # size-1
    jal dot

    # a[0]*b[0] + dot_product_recursive(a+1, b+1, size-1);
    lw t1, 0(sp)
    lw t1, 0(t1)
    addi sp, sp, 4
    lw t2, 0(sp)
    lw t2, 0(t2)
    addi sp, sp, 4
    mul t3, t2, t1
    add a0, a0, t3 # where t3 is the result from dot_product_recursive(a+1, b+1, size-1)

    # exit from recursive case
    lw  ra, 0(sp)    # restore ra
    addi sp, sp, 4   # restore stack pointer
    jr  ra

exit_base_case:
    lw t4, 0(a0)
    lw t5, 0(a1)
    mul a0, t4, t5
    jr  ra
    