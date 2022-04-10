# 2048 in Logisim
## CPU

CPU为MIPS单周期CPU，支持24+4条基本指令

![image-20220410150603610](https://markdownpicsupload.oss-cn-beijing.aliyuncs.com/img/image-20220410150603610.png)



## 2048代码逻辑

（待补充）



## 随机数生成电路

### 伪随机序列

如果一个序列，一方面它是可以预先确定的，并且是可以重复地生产和复制的；一方面它又具有某种随机序列的随机特性（即统计特性），我们便称这种序列为伪随机序列。

 伪随机序列又称为伪随机码，是一组人工生成的周期序列。它不仅具有随机序列的一些统计特性和高斯噪声所有的良好的自相关特征，而且具有某种确定的编码规则，同时又便于重复产生和处理，因而在通信领域应用广泛。

伪随机序列的产生方式很多，通常产生的伪随机序列的电路为一反馈移位寄存器。它又可分为线性反馈移位寄存器和非线性反馈移位寄存器两类。由线性反馈移位寄存器产生出的周期最长的二进制数字序列称为最大长度线性反馈移位寄存器序列，简称 m 序列，移位寄存器的长度为 n，则 m 序列的周期为 2n-1，没有全 0 状态。

其中，伪随机数发生器的初始状态需由微处理器通过D寄存器给出。

### 硬件电路
伪随机序列发生器的初始状态是由微处理器中 D寄存器提供的，而D寄存器的位数为 8 位，所以需要设计一种 8 位的伪随机序列发生器，它的本原多项式为：

![](https://latex.codecogs.com/svg.image?F(x)=x^8&plus;x^4&plus;x^3&plus;x^2&plus;1)

Verilog代码

```verilog
module random_num(
    input clk,
    input rst,
    input en,
    input [7:0] d,
    output [7:0] ran_num
);
 
integer i;
 
always @(posedge clk or posedge rst)begin:loop
 
    if (rst)
        ran_num <=  8'b0;
    else if(en)
        ran_num <=  d;
    else begin
        for(i=1;i<8;i=i+1)
            ran_num[i] <=  ran_num[i-1];
        ran_num[0] <=  ran_num[1] ^ (ran_num[2] ^ (ran_num[3] ^ ran_num[7])) ;
    end
end
 
endmodule
```



## 屏幕显示设计

（待补充）
