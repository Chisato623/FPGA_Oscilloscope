
build/gpioDemo.elf:     file format elf32-littleriscv


Disassembly of section .init:

f9000000 <_start>:

_start:
#ifdef USE_GP
.option push
.option norelax
	la gp, __global_pointer$
f9000000:	00001197          	auipc	gp,0x1
f9000004:	21018193          	addi	gp,gp,528 # f9001210 <__global_pointer$>

f9000008 <init>:
	sw a0, smp_lottery_lock, a1
    ret
#endif

init:
	la sp, _sp
f9000008:	00003117          	auipc	sp,0x3
f900000c:	a2810113          	addi	sp,sp,-1496 # f9002a30 <__freertos_irq_stack_top>

	/* Load data section */
	la a0, _data_lma
f9000010:	00001517          	auipc	a0,0x1
f9000014:	89050513          	addi	a0,a0,-1904 # f90008a0 <_data>
	la a1, _data
f9000018:	00001597          	auipc	a1,0x1
f900001c:	88858593          	addi	a1,a1,-1912 # f90008a0 <_data>
	la a2, _edata
f9000020:	81c18613          	addi	a2,gp,-2020 # f9000a2c <__bss_start>
	bgeu a1, a2, 2f
f9000024:	00c5fc63          	bgeu	a1,a2,f900003c <init+0x34>
1:
	lw t0, (a0)
f9000028:	00052283          	lw	t0,0(a0)
	sw t0, (a1)
f900002c:	0055a023          	sw	t0,0(a1)
	addi a0, a0, 4
f9000030:	00450513          	addi	a0,a0,4
	addi a1, a1, 4
f9000034:	00458593          	addi	a1,a1,4
	bltu a1, a2, 1b
f9000038:	fec5e8e3          	bltu	a1,a2,f9000028 <init+0x20>
2:

	/* Clear bss section */
	la a0, __bss_start
f900003c:	81c18513          	addi	a0,gp,-2020 # f9000a2c <__bss_start>
	la a1, _end
f9000040:	82018593          	addi	a1,gp,-2016 # f9000a30 <_end>
	bgeu a0, a1, 2f
f9000044:	00b57863          	bgeu	a0,a1,f9000054 <init+0x4c>
1:
	sw zero, (a0)
f9000048:	00052023          	sw	zero,0(a0)
	addi a0, a0, 4
f900004c:	00450513          	addi	a0,a0,4
	bltu a0, a1, 1b
f9000050:	feb56ce3          	bltu	a0,a1,f9000048 <init+0x40>
2:

#ifndef NO_LIBC_INIT_ARRAY
	call __libc_init_array
f9000054:	010000ef          	jal	ra,f9000064 <__libc_init_array>
#endif

	call main
f9000058:	65c000ef          	jal	ra,f90006b4 <main>

f900005c <mainDone>:
mainDone:
    j mainDone
f900005c:	0000006f          	j	f900005c <mainDone>

f9000060 <_init>:


	.globl _init
_init:
    ret
f9000060:	00008067          	ret

Disassembly of section .text:

f9000064 <__libc_init_array>:
f9000064:	ff010113          	addi	sp,sp,-16
f9000068:	00812423          	sw	s0,8(sp)
f900006c:	01212023          	sw	s2,0(sp)
f9000070:	00001417          	auipc	s0,0x1
f9000074:	83040413          	addi	s0,s0,-2000 # f90008a0 <_data>
f9000078:	00001917          	auipc	s2,0x1
f900007c:	82890913          	addi	s2,s2,-2008 # f90008a0 <_data>
f9000080:	40890933          	sub	s2,s2,s0
f9000084:	00112623          	sw	ra,12(sp)
f9000088:	00912223          	sw	s1,4(sp)
f900008c:	40295913          	srai	s2,s2,0x2
f9000090:	00090e63          	beqz	s2,f90000ac <__libc_init_array+0x48>
f9000094:	00000493          	li	s1,0
f9000098:	00042783          	lw	a5,0(s0)
f900009c:	00148493          	addi	s1,s1,1
f90000a0:	00440413          	addi	s0,s0,4
f90000a4:	000780e7          	jalr	a5
f90000a8:	fe9918e3          	bne	s2,s1,f9000098 <__libc_init_array+0x34>
f90000ac:	00000417          	auipc	s0,0x0
f90000b0:	7f440413          	addi	s0,s0,2036 # f90008a0 <_data>
f90000b4:	00000917          	auipc	s2,0x0
f90000b8:	7ec90913          	addi	s2,s2,2028 # f90008a0 <_data>
f90000bc:	40890933          	sub	s2,s2,s0
f90000c0:	40295913          	srai	s2,s2,0x2
f90000c4:	00090e63          	beqz	s2,f90000e0 <__libc_init_array+0x7c>
f90000c8:	00000493          	li	s1,0
f90000cc:	00042783          	lw	a5,0(s0)
f90000d0:	00148493          	addi	s1,s1,1
f90000d4:	00440413          	addi	s0,s0,4
f90000d8:	000780e7          	jalr	a5
f90000dc:	fe9918e3          	bne	s2,s1,f90000cc <__libc_init_array+0x68>
f90000e0:	00c12083          	lw	ra,12(sp)
f90000e4:	00812403          	lw	s0,8(sp)
f90000e8:	00412483          	lw	s1,4(sp)
f90000ec:	00012903          	lw	s2,0(sp)
f90000f0:	01010113          	addi	sp,sp,16
f90000f4:	00008067          	ret

