.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
text: .string "The dot product is: "
newline: .string "\n"

.text
main:
# Registers NOT to be used x0 to x4 and x10 to x17; reason to be explained later
# Registers that we can use x5 to x9 and x18 to x31; reason to be explained later

    addi x5, x0, 5 # let x5 be size and set it to 5
    addi x6, x0, 0 # let x6 be sum of dot product and set it to 0(sop)
    addi x7, x0, 0 # let x7 be multiplication of each values and set it to 0

#    for(i = 0; i < size; i++)
#       sop += a[i] * b[i];
    addi x8, x0, 0 # let x8 be i and set it to 0
    la x9, a # loading the address of a to x9
    la x20 , b # loading the address of b to x20

loop1:
    bge x8, x5, exit1 # check if i >= size, if so goto exit1
    # we need to calculate &arr1[i]
    # we need the base address of arr1
    # then, we add an offset of i*4 to the base address
    slli x18, x8, 2 # set x18 to i*4
    add x23, x18, x9 # add i*4 to the base address off a
    add x24, x18, x20 # add i*4 to the base address off b
    lw x21, 0(x23) # load value in a into x21
    lw x22, 0(x24) # load value in b into x22
    mul x7, x21, x22 # x7 = a[i] * b[i]
    add x6, x6, x7 # sop += a[i] * b[i]
    addi x8, x8, 1 # i++
    j loop1

exit1:
    # print a text character; use print_string
    addi a0, x0, 4
    la a1, text
    ecall

    # print_int; print dot product(sop)
    addi a0, x0, 1
    add a1, x0, x6
    ecall

    # print a newline character; use print_string
    addi a0, x0, 4
    la a1, newline
    ecall

    # exit cleanly
    addi a0, x0, 10
    ecall