.text
#$t7用来接收随机数
#syscall系统调用根据$v0的值执行不同的功能
#	1:生成mod2随机数
#	2:生成mod4随机数
#	34:输出棋盘上的16个数字
#中断程序地址
#	right:0x000030a0
#	left:0x000031e0
#	up:0x00003320
#	down:0x00003460
addi $s0,$zero,0
addi $s1,$zero,16
addi $s2,$zero,32
addi $s3,$zero,48
addi $s4,$zero,2
addi $v0,$zero,2
syscall
addi $t0,$zero,0
main_loop1:
beq $t0,$t7,main_label1
addi $s0,$s0,4
addi $t0,$t0,1
j main_loop1
main_label1:
sw $s4,0($s0)
addi $v0,$zero,2
syscall
addi $t0,$zero,0
main_loop2:
beq $t0,$t7,main_label2
addi $s1,$s1,4
addi $t0,$t0,1
j main_loop2
main_label2:
sw $s4,0($s1)
addi $v0,$zero,2
syscall
addi $t0,$zero,0
main_loop3:
beq $t0,$t7,main_label3
addi $s2,$s2,4
addi $t0,$t0,1
j main_loop3
main_label3:
sw $s4,0($s2)
addi $v0,$zero,2
syscall
addi $t0,$zero,0
main_loop4:
beq $t0,$t7,main_label4
addi $s3,$s3,4
addi $t0,$t0,1
j main_loop4
main_label4:
sw $s4,0($s3)
addi $v0,$0,34         # system call for LED display 
syscall
main_loop:
j main_loop

move_left:
addi $t0,$zero,0 #首地址
addi $t2,$zero,64 #尾地址
left_loop1:
lw $s0,0($t0)
lw $s1,4($t0)
lw $s2,8($t0)
lw $s3,12($t0)
bne $s1,$zero,left_label1
addi $s1,$s0,0
addi $s0,$zero,0
left_label1:
bne $s2,$zero,left_label2
addi $s2,$s1,0
addi $s1,$s0,0
addi $s0,$zero,0
left_label2:
left_loop3:
addi $t1,$zero,0 #判断是否发生合并
beq $s0,$zero,left_lab1
bne $s0,$s1,left_lab1
addi $t1,$zero,1
add $s1,$s1,$s0
addi $s0,$zero,0
left_lab1:
beq $s1,$zero,left_lab2
bne $s1,$s2,left_lab2
addi $t1,$zero,1
add $s2,$s2,$s1
addi $s1,$s0,0
addi $s0,$zero,0
left_lab2:
beq $s2,$zero,left_lab3
bne $s2,$s3,left_lab3
addi $t1,$zero,1
add $s3,$s3,$s2
addi $s2,$s1,0
addi $s1,$s0,0
addi $s0,$zero,0
left_lab3:
bne $t1,$zero,left_loop3
addi $t3,$zero,0
addi $t4,$zero,4
left_loop2:
bne $s0,$zero,left_lab4
addi $s0,$s1,0
addi $s1,$s2,0
addi $s2,$s3,0
addi $s3,$zero,0
addi $t3,$t3,1
bne $t3,$t4,left_loop2
left_lab4:
sw $s0,0($t0)
sw $s1,4($t0)
sw $s2,8($t0)
sw $s3,12($t0)
addi $t0,$t0,16
bne $t0,$t2,left_loop1
addi $t0,$zero,12
lw $s0,0($t0)
lw $s1,16($t0)
lw $s2,32($t0)
lw $s3,48($t0)
bne $s0,$zero,left_lab5 #随机数生成
addi $v0,$zero,1
syscall
beq $t7,$zero,left_lab5
addi $s0,$zero,2
sw $s0,0($t0)
j left_lab8
left_lab5:
bne $s1,$zero,left_lab6
addi $v0,$zero,1
syscall
beq $t7,$zero,left_lab6
addi $s1,$zero,2
sw $s1,16($t0)
j left_lab8
left_lab6:
bne $s2,$zero,left_lab7
addi $v0,$zero,1
syscall
beq $t7,$zero,left_lab7
addi $s2,$zero,2
sw $s2,32($t0)
j left_lab8
left_lab7:
bne $s3,$zero,left_lab8
addi $s3,$zero,2
sw $s3,48($t0)
left_lab8:
addi $v0,$0,34         # system call for LED display 
syscall
eret

