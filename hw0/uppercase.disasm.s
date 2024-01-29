
uppercase.bin:     file format elf32-littleriscv


Disassembly of section .text:

00010074 <_start>:
   10074:	ffff2517          	auipc	a0,0xffff2
   10078:	f8c50513          	addi	a0,a0,-116 # 2000 <__DATA_BEGIN__>

0001007c <convert_loop>:
   1007c:	00054283          	lbu	t0,0(a0)
   10080:	02028663          	beqz	t0,100ac <end_program>
   10084:	06100313          	li	t1,97
   10088:	07a00393          	li	t2,122
   1008c:	0062be33          	sltu	t3,t0,t1
   10090:	0053beb3          	sltu	t4,t2,t0
   10094:	000e1863          	bnez	t3,100a4 <not_lowercase>
   10098:	000e9663          	bnez	t4,100a4 <not_lowercase>
   1009c:	fe028293          	addi	t0,t0,-32
   100a0:	00550023          	sb	t0,0(a0)

000100a4 <not_lowercase>:
   100a4:	00150513          	addi	a0,a0,1
   100a8:	fd5ff06f          	j	1007c <convert_loop>

000100ac <end_program>:
   100ac:	0000006f          	j	100ac <end_program>
