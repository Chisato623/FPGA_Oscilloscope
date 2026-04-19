# 基于易灵思Ti60F225开发板的双通道示波器
## 注意：本项目只追踪了Verilog文件
## 本项目是一个基于FPGA的双通道1080P示波器，项目要求有：
a.  实现按键消抖功能；（10分） 
b.  实现周期信号的幅度、频率测量功能，在屏幕上显示测量结果；（10分） 
c.  编码风格和代码规范性。（10分） 
参见  https://www.runoob.com/w3cnote/verilog2-codestyle.html 
以及  https://www.runoob.com/w3cnote/verilog2-codeguide.html 
d.  在示波器例程“09_Ti60F225_HDMI_720P_ADCWord_NewVerison” 单通道显示
的基础上，实现双通道信号的同时显示及测量；（20分） 
e.  在示波器例程“09_Ti60F225_HDMI_720P_ADCWord_NewVerison”720p显示的
基础上，修改实现1080p显示；（20分） 
f.  阅读理解例程“V7_Ti60F225_RISCV_APB3_Picture”，并根据指定的系统框图重
新优化代码结构；（15分） 
g.  整合上述两个例程，实现上位机实时传图，在示波器屏幕左上角显示学校logo
或其他个性化图片（10分）；在示波器屏幕顶部显示个性化文字（5分）。