move_right:
addi $t0,$zero,0 #首地址
addi $t2,$zero,64 #尾地址
right_loop1:
lw $s0,12($t0)
lw $s1,8($t0)
lw $s2,4($t0)
lw $s3,0($t0)
bne $s1,$zero,right_label1
addi $s1,$s0,0
addi $s0,$zero,0
right_label1:
bne $s2,$zero,right_label2
addi $s2,$s1,0
addi $s1,$s0,0
addi $s0,$zero,0
right_label2:
right_loop3:
addi $t1,$zero,0 #判断是否发生合并
beq $s0,$zero,right_lab1
bne $s0,$s1,right_lab1
addi $t1,$zero,1
add $s1,$s1,$s0
addi $s0,$zero,0
right_lab1:
beq $s1,$zero,right_lab2
bne $s1,$s2,right_lab2
addi $t1,$zero,1
add $s2,$s2,$s1
addi $s1,$s0,0
addi $s0,$zero,0
right_lab2:
beq $s2,$zero,right_lab3
bne $s2,$s3,right_lab3
addi $t1,$zero,1
add $s3,$s3,$s2
addi $s2,$s1,0
addi $s1,$s0,0
addi $s0,$zero,0
right_lab3:
bne $t1,$zero,right_loop3
addi $t3,$zero,0
addi $t4,$zero,4
right_loop2:
bne $s0,$zero,right_lab4
addi $s0,$s1,0
addi $s1,$s2,0
addi $s2,$s3,0
addi $s3,$zero,0
addi $t3,$t3,1
bne $t3,$t4,right_loop2
right_lab4:
sw $s0,12($t0)
sw $s1,8($t0)
sw $s2,4($t0)
sw $s3,0($t0)
addi $t0,$t0,16
bne $t0,$t2,right_loop1
addi $t0,$zero,0
lw $s0,0($t0)
lw $s1,16($t0)
lw $s2,32($t0)
lw $s3,48($t0)
bne $s0,$zero,right_lab5
addi $v0,$zero,1
syscall
beq $t7,$zero,right_lab5
addi $s0,$zero,2
sw $s0,0($t0)
j right_lab8
right_lab5:
bne $s1,$zero,right_lab6
addi $v0,$zero,1
syscall
beq $t7,$zero,right_lab6
addi $s1,$zero,2
sw $s1,16($t0)
j right_lab8
right_lab6:
bne $s2,$zero,right_lab7
addi $v0,$zero,1
syscall
beq $t7,$zero,right_lab7
addi $s2,$zero,2
sw $s2,32($t0)
j right_lab8
right_lab7:
bne $s3,$zero,right_lab8
addi $s3,$zero,2
sw $s3,48($t0)
right_lab8:
addi $v0,$0,34         # system call for LED display 
syscall
eret

