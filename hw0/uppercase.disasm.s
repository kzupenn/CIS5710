
uppercase.bin:     file format elf32-littleriscv


Disassembly of section .text:

00010074 <_start>:
   10074:	ffff2517          	auipc	a0,0xffff2
   10078:	f8c50513          	addi	a0,a0,-116 # 2000 <__DATA_BEGIN__>

0001007c <convert_loop>:
   1007c:	00054283          	lbu	t0,0(a0)
   10080:	00028a63          	beqz	t0,10094 <end_program>
   10084:	fe028293          	addi	t0,t0,-32
   10088:	00550023          	sb	t0,0(a0)

0001008c <not_lowercase>:
   1008c:	00150513          	addi	a0,a0,1
   10090:	fedff06f          	j	1007c <convert_loop>

00010094 <end_program>:
   10094:	0000006f          	j	10094 <end_program>
