        .section .data
input_string:   .asciz "Hello world!"

        # tohost/fromhost are data locations used by Spike
        .align 8
tohost: .byte 0
        .align 8
fromhost: .byte 0

        
        .section .text
        .globl _start
_start:
        # Load the address of the input string into a0
        la a0, input_string

        # Your code here!

convert_loop:
    lbu t0, 0(a0)

    beqz t0, end_program

    li t1, 'a'
    li t2, 'z'
    sltu t3, t0, t1   # t3 = (t0 < 'a')
    sltu t4, t2, t0   # t4 = ('z' < t0)
    bnez t3, not_lowercase
    bnez t4, not_lowercase

    addi t0, t0, -32
    sb t0, 0(a0)

not_lowercase:
    addi a0, a0, 1

    j convert_loop
        
end_program:
        # jump here when you're done
        j end_program