move_up:
addi $t0,$zero,0 #首地址
addi $t2,$zero,16 #尾地址
up_loop1:
lw $s0,0($t0)
lw $s1,16($t0)
lw $s2,32($t0)
lw $s3,48($t0)
bne $s1,$zero,up_label1
addi $s1,$s0,0
addi $s0,$zero,0
up_label1:
bne $s2,$zero,up_label2
addi $s2,$s1,0
addi $s1,$s0,0
addi $s0,$zero,0
up_label2:
up_loop3:
addi $t1,$zero,0 #判断是否发生合并
beq $s0,$zero,up_lab1
bne $s0,$s1,up_lab1
addi $t1,$zero,1
add $s1,$s1,$s0
addi $s0,$zero,0
up_lab1:
beq $s1,$zero,up_lab2
bne $s1,$s2,up_lab2
addi $t1,$zero,1
add $s2,$s2,$s1
addi $s1,$s0,0
addi $s0,$zero,0
up_lab2:
beq $s2,$zero,up_lab3
bne $s2,$s3,up_lab3
addi $t1,$zero,1
add $s3,$s3,$s2
addi $s2,$s1,0
addi $s1,$s0,0
addi $s0,$zero,0
up_lab3:
bne $t1,$zero,up_loop3
addi $t3,$zero,0
addi $t4,$zero,4
up_loop2:
bne $s0,$zero,up_lab4
addi $s0,$s1,0
addi $s1,$s2,0
addi $s2,$s3,0
addi $s3,$zero,0
addi $t3,$t3,1
bne $t3,$t4,up_loop2
up_lab4:
sw $s0,0($t0)
sw $s1,16($t0)
sw $s2,32($t0)
sw $s3,48($t0)
addi $t0,$t0,4
bne $t0,$t2,up_loop1
addi $t0,$zero,48
lw $s0,0($t0)
lw $s1,4($t0)
lw $s2,8($t0)
lw $s3,12($t0)
bne $s0,$zero,up_lab5
addi $v0,$zero,1
syscall
beq $t7,$zero,up_lab5
addi $s0,$zero,2
sw $s0,0($t0)
j up_lab8
up_lab5:
bne $s1,$zero,up_lab6
addi $v0,$zero,1
syscall
beq $t7,$zero,up_lab6
addi $s1,$zero,2
sw $s1,4($t0)
j up_lab8
up_lab6:
bne $s2,$zero,up_lab7
addi $v0,$zero,1
syscall
beq $t7,$zero,up_lab7
addi $s2,$zero,2
sw $s2,8($t0)
j up_lab8
up_lab7:
bne $s3,$zero,up_lab8
addi $s3,$zero,2
sw $s3,12($t0)
up_lab8:
addi $v0,$0,34         # system call for LED display 
syscall
eret

move_down:
addi $t0,$zero,0 #首地址
addi $t2,$zero,16 #尾地址
down_loop1:
lw $s0,48($t0)
lw $s1,32($t0)
lw $s2,16($t0)
lw $s3,0($t0)
bne $s1,$zero,down_label1
addi $s1,$s0,0
addi $s0,$zero,0
down_label1:
bne $s2,$zero,down_label2
addi $s2,$s1,0
addi $s1,$s0,0
addi $s0,$zero,0
down_label2:
down_loop3:
addi $t1,$zero,0 #判断是否发生合并
beq $s0,$zero,down_lab1
bne $s0,$s1,down_lab1
addi $t1,$zero,1
add $s1,$s1,$s0
addi $s0,$zero,0
down_lab1:
beq $s1,$zero,down_lab2
bne $s1,$s2,down_lab2
addi $t1,$zero,1
add $s2,$s2,$s1
addi $s1,$s0,0
addi $s0,$zero,0
down_lab2:
beq $s2,$zero,down_lab3
bne $s2,$s3,down_lab3
addi $t1,$zero,1
add $s3,$s3,$s2
addi $s2,$s1,0
addi $s1,$s0,0
addi $s0,$zero,0
down_lab3:
bne $t1,$zero,down_loop3
addi $t3,$zero,0
addi $t4,$zero,4
down_loop2:
bne $s0,$zero,down_lab4
addi $s0,$s1,0
addi $s1,$s2,0
addi $s2,$s3,0
addi $s3,$zero,0
addi $t3,$t3,1
bne $t3,$t4,down_loop2
down_lab4:
sw $s0,48($t0)
sw $s1,32($t0)
sw $s2,16($t0)
sw $s3,0($t0)
addi $t0,$t0,4
bne $t0,$t2,down_loop1
addi $t0,$zero,0
lw $s0,0($t0)
lw $s1,4($t0)
lw $s2,8($t0)
lw $s3,12($t0)
bne $s0,$zero,down_lab5
addi $v0,$zero,1
syscall
beq $t7,$zero,down_lab5
addi $s0,$zero,2
sw $s0,0($t0)
j down_lab8
down_lab5:
bne $s1,$zero,down_lab6
addi $v0,$zero,1
syscall
beq $t7,$zero,down_lab6
addi $s1,$zero,2
sw $s1,4($t0)
j down_lab8
down_lab6:
bne $s2,$zero,down_lab7
addi $v0,$zero,1
syscall
beq $t7,$zero,down_lab7
addi $s2,$zero,2
sw $s2,8($t0)
j down_lab8
down_lab7:
bne $s3,$zero,down_lab8
addi $s3,$zero,2
sw $s3,12($t0)
down_lab8:
addi $v0,$0,34         # system call for LED display 
syscall
eret