f90000f8 <uart_writeAvailability>:
*          so the 'volatile' keyword is used to prevent the compiler from
*          optimizing away or reordering the read operation.
*
******************************************************************************/
    static inline u32 read_u32(u32 address){
        return *((volatile u32*) address);
f90000f8:	00452503          	lw	a0,4(a0)
*          of available spaces for writing data from bits 23 to 16. It then
*          returns this value after masking with 0xFF.
*
******************************************************************************/
    static u32 uart_writeAvailability(u32 reg){
        return (read_u32(reg + UART_STATUS) >> 16) & 0xFF;
f90000fc:	01055513          	srli	a0,a0,0x10
    }
f9000100:	0ff57513          	andi	a0,a0,255
f9000104:	00008067          	ret

f9000108 <uart_write>:
* @note    The function waits until there is available space in the UART buffer
*          for writing data. Once space is available, it writes the character
*          data to the UART data register.
*
******************************************************************************/
    static void uart_write(u32 reg, char data){
f9000108:	ff010113          	addi	sp,sp,-16
f900010c:	00112623          	sw	ra,12(sp)
f9000110:	00812423          	sw	s0,8(sp)
f9000114:	00912223          	sw	s1,4(sp)
f9000118:	00050413          	mv	s0,a0
f900011c:	00058493          	mv	s1,a1
        while(uart_writeAvailability(reg) == 0);
f9000120:	00040513          	mv	a0,s0
f9000124:	fd5ff0ef          	jal	ra,f90000f8 <uart_writeAvailability>
f9000128:	fe050ce3          	beqz	a0,f9000120 <uart_write+0x18>
*          optimizing away or reordering the write operation.
*
******************************************************************************/

    static inline void write_u32(u32 data, u32 address){
        *((volatile u32*) address) = data;
f900012c:	00942023          	sw	s1,0(s0)
        write_u32(data, reg + UART_DATA);
    }
f9000130:	00c12083          	lw	ra,12(sp)
f9000134:	00812403          	lw	s0,8(sp)
f9000138:	00412483          	lw	s1,4(sp)
f900013c:	01010113          	addi	sp,sp,16
f9000140:	00008067          	ret

f9000144 <clint_uDelay>:
*          and the time limit is non-negative, indicating that the delay has
*          not yet elapsed.
*
******************************************************************************/
    static void clint_uDelay(u32 usec, u32 hz, u32 reg){
        u32 mTimePerUsec = hz/1000000;
f9000144:	000f47b7          	lui	a5,0xf4
f9000148:	24078793          	addi	a5,a5,576 # f4240 <__stack_size+0xf2240>
f900014c:	02f5d5b3          	divu	a1,a1,a5
    readReg_u32 (clint_getTimeLow , CLINT_TIME_ADDR)
f9000150:	0000c7b7          	lui	a5,0xc
f9000154:	ff878793          	addi	a5,a5,-8 # bff8 <__stack_size+0x9ff8>
f9000158:	00f60633          	add	a2,a2,a5
        return *((volatile u32*) address);
f900015c:	00062783          	lw	a5,0(a2)
        u32 limit = clint_getTimeLow(reg) + usec*mTimePerUsec;
f9000160:	02a58533          	mul	a0,a1,a0
f9000164:	00f50533          	add	a0,a0,a5
f9000168:	00062783          	lw	a5,0(a2)
        while((int32_t)(limit-(clint_getTimeLow(reg))) >= 0);
f900016c:	40f507b3          	sub	a5,a0,a5
f9000170:	fe07dce3          	bgez	a5,f9000168 <clint_uDelay+0x24>
f9000174:	00008067          	ret

f9000178 <_putchar>:
* @note If semihosting printing is enabled (ENABLE_SEMIHOSTING_PRINT == 1),
*       the character is output using the semihosting function sh_writec().
*       Otherwise, the character is output using the BSP function bsp_putChar().
*
*******************************************************************************/
    static void _putchar(char character){
f9000178:	ff010113          	addi	sp,sp,-16
f900017c:	00112623          	sw	ra,12(sp)
        #if (ENABLE_SEMIHOSTING_PRINT == 1)
            sh_writec(character);
        #else
            bsp_putChar(character);
f9000180:	00050593          	mv	a1,a0
f9000184:	f8010537          	lui	a0,0xf8010
f9000188:	f81ff0ef          	jal	ra,f9000108 <uart_write>
        #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
f900018c:	00c12083          	lw	ra,12(sp)
f9000190:	01010113          	addi	sp,sp,16
f9000194:	00008067          	ret

f9000198 <_putchar_s>:
*       the character is output using the semihosting function sh_write0().
*       Otherwise, the character is output using the BSP function _putChar().
*
*******************************************************************************/
    static void _putchar_s(char *p)
    {
f9000198:	ff010113          	addi	sp,sp,-16
f900019c:	00112623          	sw	ra,12(sp)
f90001a0:	00812423          	sw	s0,8(sp)
f90001a4:	00050413          	mv	s0,a0
    #if (ENABLE_SEMIHOSTING_PRINT == 1)
        sh_write0(p);
    #else
        while (*p)
f90001a8:	00044503          	lbu	a0,0(s0)
f90001ac:	00050863          	beqz	a0,f90001bc <_putchar_s+0x24>
            _putchar(*(p++));
f90001b0:	00140413          	addi	s0,s0,1
f90001b4:	fc5ff0ef          	jal	ra,f9000178 <_putchar>
f90001b8:	ff1ff06f          	j	f90001a8 <_putchar_s+0x10>
    #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
f90001bc:	00c12083          	lw	ra,12(sp)
f90001c0:	00812403          	lw	s0,8(sp)
f90001c4:	01010113          	addi	sp,sp,16
f90001c8:	00008067          	ret

f90001cc <bsp_printHex>:
* @note The function iterates over each nibble (4 bits) of the value and prints the corresponding hexadecimal character.
*
*******************************************************************************/
    //bsp_printHex is used in BSP_PRINTF
    static void bsp_printHex(uint32_t val)
    {
f90001cc:	ff010113          	addi	sp,sp,-16
f90001d0:	00112623          	sw	ra,12(sp)
f90001d4:	00812423          	sw	s0,8(sp)
f90001d8:	00912223          	sw	s1,4(sp)
f90001dc:	00050493          	mv	s1,a0
        uint32_t digits;
        digits =8;

        for (int i = (4*digits)-4; i >= 0; i -= 4) {
f90001e0:	01c00413          	li	s0,28
f90001e4:	0240006f          	j	f9000208 <bsp_printHex+0x3c>
            _putchar("0123456789ABCDEF"[(val >> i) % 16]);
f90001e8:	0084d7b3          	srl	a5,s1,s0
f90001ec:	00f7f713          	andi	a4,a5,15
f90001f0:	f90017b7          	lui	a5,0xf9001
f90001f4:	8a078793          	addi	a5,a5,-1888 # f90008a0 <__freertos_irq_stack_top+0xffffde70>
f90001f8:	00e787b3          	add	a5,a5,a4
f90001fc:	0007c503          	lbu	a0,0(a5)
f9000200:	f79ff0ef          	jal	ra,f9000178 <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
f9000204:	ffc40413          	addi	s0,s0,-4
f9000208:	fe0450e3          	bgez	s0,f90001e8 <bsp_printHex+0x1c>
        }
    }
f900020c:	00c12083          	lw	ra,12(sp)
f9000210:	00812403          	lw	s0,8(sp)
f9000214:	00412483          	lw	s1,4(sp)
f9000218:	01010113          	addi	sp,sp,16
f900021c:	00008067          	ret

f9000220 <bsp_printHex_lower>:
*
* @note The function iterates over each nibble (4 bits) of the value and prints the corresponding hexadecimal character.
*
*******************************************************************************/
    static void bsp_printHex_lower(uint32_t val)
        {
f9000220:	ff010113          	addi	sp,sp,-16
f9000224:	00112623          	sw	ra,12(sp)
f9000228:	00812423          	sw	s0,8(sp)
f900022c:	00912223          	sw	s1,4(sp)
f9000230:	00050493          	mv	s1,a0
            uint32_t digits;
            digits =8;

            for (int i = (4*digits)-4; i >= 0; i -= 4) {
f9000234:	01c00413          	li	s0,28
f9000238:	0240006f          	j	f900025c <bsp_printHex_lower+0x3c>
                _putchar("0123456789abcdef"[(val >> i) % 16]);
f900023c:	0084d7b3          	srl	a5,s1,s0
f9000240:	00f7f713          	andi	a4,a5,15
f9000244:	f90017b7          	lui	a5,0xf9001
f9000248:	8b478793          	addi	a5,a5,-1868 # f90008b4 <__freertos_irq_stack_top+0xffffde84>
f900024c:	00e787b3          	add	a5,a5,a4
f9000250:	0007c503          	lbu	a0,0(a5)
f9000254:	f25ff0ef          	jal	ra,f9000178 <_putchar>
            for (int i = (4*digits)-4; i >= 0; i -= 4) {
f9000258:	ffc40413          	addi	s0,s0,-4
f900025c:	fe0450e3          	bgez	s0,f900023c <bsp_printHex_lower+0x1c>

            }
        }
f9000260:	00c12083          	lw	ra,12(sp)
f9000264:	00812403          	lw	s0,8(sp)
f9000268:	00412483          	lw	s1,4(sp)
f900026c:	01010113          	addi	sp,sp,16
f9000270:	00008067          	ret

f9000274 <bsp_printf_c>:
*
* @param c: The character to be output.
*
******************************************************************************/
    static void bsp_printf_c(int c)
    {
f9000274:	ff010113          	addi	sp,sp,-16
f9000278:	00112623          	sw	ra,12(sp)
        _putchar(c);
f900027c:	0ff57513          	andi	a0,a0,255
f9000280:	ef9ff0ef          	jal	ra,f9000178 <_putchar>
    }
f9000284:	00c12083          	lw	ra,12(sp)
f9000288:	01010113          	addi	sp,sp,16
f900028c:	00008067          	ret

f9000290 <bsp_printf_s>:
*
* @param s: A pointer to the null-terminated string to be output.
*
*******************************************************************************/
    static void bsp_printf_s(char *p)
    {
f9000290:	ff010113          	addi	sp,sp,-16
f9000294:	00112623          	sw	ra,12(sp)
        _putchar_s(p);
f9000298:	f01ff0ef          	jal	ra,f9000198 <_putchar_s>
    }
f900029c:	00c12083          	lw	ra,12(sp)
f90002a0:	01010113          	addi	sp,sp,16
f90002a4:	00008067          	ret

f90002a8 <bsp_printf_d>:
* - Handles negative numbers by printing a '-' sign.
* - Uses the 'bsp_printf_c' function to print each character.
*
******************************************************************************/
    static void bsp_printf_d(int val)
    {
f90002a8:	fd010113          	addi	sp,sp,-48
f90002ac:	02112623          	sw	ra,44(sp)
f90002b0:	02812423          	sw	s0,40(sp)
f90002b4:	02912223          	sw	s1,36(sp)
f90002b8:	00050493          	mv	s1,a0
        char buffer[32];
        char *p = buffer;
        if (val < 0) {
f90002bc:	00054663          	bltz	a0,f90002c8 <bsp_printf_d+0x20>
    {
f90002c0:	00010413          	mv	s0,sp
f90002c4:	02c0006f          	j	f90002f0 <bsp_printf_d+0x48>
            bsp_printf_c('-');
f90002c8:	02d00513          	li	a0,45
f90002cc:	fa9ff0ef          	jal	ra,f9000274 <bsp_printf_c>
            val = -val;
f90002d0:	409004b3          	neg	s1,s1
f90002d4:	fedff06f          	j	f90002c0 <bsp_printf_d+0x18>
        }
        while (val || p == buffer) {
            *(p++) = '0' + val % 10;
f90002d8:	00a00713          	li	a4,10
f90002dc:	02e4e7b3          	rem	a5,s1,a4
f90002e0:	03078793          	addi	a5,a5,48
f90002e4:	00f40023          	sb	a5,0(s0)
            val = val / 10;
f90002e8:	02e4c4b3          	div	s1,s1,a4
            *(p++) = '0' + val % 10;
f90002ec:	00140413          	addi	s0,s0,1
        while (val || p == buffer) {
f90002f0:	fe0494e3          	bnez	s1,f90002d8 <bsp_printf_d+0x30>
f90002f4:	00010793          	mv	a5,sp
f90002f8:	fef400e3          	beq	s0,a5,f90002d8 <bsp_printf_d+0x30>
f90002fc:	0100006f          	j	f900030c <bsp_printf_d+0x64>
        }
        while (p != buffer)
            bsp_printf_c(*(--p));
f9000300:	fff40413          	addi	s0,s0,-1
f9000304:	00044503          	lbu	a0,0(s0)
f9000308:	f6dff0ef          	jal	ra,f9000274 <bsp_printf_c>
        while (p != buffer)
f900030c:	00010793          	mv	a5,sp
f9000310:	fef418e3          	bne	s0,a5,f9000300 <bsp_printf_d+0x58>
    }
f9000314:	02c12083          	lw	ra,44(sp)
f9000318:	02812403          	lw	s0,40(sp)
f900031c:	02412483          	lw	s1,36(sp)
f9000320:	03010113          	addi	sp,sp,48
f9000324:	00008067          	ret

f9000328 <bsp_printf_x>:
* - Calls 'bsp_printHex_lower' to print the hexadecimal representation.
* - Determines the number of leading zeros to be printed based on the value.
*
******************************************************************************/
    static void bsp_printf_x(int val)
    {
f9000328:	ff010113          	addi	sp,sp,-16
f900032c:	00112623          	sw	ra,12(sp)
        int i,digi=2;

        for(i=0;i<8;i++)
f9000330:	00000713          	li	a4,0
f9000334:	00700793          	li	a5,7
f9000338:	02e7c063          	blt	a5,a4,f9000358 <bsp_printf_x+0x30>
        {
            if((val & (0xFFFFFFF0 <<(4*i))) == 0)
f900033c:	00271693          	slli	a3,a4,0x2
f9000340:	ff000793          	li	a5,-16
f9000344:	00d797b3          	sll	a5,a5,a3
f9000348:	00f577b3          	and	a5,a0,a5
f900034c:	00078663          	beqz	a5,f9000358 <bsp_printf_x+0x30>
        for(i=0;i<8;i++)
f9000350:	00170713          	addi	a4,a4,1
f9000354:	fe1ff06f          	j	f9000334 <bsp_printf_x+0xc>
            {
                digi=i+1;
                break;
            }
        }
        bsp_printHex_lower(val);
f9000358:	ec9ff0ef          	jal	ra,f9000220 <bsp_printHex_lower>
    }
f900035c:	00c12083          	lw	ra,12(sp)
f9000360:	01010113          	addi	sp,sp,16
f9000364:	00008067          	ret

f9000368 <bsp_printf_X>:
* - Calls 'bsp_printHex' to print the uppercase hexadecimal representation.
* - Determines the number of leading zeros to be printed based on the value.
*
******************************************************************************/
    static void bsp_printf_X(int val)
        {
f9000368:	ff010113          	addi	sp,sp,-16
f900036c:	00112623          	sw	ra,12(sp)
            int i,digi=2;

            for(i=0;i<8;i++)
f9000370:	00000713          	li	a4,0
f9000374:	00700793          	li	a5,7
f9000378:	02e7c063          	blt	a5,a4,f9000398 <bsp_printf_X+0x30>
            {
                if((val & (0xFFFFFFF0 <<(4*i))) == 0)
f900037c:	00271693          	slli	a3,a4,0x2
f9000380:	ff000793          	li	a5,-16
f9000384:	00d797b3          	sll	a5,a5,a3
f9000388:	00f577b3          	and	a5,a0,a5
f900038c:	00078663          	beqz	a5,f9000398 <bsp_printf_X+0x30>
            for(i=0;i<8;i++)
f9000390:	00170713          	addi	a4,a4,1
f9000394:	fe1ff06f          	j	f9000374 <bsp_printf_X+0xc>
                {
                    digi=i+1;
                    break;
                }
            }
            bsp_printHex(val);
f9000398:	e35ff0ef          	jal	ra,f90001cc <bsp_printHex>
        }
f900039c:	00c12083          	lw	ra,12(sp)
f90003a0:	01010113          	addi	sp,sp,16
f90003a4:	00008067          	ret

f90003a8 <plic_set_priority>:
*          specified priority value to the calculated address, effectively
*          setting the priority for the specified interrupt gateway in the PLIC.
*
******************************************************************************/
    static void plic_set_priority(u32 plic, u32 gateway, u32 priority){
        write_u32(priority, plic + PLIC_PRIORITY_BASE + gateway*4);
f90003a8:	00259593          	slli	a1,a1,0x2
f90003ac:	00a585b3          	add	a1,a1,a0
        *((volatile u32*) address) = data;
f90003b0:	00c5a023          	sw	a2,0(a1)
    }
f90003b4:	00008067          	ret

f90003b8 <plic_set_enable>:
*          to the enable register.
*
******************************************************************************/

    static void plic_set_enable(u32 plic, u32 target,u32 gateway, u32 enable){
        u32 word = plic + PLIC_ENABLE_BASE + target * PLIC_ENABLE_PER_HART + (gateway / 32 * 4);
f90003b8:	00759593          	slli	a1,a1,0x7
f90003bc:	00a58533          	add	a0,a1,a0
f90003c0:	00565593          	srli	a1,a2,0x5
f90003c4:	00259593          	slli	a1,a1,0x2
f90003c8:	00b50533          	add	a0,a0,a1
f90003cc:	000025b7          	lui	a1,0x2
f90003d0:	00b50533          	add	a0,a0,a1
        u32 mask = 1 << (gateway % 32);
f90003d4:	00100793          	li	a5,1
f90003d8:	00c797b3          	sll	a5,a5,a2
        if (enable)
f90003dc:	00068a63          	beqz	a3,f90003f0 <plic_set_enable+0x38>
        return *((volatile u32*) address);
f90003e0:	00052603          	lw	a2,0(a0) # f8010000 <__freertos_irq_stack_top+0xff00d5d0>
            write_u32(read_u32(word) | mask, word);
f90003e4:	00c7e7b3          	or	a5,a5,a2
        *((volatile u32*) address) = data;
f90003e8:	00f52023          	sw	a5,0(a0)
f90003ec:	00008067          	ret
        return *((volatile u32*) address);
f90003f0:	00052603          	lw	a2,0(a0)
        else
            write_u32(read_u32(word) & ~mask, word);
f90003f4:	fff7c793          	not	a5,a5
f90003f8:	00c7f7b3          	and	a5,a5,a2
        *((volatile u32*) address) = data;
f90003fc:	00f52023          	sw	a5,0(a0)
    }
f9000400:	00008067          	ret

f9000404 <plic_set_threshold>:
*          to the calculated address, effectively setting the threshold for the
*          specified target in the PLIC.
*
******************************************************************************/   
    static void plic_set_threshold(u32 plic, u32 target, u32 threshold){
        write_u32(threshold, plic + PLIC_THRESHOLD_BASE + target*PLIC_CONTEXT_PER_HART);
f9000404:	00c59593          	slli	a1,a1,0xc
f9000408:	00a585b3          	add	a1,a1,a0
f900040c:	00200537          	lui	a0,0x200
f9000410:	00a585b3          	add	a1,a1,a0
f9000414:	00c5a023          	sw	a2,0(a1) # 2000 <__stack_size>
    }
f9000418:	00008067          	ret

f900041c <plic_claim>:
*          value from the calculated address, effectively claiming an interrupt
*          for the specified target in the PLIC.
*
******************************************************************************/
    static u32 plic_claim(u32 plic, u32 target){
        return read_u32(plic + PLIC_CLAIM_BASE + target*PLIC_CONTEXT_PER_HART);
f900041c:	00c59593          	slli	a1,a1,0xc
f9000420:	00a585b3          	add	a1,a1,a0
f9000424:	00200537          	lui	a0,0x200
f9000428:	00450513          	addi	a0,a0,4 # 200004 <__stack_size+0x1fe004>
f900042c:	00a585b3          	add	a1,a1,a0
        return *((volatile u32*) address);
f9000430:	0005a503          	lw	a0,0(a1)
    }
f9000434:	00008067          	ret

f9000438 <plic_release>:
*          to the calculated address, effectively releasing the claimed interrupt
*          for the specified target in the PLIC.
*
******************************************************************************/
    static void plic_release(u32 plic, u32 target, u32 gateway){
        write_u32(gateway,plic + PLIC_CLAIM_BASE + target*PLIC_CONTEXT_PER_HART);
f9000438:	00c59593          	slli	a1,a1,0xc
f900043c:	00a585b3          	add	a1,a1,a0
f9000440:	00200537          	lui	a0,0x200
f9000444:	00450513          	addi	a0,a0,4 # 200004 <__stack_size+0x1fe004>
f9000448:	00a585b3          	add	a1,a1,a0
        *((volatile u32*) address) = data;
f900044c:	00c5a023          	sw	a2,0(a1)
    }
f9000450:	00008067          	ret

f9000454 <bsp_printf>:
* - Handles each format specifier by calling the appropriate helper function.
* - If floating-point support is disabled, prints a warning for the 'f' specifier.
*
******************************************************************************/
    static void bsp_printf(const char *format, ...)
    {
f9000454:	fc010113          	addi	sp,sp,-64
f9000458:	00112e23          	sw	ra,28(sp)
f900045c:	00812c23          	sw	s0,24(sp)
f9000460:	00912a23          	sw	s1,20(sp)
f9000464:	00050493          	mv	s1,a0
f9000468:	02b12223          	sw	a1,36(sp)
f900046c:	02c12423          	sw	a2,40(sp)
f9000470:	02d12623          	sw	a3,44(sp)
f9000474:	02e12823          	sw	a4,48(sp)
f9000478:	02f12a23          	sw	a5,52(sp)
f900047c:	03012c23          	sw	a6,56(sp)
f9000480:	03112e23          	sw	a7,60(sp)
        int i;
        va_list ap;

        va_start(ap, format);
f9000484:	02410793          	addi	a5,sp,36
f9000488:	00f12623          	sw	a5,12(sp)

        for (i = 0; format[i]; i++)
f900048c:	00000413          	li	s0,0
f9000490:	01c0006f          	j	f90004ac <bsp_printf+0x58>
            if (format[i] == '%') {
                while (format[++i]) {
                    if (format[i] == 'c') {
                        bsp_printf_c(va_arg(ap,int));
f9000494:	00c12783          	lw	a5,12(sp)
f9000498:	00478713          	addi	a4,a5,4
f900049c:	00e12623          	sw	a4,12(sp)
f90004a0:	0007a503          	lw	a0,0(a5)
f90004a4:	dd1ff0ef          	jal	ra,f9000274 <bsp_printf_c>
        for (i = 0; format[i]; i++)
f90004a8:	00140413          	addi	s0,s0,1
f90004ac:	008487b3          	add	a5,s1,s0
f90004b0:	0007c503          	lbu	a0,0(a5)
f90004b4:	0c050263          	beqz	a0,f9000578 <bsp_printf+0x124>
            if (format[i] == '%') {
f90004b8:	02500793          	li	a5,37
f90004bc:	06f50663          	beq	a0,a5,f9000528 <bsp_printf+0xd4>
                        break;
                    }
#endif //#if (ENABLE_FLOATING_POINT_SUPPORT)
                }
            } else
                bsp_printf_c(format[i]);
f90004c0:	db5ff0ef          	jal	ra,f9000274 <bsp_printf_c>
f90004c4:	fe5ff06f          	j	f90004a8 <bsp_printf+0x54>
                        bsp_printf_s(va_arg(ap,char*));
f90004c8:	00c12783          	lw	a5,12(sp)
f90004cc:	00478713          	addi	a4,a5,4
f90004d0:	00e12623          	sw	a4,12(sp)
f90004d4:	0007a503          	lw	a0,0(a5)
f90004d8:	db9ff0ef          	jal	ra,f9000290 <bsp_printf_s>
                        break;
f90004dc:	fcdff06f          	j	f90004a8 <bsp_printf+0x54>
                        bsp_printf_d(va_arg(ap,int));
f90004e0:	00c12783          	lw	a5,12(sp)
f90004e4:	00478713          	addi	a4,a5,4
f90004e8:	00e12623          	sw	a4,12(sp)
f90004ec:	0007a503          	lw	a0,0(a5)
f90004f0:	db9ff0ef          	jal	ra,f90002a8 <bsp_printf_d>
                        break;
f90004f4:	fb5ff06f          	j	f90004a8 <bsp_printf+0x54>
                        bsp_printf_X(va_arg(ap,int));
f90004f8:	00c12783          	lw	a5,12(sp)
f90004fc:	00478713          	addi	a4,a5,4
f9000500:	00e12623          	sw	a4,12(sp)
f9000504:	0007a503          	lw	a0,0(a5)
f9000508:	e61ff0ef          	jal	ra,f9000368 <bsp_printf_X>
                        break;
f900050c:	f9dff06f          	j	f90004a8 <bsp_printf+0x54>
                        bsp_printf_x(va_arg(ap,int));
f9000510:	00c12783          	lw	a5,12(sp)
f9000514:	00478713          	addi	a4,a5,4
f9000518:	00e12623          	sw	a4,12(sp)
f900051c:	0007a503          	lw	a0,0(a5)
f9000520:	e09ff0ef          	jal	ra,f9000328 <bsp_printf_x>
                        break;
f9000524:	f85ff06f          	j	f90004a8 <bsp_printf+0x54>
                while (format[++i]) {
f9000528:	00140413          	addi	s0,s0,1
f900052c:	008487b3          	add	a5,s1,s0
f9000530:	0007c783          	lbu	a5,0(a5)
f9000534:	f6078ae3          	beqz	a5,f90004a8 <bsp_printf+0x54>
                    if (format[i] == 'c') {
f9000538:	06300713          	li	a4,99
f900053c:	f4e78ce3          	beq	a5,a4,f9000494 <bsp_printf+0x40>
                    else if (format[i] == 's') {
f9000540:	07300713          	li	a4,115
f9000544:	f8e782e3          	beq	a5,a4,f90004c8 <bsp_printf+0x74>
                    else if (format[i] == 'd') {
f9000548:	06400713          	li	a4,100
f900054c:	f8e78ae3          	beq	a5,a4,f90004e0 <bsp_printf+0x8c>
                    else if (format[i] == 'X') {
f9000550:	05800713          	li	a4,88
f9000554:	fae782e3          	beq	a5,a4,f90004f8 <bsp_printf+0xa4>
                    else if (format[i] == 'x') {
f9000558:	07800713          	li	a4,120
f900055c:	fae78ae3          	beq	a5,a4,f9000510 <bsp_printf+0xbc>
                    else if (format[i] == 'f') {
f9000560:	06600713          	li	a4,102
f9000564:	fce792e3          	bne	a5,a4,f9000528 <bsp_printf+0xd4>
                        bsp_printf_s("<Floating point printing not enable. Please Enable it at bsp.h first...>");
f9000568:	f9001537          	lui	a0,0xf9001
f900056c:	8c850513          	addi	a0,a0,-1848 # f90008c8 <__freertos_irq_stack_top+0xffffde98>
f9000570:	d21ff0ef          	jal	ra,f9000290 <bsp_printf_s>
                        break;
f9000574:	f35ff06f          	j	f90004a8 <bsp_printf+0x54>

        va_end(ap);
    }
f9000578:	01c12083          	lw	ra,28(sp)
f900057c:	01812403          	lw	s0,24(sp)
f9000580:	01412483          	lw	s1,20(sp)
f9000584:	04010113          	addi	sp,sp,64
f9000588:	00008067          	ret

f900058c <init>:
*
* @brief This function initializes GPIO interrupts and enables external interrupts
*        by setting up the machine trap vector. 
*
******************************************************************************/
void init(){
f900058c:	ff010113          	addi	sp,sp,-16
f9000590:	00112623          	sw	ra,12(sp)
    //configure PLIC
    //cpu 0 accept all interrupts with priority above 0
    plic_set_threshold(BSP_PLIC, BSP_PLIC_CPU_0, 0); 
f9000594:	00000613          	li	a2,0
f9000598:	00000593          	li	a1,0
f900059c:	f8c00537          	lui	a0,0xf8c00
f90005a0:	e65ff0ef          	jal	ra,f9000404 <plic_set_threshold>
    plic_set_enable(BSP_PLIC, BSP_PLIC_CPU_0, SYSTEM_PLIC_SYSTEM_GPIO_0_IO_INTERRUPTS_0, 1);
f90005a4:	00100693          	li	a3,1
f90005a8:	00c00613          	li	a2,12
f90005ac:	00000593          	li	a1,0
f90005b0:	f8c00537          	lui	a0,0xf8c00
f90005b4:	e05ff0ef          	jal	ra,f90003b8 <plic_set_enable>
    plic_set_priority(BSP_PLIC, SYSTEM_PLIC_SYSTEM_GPIO_0_IO_INTERRUPTS_0, 1);
f90005b8:	00100613          	li	a2,1
f90005bc:	00c00593          	li	a1,12
f90005c0:	f8c00537          	lui	a0,0xf8c00
f90005c4:	de5ff0ef          	jal	ra,f90003a8 <plic_set_priority>
f90005c8:	f80157b7          	lui	a5,0xf8015
f90005cc:	00100713          	li	a4,1
f90005d0:	02e7a023          	sw	a4,32(a5) # f8015020 <__freertos_irq_stack_top+0xff0125f0>
    //Enable rising edge interrupts
    gpio_setInterruptRiseEnable(GPIO0, 1); 
    //enable interrupts
    //Set the machine trap vector (../common/trap.S)
    csr_write(mtvec, trap_entry); 
f90005d4:	f90017b7          	lui	a5,0xf9001
f90005d8:	81078793          	addi	a5,a5,-2032 # f9000810 <__freertos_irq_stack_top+0xffffdde0>
f90005dc:	30579073          	csrw	mtvec,a5
    //Enable external interrupts
    csr_set(mie, MIE_MEIE); 
f90005e0:	000017b7          	lui	a5,0x1
f90005e4:	80078793          	addi	a5,a5,-2048 # 800 <regnum_t6+0x7e1>
f90005e8:	3047a073          	csrs	mie,a5
    csr_write(mstatus, csr_read(mstatus) | MSTATUS_MPP | MSTATUS_MIE);
f90005ec:	300027f3          	csrr	a5,mstatus
f90005f0:	00002737          	lui	a4,0x2
f90005f4:	80870713          	addi	a4,a4,-2040 # 1808 <regnum_t6+0x17e9>
f90005f8:	00e7e7b3          	or	a5,a5,a4
f90005fc:	30079073          	csrw	mstatus,a5
}
f9000600:	00c12083          	lw	ra,12(sp)
f9000604:	01010113          	addi	sp,sp,16
f9000608:	00008067          	ret

f900060c <crash>:
*
* @brief This function handles the system crash scenario by printing a crash message
* 		 and entering an infinite loop.
*
******************************************************************************/
void crash(){
f900060c:	ff010113          	addi	sp,sp,-16
f9000610:	00112623          	sw	ra,12(sp)
    bsp_printf("\r\n*** CRASH ***\r\n");
f9000614:	f9001537          	lui	a0,0xf9001
f9000618:	91450513          	addi	a0,a0,-1772 # f9000914 <__freertos_irq_stack_top+0xffffdee4>
f900061c:	e39ff0ef          	jal	ra,f9000454 <bsp_printf>
    while(1);
f9000620:	0000006f          	j	f9000620 <crash+0x14>

f9000624 <externalInterrupt>:
void externalInterrupt(){
f9000624:	ff010113          	addi	sp,sp,-16
f9000628:	00112623          	sw	ra,12(sp)
f900062c:	00812423          	sw	s0,8(sp)
    while(claim = plic_claim(BSP_PLIC, BSP_PLIC_CPU_0)){
f9000630:	00000593          	li	a1,0
f9000634:	f8c00537          	lui	a0,0xf8c00
f9000638:	de5ff0ef          	jal	ra,f900041c <plic_claim>
f900063c:	00050413          	mv	s0,a0
f9000640:	02050863          	beqz	a0,f9000670 <externalInterrupt+0x4c>
        switch(claim){
f9000644:	00c00793          	li	a5,12
f9000648:	02f41263          	bne	s0,a5,f900066c <externalInterrupt+0x48>
        case SYSTEM_PLIC_SYSTEM_GPIO_0_IO_INTERRUPTS_0: bsp_printf("gpio 0 interrupt routine \r\n"); break;
f900064c:	f9001537          	lui	a0,0xf9001
f9000650:	92850513          	addi	a0,a0,-1752 # f9000928 <__freertos_irq_stack_top+0xffffdef8>
f9000654:	e01ff0ef          	jal	ra,f9000454 <bsp_printf>
        plic_release(BSP_PLIC, BSP_PLIC_CPU_0, claim); 
f9000658:	00040613          	mv	a2,s0
f900065c:	00000593          	li	a1,0
f9000660:	f8c00537          	lui	a0,0xf8c00
f9000664:	dd5ff0ef          	jal	ra,f9000438 <plic_release>
f9000668:	fc9ff06f          	j	f9000630 <externalInterrupt+0xc>
        default: crash(); break;
f900066c:	fa1ff0ef          	jal	ra,f900060c <crash>
}
f9000670:	00c12083          	lw	ra,12(sp)
f9000674:	00812403          	lw	s0,8(sp)
f9000678:	01010113          	addi	sp,sp,16
f900067c:	00008067          	ret

f9000680 <trap>:
void trap(){
f9000680:	ff010113          	addi	sp,sp,-16
f9000684:	00112623          	sw	ra,12(sp)
    int32_t mcause = csr_read(mcause);
f9000688:	342027f3          	csrr	a5,mcause
    if(interrupt){
f900068c:	0207d263          	bgez	a5,f90006b0 <trap+0x30>
f9000690:	00f7f713          	andi	a4,a5,15
        switch(cause){
f9000694:	00b00793          	li	a5,11
f9000698:	00f71a63          	bne	a4,a5,f90006ac <trap+0x2c>
        case CAUSE_MACHINE_EXTERNAL: externalInterrupt(); break;
f900069c:	f89ff0ef          	jal	ra,f9000624 <externalInterrupt>
}
f90006a0:	00c12083          	lw	ra,12(sp)
f90006a4:	01010113          	addi	sp,sp,16
f90006a8:	00008067          	ret
        default: crash(); break;
f90006ac:	f61ff0ef          	jal	ra,f900060c <crash>
        crash();
f90006b0:	f5dff0ef          	jal	ra,f900060c <crash>

f90006b4 <main>:
*        demonstrates GPIO 0 interrupt handling by instructing the user to press
*        and release various onboard buttons (sw4, sw6, sw7) corresponding to
*        different timer intervals.
*
******************************************************************************/
void main() {
f90006b4:	fe010113          	addi	sp,sp,-32
f90006b8:	00112e23          	sw	ra,28(sp)
f90006bc:	00812c23          	sw	s0,24(sp)
f90006c0:	00912a23          	sw	s1,20(sp)
f90006c4:	01212823          	sw	s2,16(sp)
f90006c8:	01312623          	sw	s3,12(sp)
    bsp_init();
    bsp_printf("gpio 0 demo ! \r\n");
f90006cc:	f9001537          	lui	a0,0xf9001
f90006d0:	94450513          	addi	a0,a0,-1724 # f9000944 <__freertos_irq_stack_top+0xffffdf14>
f90006d4:	d81ff0ef          	jal	ra,f9000454 <bsp_printf>
    bsp_printf("onboard LEDs blinking \r\n");
f90006d8:	f9001537          	lui	a0,0xf9001
f90006dc:	95850513          	addi	a0,a0,-1704 # f9000958 <__freertos_irq_stack_top+0xffffdf28>
f90006e0:	d75ff0ef          	jal	ra,f9000454 <bsp_printf>
f90006e4:	f80157b7          	lui	a5,0xf8015
f90006e8:	00e00713          	li	a4,14
f90006ec:	00e7a423          	sw	a4,8(a5) # f8015008 <__freertos_irq_stack_top+0xff0125d8>
f90006f0:	0ff00713          	li	a4,255
f90006f4:	00e7a223          	sw	a4,4(a5)
    //configure 4 bits gpio 0
    gpio_setOutputEnable(GPIO0, 0xe);
    gpio_setOutput(GPIO0, 0xff);
    for (int i=0; i<50; i=i+1) {
f90006f8:	00000993          	li	s3,0
f90006fc:	0d40006f          	j	f90007d0 <main+0x11c>
f9000700:	f8015937          	lui	s2,0xf8015
f9000704:	0fe00793          	li	a5,254
f9000708:	00f92223          	sw	a5,4(s2) # f8015004 <__freertos_irq_stack_top+0xff0125d4>
        gpio_setOutput(GPIO0, 0b11111110);
        bsp_uDelay(LOOP_UDELAY);
f900070c:	f8b00637          	lui	a2,0xf8b00
f9000710:	05f5e4b7          	lui	s1,0x5f5e
f9000714:	10048593          	addi	a1,s1,256 # 5f5e100 <__stack_size+0x5f5c100>
f9000718:	00018437          	lui	s0,0x18
f900071c:	6a040513          	addi	a0,s0,1696 # 186a0 <__stack_size+0x166a0>
f9000720:	a25ff0ef          	jal	ra,f9000144 <clint_uDelay>
f9000724:	0fd00793          	li	a5,253
f9000728:	00f92223          	sw	a5,4(s2)
        gpio_setOutput(GPIO0, 0b11111101);
        bsp_uDelay(LOOP_UDELAY);
f900072c:	f8b00637          	lui	a2,0xf8b00
f9000730:	10048593          	addi	a1,s1,256
f9000734:	6a040513          	addi	a0,s0,1696
f9000738:	a0dff0ef          	jal	ra,f9000144 <clint_uDelay>
f900073c:	0fb00793          	li	a5,251
f9000740:	00f92223          	sw	a5,4(s2)
        gpio_setOutput(GPIO0, 0b11111011);
        bsp_uDelay(LOOP_UDELAY);
f9000744:	f8b00637          	lui	a2,0xf8b00
f9000748:	10048593          	addi	a1,s1,256
f900074c:	6a040513          	addi	a0,s0,1696
f9000750:	9f5ff0ef          	jal	ra,f9000144 <clint_uDelay>
f9000754:	0f700793          	li	a5,247
f9000758:	00f92223          	sw	a5,4(s2)
        gpio_setOutput(GPIO0, 0b11110111);
        bsp_uDelay(LOOP_UDELAY);
f900075c:	f8b00637          	lui	a2,0xf8b00
f9000760:	10048593          	addi	a1,s1,256
f9000764:	6a040513          	addi	a0,s0,1696
f9000768:	9ddff0ef          	jal	ra,f9000144 <clint_uDelay>
f900076c:	0ef00793          	li	a5,239
f9000770:	00f92223          	sw	a5,4(s2)
        gpio_setOutput(GPIO0, 0b11101111);
        bsp_uDelay(LOOP_UDELAY);
f9000774:	f8b00637          	lui	a2,0xf8b00
f9000778:	10048593          	addi	a1,s1,256
f900077c:	6a040513          	addi	a0,s0,1696
f9000780:	9c5ff0ef          	jal	ra,f9000144 <clint_uDelay>
f9000784:	0df00793          	li	a5,223
f9000788:	00f92223          	sw	a5,4(s2)
        gpio_setOutput(GPIO0, 0b11011111);
        bsp_uDelay(LOOP_UDELAY);
f900078c:	f8b00637          	lui	a2,0xf8b00
f9000790:	10048593          	addi	a1,s1,256
f9000794:	6a040513          	addi	a0,s0,1696
f9000798:	9adff0ef          	jal	ra,f9000144 <clint_uDelay>
f900079c:	0bf00793          	li	a5,191
f90007a0:	00f92223          	sw	a5,4(s2)
        gpio_setOutput(GPIO0, 0b10111111);
        bsp_uDelay(LOOP_UDELAY);
f90007a4:	f8b00637          	lui	a2,0xf8b00
f90007a8:	10048593          	addi	a1,s1,256
f90007ac:	6a040513          	addi	a0,s0,1696
f90007b0:	995ff0ef          	jal	ra,f9000144 <clint_uDelay>
f90007b4:	07f00793          	li	a5,127
f90007b8:	00f92223          	sw	a5,4(s2)
        gpio_setOutput(GPIO0, 0b01111111);
        bsp_uDelay(LOOP_UDELAY);
f90007bc:	f8b00637          	lui	a2,0xf8b00
f90007c0:	10048593          	addi	a1,s1,256
f90007c4:	6a040513          	addi	a0,s0,1696
f90007c8:	97dff0ef          	jal	ra,f9000144 <clint_uDelay>
    for (int i=0; i<50; i=i+1) {
f90007cc:	00198993          	addi	s3,s3,1
f90007d0:	03100793          	li	a5,49
f90007d4:	f337d6e3          	bge	a5,s3,f9000700 <main+0x4c>

    }   
    bsp_printf("gpio 0 interrupt demo ! \r\n");
f90007d8:	f9001537          	lui	a0,0xf9001
f90007dc:	97450513          	addi	a0,a0,-1676 # f9000974 <__freertos_irq_stack_top+0xffffdf44>
f90007e0:	c75ff0ef          	jal	ra,f9000454 <bsp_printf>
    bsp_printf("Ti180 press and release onboard button sw4 \r\n");
f90007e4:	f9001537          	lui	a0,0xf9001
f90007e8:	99050513          	addi	a0,a0,-1648 # f9000990 <__freertos_irq_stack_top+0xffffdf60>
f90007ec:	c69ff0ef          	jal	ra,f9000454 <bsp_printf>
    bsp_printf("Ti60 press and release onboard button sw6 \r\n");
f90007f0:	f9001537          	lui	a0,0xf9001
f90007f4:	9c050513          	addi	a0,a0,-1600 # f90009c0 <__freertos_irq_stack_top+0xffffdf90>
f90007f8:	c5dff0ef          	jal	ra,f9000454 <bsp_printf>
    bsp_printf("T120 press and release onboard button sw7 \r\n");
f90007fc:	f9001537          	lui	a0,0xf9001
f9000800:	9f050513          	addi	a0,a0,-1552 # f90009f0 <__freertos_irq_stack_top+0xffffdfc0>
f9000804:	c51ff0ef          	jal	ra,f9000454 <bsp_printf>
    init();
f9000808:	d85ff0ef          	jal	ra,f900058c <init>
    while(1); 
f900080c:	0000006f          	j	f900080c <main+0x158>

f9000810 <trap_entry>:
.global  trap_entry
.align(2) //mtvec require 32 bits allignement
trap_entry:
  addi sp,sp, -16*4
f9000810:	fc010113          	addi	sp,sp,-64
  sw x1,   0*4(sp)
f9000814:	00112023          	sw	ra,0(sp)
  sw x5,   1*4(sp)
f9000818:	00512223          	sw	t0,4(sp)
  sw x6,   2*4(sp)
f900081c:	00612423          	sw	t1,8(sp)
  sw x7,   3*4(sp)
f9000820:	00712623          	sw	t2,12(sp)
  sw x10,  4*4(sp)
f9000824:	00a12823          	sw	a0,16(sp)
  sw x11,  5*4(sp)
f9000828:	00b12a23          	sw	a1,20(sp)
  sw x12,  6*4(sp)
f900082c:	00c12c23          	sw	a2,24(sp)
  sw x13,  7*4(sp)
f9000830:	00d12e23          	sw	a3,28(sp)
  sw x14,  8*4(sp)
f9000834:	02e12023          	sw	a4,32(sp)
  sw x15,  9*4(sp)
f9000838:	02f12223          	sw	a5,36(sp)
  sw x16, 10*4(sp)
f900083c:	03012423          	sw	a6,40(sp)
  sw x17, 11*4(sp)
f9000840:	03112623          	sw	a7,44(sp)
  sw x28, 12*4(sp)
f9000844:	03c12823          	sw	t3,48(sp)
  sw x29, 13*4(sp)
f9000848:	03d12a23          	sw	t4,52(sp)
  sw x30, 14*4(sp)
f900084c:	03e12c23          	sw	t5,56(sp)
  sw x31, 15*4(sp)
f9000850:	03f12e23          	sw	t6,60(sp)
  call trap
f9000854:	e2dff0ef          	jal	ra,f9000680 <trap>
  lw x1 ,  0*4(sp)
f9000858:	00012083          	lw	ra,0(sp)
  lw x5,   1*4(sp)
f900085c:	00412283          	lw	t0,4(sp)
  lw x6,   2*4(sp)
f9000860:	00812303          	lw	t1,8(sp)
  lw x7,   3*4(sp)
f9000864:	00c12383          	lw	t2,12(sp)
  lw x10,  4*4(sp)
f9000868:	01012503          	lw	a0,16(sp)
  lw x11,  5*4(sp)
f900086c:	01412583          	lw	a1,20(sp)
  lw x12,  6*4(sp)
f9000870:	01812603          	lw	a2,24(sp)
  lw x13,  7*4(sp)
f9000874:	01c12683          	lw	a3,28(sp)
  lw x14,  8*4(sp)
f9000878:	02012703          	lw	a4,32(sp)
  lw x15,  9*4(sp)
f900087c:	02412783          	lw	a5,36(sp)
  lw x16, 10*4(sp)
f9000880:	02812803          	lw	a6,40(sp)
  lw x17, 11*4(sp)
f9000884:	02c12883          	lw	a7,44(sp)
  lw x28, 12*4(sp)
f9000888:	03012e03          	lw	t3,48(sp)
  lw x29, 13*4(sp)
f900088c:	03412e83          	lw	t4,52(sp)
  lw x30, 14*4(sp)
f9000890:	03812f03          	lw	t5,56(sp)
  lw x31, 15*4(sp)
f9000894:	03c12f83          	lw	t6,60(sp)
  addi sp,sp, 16*4
f9000898:	04010113          	addi	sp,sp,64
  mret
f900089c:	30200073          	mret
