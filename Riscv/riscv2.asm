.data 
.text
.globl main
main:
li s0, 0
li s1, 1
li s2, 2
li s3, 3
li s4, 4
li s5, 5
li s6, 6
li s7, 7
li a6, 0x00003C60#io�����ַ
li a7, 0x00003C70#io�����ַ
li a4, 0x00003C80#ioȷ����ť
li t6, 0x00002000#���ݶο�ʼ�ĵ�ַ

SelectChoice:
lw a0, 0(a7)#������Ա��
lw a1, 0(a4)
beq a1, zero, SelectChoice
li a1, 0
sw zero, 0(a4)#����

beq a0, s0, test0
beq a0, s1, test1
beq a0, s2, test2
beq a0, s3, test3
beq a0, s4, test4
beq a0, s5, test5
beq a0, s6, test6
beq a0, s7, test7

test0:
input01:
lw a2, 0(a7)
beq a1, zero, input01
li a1, 0
sw zero, 0(a4)#����
input02:
lw a3, 0(a7)
beq a1, zero, input02
li a1, 0
sw zero, 0(a4)#����
output0:
sw a2, 0(a6)
sw a3, 0(a6)
beq a1, zero, output0
li a1, 0
sw zero, 0(a4)#����
j SelectChoice

test1:
input11:
lw a2, 0(a7)
beq a1, zero, input11
li a1, 0
sw zero, 0(a4)#����
lb t0, 0(a2)
sw t0, 0(a6)
output1:
sw t0, 0(a6)
beq a1, zero, output1
li a1, 0
sw zero, 0(a4)#����
j SelectChoice

test2:
input21:
lw a3, 0(a7)
beq a1, zero, input21
li a1, 0
sw zero, 0(a4)#����
lbu t0, 0(a3)
sw t0, 4(t6)
output2:
sw t0, 0(a6)
beq a1, zero, output2
li a1, 0
sw zero, 0(a4)#����
j SelectChoice

test3:
lw t1, 0(t6)
lw t2, 4(t6)
beq t1, t2, show
sw zero, 0(a6)
beq a1, zero, show
li a1, 0
sw zero, 0(a4)#����
j SelectChoice

test4:
lw t1, 0(t6)
lw t2, 4(t6)
blt t1, t2, show
sw zero, 0(a6)
beq a1, zero, show
li a1, 0
sw zero, 0(a4)#����
j SelectChoice

test5:
lw t1, 0(t6)
lw t2, 4(t6)
bge t1, t2, show
sw zero, 0(a6)
beq a1, zero, show
li a1, 0
sw zero, 0(a4)#����
j SelectChoice

test6:
lw t1, 0(t6)
lw t2, 4(t6)
bltu t1, t2, show
sw zero, 0(a6)
beq a1, zero, show
li a1, 0
sw zero, 0(a4)#����
j SelectChoice

test7:
lw t1, 0(t6)
lw t2, 4(t6)
bgeu t1, t2, show
sw zero, 0(a6)
beq a1, zero, show
li a1, 0
sw zero, 0(a4)#����
j SelectChoice

show:
li t3, 1
sw t3, 0(a6)
beq a1, zero, show
li a1, 0
sw zero, 0(a4)#����
j SelectChoice





