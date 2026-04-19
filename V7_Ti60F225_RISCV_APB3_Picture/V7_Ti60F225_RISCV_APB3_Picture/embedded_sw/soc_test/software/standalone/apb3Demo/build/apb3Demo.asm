
build/apb3Demo.elf:     file format elf32-littleriscv


Disassembly of section .init:

f9000000 <_start>:

_start:
#ifdef USE_GP
.option push
.option norelax
	la gp, __global_pointer$
f9000000:	00008197          	auipc	gp,0x8
f9000004:	f6818193          	addi	gp,gp,-152 # f9007f68 <__global_pointer$>

f9000008 <init>:
	sw a0, smp_lottery_lock, a1
    ret
#endif

init:
	la sp, _sp
f9000008:	0000a117          	auipc	sp,0xa
f900000c:	83810113          	addi	sp,sp,-1992 # f9009840 <__freertos_irq_stack_top>

	/* Load data section */
	la a0, _data_lma
f9000010:	00005517          	auipc	a0,0x5
f9000014:	94850513          	addi	a0,a0,-1720 # f9004958 <_data>
	la a1, _data
f9000018:	00005597          	auipc	a1,0x5
f900001c:	94058593          	addi	a1,a1,-1728 # f9004958 <_data>
	la a2, _edata
f9000020:	8bc18613          	addi	a2,gp,-1860 # f9007824 <j>
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
f900003c:	8bc18513          	addi	a0,gp,-1860 # f9007824 <j>
	la a1, _end
f9000040:	8d018593          	addi	a1,gp,-1840 # f9007838 <_end>
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
f9000054:	01c000ef          	jal	ra,f9000070 <__libc_init_array>
#endif

	call main
f9000058:	325010ef          	jal	ra,f9001b7c <main>

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

f9000070 <__libc_init_array>:
f9000070:	ff010113          	addi	sp,sp,-16
f9000074:	00812423          	sw	s0,8(sp)
f9000078:	01212023          	sw	s2,0(sp)
f900007c:	00005417          	auipc	s0,0x5
f9000080:	8dc40413          	addi	s0,s0,-1828 # f9004958 <_data>
f9000084:	00005917          	auipc	s2,0x5
f9000088:	8d490913          	addi	s2,s2,-1836 # f9004958 <_data>
f900008c:	40890933          	sub	s2,s2,s0
f9000090:	00112623          	sw	ra,12(sp)
f9000094:	00912223          	sw	s1,4(sp)
f9000098:	40295913          	srai	s2,s2,0x2
f900009c:	00090e63          	beqz	s2,f90000b8 <__libc_init_array+0x48>
f90000a0:	00000493          	li	s1,0
f90000a4:	00042783          	lw	a5,0(s0)
f90000a8:	00148493          	addi	s1,s1,1
f90000ac:	00440413          	addi	s0,s0,4
f90000b0:	000780e7          	jalr	a5
f90000b4:	fe9918e3          	bne	s2,s1,f90000a4 <__libc_init_array+0x34>
f90000b8:	00005417          	auipc	s0,0x5
f90000bc:	8a040413          	addi	s0,s0,-1888 # f9004958 <_data>
f90000c0:	00005917          	auipc	s2,0x5
f90000c4:	89890913          	addi	s2,s2,-1896 # f9004958 <_data>
f90000c8:	40890933          	sub	s2,s2,s0
f90000cc:	40295913          	srai	s2,s2,0x2
f90000d0:	00090e63          	beqz	s2,f90000ec <__libc_init_array+0x7c>
f90000d4:	00000493          	li	s1,0
f90000d8:	00042783          	lw	a5,0(s0)
f90000dc:	00148493          	addi	s1,s1,1
f90000e0:	00440413          	addi	s0,s0,4
f90000e4:	000780e7          	jalr	a5
f90000e8:	fe9918e3          	bne	s2,s1,f90000d8 <__libc_init_array+0x68>
f90000ec:	00c12083          	lw	ra,12(sp)
f90000f0:	00812403          	lw	s0,8(sp)
f90000f4:	00412483          	lw	s1,4(sp)
f90000f8:	00012903          	lw	s2,0(sp)
f90000fc:	01010113          	addi	sp,sp,16
f9000100:	00008067          	ret
	...

f9000110 <sh_write0>:
* @note    None.
*
******************************************************************************/

static void sh_write0(char* buf)
{
f9000110:	00050593          	mv	a1,a0
    register int value asm ("a0") = reason;
f9000114:	00400513          	li	a0,4
    register void* ptr asm ("a1") = arg;
f9000118:	00000013          	nop
f900011c:	00000013          	nop
    asm volatile (
f9000120:	01f01013          	slli	zero,zero,0x1f
f9000124:	00100073          	ebreak
f9000128:	40705013          	srai	zero,zero,0x7
f900012c:	00000013          	nop
    // Print zero-terminated string
    call_host(SEMIHOSTING_SYS_WRITE0, (void*) buf);
}
f9000130:	00008067          	ret

f9000134 <_putchar_s>:
*       the character is output using the semihosting function sh_write0().
*       Otherwise, the character is output using the BSP function _putChar().
*
*******************************************************************************/
    static void _putchar_s(char *p)
    {
f9000134:	ff010113          	addi	sp,sp,-16
f9000138:	00112623          	sw	ra,12(sp)
    #if (ENABLE_SEMIHOSTING_PRINT == 1)
        sh_write0(p);
f900013c:	fd5ff0ef          	jal	ra,f9000110 <sh_write0>
    #else
        while (*p)
            _putchar(*(p++));
    #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
f9000140:	00c12083          	lw	ra,12(sp)
f9000144:	01010113          	addi	sp,sp,16
f9000148:	00008067          	ret

f900014c <_out_buffer>:
*
******************************************************************************/

static inline void _out_buffer(char character, void* buffer, size_t idx, size_t maxlen)
{
  if (idx < maxlen) {
f900014c:	00d67663          	bgeu	a2,a3,f9000158 <_out_buffer+0xc>
    ((char*)buffer)[idx] = character;
f9000150:	00c585b3          	add	a1,a1,a2
f9000154:	00a58023          	sb	a0,0(a1)
  }
}
f9000158:	00008067          	ret

f900015c <_out_null>:
*
******************************************************************************/
static inline void _out_null(char character, void* buffer, size_t idx, size_t maxlen)
{
  (void)character; (void)buffer; (void)idx; (void)maxlen;
}
f900015c:	00008067          	ret

f9000160 <_atoi>:
* @return Converted unsigned integer value.
*
******************************************************************************/
static unsigned int _atoi(const char** str)
{
  unsigned int i = 0U;
f9000160:	00000793          	li	a5,0
  while (_is_digit(**str)) {
f9000164:	00052683          	lw	a3,0(a0)
f9000168:	0006c703          	lbu	a4,0(a3)
  return (ch >= '0') && (ch <= '9');
f900016c:	fd070713          	addi	a4,a4,-48
f9000170:	0ff77713          	andi	a4,a4,255
  while (_is_digit(**str)) {
f9000174:	00900613          	li	a2,9
f9000178:	02e66463          	bltu	a2,a4,f90001a0 <_atoi+0x40>
    i = i * 10U + (unsigned int)(*((*str)++) - '0');
f900017c:	00279713          	slli	a4,a5,0x2
f9000180:	00f707b3          	add	a5,a4,a5
f9000184:	00179713          	slli	a4,a5,0x1
f9000188:	00168793          	addi	a5,a3,1
f900018c:	00f52023          	sw	a5,0(a0)
f9000190:	0006c783          	lbu	a5,0(a3)
f9000194:	00e787b3          	add	a5,a5,a4
f9000198:	fd078793          	addi	a5,a5,-48
f900019c:	fc9ff06f          	j	f9000164 <_atoi+0x4>
  }
  return i;
}
f90001a0:	00078513          	mv	a0,a5
f90001a4:	00008067          	ret

f90001a8 <_out_rev>:
*
* @return Updated index in the buffer after outputting the string.
*
******************************************************************************/
static size_t _out_rev(out_fct_type out, char* buffer, size_t idx, size_t maxlen, const char* buf, size_t len, unsigned int width, unsigned int flags)
{
f90001a8:	fd010113          	addi	sp,sp,-48
f90001ac:	02112623          	sw	ra,44(sp)
f90001b0:	02812423          	sw	s0,40(sp)
f90001b4:	02912223          	sw	s1,36(sp)
f90001b8:	03212023          	sw	s2,32(sp)
f90001bc:	01312e23          	sw	s3,28(sp)
f90001c0:	01412c23          	sw	s4,24(sp)
f90001c4:	01512a23          	sw	s5,20(sp)
f90001c8:	01612823          	sw	s6,16(sp)
f90001cc:	01712623          	sw	s7,12(sp)
f90001d0:	01812423          	sw	s8,8(sp)
f90001d4:	01912223          	sw	s9,4(sp)
f90001d8:	00050493          	mv	s1,a0
f90001dc:	00058913          	mv	s2,a1
f90001e0:	00060b93          	mv	s7,a2
f90001e4:	00068993          	mv	s3,a3
f90001e8:	00070b13          	mv	s6,a4
f90001ec:	00078413          	mv	s0,a5
f90001f0:	00080a93          	mv	s5,a6
f90001f4:	00088c13          	mv	s8,a7
  const size_t start_idx = idx;

  // pad spaces up to given width
  if (!(flags & FLAGS_LEFT) && !(flags & FLAGS_ZEROPAD)) {
f90001f8:	0038f793          	andi	a5,a7,3
f90001fc:	02078663          	beqz	a5,f9000228 <_out_rev+0x80>
      out(' ', buffer, idx++, maxlen);
    }
  }

  // reverse string
  while (len) {
f9000200:	04040863          	beqz	s0,f9000250 <_out_rev+0xa8>
    out(buf[--len], buffer, idx++, maxlen);
f9000204:	fff40413          	addi	s0,s0,-1
f9000208:	008b07b3          	add	a5,s6,s0
f900020c:	00160a13          	addi	s4,a2,1
f9000210:	00098693          	mv	a3,s3
f9000214:	00090593          	mv	a1,s2
f9000218:	0007c503          	lbu	a0,0(a5)
f900021c:	000480e7          	jalr	s1
f9000220:	000a0613          	mv	a2,s4
f9000224:	fddff06f          	j	f9000200 <_out_rev+0x58>
    for (size_t i = len; i < width; i++) {
f9000228:	00040a13          	mv	s4,s0
f900022c:	fd5a7ae3          	bgeu	s4,s5,f9000200 <_out_rev+0x58>
      out(' ', buffer, idx++, maxlen);
f9000230:	00160c93          	addi	s9,a2,1
f9000234:	00098693          	mv	a3,s3
f9000238:	00090593          	mv	a1,s2
f900023c:	02000513          	li	a0,32
f9000240:	000480e7          	jalr	s1
    for (size_t i = len; i < width; i++) {
f9000244:	001a0a13          	addi	s4,s4,1
      out(' ', buffer, idx++, maxlen);
f9000248:	000c8613          	mv	a2,s9
f900024c:	fe1ff06f          	j	f900022c <_out_rev+0x84>
  }

  // append pad spaces up to given width
  if (flags & FLAGS_LEFT) {
f9000250:	002c7c13          	andi	s8,s8,2
f9000254:	020c1e63          	bnez	s8,f9000290 <_out_rev+0xe8>
      out(' ', buffer, idx++, maxlen);
    }
  }

  return idx;
}
f9000258:	00060513          	mv	a0,a2
f900025c:	02c12083          	lw	ra,44(sp)
f9000260:	02812403          	lw	s0,40(sp)
f9000264:	02412483          	lw	s1,36(sp)
f9000268:	02012903          	lw	s2,32(sp)
f900026c:	01c12983          	lw	s3,28(sp)
f9000270:	01812a03          	lw	s4,24(sp)
f9000274:	01412a83          	lw	s5,20(sp)
f9000278:	01012b03          	lw	s6,16(sp)
f900027c:	00c12b83          	lw	s7,12(sp)
f9000280:	00812c03          	lw	s8,8(sp)
f9000284:	00412c83          	lw	s9,4(sp)
f9000288:	03010113          	addi	sp,sp,48
f900028c:	00008067          	ret
    while (idx - start_idx < width) {
f9000290:	417607b3          	sub	a5,a2,s7
f9000294:	fd57f2e3          	bgeu	a5,s5,f9000258 <_out_rev+0xb0>
      out(' ', buffer, idx++, maxlen);
f9000298:	00160413          	addi	s0,a2,1
f900029c:	00098693          	mv	a3,s3
f90002a0:	00090593          	mv	a1,s2
f90002a4:	02000513          	li	a0,32
f90002a8:	000480e7          	jalr	s1
f90002ac:	00040613          	mv	a2,s0
f90002b0:	fe1ff06f          	j	f9000290 <_out_rev+0xe8>

f90002b4 <_ntoa_format>:
*
* @return Number of characters written to the buffer.
*
******************************************************************************/
static size_t _ntoa_format(out_fct_type out, char* buffer, size_t idx, size_t maxlen, char* buf, size_t len, bool negative, unsigned int base, unsigned int prec, unsigned int width, unsigned int flags)
{
f90002b4:	ff010113          	addi	sp,sp,-16
f90002b8:	00112623          	sw	ra,12(sp)
f90002bc:	00080f93          	mv	t6,a6
f90002c0:	00088f13          	mv	t5,a7
f90002c4:	01012e83          	lw	t4,16(sp)
f90002c8:	01412803          	lw	a6,20(sp)
f90002cc:	01812883          	lw	a7,24(sp)
  // pad leading zeros
  if (!(flags & FLAGS_LEFT)) {
f90002d0:	0028f313          	andi	t1,a7,2
f90002d4:	06031263          	bnez	t1,f9000338 <_ntoa_format+0x84>
    if (width && (flags & FLAGS_ZEROPAD) && (negative || (flags & (FLAGS_PLUS | FLAGS_SPACE)))) {
f90002d8:	00080e63          	beqz	a6,f90002f4 <_ntoa_format+0x40>
f90002dc:	0018f313          	andi	t1,a7,1
f90002e0:	00030a63          	beqz	t1,f90002f4 <_ntoa_format+0x40>
f90002e4:	000f9663          	bnez	t6,f90002f0 <_ntoa_format+0x3c>
f90002e8:	00c8f313          	andi	t1,a7,12
f90002ec:	00030463          	beqz	t1,f90002f4 <_ntoa_format+0x40>
      width--;
f90002f0:	fff80813          	addi	a6,a6,-1
    }
    while ((len < prec) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
f90002f4:	03d7f863          	bgeu	a5,t4,f9000324 <_ntoa_format+0x70>
f90002f8:	01f00313          	li	t1,31
f90002fc:	02f36463          	bltu	t1,a5,f9000324 <_ntoa_format+0x70>
      buf[len++] = '0';
f9000300:	00f70333          	add	t1,a4,a5
f9000304:	03000e13          	li	t3,48
f9000308:	01c30023          	sb	t3,0(t1)
f900030c:	00178793          	addi	a5,a5,1
f9000310:	fe5ff06f          	j	f90002f4 <_ntoa_format+0x40>
    }
    while ((flags & FLAGS_ZEROPAD) && (len < width) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
      buf[len++] = '0';
f9000314:	00f70333          	add	t1,a4,a5
f9000318:	03000e13          	li	t3,48
f900031c:	01c30023          	sb	t3,0(t1)
f9000320:	00178793          	addi	a5,a5,1
    while ((flags & FLAGS_ZEROPAD) && (len < width) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
f9000324:	0018f313          	andi	t1,a7,1
f9000328:	00030863          	beqz	t1,f9000338 <_ntoa_format+0x84>
f900032c:	0107f663          	bgeu	a5,a6,f9000338 <_ntoa_format+0x84>
f9000330:	01f00313          	li	t1,31
f9000334:	fef370e3          	bgeu	t1,a5,f9000314 <_ntoa_format+0x60>
    }
  }

  // handle hash
  if (flags & FLAGS_HASH) {
f9000338:	0108f313          	andi	t1,a7,16
f900033c:	04030463          	beqz	t1,f9000384 <_ntoa_format+0xd0>
    if (!(flags & FLAGS_PRECISION) && len && ((len == prec) || (len == width))) {
f9000340:	4008f313          	andi	t1,a7,1024
f9000344:	00031863          	bnez	t1,f9000354 <_ntoa_format+0xa0>
f9000348:	00078663          	beqz	a5,f9000354 <_ntoa_format+0xa0>
f900034c:	07d78263          	beq	a5,t4,f90003b0 <_ntoa_format+0xfc>
f9000350:	07078063          	beq	a5,a6,f90003b0 <_ntoa_format+0xfc>
      len--;
      if (len && (base == 16U)) {
        len--;
      }
    }
    if ((base == 16U) && !(flags & FLAGS_UPPERCASE) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
f9000354:	01000313          	li	t1,16
f9000358:	086f0063          	beq	t5,t1,f90003d8 <_ntoa_format+0x124>
      buf[len++] = 'x';
    }
    else if ((base == 16U) && (flags & FLAGS_UPPERCASE) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
f900035c:	01000313          	li	t1,16
f9000360:	086f0e63          	beq	t5,t1,f90003fc <_ntoa_format+0x148>
      buf[len++] = 'X';
    }
    else if ((base == 2U) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
f9000364:	00200313          	li	t1,2
f9000368:	0a6f0c63          	beq	t5,t1,f9000420 <_ntoa_format+0x16c>
      buf[len++] = 'b';
    }
    if (len < PRINTF_NTOA_BUFFER_SIZE) {
f900036c:	01f00313          	li	t1,31
f9000370:	00f36a63          	bltu	t1,a5,f9000384 <_ntoa_format+0xd0>
      buf[len++] = '0';
f9000374:	00f70333          	add	t1,a4,a5
f9000378:	03000e13          	li	t3,48
f900037c:	01c30023          	sb	t3,0(t1)
f9000380:	00178793          	addi	a5,a5,1
    }
  }

  if (len < PRINTF_NTOA_BUFFER_SIZE) {
f9000384:	01f00313          	li	t1,31
f9000388:	00f36c63          	bltu	t1,a5,f90003a0 <_ntoa_format+0xec>
    if (negative) {
f900038c:	0a0f8863          	beqz	t6,f900043c <_ntoa_format+0x188>
      buf[len++] = '-';
f9000390:	00f70333          	add	t1,a4,a5
f9000394:	02d00e13          	li	t3,45
f9000398:	01c30023          	sb	t3,0(t1)
f900039c:	00178793          	addi	a5,a5,1
    else if (flags & FLAGS_SPACE) {
      buf[len++] = ' ';
    }
  }

  return _out_rev(out, buffer, idx, maxlen, buf, len, width, flags);
f90003a0:	e09ff0ef          	jal	ra,f90001a8 <_out_rev>
}
f90003a4:	00c12083          	lw	ra,12(sp)
f90003a8:	01010113          	addi	sp,sp,16
f90003ac:	00008067          	ret
      len--;
f90003b0:	fff78313          	addi	t1,a5,-1
      if (len && (base == 16U)) {
f90003b4:	00030e63          	beqz	t1,f90003d0 <_ntoa_format+0x11c>
f90003b8:	01000e13          	li	t3,16
f90003bc:	01cf0663          	beq	t5,t3,f90003c8 <_ntoa_format+0x114>
      len--;
f90003c0:	00030793          	mv	a5,t1
f90003c4:	f91ff06f          	j	f9000354 <_ntoa_format+0xa0>
        len--;
f90003c8:	ffe78793          	addi	a5,a5,-2
f90003cc:	f89ff06f          	j	f9000354 <_ntoa_format+0xa0>
      len--;
f90003d0:	00030793          	mv	a5,t1
f90003d4:	f81ff06f          	j	f9000354 <_ntoa_format+0xa0>
    if ((base == 16U) && !(flags & FLAGS_UPPERCASE) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
f90003d8:	0208f313          	andi	t1,a7,32
f90003dc:	f80310e3          	bnez	t1,f900035c <_ntoa_format+0xa8>
f90003e0:	01f00313          	li	t1,31
f90003e4:	f6f36ce3          	bltu	t1,a5,f900035c <_ntoa_format+0xa8>
      buf[len++] = 'x';
f90003e8:	00f70333          	add	t1,a4,a5
f90003ec:	07800e13          	li	t3,120
f90003f0:	01c30023          	sb	t3,0(t1)
f90003f4:	00178793          	addi	a5,a5,1
f90003f8:	f75ff06f          	j	f900036c <_ntoa_format+0xb8>
    else if ((base == 16U) && (flags & FLAGS_UPPERCASE) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
f90003fc:	0208f313          	andi	t1,a7,32
f9000400:	f60302e3          	beqz	t1,f9000364 <_ntoa_format+0xb0>
f9000404:	01f00313          	li	t1,31
f9000408:	f4f36ee3          	bltu	t1,a5,f9000364 <_ntoa_format+0xb0>
      buf[len++] = 'X';
f900040c:	00f70333          	add	t1,a4,a5
f9000410:	05800e13          	li	t3,88
f9000414:	01c30023          	sb	t3,0(t1)
f9000418:	00178793          	addi	a5,a5,1
f900041c:	f51ff06f          	j	f900036c <_ntoa_format+0xb8>
    else if ((base == 2U) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
f9000420:	01f00313          	li	t1,31
f9000424:	f4f364e3          	bltu	t1,a5,f900036c <_ntoa_format+0xb8>
      buf[len++] = 'b';
f9000428:	00f70333          	add	t1,a4,a5
f900042c:	06200e13          	li	t3,98
f9000430:	01c30023          	sb	t3,0(t1)
f9000434:	00178793          	addi	a5,a5,1
f9000438:	f35ff06f          	j	f900036c <_ntoa_format+0xb8>
    else if (flags & FLAGS_PLUS) {
f900043c:	0048f313          	andi	t1,a7,4
f9000440:	00030c63          	beqz	t1,f9000458 <_ntoa_format+0x1a4>
      buf[len++] = '+';  // ignore the space if the '+' exists
f9000444:	00f70333          	add	t1,a4,a5
f9000448:	02b00e13          	li	t3,43
f900044c:	01c30023          	sb	t3,0(t1)
f9000450:	00178793          	addi	a5,a5,1
f9000454:	f4dff06f          	j	f90003a0 <_ntoa_format+0xec>
    else if (flags & FLAGS_SPACE) {
f9000458:	0088f313          	andi	t1,a7,8
f900045c:	f40302e3          	beqz	t1,f90003a0 <_ntoa_format+0xec>
      buf[len++] = ' ';
f9000460:	00f70333          	add	t1,a4,a5
f9000464:	02000e13          	li	t3,32
f9000468:	01c30023          	sb	t3,0(t1)
f900046c:	00178793          	addi	a5,a5,1
f9000470:	f31ff06f          	j	f90003a0 <_ntoa_format+0xec>

f9000474 <_ntoa_long>:
* @return Number of characters written to the buffer.
*
*
******************************************************************************/
static size_t _ntoa_long(out_fct_type out, char* buffer, size_t idx, size_t maxlen, unsigned long value, bool negative, unsigned long base, unsigned int prec, unsigned int width, unsigned int flags)
{
f9000474:	fc010113          	addi	sp,sp,-64
f9000478:	02112e23          	sw	ra,60(sp)
f900047c:	00078f93          	mv	t6,a5
f9000480:	04412f03          	lw	t5,68(sp)
  char buf[PRINTF_NTOA_BUFFER_SIZE];
  size_t len = 0U;

  // no hash for 0 values
  if (!value) {
f9000484:	00071463          	bnez	a4,f900048c <_ntoa_long+0x18>
    flags &= ~FLAGS_HASH;
f9000488:	feff7f13          	andi	t5,t5,-17
  }

  // write if precision != 0 and value is != 0
  if (!(flags & FLAGS_PRECISION) || value) {
f900048c:	400f7e93          	andi	t4,t5,1024
f9000490:	040e8a63          	beqz	t4,f90004e4 <_ntoa_long+0x70>
f9000494:	06070a63          	beqz	a4,f9000508 <_ntoa_long+0x94>
f9000498:	00000e93          	li	t4,0
f900049c:	0480006f          	j	f90004e4 <_ntoa_long+0x70>
    do {
      const char digit = (char)(value % base);
      buf[len++] = digit < 10 ? '0' + digit : (flags & FLAGS_UPPERCASE ? 'A' : 'a') + digit - 10;
f90004a0:	020f7313          	andi	t1,t5,32
f90004a4:	04030e63          	beqz	t1,f9000500 <_ntoa_long+0x8c>
f90004a8:	04100313          	li	t1,65
f90004ac:	01c30333          	add	t1,t1,t3
f90004b0:	0ff37313          	andi	t1,t1,255
f90004b4:	ff630313          	addi	t1,t1,-10
f90004b8:	0ff37313          	andi	t1,t1,255
f90004bc:	001e8793          	addi	a5,t4,1
f90004c0:	03010e13          	addi	t3,sp,48
f90004c4:	01de0eb3          	add	t4,t3,t4
f90004c8:	fe6e8023          	sb	t1,-32(t4)
      value /= base;
f90004cc:	03075333          	divu	t1,a4,a6
    } while (value && (len < PRINTF_NTOA_BUFFER_SIZE));
f90004d0:	03076e63          	bltu	a4,a6,f900050c <_ntoa_long+0x98>
f90004d4:	01f00713          	li	a4,31
f90004d8:	02f76a63          	bltu	a4,a5,f900050c <_ntoa_long+0x98>
      buf[len++] = digit < 10 ? '0' + digit : (flags & FLAGS_UPPERCASE ? 'A' : 'a') + digit - 10;
f90004dc:	00078e93          	mv	t4,a5
      value /= base;
f90004e0:	00030713          	mv	a4,t1
      const char digit = (char)(value % base);
f90004e4:	03077333          	remu	t1,a4,a6
f90004e8:	0ff37e13          	andi	t3,t1,255
      buf[len++] = digit < 10 ? '0' + digit : (flags & FLAGS_UPPERCASE ? 'A' : 'a') + digit - 10;
f90004ec:	00900313          	li	t1,9
f90004f0:	fbc368e3          	bltu	t1,t3,f90004a0 <_ntoa_long+0x2c>
f90004f4:	030e0313          	addi	t1,t3,48
f90004f8:	0ff37313          	andi	t1,t1,255
f90004fc:	fc1ff06f          	j	f90004bc <_ntoa_long+0x48>
f9000500:	06100313          	li	t1,97
f9000504:	fa9ff06f          	j	f90004ac <_ntoa_long+0x38>
  size_t len = 0U;
f9000508:	00070793          	mv	a5,a4
  }

  return _ntoa_format(out, buffer, idx, maxlen, buf, len, negative, (unsigned int)base, prec, width, flags);
f900050c:	01e12423          	sw	t5,8(sp)
f9000510:	04012703          	lw	a4,64(sp)
f9000514:	00e12223          	sw	a4,4(sp)
f9000518:	01112023          	sw	a7,0(sp)
f900051c:	00080893          	mv	a7,a6
f9000520:	000f8813          	mv	a6,t6
f9000524:	01010713          	addi	a4,sp,16
f9000528:	d8dff0ef          	jal	ra,f90002b4 <_ntoa_format>
}
f900052c:	03c12083          	lw	ra,60(sp)
f9000530:	04010113          	addi	sp,sp,64
f9000534:	00008067          	ret

f9000538 <_ntoa_long_long>:
*
* @return Number of characters written to the buffer.
*
******************************************************************************/
static size_t _ntoa_long_long(out_fct_type out, char* buffer, size_t idx, size_t maxlen, unsigned long long value, bool negative, unsigned long long base, unsigned int prec, unsigned int width, unsigned int flags)
{
f9000538:	f8010113          	addi	sp,sp,-128
f900053c:	06112623          	sw	ra,108(sp)
f9000540:	06812423          	sw	s0,104(sp)
f9000544:	06912223          	sw	s1,100(sp)
f9000548:	07212023          	sw	s2,96(sp)
f900054c:	05312e23          	sw	s3,92(sp)
f9000550:	05412c23          	sw	s4,88(sp)
f9000554:	05512a23          	sw	s5,84(sp)
f9000558:	05612823          	sw	s6,80(sp)
f900055c:	05712623          	sw	s7,76(sp)
f9000560:	05812423          	sw	s8,72(sp)
f9000564:	05912223          	sw	s9,68(sp)
f9000568:	05a12023          	sw	s10,64(sp)
f900056c:	03b12e23          	sw	s11,60(sp)
f9000570:	00050b93          	mv	s7,a0
f9000574:	00058c13          	mv	s8,a1
f9000578:	00060c93          	mv	s9,a2
f900057c:	00068d13          	mv	s10,a3
f9000580:	00070993          	mv	s3,a4
f9000584:	00078493          	mv	s1,a5
f9000588:	00080d93          	mv	s11,a6
f900058c:	07112e23          	sw	a7,124(sp)
f9000590:	00088a93          	mv	s5,a7
f9000594:	08012903          	lw	s2,128(sp)
f9000598:	08c12b03          	lw	s6,140(sp)
  char buf[PRINTF_NTOA_BUFFER_SIZE];
  size_t len = 0U;

  // no hash for 0 values
  if (!value) {
f900059c:	009767b3          	or	a5,a4,s1
f90005a0:	00079463          	bnez	a5,f90005a8 <_ntoa_long_long+0x70>
    flags &= ~FLAGS_HASH;
f90005a4:	fefb7b13          	andi	s6,s6,-17
  }

  // write if precision != 0 and value is != 0
  if (!(flags & FLAGS_PRECISION) || value) {
f90005a8:	400b7413          	andi	s0,s6,1024
f90005ac:	06040863          	beqz	s0,f900061c <_ntoa_long_long+0xe4>
f90005b0:	0099e7b3          	or	a5,s3,s1
f90005b4:	0a078263          	beqz	a5,f9000658 <_ntoa_long_long+0x120>
f90005b8:	00000413          	li	s0,0
f90005bc:	0600006f          	j	f900061c <_ntoa_long_long+0xe4>
    do {
      const char digit = (char)(value % base);
      buf[len++] = digit < 10 ? '0' + digit : (flags & FLAGS_UPPERCASE ? 'A' : 'a') + digit - 10;
f90005c0:	020b7793          	andi	a5,s6,32
f90005c4:	08078263          	beqz	a5,f9000648 <_ntoa_long_long+0x110>
f90005c8:	04100793          	li	a5,65
f90005cc:	00a78533          	add	a0,a5,a0
f90005d0:	0ff57513          	andi	a0,a0,255
f90005d4:	ff650513          	addi	a0,a0,-10
f90005d8:	0ff57513          	andi	a0,a0,255
f90005dc:	00140a13          	addi	s4,s0,1
f90005e0:	03010793          	addi	a5,sp,48
f90005e4:	00878433          	add	s0,a5,s0
f90005e8:	fea40023          	sb	a0,-32(s0)
      value /= base;
f90005ec:	000a8613          	mv	a2,s5
f90005f0:	00090693          	mv	a3,s2
f90005f4:	00098513          	mv	a0,s3
f90005f8:	00048593          	mv	a1,s1
f90005fc:	5e4010ef          	jal	ra,f9001be0 <__udivdi3>
    } while (value && (len < PRINTF_NTOA_BUFFER_SIZE));
f9000600:	0524ee63          	bltu	s1,s2,f900065c <_ntoa_long_long+0x124>
f9000604:	04990663          	beq	s2,s1,f9000650 <_ntoa_long_long+0x118>
f9000608:	01f00793          	li	a5,31
f900060c:	0547e863          	bltu	a5,s4,f900065c <_ntoa_long_long+0x124>
      buf[len++] = digit < 10 ? '0' + digit : (flags & FLAGS_UPPERCASE ? 'A' : 'a') + digit - 10;
f9000610:	000a0413          	mv	s0,s4
      value /= base;
f9000614:	00050993          	mv	s3,a0
f9000618:	00058493          	mv	s1,a1
      const char digit = (char)(value % base);
f900061c:	000a8613          	mv	a2,s5
f9000620:	00090693          	mv	a3,s2
f9000624:	00098513          	mv	a0,s3
f9000628:	00048593          	mv	a1,s1
f900062c:	255010ef          	jal	ra,f9002080 <__umoddi3>
f9000630:	0ff57513          	andi	a0,a0,255
      buf[len++] = digit < 10 ? '0' + digit : (flags & FLAGS_UPPERCASE ? 'A' : 'a') + digit - 10;
f9000634:	00900793          	li	a5,9
f9000638:	f8a7e4e3          	bltu	a5,a0,f90005c0 <_ntoa_long_long+0x88>
f900063c:	03050513          	addi	a0,a0,48
f9000640:	0ff57513          	andi	a0,a0,255
f9000644:	f99ff06f          	j	f90005dc <_ntoa_long_long+0xa4>
f9000648:	06100793          	li	a5,97
f900064c:	f81ff06f          	j	f90005cc <_ntoa_long_long+0x94>
    } while (value && (len < PRINTF_NTOA_BUFFER_SIZE));
f9000650:	fb59fce3          	bgeu	s3,s5,f9000608 <_ntoa_long_long+0xd0>
f9000654:	0080006f          	j	f900065c <_ntoa_long_long+0x124>
  size_t len = 0U;
f9000658:	00000a13          	li	s4,0
  }

  return _ntoa_format(out, buffer, idx, maxlen, buf, len, negative, (unsigned int)base, prec, width, flags);
f900065c:	01612423          	sw	s6,8(sp)
f9000660:	08812783          	lw	a5,136(sp)
f9000664:	00f12223          	sw	a5,4(sp)
f9000668:	08412783          	lw	a5,132(sp)
f900066c:	00f12023          	sw	a5,0(sp)
f9000670:	000a8893          	mv	a7,s5
f9000674:	000d8813          	mv	a6,s11
f9000678:	000a0793          	mv	a5,s4
f900067c:	01010713          	addi	a4,sp,16
f9000680:	000d0693          	mv	a3,s10
f9000684:	000c8613          	mv	a2,s9
f9000688:	000c0593          	mv	a1,s8
f900068c:	000b8513          	mv	a0,s7
f9000690:	c25ff0ef          	jal	ra,f90002b4 <_ntoa_format>
}
f9000694:	06c12083          	lw	ra,108(sp)
f9000698:	06812403          	lw	s0,104(sp)
f900069c:	06412483          	lw	s1,100(sp)
f90006a0:	06012903          	lw	s2,96(sp)
f90006a4:	05c12983          	lw	s3,92(sp)
f90006a8:	05812a03          	lw	s4,88(sp)
f90006ac:	05412a83          	lw	s5,84(sp)
f90006b0:	05012b03          	lw	s6,80(sp)
f90006b4:	04c12b83          	lw	s7,76(sp)
f90006b8:	04812c03          	lw	s8,72(sp)
f90006bc:	04412c83          	lw	s9,68(sp)
f90006c0:	04012d03          	lw	s10,64(sp)
f90006c4:	03c12d83          	lw	s11,60(sp)
f90006c8:	08010113          	addi	sp,sp,128
f90006cc:	00008067          	ret

f90006d0 <_etoa>:
*
* @note           Contributed by: Martijn Jasperse <m.jasperse@gmail.com>
*
******************************************************************************/
static size_t _etoa(out_fct_type out, char* buffer, size_t idx, size_t maxlen, double value, unsigned int prec, unsigned int width, unsigned int flags)
{
f90006d0:	f8010113          	addi	sp,sp,-128
f90006d4:	06112e23          	sw	ra,124(sp)
f90006d8:	06812c23          	sw	s0,120(sp)
f90006dc:	06912a23          	sw	s1,116(sp)
f90006e0:	07212823          	sw	s2,112(sp)
f90006e4:	07312623          	sw	s3,108(sp)
f90006e8:	07412423          	sw	s4,104(sp)
f90006ec:	07512223          	sw	s5,100(sp)
f90006f0:	07612023          	sw	s6,96(sp)
f90006f4:	05712e23          	sw	s7,92(sp)
f90006f8:	05812c23          	sw	s8,88(sp)
f90006fc:	05912a23          	sw	s9,84(sp)
f9000700:	05a12823          	sw	s10,80(sp)
f9000704:	05b12623          	sw	s11,76(sp)
f9000708:	00050b13          	mv	s6,a0
f900070c:	00b12e23          	sw	a1,28(sp)
f9000710:	00060d13          	mv	s10,a2
f9000714:	02d12023          	sw	a3,32(sp)
f9000718:	00070493          	mv	s1,a4
f900071c:	00078413          	mv	s0,a5
f9000720:	00080b93          	mv	s7,a6
f9000724:	00088c93          	mv	s9,a7
f9000728:	08012903          	lw	s2,128(sp)
  // check for NaN and special values
  if ((value != value) || (value > DBL_MAX) || (value < -DBL_MAX)) {
f900072c:	00048613          	mv	a2,s1
f9000730:	00040693          	mv	a3,s0
f9000734:	00048513          	mv	a0,s1
f9000738:	00040593          	mv	a1,s0
f900073c:	5a5020ef          	jal	ra,f90034e0 <__eqdf2>
f9000740:	42051463          	bnez	a0,f9000b68 <_etoa+0x498>
f9000744:	8181a603          	lw	a2,-2024(gp) # f9007780 <cycle_times+0x8>
f9000748:	81c1a683          	lw	a3,-2020(gp) # f9007784 <cycle_times+0xc>
f900074c:	00048513          	mv	a0,s1
f9000750:	00040593          	mv	a1,s0
f9000754:	619020ef          	jal	ra,f900356c <__gedf2>
f9000758:	40a04863          	bgtz	a0,f9000b68 <_etoa+0x498>
f900075c:	8201a603          	lw	a2,-2016(gp) # f9007788 <cycle_times+0x10>
f9000760:	8241a683          	lw	a3,-2012(gp) # f900778c <cycle_times+0x14>
f9000764:	00048513          	mv	a0,s1
f9000768:	00040593          	mv	a1,s0
f900076c:	6fd020ef          	jal	ra,f9003668 <__ledf2>
f9000770:	3e054c63          	bltz	a0,f9000b68 <_etoa+0x498>
    return _ftoa(out, buffer, idx, maxlen, value, prec, width, flags);
  }

  // determine the sign
  const bool negative = value < 0;
  if (negative) {
f9000774:	00000613          	li	a2,0
f9000778:	00000693          	li	a3,0
f900077c:	00048513          	mv	a0,s1
f9000780:	00040593          	mv	a1,s0
f9000784:	6e5020ef          	jal	ra,f9003668 <__ledf2>
f9000788:	44054263          	bltz	a0,f9000bcc <_etoa+0x4fc>
f900078c:	02912223          	sw	s1,36(sp)
f9000790:	00040993          	mv	s3,s0
    value = -value;
  }

  // default precision
  if (!(flags & FLAGS_PRECISION)) {
f9000794:	40097c13          	andi	s8,s2,1024
f9000798:	000c1463          	bnez	s8,f90007a0 <_etoa+0xd0>
    prec = PRINTF_DEFAULT_FLOAT_PRECISION;
f900079c:	00400b93          	li	s7,4
    uint64_t U;
    double   F;
  } conv;

  conv.F = value;
  int exp2 = (int)((conv.U >> 52U) & 0x07FFU) - 1023;           // effectively log2
f90007a0:	0149d513          	srli	a0,s3,0x14
f90007a4:	7ff57513          	andi	a0,a0,2047
  conv.U = (conv.U & ((1ULL << 52U) - 1U)) | (1023ULL << 52U);  // drop the exponent so conv.F is now in [1,2)
f90007a8:	00100db7          	lui	s11,0x100
f90007ac:	fffd8d93          	addi	s11,s11,-1 # fffff <__stack_size+0xfdfff>
f90007b0:	01b9fdb3          	and	s11,s3,s11
f90007b4:	3ff007b7          	lui	a5,0x3ff00
f90007b8:	01b7edb3          	or	s11,a5,s11
  // now approximate log10 from the log2 integer part and an expansion of ln around 1.5
  int expval = (int)(0.1760912590558 + exp2 * 0.301029995663981 + (conv.F - 1.5) * 0.289529654602168);
f90007bc:	c0150513          	addi	a0,a0,-1023
f90007c0:	775030ef          	jal	ra,f9004734 <__floatsidf>
f90007c4:	8281a603          	lw	a2,-2008(gp) # f9007790 <cycle_times+0x18>
f90007c8:	82c1a683          	lw	a3,-2004(gp) # f9007794 <cycle_times+0x1c>
f90007cc:	79d020ef          	jal	ra,f9003768 <__muldf3>
f90007d0:	8301a603          	lw	a2,-2000(gp) # f9007798 <cycle_times+0x20>
f90007d4:	8341a683          	lw	a3,-1996(gp) # f900779c <cycle_times+0x24>
f90007d8:	509010ef          	jal	ra,f90024e0 <__adddf3>
f90007dc:	00050a13          	mv	s4,a0
f90007e0:	00058a93          	mv	s5,a1
f90007e4:	8381a603          	lw	a2,-1992(gp) # f90077a0 <cycle_times+0x28>
f90007e8:	83c1a683          	lw	a3,-1988(gp) # f90077a4 <cycle_times+0x2c>
f90007ec:	02412703          	lw	a4,36(sp)
f90007f0:	00070513          	mv	a0,a4
f90007f4:	000d8593          	mv	a1,s11
f90007f8:	5c4030ef          	jal	ra,f9003dbc <__subdf3>
f90007fc:	8401a603          	lw	a2,-1984(gp) # f90077a8 <cycle_times+0x30>
f9000800:	8441a683          	lw	a3,-1980(gp) # f90077ac <cycle_times+0x34>
f9000804:	765020ef          	jal	ra,f9003768 <__muldf3>
f9000808:	00050613          	mv	a2,a0
f900080c:	00058693          	mv	a3,a1
f9000810:	000a0513          	mv	a0,s4
f9000814:	000a8593          	mv	a1,s5
f9000818:	4c9010ef          	jal	ra,f90024e0 <__adddf3>
f900081c:	61d030ef          	jal	ra,f9004638 <__fixdfsi>
f9000820:	00050d93          	mv	s11,a0
  // now we want to compute 10^expval but we want to be sure it won't overflow
  exp2 = (int)(expval * 3.321928094887362 + 0.5);
f9000824:	711030ef          	jal	ra,f9004734 <__floatsidf>
f9000828:	02a12423          	sw	a0,40(sp)
f900082c:	02b12623          	sw	a1,44(sp)
f9000830:	8481a603          	lw	a2,-1976(gp) # f90077b0 <cycle_times+0x38>
f9000834:	84c1a683          	lw	a3,-1972(gp) # f90077b4 <cycle_times+0x3c>
f9000838:	731020ef          	jal	ra,f9003768 <__muldf3>
f900083c:	8501a603          	lw	a2,-1968(gp) # f90077b8 <cycle_times+0x40>
f9000840:	8541a683          	lw	a3,-1964(gp) # f90077bc <cycle_times+0x44>
f9000844:	49d010ef          	jal	ra,f90024e0 <__adddf3>
f9000848:	5f1030ef          	jal	ra,f9004638 <__fixdfsi>
f900084c:	00050a13          	mv	s4,a0
  const double z  = expval * 2.302585092994046 - exp2 * 0.6931471805599453;
f9000850:	8581a603          	lw	a2,-1960(gp) # f90077c0 <cycle_times+0x48>
f9000854:	85c1a683          	lw	a3,-1956(gp) # f90077c4 <cycle_times+0x4c>
f9000858:	02812503          	lw	a0,40(sp)
f900085c:	02c12583          	lw	a1,44(sp)
f9000860:	709020ef          	jal	ra,f9003768 <__muldf3>
f9000864:	02a12423          	sw	a0,40(sp)
f9000868:	02b12623          	sw	a1,44(sp)
f900086c:	000a0513          	mv	a0,s4
f9000870:	6c5030ef          	jal	ra,f9004734 <__floatsidf>
f9000874:	8601a603          	lw	a2,-1952(gp) # f90077c8 <cycle_times+0x50>
f9000878:	8641a683          	lw	a3,-1948(gp) # f90077cc <cycle_times+0x54>
f900087c:	6ed020ef          	jal	ra,f9003768 <__muldf3>
f9000880:	00050613          	mv	a2,a0
f9000884:	00058693          	mv	a3,a1
f9000888:	02812503          	lw	a0,40(sp)
f900088c:	02c12583          	lw	a1,44(sp)
f9000890:	52c030ef          	jal	ra,f9003dbc <__subdf3>
  const double z2 = z * z;
f9000894:	02a12423          	sw	a0,40(sp)
f9000898:	02b12623          	sw	a1,44(sp)
f900089c:	00050613          	mv	a2,a0
f90008a0:	00058693          	mv	a3,a1
f90008a4:	6c5020ef          	jal	ra,f9003768 <__muldf3>
f90008a8:	02a12823          	sw	a0,48(sp)
f90008ac:	02b12a23          	sw	a1,52(sp)
  conv.U = (uint64_t)(exp2 + 1023) << 52U;
f90008b0:	3ffa0793          	addi	a5,s4,1023
f90008b4:	01479a13          	slli	s4,a5,0x14
  // compute exp(z) using continued fractions, see https://en.wikipedia.org/wiki/Exponential_function#Continued_fractions_for_ex
  conv.F *= 1 + 2 * z / (2 - z + (z2 / (6 + (z2 / (10 + z2 / 14)))));
f90008b8:	02812783          	lw	a5,40(sp)
f90008bc:	02c12803          	lw	a6,44(sp)
f90008c0:	00078613          	mv	a2,a5
f90008c4:	00080693          	mv	a3,a6
f90008c8:	00078513          	mv	a0,a5
f90008cc:	00080593          	mv	a1,a6
f90008d0:	411010ef          	jal	ra,f90024e0 <__adddf3>
f90008d4:	02a12c23          	sw	a0,56(sp)
f90008d8:	02b12e23          	sw	a1,60(sp)
f90008dc:	02812603          	lw	a2,40(sp)
f90008e0:	02c12683          	lw	a3,44(sp)
f90008e4:	8681a503          	lw	a0,-1944(gp) # f90077d0 <cycle_times+0x58>
f90008e8:	86c1a583          	lw	a1,-1940(gp) # f90077d4 <cycle_times+0x5c>
f90008ec:	4d0030ef          	jal	ra,f9003dbc <__subdf3>
f90008f0:	02a12423          	sw	a0,40(sp)
f90008f4:	02b12623          	sw	a1,44(sp)
f90008f8:	8701a603          	lw	a2,-1936(gp) # f90077d8 <cycle_times+0x60>
f90008fc:	8741a683          	lw	a3,-1932(gp) # f90077dc <cycle_times+0x64>
f9000900:	03012503          	lw	a0,48(sp)
f9000904:	03412583          	lw	a1,52(sp)
f9000908:	45c020ef          	jal	ra,f9002d64 <__divdf3>
f900090c:	8781a603          	lw	a2,-1928(gp) # f90077e0 <cycle_times+0x68>
f9000910:	87c1a683          	lw	a3,-1924(gp) # f90077e4 <cycle_times+0x6c>
f9000914:	3cd010ef          	jal	ra,f90024e0 <__adddf3>
f9000918:	00050613          	mv	a2,a0
f900091c:	00058693          	mv	a3,a1
f9000920:	03012503          	lw	a0,48(sp)
f9000924:	03412583          	lw	a1,52(sp)
f9000928:	43c020ef          	jal	ra,f9002d64 <__divdf3>
f900092c:	8801a603          	lw	a2,-1920(gp) # f90077e8 <cycle_times+0x70>
f9000930:	8841a683          	lw	a3,-1916(gp) # f90077ec <cycle_times+0x74>
f9000934:	3ad010ef          	jal	ra,f90024e0 <__adddf3>
f9000938:	00050613          	mv	a2,a0
f900093c:	00058693          	mv	a3,a1
f9000940:	03012503          	lw	a0,48(sp)
f9000944:	03412583          	lw	a1,52(sp)
f9000948:	41c020ef          	jal	ra,f9002d64 <__divdf3>
f900094c:	00050613          	mv	a2,a0
f9000950:	00058693          	mv	a3,a1
f9000954:	02812503          	lw	a0,40(sp)
f9000958:	02c12583          	lw	a1,44(sp)
f900095c:	385010ef          	jal	ra,f90024e0 <__adddf3>
f9000960:	00050613          	mv	a2,a0
f9000964:	00058693          	mv	a3,a1
f9000968:	03812503          	lw	a0,56(sp)
f900096c:	03c12583          	lw	a1,60(sp)
f9000970:	3f4020ef          	jal	ra,f9002d64 <__divdf3>
f9000974:	8881a603          	lw	a2,-1912(gp) # f90077f0 <cycle_times+0x78>
f9000978:	88c1a683          	lw	a3,-1908(gp) # f90077f4 <cycle_times+0x7c>
f900097c:	365010ef          	jal	ra,f90024e0 <__adddf3>
f9000980:	00000713          	li	a4,0
f9000984:	00070613          	mv	a2,a4
f9000988:	000a0693          	mv	a3,s4
f900098c:	5dd020ef          	jal	ra,f9003768 <__muldf3>
f9000990:	00050a13          	mv	s4,a0
f9000994:	00058a93          	mv	s5,a1
f9000998:	02a12423          	sw	a0,40(sp)
f900099c:	02b12623          	sw	a1,44(sp)
  // correct for rounding errors
  if (value < conv.F) {
f90009a0:	02412703          	lw	a4,36(sp)
f90009a4:	00070613          	mv	a2,a4
f90009a8:	00098693          	mv	a3,s3
f90009ac:	3c1020ef          	jal	ra,f900356c <__gedf2>
f90009b0:	02a05263          	blez	a0,f90009d4 <_etoa+0x304>
    expval--;
f90009b4:	fffd8d93          	addi	s11,s11,-1
    conv.F /= 10;
f90009b8:	8781a603          	lw	a2,-1928(gp) # f90077e0 <cycle_times+0x68>
f90009bc:	87c1a683          	lw	a3,-1924(gp) # f90077e4 <cycle_times+0x6c>
f90009c0:	000a0513          	mv	a0,s4
f90009c4:	000a8593          	mv	a1,s5
f90009c8:	39c020ef          	jal	ra,f9002d64 <__divdf3>
f90009cc:	02a12423          	sw	a0,40(sp)
f90009d0:	02b12623          	sw	a1,44(sp)
  }

  // the exponent format is "%+03d" and largest value is "307", so set aside 4-5 characters
  unsigned int minwidth = ((expval < 100) && (expval > -100)) ? 4U : 5U;
f90009d4:	063d8793          	addi	a5,s11,99
f90009d8:	0c600713          	li	a4,198
f90009dc:	20f76063          	bltu	a4,a5,f9000bdc <_etoa+0x50c>
f90009e0:	00400a13          	li	s4,4

  // in "%g" mode, "prec" is the number of *significant figures* not decimals
  if (flags & FLAGS_ADAPT_EXP) {
f90009e4:	000017b7          	lui	a5,0x1
f90009e8:	80078793          	addi	a5,a5,-2048 # 800 <regnum_t6+0x7e1>
f90009ec:	00f977b3          	and	a5,s2,a5
f90009f0:	04078863          	beqz	a5,f9000a40 <_etoa+0x370>
    // do we want to fall-back to "%f" mode?
    if ((value >= 1e-4) && (value < 1e6)) {
f90009f4:	8901a603          	lw	a2,-1904(gp) # f90077f8 <cycle_times+0x80>
f90009f8:	8941a683          	lw	a3,-1900(gp) # f90077fc <cycle_times+0x84>
f90009fc:	02412a83          	lw	s5,36(sp)
f9000a00:	000a8513          	mv	a0,s5
f9000a04:	00098593          	mv	a1,s3
f9000a08:	365020ef          	jal	ra,f900356c <__gedf2>
f9000a0c:	1e054063          	bltz	a0,f9000bec <_etoa+0x51c>
f9000a10:	8981a603          	lw	a2,-1896(gp) # f9007800 <cycle_times+0x88>
f9000a14:	89c1a683          	lw	a3,-1892(gp) # f9007804 <cycle_times+0x8c>
f9000a18:	000a8513          	mv	a0,s5
f9000a1c:	00098593          	mv	a1,s3
f9000a20:	449020ef          	jal	ra,f9003668 <__ledf2>
f9000a24:	1c055463          	bgez	a0,f9000bec <_etoa+0x51c>
      if ((int)prec > expval) {
f9000a28:	1b7dde63          	bge	s11,s7,f9000be4 <_etoa+0x514>
        prec = (unsigned)((int)prec - expval - 1);
f9000a2c:	41bb8db3          	sub	s11,s7,s11
f9000a30:	fffd8b93          	addi	s7,s11,-1
      }
      else {
        prec = 0;
      }
      flags |= FLAGS_PRECISION;   // make sure _ftoa respects precision
f9000a34:	40096913          	ori	s2,s2,1024
      // no characters in exponent
      minwidth = 0U;
f9000a38:	00000a13          	li	s4,0
      expval   = 0;
f9000a3c:	00000d93          	li	s11,0
    }
  }

  // will everything fit?
  unsigned int fwidth = width;
  if (width > minwidth) {
f9000a40:	1b9a7e63          	bgeu	s4,s9,f9000bfc <_etoa+0x52c>
    // we didn't fall-back so subtract the characters required for the exponent
    fwidth -= minwidth;
f9000a44:	414c87b3          	sub	a5,s9,s4
f9000a48:	00078c13          	mv	s8,a5
  } else {
    // not enough characters, so go back to default sizing
    fwidth = 0U;
  }
  if ((flags & FLAGS_LEFT) && minwidth) {
f9000a4c:	00297a93          	andi	s5,s2,2
f9000a50:	000a8663          	beqz	s5,f9000a5c <_etoa+0x38c>
f9000a54:	000a0463          	beqz	s4,f9000a5c <_etoa+0x38c>
    // if we're padding on the right, DON'T pad the floating part
    fwidth = 0U;
f9000a58:	00000c13          	li	s8,0
  }

  // rescale the float value
  if (expval) {
f9000a5c:	020d8263          	beqz	s11,f9000a80 <_etoa+0x3b0>
    value /= conv.F;
f9000a60:	02812603          	lw	a2,40(sp)
f9000a64:	02c12683          	lw	a3,44(sp)
f9000a68:	02412703          	lw	a4,36(sp)
f9000a6c:	00070513          	mv	a0,a4
f9000a70:	00098593          	mv	a1,s3
f9000a74:	2f0020ef          	jal	ra,f9002d64 <__divdf3>
f9000a78:	02a12223          	sw	a0,36(sp)
f9000a7c:	00058993          	mv	s3,a1
  }

  // output the floating part
  const size_t start_idx = idx;
  idx = _ftoa(out, buffer, idx, maxlen, negative ? -value : value, prec, fwidth, flags & ~FLAGS_ADAPT_EXP);
f9000a80:	00000613          	li	a2,0
f9000a84:	00000693          	li	a3,0
f9000a88:	00048513          	mv	a0,s1
f9000a8c:	00040593          	mv	a1,s0
f9000a90:	3d9020ef          	jal	ra,f9003668 <__ledf2>
f9000a94:	16054863          	bltz	a0,f9000c04 <_etoa+0x534>
f9000a98:	fffff7b7          	lui	a5,0xfffff
f9000a9c:	7ff78793          	addi	a5,a5,2047 # fffff7ff <__freertos_irq_stack_top+0x6ff5fbf>
f9000aa0:	00f977b3          	and	a5,s2,a5
f9000aa4:	00f12023          	sw	a5,0(sp)
f9000aa8:	000c0893          	mv	a7,s8
f9000aac:	000b8813          	mv	a6,s7
f9000ab0:	02412603          	lw	a2,36(sp)
f9000ab4:	00060713          	mv	a4,a2
f9000ab8:	00098793          	mv	a5,s3
f9000abc:	02012683          	lw	a3,32(sp)
f9000ac0:	000d0613          	mv	a2,s10
f9000ac4:	01c12583          	lw	a1,28(sp)
f9000ac8:	000b0513          	mv	a0,s6
f9000acc:	14c000ef          	jal	ra,f9000c18 <_ftoa>

  // output the exponent part
  if (minwidth) {
f9000ad0:	0c0a0063          	beqz	s4,f9000b90 <_etoa+0x4c0>
    // output the exponential symbol
    out((flags & FLAGS_UPPERCASE) ? 'E' : 'e', buffer, idx++, maxlen);
f9000ad4:	02097913          	andi	s2,s2,32
f9000ad8:	12090c63          	beqz	s2,f9000c10 <_etoa+0x540>
f9000adc:	04500793          	li	a5,69
f9000ae0:	00150413          	addi	s0,a0,1
f9000ae4:	02012903          	lw	s2,32(sp)
f9000ae8:	00090693          	mv	a3,s2
f9000aec:	00050613          	mv	a2,a0
f9000af0:	01c12483          	lw	s1,28(sp)
f9000af4:	00048593          	mv	a1,s1
f9000af8:	00078513          	mv	a0,a5
f9000afc:	000b00e7          	jalr	s6
    // output the exponent value
    idx = _ntoa_long(out, buffer, idx, maxlen, (expval < 0) ? -expval : expval, expval < 0, 10, 0, minwidth-1, FLAGS_ZEROPAD | FLAGS_PLUS);
f9000b00:	41fdd713          	srai	a4,s11,0x1f
f9000b04:	01b746b3          	xor	a3,a4,s11
f9000b08:	00500793          	li	a5,5
f9000b0c:	00f12223          	sw	a5,4(sp)
f9000b10:	fffa0a13          	addi	s4,s4,-1
f9000b14:	01412023          	sw	s4,0(sp)
f9000b18:	00000893          	li	a7,0
f9000b1c:	00a00813          	li	a6,10
f9000b20:	01fdd793          	srli	a5,s11,0x1f
f9000b24:	40e68733          	sub	a4,a3,a4
f9000b28:	00090693          	mv	a3,s2
f9000b2c:	00040613          	mv	a2,s0
f9000b30:	00048593          	mv	a1,s1
f9000b34:	000b0513          	mv	a0,s6
f9000b38:	93dff0ef          	jal	ra,f9000474 <_ntoa_long>
    // might need to right-pad spaces
    if (flags & FLAGS_LEFT) {
f9000b3c:	040a8a63          	beqz	s5,f9000b90 <_etoa+0x4c0>
      while (idx - start_idx < width) out(' ', buffer, idx++, maxlen);
f9000b40:	41a507b3          	sub	a5,a0,s10
f9000b44:	0597f663          	bgeu	a5,s9,f9000b90 <_etoa+0x4c0>
f9000b48:	00150413          	addi	s0,a0,1
f9000b4c:	02012683          	lw	a3,32(sp)
f9000b50:	00050613          	mv	a2,a0
f9000b54:	01c12583          	lw	a1,28(sp)
f9000b58:	02000513          	li	a0,32
f9000b5c:	000b00e7          	jalr	s6
f9000b60:	00040513          	mv	a0,s0
f9000b64:	fddff06f          	j	f9000b40 <_etoa+0x470>
    return _ftoa(out, buffer, idx, maxlen, value, prec, width, flags);
f9000b68:	01212023          	sw	s2,0(sp)
f9000b6c:	000c8893          	mv	a7,s9
f9000b70:	000b8813          	mv	a6,s7
f9000b74:	00048713          	mv	a4,s1
f9000b78:	00040793          	mv	a5,s0
f9000b7c:	02012683          	lw	a3,32(sp)
f9000b80:	000d0613          	mv	a2,s10
f9000b84:	01c12583          	lw	a1,28(sp)
f9000b88:	000b0513          	mv	a0,s6
f9000b8c:	08c000ef          	jal	ra,f9000c18 <_ftoa>
    }
  }
  return idx;
}
f9000b90:	07c12083          	lw	ra,124(sp)
f9000b94:	07812403          	lw	s0,120(sp)
f9000b98:	07412483          	lw	s1,116(sp)
f9000b9c:	07012903          	lw	s2,112(sp)
f9000ba0:	06c12983          	lw	s3,108(sp)
f9000ba4:	06812a03          	lw	s4,104(sp)
f9000ba8:	06412a83          	lw	s5,100(sp)
f9000bac:	06012b03          	lw	s6,96(sp)
f9000bb0:	05c12b83          	lw	s7,92(sp)
f9000bb4:	05812c03          	lw	s8,88(sp)
f9000bb8:	05412c83          	lw	s9,84(sp)
f9000bbc:	05012d03          	lw	s10,80(sp)
f9000bc0:	04c12d83          	lw	s11,76(sp)
f9000bc4:	08010113          	addi	sp,sp,128
f9000bc8:	00008067          	ret
    value = -value;
f9000bcc:	02912223          	sw	s1,36(sp)
f9000bd0:	800009b7          	lui	s3,0x80000
f9000bd4:	0089c9b3          	xor	s3,s3,s0
f9000bd8:	bbdff06f          	j	f9000794 <_etoa+0xc4>
  unsigned int minwidth = ((expval < 100) && (expval > -100)) ? 4U : 5U;
f9000bdc:	00500a13          	li	s4,5
f9000be0:	e05ff06f          	j	f90009e4 <_etoa+0x314>
        prec = 0;
f9000be4:	00000b93          	li	s7,0
f9000be8:	e4dff06f          	j	f9000a34 <_etoa+0x364>
      if ((prec > 0) && (flags & FLAGS_PRECISION)) {
f9000bec:	e40b8ae3          	beqz	s7,f9000a40 <_etoa+0x370>
f9000bf0:	e40c08e3          	beqz	s8,f9000a40 <_etoa+0x370>
        --prec;
f9000bf4:	fffb8b93          	addi	s7,s7,-1
f9000bf8:	e49ff06f          	j	f9000a40 <_etoa+0x370>
    fwidth = 0U;
f9000bfc:	00000c13          	li	s8,0
f9000c00:	e4dff06f          	j	f9000a4c <_etoa+0x37c>
  idx = _ftoa(out, buffer, idx, maxlen, negative ? -value : value, prec, fwidth, flags & ~FLAGS_ADAPT_EXP);
f9000c04:	800007b7          	lui	a5,0x80000
f9000c08:	0137c9b3          	xor	s3,a5,s3
f9000c0c:	e8dff06f          	j	f9000a98 <_etoa+0x3c8>
    out((flags & FLAGS_UPPERCASE) ? 'E' : 'e', buffer, idx++, maxlen);
f9000c10:	06500793          	li	a5,101
f9000c14:	ecdff06f          	j	f9000ae0 <_etoa+0x410>

f9000c18 <_ftoa>:
{
f9000c18:	f8010113          	addi	sp,sp,-128
f9000c1c:	06112e23          	sw	ra,124(sp)
f9000c20:	06812c23          	sw	s0,120(sp)
f9000c24:	06912a23          	sw	s1,116(sp)
f9000c28:	07212823          	sw	s2,112(sp)
f9000c2c:	07312623          	sw	s3,108(sp)
f9000c30:	07412423          	sw	s4,104(sp)
f9000c34:	07512223          	sw	s5,100(sp)
f9000c38:	07612023          	sw	s6,96(sp)
f9000c3c:	05712e23          	sw	s7,92(sp)
f9000c40:	05812c23          	sw	s8,88(sp)
f9000c44:	05912a23          	sw	s9,84(sp)
f9000c48:	05a12823          	sw	s10,80(sp)
f9000c4c:	05b12623          	sw	s11,76(sp)
f9000c50:	00050b93          	mv	s7,a0
f9000c54:	00058c13          	mv	s8,a1
f9000c58:	00060c93          	mv	s9,a2
f9000c5c:	00068d13          	mv	s10,a3
f9000c60:	00070a13          	mv	s4,a4
f9000c64:	00078a93          	mv	s5,a5
f9000c68:	00080493          	mv	s1,a6
f9000c6c:	00088b13          	mv	s6,a7
  if (value != value)
f9000c70:	00070613          	mv	a2,a4
f9000c74:	00078693          	mv	a3,a5
f9000c78:	00070513          	mv	a0,a4
f9000c7c:	00078593          	mv	a1,a5
f9000c80:	061020ef          	jal	ra,f90034e0 <__eqdf2>
f9000c84:	0a051e63          	bnez	a0,f9000d40 <_ftoa+0x128>
  if (value < -DBL_MAX)
f9000c88:	8201a603          	lw	a2,-2016(gp) # f9007788 <cycle_times+0x10>
f9000c8c:	8241a683          	lw	a3,-2012(gp) # f900778c <cycle_times+0x14>
f9000c90:	000a0513          	mv	a0,s4
f9000c94:	000a8593          	mv	a1,s5
f9000c98:	1d1020ef          	jal	ra,f9003668 <__ledf2>
f9000c9c:	0c054863          	bltz	a0,f9000d6c <_ftoa+0x154>
  if (value > DBL_MAX)
f9000ca0:	8181a603          	lw	a2,-2024(gp) # f9007780 <cycle_times+0x8>
f9000ca4:	81c1a683          	lw	a3,-2020(gp) # f9007784 <cycle_times+0xc>
f9000ca8:	000a0513          	mv	a0,s4
f9000cac:	000a8593          	mv	a1,s5
f9000cb0:	0bd020ef          	jal	ra,f900356c <__gedf2>
f9000cb4:	0ea04263          	bgtz	a0,f9000d98 <_ftoa+0x180>
  if ((value > PRINTF_MAX_FLOAT) || (value < -PRINTF_MAX_FLOAT)) {
f9000cb8:	8a01a603          	lw	a2,-1888(gp) # f9007808 <cycle_times+0x90>
f9000cbc:	8a41a683          	lw	a3,-1884(gp) # f900780c <cycle_times+0x94>
f9000cc0:	000a0513          	mv	a0,s4
f9000cc4:	000a8593          	mv	a1,s5
f9000cc8:	0a5020ef          	jal	ra,f900356c <__gedf2>
f9000ccc:	10a04e63          	bgtz	a0,f9000de8 <_ftoa+0x1d0>
f9000cd0:	8a81a603          	lw	a2,-1880(gp) # f9007810 <cycle_times+0x98>
f9000cd4:	8ac1a683          	lw	a3,-1876(gp) # f9007814 <cycle_times+0x9c>
f9000cd8:	000a0513          	mv	a0,s4
f9000cdc:	000a8593          	mv	a1,s5
f9000ce0:	189020ef          	jal	ra,f9003668 <__ledf2>
f9000ce4:	10054263          	bltz	a0,f9000de8 <_ftoa+0x1d0>
  if (value < 0) {
f9000ce8:	00000613          	li	a2,0
f9000cec:	00000693          	li	a3,0
f9000cf0:	000a0513          	mv	a0,s4
f9000cf4:	000a8593          	mv	a1,s5
f9000cf8:	171020ef          	jal	ra,f9003668 <__ledf2>
f9000cfc:	10054e63          	bltz	a0,f9000e18 <_ftoa+0x200>
  bool negative = false;
f9000d00:	00000d93          	li	s11,0
  if (!(flags & FLAGS_PRECISION)) {
f9000d04:	08012783          	lw	a5,128(sp)
f9000d08:	4007f793          	andi	a5,a5,1024
f9000d0c:	12078863          	beqz	a5,f9000e3c <_ftoa+0x224>
    prec = PRINTF_DEFAULT_FLOAT_PRECISION;
f9000d10:	00000413          	li	s0,0
  while ((len < PRINTF_FTOA_BUFFER_SIZE) && (prec > 9U)) {
f9000d14:	01f00793          	li	a5,31
f9000d18:	1287e663          	bltu	a5,s0,f9000e44 <_ftoa+0x22c>
f9000d1c:	00900793          	li	a5,9
f9000d20:	1297f263          	bgeu	a5,s1,f9000e44 <_ftoa+0x22c>
    buf[len++] = '0';
f9000d24:	04010793          	addi	a5,sp,64
f9000d28:	008787b3          	add	a5,a5,s0
f9000d2c:	03000713          	li	a4,48
f9000d30:	fee78023          	sb	a4,-32(a5) # 7fffffe0 <__freertos_irq_stack_top+0x86ff67a0>
    prec--;
f9000d34:	fff48493          	addi	s1,s1,-1
    buf[len++] = '0';
f9000d38:	00140413          	addi	s0,s0,1
f9000d3c:	fd9ff06f          	j	f9000d14 <_ftoa+0xfc>
    return _out_rev(out, buffer, idx, maxlen, "nan", 3, width, flags);
f9000d40:	08012883          	lw	a7,128(sp)
f9000d44:	000b0813          	mv	a6,s6
f9000d48:	00300793          	li	a5,3
f9000d4c:	f9005737          	lui	a4,0xf9005
f9000d50:	b9470713          	addi	a4,a4,-1132 # f9004b94 <__freertos_irq_stack_top+0xffffb354>
f9000d54:	000d0693          	mv	a3,s10
f9000d58:	000c8613          	mv	a2,s9
f9000d5c:	000c0593          	mv	a1,s8
f9000d60:	000b8513          	mv	a0,s7
f9000d64:	c44ff0ef          	jal	ra,f90001a8 <_out_rev>
f9000d68:	3400006f          	j	f90010a8 <_ftoa+0x490>
    return _out_rev(out, buffer, idx, maxlen, "fni-", 4, width, flags);
f9000d6c:	08012883          	lw	a7,128(sp)
f9000d70:	000b0813          	mv	a6,s6
f9000d74:	00400793          	li	a5,4
f9000d78:	f9005737          	lui	a4,0xf9005
f9000d7c:	b9870713          	addi	a4,a4,-1128 # f9004b98 <__freertos_irq_stack_top+0xffffb358>
f9000d80:	000d0693          	mv	a3,s10
f9000d84:	000c8613          	mv	a2,s9
f9000d88:	000c0593          	mv	a1,s8
f9000d8c:	000b8513          	mv	a0,s7
f9000d90:	c18ff0ef          	jal	ra,f90001a8 <_out_rev>
f9000d94:	3140006f          	j	f90010a8 <_ftoa+0x490>
    return _out_rev(out, buffer, idx, maxlen, (flags & FLAGS_PLUS) ? "fni+" : "fni", (flags & FLAGS_PLUS) ? 4U : 3U, width, flags);
f9000d98:	08012783          	lw	a5,128(sp)
f9000d9c:	0047f793          	andi	a5,a5,4
f9000da0:	02078a63          	beqz	a5,f9000dd4 <_ftoa+0x1bc>
f9000da4:	f9005737          	lui	a4,0xf9005
f9000da8:	b8c70713          	addi	a4,a4,-1140 # f9004b8c <__freertos_irq_stack_top+0xffffb34c>
f9000dac:	02078a63          	beqz	a5,f9000de0 <_ftoa+0x1c8>
f9000db0:	00400793          	li	a5,4
f9000db4:	08012883          	lw	a7,128(sp)
f9000db8:	000b0813          	mv	a6,s6
f9000dbc:	000d0693          	mv	a3,s10
f9000dc0:	000c8613          	mv	a2,s9
f9000dc4:	000c0593          	mv	a1,s8
f9000dc8:	000b8513          	mv	a0,s7
f9000dcc:	bdcff0ef          	jal	ra,f90001a8 <_out_rev>
f9000dd0:	2d80006f          	j	f90010a8 <_ftoa+0x490>
f9000dd4:	f9005737          	lui	a4,0xf9005
f9000dd8:	b8870713          	addi	a4,a4,-1144 # f9004b88 <__freertos_irq_stack_top+0xffffb348>
f9000ddc:	fd1ff06f          	j	f9000dac <_ftoa+0x194>
f9000de0:	00300793          	li	a5,3
f9000de4:	fd1ff06f          	j	f9000db4 <_ftoa+0x19c>
    return _etoa(out, buffer, idx, maxlen, value, prec, width, flags);
f9000de8:	08012783          	lw	a5,128(sp)
f9000dec:	00f12023          	sw	a5,0(sp)
f9000df0:	000b0893          	mv	a7,s6
f9000df4:	00048813          	mv	a6,s1
f9000df8:	000a0713          	mv	a4,s4
f9000dfc:	000a8793          	mv	a5,s5
f9000e00:	000d0693          	mv	a3,s10
f9000e04:	000c8613          	mv	a2,s9
f9000e08:	000c0593          	mv	a1,s8
f9000e0c:	000b8513          	mv	a0,s7
f9000e10:	8c1ff0ef          	jal	ra,f90006d0 <_etoa>
f9000e14:	2940006f          	j	f90010a8 <_ftoa+0x490>
    value = 0 - value;
f9000e18:	000a0613          	mv	a2,s4
f9000e1c:	000a8693          	mv	a3,s5
f9000e20:	00000513          	li	a0,0
f9000e24:	00000593          	li	a1,0
f9000e28:	795020ef          	jal	ra,f9003dbc <__subdf3>
f9000e2c:	00050a13          	mv	s4,a0
f9000e30:	00058a93          	mv	s5,a1
    negative = true;
f9000e34:	00100d93          	li	s11,1
f9000e38:	ecdff06f          	j	f9000d04 <_ftoa+0xec>
    prec = PRINTF_DEFAULT_FLOAT_PRECISION;
f9000e3c:	00400493          	li	s1,4
f9000e40:	ed1ff06f          	j	f9000d10 <_ftoa+0xf8>
  int whole = (int)value;
f9000e44:	000a0513          	mv	a0,s4
f9000e48:	000a8593          	mv	a1,s5
f9000e4c:	7ec030ef          	jal	ra,f9004638 <__fixdfsi>
f9000e50:	00050913          	mv	s2,a0
  double tmp = (value - whole) * pow10[prec];
f9000e54:	0e1030ef          	jal	ra,f9004734 <__floatsidf>
f9000e58:	00050613          	mv	a2,a0
f9000e5c:	00058693          	mv	a3,a1
f9000e60:	000a0513          	mv	a0,s4
f9000e64:	000a8593          	mv	a1,s5
f9000e68:	755020ef          	jal	ra,f9003dbc <__subdf3>
f9000e6c:	00349793          	slli	a5,s1,0x3
f9000e70:	f9005737          	lui	a4,0xf9005
f9000e74:	b3870713          	addi	a4,a4,-1224 # f9004b38 <__freertos_irq_stack_top+0xffffb2f8>
f9000e78:	00f707b3          	add	a5,a4,a5
f9000e7c:	0047a803          	lw	a6,4(a5)
f9000e80:	0007a783          	lw	a5,0(a5)
f9000e84:	00f12c23          	sw	a5,24(sp)
f9000e88:	01012e23          	sw	a6,28(sp)
f9000e8c:	00078613          	mv	a2,a5
f9000e90:	00080693          	mv	a3,a6
f9000e94:	0d5020ef          	jal	ra,f9003768 <__muldf3>
f9000e98:	00a12823          	sw	a0,16(sp)
f9000e9c:	00b12a23          	sw	a1,20(sp)
  unsigned long frac = (unsigned long)tmp;
f9000ea0:	01d030ef          	jal	ra,f90046bc <__fixunsdfsi>
f9000ea4:	00050993          	mv	s3,a0
  diff = tmp - frac;
f9000ea8:	14d030ef          	jal	ra,f90047f4 <__floatunsidf>
f9000eac:	00050613          	mv	a2,a0
f9000eb0:	00058693          	mv	a3,a1
f9000eb4:	01012503          	lw	a0,16(sp)
f9000eb8:	01412583          	lw	a1,20(sp)
f9000ebc:	701020ef          	jal	ra,f9003dbc <__subdf3>
f9000ec0:	00a12823          	sw	a0,16(sp)
f9000ec4:	00b12a23          	sw	a1,20(sp)
  if (diff > 0.5) {
f9000ec8:	8501a603          	lw	a2,-1968(gp) # f90077b8 <cycle_times+0x40>
f9000ecc:	8541a683          	lw	a3,-1964(gp) # f90077bc <cycle_times+0x44>
f9000ed0:	69c020ef          	jal	ra,f900356c <__gedf2>
f9000ed4:	08a05863          	blez	a0,f9000f64 <_ftoa+0x34c>
    ++frac;
f9000ed8:	00198993          	addi	s3,s3,1 # 80000001 <__freertos_irq_stack_top+0x86ff67c1>
    if (frac >= pow10[prec]) {
f9000edc:	00098513          	mv	a0,s3
f9000ee0:	115030ef          	jal	ra,f90047f4 <__floatunsidf>
f9000ee4:	00050613          	mv	a2,a0
f9000ee8:	00058693          	mv	a3,a1
f9000eec:	01812503          	lw	a0,24(sp)
f9000ef0:	01c12583          	lw	a1,28(sp)
f9000ef4:	774020ef          	jal	ra,f9003668 <__ledf2>
f9000ef8:	00a04663          	bgtz	a0,f9000f04 <_ftoa+0x2ec>
      ++whole;
f9000efc:	00190913          	addi	s2,s2,1
      frac = 0;
f9000f00:	00000993          	li	s3,0
  if (prec == 0U) {
f9000f04:	08049663          	bnez	s1,f9000f90 <_ftoa+0x378>
    diff = value - (double)whole;
f9000f08:	00090513          	mv	a0,s2
f9000f0c:	029030ef          	jal	ra,f9004734 <__floatsidf>
f9000f10:	00050613          	mv	a2,a0
f9000f14:	00058693          	mv	a3,a1
f9000f18:	000a0513          	mv	a0,s4
f9000f1c:	000a8593          	mv	a1,s5
f9000f20:	69d020ef          	jal	ra,f9003dbc <__subdf3>
f9000f24:	00050a13          	mv	s4,a0
f9000f28:	00058a93          	mv	s5,a1
    if ((!(diff < 0.5) || (diff > 0.5)) && (whole & 1)) {
f9000f2c:	8501a603          	lw	a2,-1968(gp) # f90077b8 <cycle_times+0x40>
f9000f30:	8541a683          	lw	a3,-1964(gp) # f90077bc <cycle_times+0x44>
f9000f34:	734020ef          	jal	ra,f9003668 <__ledf2>
f9000f38:	00055e63          	bgez	a0,f9000f54 <_ftoa+0x33c>
f9000f3c:	8501a603          	lw	a2,-1968(gp) # f90077b8 <cycle_times+0x40>
f9000f40:	8541a683          	lw	a3,-1964(gp) # f90077bc <cycle_times+0x44>
f9000f44:	000a0513          	mv	a0,s4
f9000f48:	000a8593          	mv	a1,s5
f9000f4c:	620020ef          	jal	ra,f900356c <__gedf2>
f9000f50:	0ca05263          	blez	a0,f9001014 <_ftoa+0x3fc>
f9000f54:	00197793          	andi	a5,s2,1
f9000f58:	0a078e63          	beqz	a5,f9001014 <_ftoa+0x3fc>
      ++whole;
f9000f5c:	00190913          	addi	s2,s2,1
f9000f60:	0b40006f          	j	f9001014 <_ftoa+0x3fc>
  else if (diff < 0.5) {
f9000f64:	8501a603          	lw	a2,-1968(gp) # f90077b8 <cycle_times+0x40>
f9000f68:	8541a683          	lw	a3,-1964(gp) # f90077bc <cycle_times+0x44>
f9000f6c:	01012503          	lw	a0,16(sp)
f9000f70:	01412583          	lw	a1,20(sp)
f9000f74:	6f4020ef          	jal	ra,f9003668 <__ledf2>
f9000f78:	f80546e3          	bltz	a0,f9000f04 <_ftoa+0x2ec>
  else if ((frac == 0U) || (frac & 1U)) {
f9000f7c:	00098663          	beqz	s3,f9000f88 <_ftoa+0x370>
f9000f80:	0019f793          	andi	a5,s3,1
f9000f84:	f80780e3          	beqz	a5,f9000f04 <_ftoa+0x2ec>
    ++frac;
f9000f88:	00198993          	addi	s3,s3,1
f9000f8c:	f79ff06f          	j	f9000f04 <_ftoa+0x2ec>
    while (len < PRINTF_FTOA_BUFFER_SIZE) {
f9000f90:	01f00793          	li	a5,31
f9000f94:	0487ea63          	bltu	a5,s0,f9000fe8 <_ftoa+0x3d0>
      --count;
f9000f98:	fff48493          	addi	s1,s1,-1
      buf[len++] = (char)(48U + (frac % 10U));
f9000f9c:	00a00793          	li	a5,10
f9000fa0:	02f9f733          	remu	a4,s3,a5
f9000fa4:	00140693          	addi	a3,s0,1
f9000fa8:	03070713          	addi	a4,a4,48
f9000fac:	04010613          	addi	a2,sp,64
f9000fb0:	00860433          	add	s0,a2,s0
f9000fb4:	fee40023          	sb	a4,-32(s0)
      if (!(frac /= 10U)) {
f9000fb8:	02f9d7b3          	divu	a5,s3,a5
f9000fbc:	00900713          	li	a4,9
f9000fc0:	09377463          	bgeu	a4,s3,f9001048 <_ftoa+0x430>
f9000fc4:	00078993          	mv	s3,a5
      buf[len++] = (char)(48U + (frac % 10U));
f9000fc8:	00068413          	mv	s0,a3
f9000fcc:	fc5ff06f          	j	f9000f90 <_ftoa+0x378>
      buf[len++] = '0';
f9000fd0:	04010713          	addi	a4,sp,64
f9000fd4:	00870733          	add	a4,a4,s0
f9000fd8:	03000693          	li	a3,48
f9000fdc:	fed70023          	sb	a3,-32(a4)
    while ((len < PRINTF_FTOA_BUFFER_SIZE) && (count-- > 0U)) {
f9000fe0:	00078493          	mv	s1,a5
      buf[len++] = '0';
f9000fe4:	00140413          	addi	s0,s0,1
    while ((len < PRINTF_FTOA_BUFFER_SIZE) && (count-- > 0U)) {
f9000fe8:	01f00793          	li	a5,31
f9000fec:	0087e663          	bltu	a5,s0,f9000ff8 <_ftoa+0x3e0>
f9000ff0:	fff48793          	addi	a5,s1,-1
f9000ff4:	fc049ee3          	bnez	s1,f9000fd0 <_ftoa+0x3b8>
    if (len < PRINTF_FTOA_BUFFER_SIZE) {
f9000ff8:	01f00793          	li	a5,31
f9000ffc:	0087ec63          	bltu	a5,s0,f9001014 <_ftoa+0x3fc>
      buf[len++] = '.';
f9001000:	04010793          	addi	a5,sp,64
f9001004:	008787b3          	add	a5,a5,s0
f9001008:	02e00713          	li	a4,46
f900100c:	fee78023          	sb	a4,-32(a5)
f9001010:	00140413          	addi	s0,s0,1
  while (len < PRINTF_FTOA_BUFFER_SIZE) {
f9001014:	01f00793          	li	a5,31
f9001018:	0287ee63          	bltu	a5,s0,f9001054 <_ftoa+0x43c>
    buf[len++] = (char)(48 + (whole % 10));
f900101c:	00a00713          	li	a4,10
f9001020:	02e967b3          	rem	a5,s2,a4
f9001024:	00140693          	addi	a3,s0,1
f9001028:	03078793          	addi	a5,a5,48
f900102c:	04010613          	addi	a2,sp,64
f9001030:	00860433          	add	s0,a2,s0
f9001034:	fef40023          	sb	a5,-32(s0)
    if (!(whole /= 10)) {
f9001038:	02e94933          	div	s2,s2,a4
f900103c:	00090a63          	beqz	s2,f9001050 <_ftoa+0x438>
    buf[len++] = (char)(48 + (whole % 10));
f9001040:	00068413          	mv	s0,a3
f9001044:	fd1ff06f          	j	f9001014 <_ftoa+0x3fc>
      buf[len++] = (char)(48U + (frac % 10U));
f9001048:	00068413          	mv	s0,a3
f900104c:	f9dff06f          	j	f9000fe8 <_ftoa+0x3d0>
    buf[len++] = (char)(48 + (whole % 10));
f9001050:	00068413          	mv	s0,a3
  if (!(flags & FLAGS_LEFT) && (flags & FLAGS_ZEROPAD)) {
f9001054:	08012783          	lw	a5,128(sp)
f9001058:	0037f713          	andi	a4,a5,3
f900105c:	00100793          	li	a5,1
f9001060:	08f70263          	beq	a4,a5,f90010e4 <_ftoa+0x4cc>
  if (len < PRINTF_FTOA_BUFFER_SIZE) {
f9001064:	01f00793          	li	a5,31
f9001068:	0087ee63          	bltu	a5,s0,f9001084 <_ftoa+0x46c>
    if (negative) {
f900106c:	0a0d8a63          	beqz	s11,f9001120 <_ftoa+0x508>
      buf[len++] = '-';
f9001070:	04010793          	addi	a5,sp,64
f9001074:	008787b3          	add	a5,a5,s0
f9001078:	02d00713          	li	a4,45
f900107c:	fee78023          	sb	a4,-32(a5)
f9001080:	00140413          	addi	s0,s0,1
  return _out_rev(out, buffer, idx, maxlen, buf, len, width, flags);
f9001084:	08012883          	lw	a7,128(sp)
f9001088:	000b0813          	mv	a6,s6
f900108c:	00040793          	mv	a5,s0
f9001090:	02010713          	addi	a4,sp,32
f9001094:	000d0693          	mv	a3,s10
f9001098:	000c8613          	mv	a2,s9
f900109c:	000c0593          	mv	a1,s8
f90010a0:	000b8513          	mv	a0,s7
f90010a4:	904ff0ef          	jal	ra,f90001a8 <_out_rev>
}
f90010a8:	07c12083          	lw	ra,124(sp)
f90010ac:	07812403          	lw	s0,120(sp)
f90010b0:	07412483          	lw	s1,116(sp)
f90010b4:	07012903          	lw	s2,112(sp)
f90010b8:	06c12983          	lw	s3,108(sp)
f90010bc:	06812a03          	lw	s4,104(sp)
f90010c0:	06412a83          	lw	s5,100(sp)
f90010c4:	06012b03          	lw	s6,96(sp)
f90010c8:	05c12b83          	lw	s7,92(sp)
f90010cc:	05812c03          	lw	s8,88(sp)
f90010d0:	05412c83          	lw	s9,84(sp)
f90010d4:	05012d03          	lw	s10,80(sp)
f90010d8:	04c12d83          	lw	s11,76(sp)
f90010dc:	08010113          	addi	sp,sp,128
f90010e0:	00008067          	ret
    if (width && (negative || (flags & (FLAGS_PLUS | FLAGS_SPACE)))) {
f90010e4:	000b0c63          	beqz	s6,f90010fc <_ftoa+0x4e4>
f90010e8:	000d9863          	bnez	s11,f90010f8 <_ftoa+0x4e0>
f90010ec:	08012783          	lw	a5,128(sp)
f90010f0:	00c7f793          	andi	a5,a5,12
f90010f4:	00078463          	beqz	a5,f90010fc <_ftoa+0x4e4>
      width--;
f90010f8:	fffb0b13          	addi	s6,s6,-1
    while ((len < width) && (len < PRINTF_FTOA_BUFFER_SIZE)) {
f90010fc:	f76474e3          	bgeu	s0,s6,f9001064 <_ftoa+0x44c>
f9001100:	01f00793          	li	a5,31
f9001104:	f687e0e3          	bltu	a5,s0,f9001064 <_ftoa+0x44c>
      buf[len++] = '0';
f9001108:	04010793          	addi	a5,sp,64
f900110c:	008787b3          	add	a5,a5,s0
f9001110:	03000713          	li	a4,48
f9001114:	fee78023          	sb	a4,-32(a5)
f9001118:	00140413          	addi	s0,s0,1
f900111c:	fe1ff06f          	j	f90010fc <_ftoa+0x4e4>
    else if (flags & FLAGS_PLUS) {
f9001120:	08012783          	lw	a5,128(sp)
f9001124:	0047f793          	andi	a5,a5,4
f9001128:	00078e63          	beqz	a5,f9001144 <_ftoa+0x52c>
      buf[len++] = '+';  // ignore the space if the '+' exists
f900112c:	04010793          	addi	a5,sp,64
f9001130:	008787b3          	add	a5,a5,s0
f9001134:	02b00713          	li	a4,43
f9001138:	fee78023          	sb	a4,-32(a5)
f900113c:	00140413          	addi	s0,s0,1
f9001140:	f45ff06f          	j	f9001084 <_ftoa+0x46c>
    else if (flags & FLAGS_SPACE) {
f9001144:	08012783          	lw	a5,128(sp)
f9001148:	0087f793          	andi	a5,a5,8
f900114c:	f2078ce3          	beqz	a5,f9001084 <_ftoa+0x46c>
      buf[len++] = ' ';
f9001150:	04010793          	addi	a5,sp,64
f9001154:	008787b3          	add	a5,a5,s0
f9001158:	02000713          	li	a4,32
f900115c:	fee78023          	sb	a4,-32(a5)
f9001160:	00140413          	addi	s0,s0,1
f9001164:	f21ff06f          	j	f9001084 <_ftoa+0x46c>

f9001168 <_vsnprintf>:
*                 terminating null character), or a negative value if an error
*                 occurred.
*
******************************************************************************/
static int _vsnprintf(out_fct_type out, char* buffer, const size_t maxlen, const char* format, va_list va)
{
f9001168:	fa010113          	addi	sp,sp,-96
f900116c:	04112e23          	sw	ra,92(sp)
f9001170:	04812c23          	sw	s0,88(sp)
f9001174:	04912a23          	sw	s1,84(sp)
f9001178:	05212823          	sw	s2,80(sp)
f900117c:	05312623          	sw	s3,76(sp)
f9001180:	05412423          	sw	s4,72(sp)
f9001184:	05512223          	sw	s5,68(sp)
f9001188:	05612023          	sw	s6,64(sp)
f900118c:	03712e23          	sw	s7,60(sp)
f9001190:	03812c23          	sw	s8,56(sp)
f9001194:	03912a23          	sw	s9,52(sp)
f9001198:	03a12823          	sw	s10,48(sp)
f900119c:	03b12623          	sw	s11,44(sp)
f90011a0:	00050a13          	mv	s4,a0
f90011a4:	00058993          	mv	s3,a1
f90011a8:	00060913          	mv	s2,a2
f90011ac:	00d12e23          	sw	a3,28(sp)
f90011b0:	00e12c23          	sw	a4,24(sp)
  unsigned int flags, width, precision, n;
  size_t idx = 0U;

  if (!buffer) {
f90011b4:	0a0586e3          	beqz	a1,f9001a60 <_vsnprintf+0x8f8>
          while (l++ < width) {
            out(' ', buffer, idx++, maxlen);
          }
        }
        format++;
        break;
f90011b8:	00000413          	li	s0,0
  while (*format)
f90011bc:	01c12783          	lw	a5,28(sp)
f90011c0:	0007c503          	lbu	a0,0(a5)
f90011c4:	0a0504e3          	beqz	a0,f9001a6c <_vsnprintf+0x904>
    if (*format != '%') {
f90011c8:	02500713          	li	a4,37
f90011cc:	02e50663          	beq	a0,a4,f90011f8 <_vsnprintf+0x90>
      out(*format, buffer, idx++, maxlen);
f90011d0:	00140493          	addi	s1,s0,1
f90011d4:	00090693          	mv	a3,s2
f90011d8:	00040613          	mv	a2,s0
f90011dc:	00098593          	mv	a1,s3
f90011e0:	000a00e7          	jalr	s4
      format++;
f90011e4:	01c12783          	lw	a5,28(sp)
f90011e8:	00178793          	addi	a5,a5,1
f90011ec:	00f12e23          	sw	a5,28(sp)
      out(*format, buffer, idx++, maxlen);
f90011f0:	00048413          	mv	s0,s1
      continue;
f90011f4:	fc9ff06f          	j	f90011bc <_vsnprintf+0x54>
      format++;
f90011f8:	00178793          	addi	a5,a5,1
f90011fc:	00f12e23          	sw	a5,28(sp)
    flags = 0U;
f9001200:	00000493          	li	s1,0
f9001204:	0700006f          	j	f9001274 <_vsnprintf+0x10c>
  return (ch >= '0') && (ch <= '9');
f9001208:	fd060793          	addi	a5,a2,-48
f900120c:	0ff7f793          	andi	a5,a5,255
    if (_is_digit(*format)) {
f9001210:	00900713          	li	a4,9
f9001214:	0cf77863          	bgeu	a4,a5,f90012e4 <_vsnprintf+0x17c>
    else if (*format == '*') {
f9001218:	02a00793          	li	a5,42
f900121c:	0cf60c63          	beq	a2,a5,f90012f4 <_vsnprintf+0x18c>
    width = 0U;
f9001220:	00000b13          	li	s6,0
    if (*format == '.') {
f9001224:	01c12783          	lw	a5,28(sp)
f9001228:	0007c683          	lbu	a3,0(a5)
f900122c:	02e00713          	li	a4,46
f9001230:	0ee68a63          	beq	a3,a4,f9001324 <_vsnprintf+0x1bc>
    precision = 0U;
f9001234:	00000a93          	li	s5,0
    switch (*format) {
f9001238:	01c12703          	lw	a4,28(sp)
f900123c:	00074783          	lbu	a5,0(a4)
f9001240:	f9878793          	addi	a5,a5,-104
f9001244:	0ff7f613          	andi	a2,a5,255
f9001248:	01200693          	li	a3,18
f900124c:	1ec6e863          	bltu	a3,a2,f900143c <_vsnprintf+0x2d4>
f9001250:	00261793          	slli	a5,a2,0x2
f9001254:	f90056b7          	lui	a3,0xf9005
f9001258:	95868693          	addi	a3,a3,-1704 # f9004958 <__freertos_irq_stack_top+0xffffb118>
f900125c:	00d787b3          	add	a5,a5,a3
f9001260:	0007a783          	lw	a5,0(a5)
f9001264:	00078067          	jr	a5
        case '0': flags |= FLAGS_ZEROPAD; format++; n = 1U; break;
f9001268:	0014e493          	ori	s1,s1,1
f900126c:	00170713          	addi	a4,a4,1
f9001270:	00e12e23          	sw	a4,28(sp)
      switch (*format) {
f9001274:	01c12703          	lw	a4,28(sp)
f9001278:	00074603          	lbu	a2,0(a4)
f900127c:	fe060793          	addi	a5,a2,-32
f9001280:	0ff7f593          	andi	a1,a5,255
f9001284:	01000693          	li	a3,16
f9001288:	f8b6e0e3          	bltu	a3,a1,f9001208 <_vsnprintf+0xa0>
f900128c:	00259793          	slli	a5,a1,0x2
f9001290:	f90056b7          	lui	a3,0xf9005
f9001294:	9a468693          	addi	a3,a3,-1628 # f90049a4 <__freertos_irq_stack_top+0xffffb164>
f9001298:	00d787b3          	add	a5,a5,a3
f900129c:	0007a783          	lw	a5,0(a5)
f90012a0:	00078067          	jr	a5
        case '-': flags |= FLAGS_LEFT;    format++; n = 1U; break;
f90012a4:	0024e493          	ori	s1,s1,2
f90012a8:	00170713          	addi	a4,a4,1
f90012ac:	00e12e23          	sw	a4,28(sp)
f90012b0:	fc5ff06f          	j	f9001274 <_vsnprintf+0x10c>
        case '+': flags |= FLAGS_PLUS;    format++; n = 1U; break;
f90012b4:	0044e493          	ori	s1,s1,4
f90012b8:	00170713          	addi	a4,a4,1
f90012bc:	00e12e23          	sw	a4,28(sp)
f90012c0:	fb5ff06f          	j	f9001274 <_vsnprintf+0x10c>
        case ' ': flags |= FLAGS_SPACE;   format++; n = 1U; break;
f90012c4:	0084e493          	ori	s1,s1,8
f90012c8:	00170713          	addi	a4,a4,1
f90012cc:	00e12e23          	sw	a4,28(sp)
f90012d0:	fa5ff06f          	j	f9001274 <_vsnprintf+0x10c>
        case '#': flags |= FLAGS_HASH;    format++; n = 1U; break;
f90012d4:	0104e493          	ori	s1,s1,16
f90012d8:	00170713          	addi	a4,a4,1
f90012dc:	00e12e23          	sw	a4,28(sp)
f90012e0:	f95ff06f          	j	f9001274 <_vsnprintf+0x10c>
      width = _atoi(&format);
f90012e4:	01c10513          	addi	a0,sp,28
f90012e8:	e79fe0ef          	jal	ra,f9000160 <_atoi>
f90012ec:	00050b13          	mv	s6,a0
f90012f0:	f35ff06f          	j	f9001224 <_vsnprintf+0xbc>
      const int w = va_arg(va, int);
f90012f4:	01812783          	lw	a5,24(sp)
f90012f8:	00478713          	addi	a4,a5,4
f90012fc:	00e12c23          	sw	a4,24(sp)
f9001300:	0007ab03          	lw	s6,0(a5)
      if (w < 0) {
f9001304:	000b4a63          	bltz	s6,f9001318 <_vsnprintf+0x1b0>
      format++;
f9001308:	01c12783          	lw	a5,28(sp)
f900130c:	00178793          	addi	a5,a5,1
f9001310:	00f12e23          	sw	a5,28(sp)
f9001314:	f11ff06f          	j	f9001224 <_vsnprintf+0xbc>
        flags |= FLAGS_LEFT;    // reverse padding
f9001318:	0024e493          	ori	s1,s1,2
        width = (unsigned int)-w;
f900131c:	41600b33          	neg	s6,s6
f9001320:	fe9ff06f          	j	f9001308 <_vsnprintf+0x1a0>
      flags |= FLAGS_PRECISION;
f9001324:	4004e493          	ori	s1,s1,1024
      format++;
f9001328:	00178713          	addi	a4,a5,1
f900132c:	00e12e23          	sw	a4,28(sp)
      if (_is_digit(*format)) {
f9001330:	0017c703          	lbu	a4,1(a5)
  return (ch >= '0') && (ch <= '9');
f9001334:	fd070793          	addi	a5,a4,-48
f9001338:	0ff7f793          	andi	a5,a5,255
      if (_is_digit(*format)) {
f900133c:	00900693          	li	a3,9
f9001340:	00f6fa63          	bgeu	a3,a5,f9001354 <_vsnprintf+0x1ec>
      else if (*format == '*') {
f9001344:	02a00793          	li	a5,42
f9001348:	00f70e63          	beq	a4,a5,f9001364 <_vsnprintf+0x1fc>
    precision = 0U;
f900134c:	00000a93          	li	s5,0
f9001350:	ee9ff06f          	j	f9001238 <_vsnprintf+0xd0>
        precision = _atoi(&format);
f9001354:	01c10513          	addi	a0,sp,28
f9001358:	e09fe0ef          	jal	ra,f9000160 <_atoi>
f900135c:	00050a93          	mv	s5,a0
f9001360:	ed9ff06f          	j	f9001238 <_vsnprintf+0xd0>
        const int prec = (int)va_arg(va, int);
f9001364:	01812783          	lw	a5,24(sp)
f9001368:	00478713          	addi	a4,a5,4
f900136c:	00e12c23          	sw	a4,24(sp)
f9001370:	0007aa83          	lw	s5,0(a5)
        precision = prec > 0 ? (unsigned int)prec : 0U;
f9001374:	000aca63          	bltz	s5,f9001388 <_vsnprintf+0x220>
        format++;
f9001378:	01c12783          	lw	a5,28(sp)
f900137c:	00178793          	addi	a5,a5,1
f9001380:	00f12e23          	sw	a5,28(sp)
f9001384:	eb5ff06f          	j	f9001238 <_vsnprintf+0xd0>
        precision = prec > 0 ? (unsigned int)prec : 0U;
f9001388:	00000a93          	li	s5,0
f900138c:	fedff06f          	j	f9001378 <_vsnprintf+0x210>
        flags |= FLAGS_LONG;
f9001390:	1004e693          	ori	a3,s1,256
        format++;
f9001394:	00170793          	addi	a5,a4,1
f9001398:	00f12e23          	sw	a5,28(sp)
        if (*format == 'l') {
f900139c:	00174603          	lbu	a2,1(a4)
f90013a0:	06c00713          	li	a4,108
f90013a4:	04e61463          	bne	a2,a4,f90013ec <_vsnprintf+0x284>
          flags |= FLAGS_LONG_LONG;
f90013a8:	3004e693          	ori	a3,s1,768
          format++;
f90013ac:	00178793          	addi	a5,a5,1
f90013b0:	00f12e23          	sw	a5,28(sp)
f90013b4:	0380006f          	j	f90013ec <_vsnprintf+0x284>
        flags |= FLAGS_SHORT;
f90013b8:	0804e693          	ori	a3,s1,128
        format++;
f90013bc:	00170793          	addi	a5,a4,1
f90013c0:	00f12e23          	sw	a5,28(sp)
        if (*format == 'h') {
f90013c4:	00174603          	lbu	a2,1(a4)
f90013c8:	06800713          	li	a4,104
f90013cc:	02e61063          	bne	a2,a4,f90013ec <_vsnprintf+0x284>
          flags |= FLAGS_CHAR;
f90013d0:	0c04e693          	ori	a3,s1,192
          format++;
f90013d4:	00178793          	addi	a5,a5,1
f90013d8:	00f12e23          	sw	a5,28(sp)
f90013dc:	0100006f          	j	f90013ec <_vsnprintf+0x284>
        flags |= (sizeof(ptrdiff_t) == sizeof(long) ? FLAGS_LONG : FLAGS_LONG_LONG);
f90013e0:	1004e693          	ori	a3,s1,256
        format++;
f90013e4:	00170713          	addi	a4,a4,1
f90013e8:	00e12e23          	sw	a4,28(sp)
    switch (*format) {
f90013ec:	01c12783          	lw	a5,28(sp)
f90013f0:	0007c503          	lbu	a0,0(a5)
f90013f4:	fdb50793          	addi	a5,a0,-37
f90013f8:	0ff7f613          	andi	a2,a5,255
f90013fc:	05300713          	li	a4,83
f9001400:	62c76c63          	bltu	a4,a2,f9001a38 <_vsnprintf+0x8d0>
f9001404:	00261793          	slli	a5,a2,0x2
f9001408:	f9005737          	lui	a4,0xf9005
f900140c:	9e870713          	addi	a4,a4,-1560 # f90049e8 <__freertos_irq_stack_top+0xffffb1a8>
f9001410:	00e787b3          	add	a5,a5,a4
f9001414:	0007a783          	lw	a5,0(a5)
f9001418:	00078067          	jr	a5
        flags |= (sizeof(intmax_t) == sizeof(long) ? FLAGS_LONG : FLAGS_LONG_LONG);
f900141c:	2004e693          	ori	a3,s1,512
        format++;
f9001420:	00170713          	addi	a4,a4,1
f9001424:	00e12e23          	sw	a4,28(sp)
        break;
f9001428:	fc5ff06f          	j	f90013ec <_vsnprintf+0x284>
        flags |= (sizeof(size_t) == sizeof(long) ? FLAGS_LONG : FLAGS_LONG_LONG);
f900142c:	1004e693          	ori	a3,s1,256
        format++;
f9001430:	00170713          	addi	a4,a4,1
f9001434:	00e12e23          	sw	a4,28(sp)
        break;
f9001438:	fb5ff06f          	j	f90013ec <_vsnprintf+0x284>
    switch (*format) {
f900143c:	00048693          	mv	a3,s1
f9001440:	fadff06f          	j	f90013ec <_vsnprintf+0x284>
        if (*format == 'x' || *format == 'X') {
f9001444:	07800793          	li	a5,120
f9001448:	02f50463          	beq	a0,a5,f9001470 <_vsnprintf+0x308>
f900144c:	05800793          	li	a5,88
f9001450:	0af50863          	beq	a0,a5,f9001500 <_vsnprintf+0x398>
        else if (*format == 'o') {
f9001454:	06f00793          	li	a5,111
f9001458:	0af50863          	beq	a0,a5,f9001508 <_vsnprintf+0x3a0>
        else if (*format == 'b') {
f900145c:	06200793          	li	a5,98
f9001460:	0af50863          	beq	a0,a5,f9001510 <_vsnprintf+0x3a8>
          flags &= ~FLAGS_HASH;   // no hash for dec format
f9001464:	fef6f693          	andi	a3,a3,-17
          base = 10U;
f9001468:	00a00813          	li	a6,10
f900146c:	0080006f          	j	f9001474 <_vsnprintf+0x30c>
          base = 16U;
f9001470:	01000813          	li	a6,16
        if (*format == 'X') {
f9001474:	05800793          	li	a5,88
f9001478:	0af50063          	beq	a0,a5,f9001518 <_vsnprintf+0x3b0>
        if ((*format != 'i') && (*format != 'd')) {
f900147c:	06900793          	li	a5,105
f9001480:	00f50863          	beq	a0,a5,f9001490 <_vsnprintf+0x328>
f9001484:	06400793          	li	a5,100
f9001488:	00f50463          	beq	a0,a5,f9001490 <_vsnprintf+0x328>
          flags &= ~(FLAGS_PLUS | FLAGS_SPACE);
f900148c:	ff36f693          	andi	a3,a3,-13
        if (flags & FLAGS_PRECISION) {
f9001490:	4006f793          	andi	a5,a3,1024
f9001494:	00078463          	beqz	a5,f900149c <_vsnprintf+0x334>
          flags &= ~FLAGS_ZEROPAD;
f9001498:	ffe6f693          	andi	a3,a3,-2
        if ((*format == 'i') || (*format == 'd')) {
f900149c:	06900793          	li	a5,105
f90014a0:	08f50063          	beq	a0,a5,f9001520 <_vsnprintf+0x3b8>
f90014a4:	06400793          	li	a5,100
f90014a8:	06f50c63          	beq	a0,a5,f9001520 <_vsnprintf+0x3b8>
          if (flags & FLAGS_LONG_LONG) {
f90014ac:	2006f793          	andi	a5,a3,512
f90014b0:	1c079063          	bnez	a5,f9001670 <_vsnprintf+0x508>
          else if (flags & FLAGS_LONG) {
f90014b4:	1006f793          	andi	a5,a3,256
f90014b8:	20079463          	bnez	a5,f90016c0 <_vsnprintf+0x558>
            const unsigned int value = (flags & FLAGS_CHAR) ? (unsigned char)va_arg(va, unsigned int) : (flags & FLAGS_SHORT) ? (unsigned short int)va_arg(va, unsigned int) : va_arg(va, unsigned int);
f90014bc:	0406f793          	andi	a5,a3,64
f90014c0:	22078e63          	beqz	a5,f90016fc <_vsnprintf+0x594>
f90014c4:	01812783          	lw	a5,24(sp)
f90014c8:	00478713          	addi	a4,a5,4
f90014cc:	00e12c23          	sw	a4,24(sp)
f90014d0:	0007c703          	lbu	a4,0(a5)
            idx = _ntoa_long(out, buffer, idx, maxlen, value, false, base, precision, width, flags);
f90014d4:	00d12223          	sw	a3,4(sp)
f90014d8:	01612023          	sw	s6,0(sp)
f90014dc:	000a8893          	mv	a7,s5
f90014e0:	00000793          	li	a5,0
f90014e4:	00090693          	mv	a3,s2
f90014e8:	00040613          	mv	a2,s0
f90014ec:	00098593          	mv	a1,s3
f90014f0:	000a0513          	mv	a0,s4
f90014f4:	f81fe0ef          	jal	ra,f9000474 <_ntoa_long>
f90014f8:	00050413          	mv	s0,a0
f90014fc:	0800006f          	j	f900157c <_vsnprintf+0x414>
          base = 16U;
f9001500:	01000813          	li	a6,16
f9001504:	f71ff06f          	j	f9001474 <_vsnprintf+0x30c>
          base =  8U;
f9001508:	00800813          	li	a6,8
f900150c:	f69ff06f          	j	f9001474 <_vsnprintf+0x30c>
          base =  2U;
f9001510:	00200813          	li	a6,2
f9001514:	f61ff06f          	j	f9001474 <_vsnprintf+0x30c>
          flags |= FLAGS_UPPERCASE;
f9001518:	0206e693          	ori	a3,a3,32
f900151c:	f61ff06f          	j	f900147c <_vsnprintf+0x314>
          if (flags & FLAGS_LONG_LONG) {
f9001520:	2006f793          	andi	a5,a3,512
f9001524:	06079463          	bnez	a5,f900158c <_vsnprintf+0x424>
          else if (flags & FLAGS_LONG) {
f9001528:	1006f793          	andi	a5,a3,256
f900152c:	0c079663          	bnez	a5,f90015f8 <_vsnprintf+0x490>
            const int value = (flags & FLAGS_CHAR) ? (char)va_arg(va, int) : (flags & FLAGS_SHORT) ? (short int)va_arg(va, int) : va_arg(va, int);
f9001530:	0406f793          	andi	a5,a3,64
f9001534:	10078663          	beqz	a5,f9001640 <_vsnprintf+0x4d8>
f9001538:	01812783          	lw	a5,24(sp)
f900153c:	00478713          	addi	a4,a5,4
f9001540:	00e12c23          	sw	a4,24(sp)
f9001544:	0007c783          	lbu	a5,0(a5)
            idx = _ntoa_long(out, buffer, idx, maxlen, (unsigned int)(value > 0 ? value : 0 - value), value < 0, base, precision, width, flags);
f9001548:	41f7d713          	srai	a4,a5,0x1f
f900154c:	00f74633          	xor	a2,a4,a5
f9001550:	00d12223          	sw	a3,4(sp)
f9001554:	01612023          	sw	s6,0(sp)
f9001558:	000a8893          	mv	a7,s5
f900155c:	01f7d793          	srli	a5,a5,0x1f
f9001560:	40e60733          	sub	a4,a2,a4
f9001564:	00090693          	mv	a3,s2
f9001568:	00040613          	mv	a2,s0
f900156c:	00098593          	mv	a1,s3
f9001570:	000a0513          	mv	a0,s4
f9001574:	f01fe0ef          	jal	ra,f9000474 <_ntoa_long>
f9001578:	00050413          	mv	s0,a0
        format++;
f900157c:	01c12783          	lw	a5,28(sp)
f9001580:	00178793          	addi	a5,a5,1
f9001584:	00f12e23          	sw	a5,28(sp)
        break;
f9001588:	c35ff06f          	j	f90011bc <_vsnprintf+0x54>
            const long long value = va_arg(va, long long);
f900158c:	01812783          	lw	a5,24(sp)
f9001590:	00778793          	addi	a5,a5,7
f9001594:	ff87f793          	andi	a5,a5,-8
f9001598:	00878713          	addi	a4,a5,8
f900159c:	00e12c23          	sw	a4,24(sp)
f90015a0:	0007a603          	lw	a2,0(a5)
f90015a4:	0047a503          	lw	a0,4(a5)
            idx = _ntoa_long_long(out, buffer, idx, maxlen, (unsigned long long)(value > 0 ? value : 0 - value), value < 0, base, precision, width, flags);
f90015a8:	41f55793          	srai	a5,a0,0x1f
f90015ac:	00c7c633          	xor	a2,a5,a2
f90015b0:	00a7c5b3          	xor	a1,a5,a0
f90015b4:	40f60733          	sub	a4,a2,a5
f90015b8:	00e63633          	sltu	a2,a2,a4
f90015bc:	40f585b3          	sub	a1,a1,a5
f90015c0:	40c587b3          	sub	a5,a1,a2
f90015c4:	00d12623          	sw	a3,12(sp)
f90015c8:	01612423          	sw	s6,8(sp)
f90015cc:	01512223          	sw	s5,4(sp)
f90015d0:	00012023          	sw	zero,0(sp)
f90015d4:	00080893          	mv	a7,a6
f90015d8:	01f55813          	srli	a6,a0,0x1f
f90015dc:	00090693          	mv	a3,s2
f90015e0:	00040613          	mv	a2,s0
f90015e4:	00098593          	mv	a1,s3
f90015e8:	000a0513          	mv	a0,s4
f90015ec:	f4dfe0ef          	jal	ra,f9000538 <_ntoa_long_long>
f90015f0:	00050413          	mv	s0,a0
f90015f4:	f89ff06f          	j	f900157c <_vsnprintf+0x414>
            const long value = va_arg(va, long);
f90015f8:	01812783          	lw	a5,24(sp)
f90015fc:	00478713          	addi	a4,a5,4
f9001600:	00e12c23          	sw	a4,24(sp)
f9001604:	0007a783          	lw	a5,0(a5)
            idx = _ntoa_long(out, buffer, idx, maxlen, (unsigned long)(value > 0 ? value : 0 - value), value < 0, base, precision, width, flags);
f9001608:	41f7d713          	srai	a4,a5,0x1f
f900160c:	00f74633          	xor	a2,a4,a5
f9001610:	00d12223          	sw	a3,4(sp)
f9001614:	01612023          	sw	s6,0(sp)
f9001618:	000a8893          	mv	a7,s5
f900161c:	01f7d793          	srli	a5,a5,0x1f
f9001620:	40e60733          	sub	a4,a2,a4
f9001624:	00090693          	mv	a3,s2
f9001628:	00040613          	mv	a2,s0
f900162c:	00098593          	mv	a1,s3
f9001630:	000a0513          	mv	a0,s4
f9001634:	e41fe0ef          	jal	ra,f9000474 <_ntoa_long>
f9001638:	00050413          	mv	s0,a0
f900163c:	f41ff06f          	j	f900157c <_vsnprintf+0x414>
            const int value = (flags & FLAGS_CHAR) ? (char)va_arg(va, int) : (flags & FLAGS_SHORT) ? (short int)va_arg(va, int) : va_arg(va, int);
f9001640:	0806f793          	andi	a5,a3,128
f9001644:	00078c63          	beqz	a5,f900165c <_vsnprintf+0x4f4>
f9001648:	01812783          	lw	a5,24(sp)
f900164c:	00478713          	addi	a4,a5,4
f9001650:	00e12c23          	sw	a4,24(sp)
f9001654:	00079783          	lh	a5,0(a5)
f9001658:	ef1ff06f          	j	f9001548 <_vsnprintf+0x3e0>
f900165c:	01812783          	lw	a5,24(sp)
f9001660:	00478713          	addi	a4,a5,4
f9001664:	00e12c23          	sw	a4,24(sp)
f9001668:	0007a783          	lw	a5,0(a5)
f900166c:	eddff06f          	j	f9001548 <_vsnprintf+0x3e0>
            idx = _ntoa_long_long(out, buffer, idx, maxlen, va_arg(va, unsigned long long), false, base, precision, width, flags);
f9001670:	01812783          	lw	a5,24(sp)
f9001674:	00778793          	addi	a5,a5,7
f9001678:	ff87f793          	andi	a5,a5,-8
f900167c:	00878713          	addi	a4,a5,8
f9001680:	00e12c23          	sw	a4,24(sp)
f9001684:	0007a703          	lw	a4,0(a5)
f9001688:	0047a783          	lw	a5,4(a5)
f900168c:	00d12623          	sw	a3,12(sp)
f9001690:	01612423          	sw	s6,8(sp)
f9001694:	01512223          	sw	s5,4(sp)
f9001698:	00012023          	sw	zero,0(sp)
f900169c:	00080893          	mv	a7,a6
f90016a0:	00000813          	li	a6,0
f90016a4:	00090693          	mv	a3,s2
f90016a8:	00040613          	mv	a2,s0
f90016ac:	00098593          	mv	a1,s3
f90016b0:	000a0513          	mv	a0,s4
f90016b4:	e85fe0ef          	jal	ra,f9000538 <_ntoa_long_long>
f90016b8:	00050413          	mv	s0,a0
f90016bc:	ec1ff06f          	j	f900157c <_vsnprintf+0x414>
            idx = _ntoa_long(out, buffer, idx, maxlen, va_arg(va, unsigned long), false, base, precision, width, flags);
f90016c0:	01812783          	lw	a5,24(sp)
f90016c4:	00478713          	addi	a4,a5,4
f90016c8:	00e12c23          	sw	a4,24(sp)
f90016cc:	0007a703          	lw	a4,0(a5)
f90016d0:	00d12223          	sw	a3,4(sp)
f90016d4:	01612023          	sw	s6,0(sp)
f90016d8:	000a8893          	mv	a7,s5
f90016dc:	00000793          	li	a5,0
f90016e0:	00090693          	mv	a3,s2
f90016e4:	00040613          	mv	a2,s0
f90016e8:	00098593          	mv	a1,s3
f90016ec:	000a0513          	mv	a0,s4
f90016f0:	d85fe0ef          	jal	ra,f9000474 <_ntoa_long>
f90016f4:	00050413          	mv	s0,a0
f90016f8:	e85ff06f          	j	f900157c <_vsnprintf+0x414>
            const unsigned int value = (flags & FLAGS_CHAR) ? (unsigned char)va_arg(va, unsigned int) : (flags & FLAGS_SHORT) ? (unsigned short int)va_arg(va, unsigned int) : va_arg(va, unsigned int);
f90016fc:	0806f793          	andi	a5,a3,128
f9001700:	00078c63          	beqz	a5,f9001718 <_vsnprintf+0x5b0>
f9001704:	01812783          	lw	a5,24(sp)
f9001708:	00478713          	addi	a4,a5,4
f900170c:	00e12c23          	sw	a4,24(sp)
f9001710:	0007d703          	lhu	a4,0(a5)
f9001714:	dc1ff06f          	j	f90014d4 <_vsnprintf+0x36c>
f9001718:	01812783          	lw	a5,24(sp)
f900171c:	00478713          	addi	a4,a5,4
f9001720:	00e12c23          	sw	a4,24(sp)
f9001724:	0007a703          	lw	a4,0(a5)
f9001728:	dadff06f          	j	f90014d4 <_vsnprintf+0x36c>
        if (*format == 'F') flags |= FLAGS_UPPERCASE;
f900172c:	04600793          	li	a5,70
f9001730:	04f50a63          	beq	a0,a5,f9001784 <_vsnprintf+0x61c>
        idx = _ftoa(out, buffer, idx, maxlen, va_arg(va, double), precision, width, flags);
f9001734:	01812783          	lw	a5,24(sp)
f9001738:	00778793          	addi	a5,a5,7
f900173c:	ff87f793          	andi	a5,a5,-8
f9001740:	00878713          	addi	a4,a5,8
f9001744:	00e12c23          	sw	a4,24(sp)
f9001748:	0007a703          	lw	a4,0(a5)
f900174c:	0047a783          	lw	a5,4(a5)
f9001750:	00d12023          	sw	a3,0(sp)
f9001754:	000b0893          	mv	a7,s6
f9001758:	000a8813          	mv	a6,s5
f900175c:	00090693          	mv	a3,s2
f9001760:	00040613          	mv	a2,s0
f9001764:	00098593          	mv	a1,s3
f9001768:	000a0513          	mv	a0,s4
f900176c:	cacff0ef          	jal	ra,f9000c18 <_ftoa>
f9001770:	00050413          	mv	s0,a0
        format++;
f9001774:	01c12783          	lw	a5,28(sp)
f9001778:	00178793          	addi	a5,a5,1
f900177c:	00f12e23          	sw	a5,28(sp)
        break;
f9001780:	a3dff06f          	j	f90011bc <_vsnprintf+0x54>
        if (*format == 'F') flags |= FLAGS_UPPERCASE;
f9001784:	0206e693          	ori	a3,a3,32
f9001788:	fadff06f          	j	f9001734 <_vsnprintf+0x5cc>
        if ((*format == 'g')||(*format == 'G')) flags |= FLAGS_ADAPT_EXP;
f900178c:	06700793          	li	a5,103
f9001790:	00f50663          	beq	a0,a5,f900179c <_vsnprintf+0x634>
f9001794:	04700793          	li	a5,71
f9001798:	00f51863          	bne	a0,a5,f90017a8 <_vsnprintf+0x640>
f900179c:	000017b7          	lui	a5,0x1
f90017a0:	80078793          	addi	a5,a5,-2048 # 800 <regnum_t6+0x7e1>
f90017a4:	00f6e6b3          	or	a3,a3,a5
        if ((*format == 'E')||(*format == 'G')) flags |= FLAGS_UPPERCASE;
f90017a8:	04500793          	li	a5,69
f90017ac:	00f50663          	beq	a0,a5,f90017b8 <_vsnprintf+0x650>
f90017b0:	04700793          	li	a5,71
f90017b4:	00f51463          	bne	a0,a5,f90017bc <_vsnprintf+0x654>
f90017b8:	0206e693          	ori	a3,a3,32
        idx = _etoa(out, buffer, idx, maxlen, va_arg(va, double), precision, width, flags);
f90017bc:	01812783          	lw	a5,24(sp)
f90017c0:	00778793          	addi	a5,a5,7
f90017c4:	ff87f793          	andi	a5,a5,-8
f90017c8:	00878713          	addi	a4,a5,8
f90017cc:	00e12c23          	sw	a4,24(sp)
f90017d0:	0007a703          	lw	a4,0(a5)
f90017d4:	0047a783          	lw	a5,4(a5)
f90017d8:	00d12023          	sw	a3,0(sp)
f90017dc:	000b0893          	mv	a7,s6
f90017e0:	000a8813          	mv	a6,s5
f90017e4:	00090693          	mv	a3,s2
f90017e8:	00040613          	mv	a2,s0
f90017ec:	00098593          	mv	a1,s3
f90017f0:	000a0513          	mv	a0,s4
f90017f4:	eddfe0ef          	jal	ra,f90006d0 <_etoa>
f90017f8:	00050413          	mv	s0,a0
        format++;
f90017fc:	01c12783          	lw	a5,28(sp)
f9001800:	00178793          	addi	a5,a5,1
f9001804:	00f12e23          	sw	a5,28(sp)
        break;
f9001808:	9b5ff06f          	j	f90011bc <_vsnprintf+0x54>
        if (!(flags & FLAGS_LEFT)) {
f900180c:	0026fb93          	andi	s7,a3,2
f9001810:	060b8863          	beqz	s7,f9001880 <_vsnprintf+0x718>
        unsigned int l = 1U;
f9001814:	00100493          	li	s1,1
        out((char)va_arg(va, int), buffer, idx++, maxlen);
f9001818:	01812783          	lw	a5,24(sp)
f900181c:	00478713          	addi	a4,a5,4
f9001820:	00e12c23          	sw	a4,24(sp)
f9001824:	00140a93          	addi	s5,s0,1
f9001828:	00090693          	mv	a3,s2
f900182c:	00040613          	mv	a2,s0
f9001830:	00098593          	mv	a1,s3
f9001834:	0007c503          	lbu	a0,0(a5)
f9001838:	000a00e7          	jalr	s4
        if (flags & FLAGS_LEFT) {
f900183c:	060b9663          	bnez	s7,f90018a8 <_vsnprintf+0x740>
        format++;
f9001840:	01c12783          	lw	a5,28(sp)
f9001844:	00178793          	addi	a5,a5,1
f9001848:	00f12e23          	sw	a5,28(sp)
        break;
f900184c:	000a8413          	mv	s0,s5
f9001850:	96dff06f          	j	f90011bc <_vsnprintf+0x54>
            out(' ', buffer, idx++, maxlen);
f9001854:	00140a93          	addi	s5,s0,1
f9001858:	00090693          	mv	a3,s2
f900185c:	00040613          	mv	a2,s0
f9001860:	00098593          	mv	a1,s3
f9001864:	02000513          	li	a0,32
f9001868:	000a00e7          	jalr	s4
          while (l++ < width) {
f900186c:	00048793          	mv	a5,s1
            out(' ', buffer, idx++, maxlen);
f9001870:	000a8413          	mv	s0,s5
          while (l++ < width) {
f9001874:	00178493          	addi	s1,a5,1
f9001878:	fd67eee3          	bltu	a5,s6,f9001854 <_vsnprintf+0x6ec>
f900187c:	f9dff06f          	j	f9001818 <_vsnprintf+0x6b0>
        unsigned int l = 1U;
f9001880:	00100793          	li	a5,1
f9001884:	ff1ff06f          	j	f9001874 <_vsnprintf+0x70c>
            out(' ', buffer, idx++, maxlen);
f9001888:	001a8b93          	addi	s7,s5,1
f900188c:	00090693          	mv	a3,s2
f9001890:	000a8613          	mv	a2,s5
f9001894:	00098593          	mv	a1,s3
f9001898:	02000513          	li	a0,32
f900189c:	000a00e7          	jalr	s4
          while (l++ < width) {
f90018a0:	00040493          	mv	s1,s0
            out(' ', buffer, idx++, maxlen);
f90018a4:	000b8a93          	mv	s5,s7
          while (l++ < width) {
f90018a8:	00148413          	addi	s0,s1,1
f90018ac:	fd64eee3          	bltu	s1,s6,f9001888 <_vsnprintf+0x720>
f90018b0:	f91ff06f          	j	f9001840 <_vsnprintf+0x6d8>
      }

      case 's' : {
        const char* p = va_arg(va, char*);
f90018b4:	01812783          	lw	a5,24(sp)
f90018b8:	00478713          	addi	a4,a5,4
f90018bc:	00e12c23          	sw	a4,24(sp)
f90018c0:	0007ab83          	lw	s7,0(a5)
        unsigned int l = _strnlen_s(p, precision ? precision : (size_t)-1);
f90018c4:	020a9463          	bnez	s5,f90018ec <_vsnprintf+0x784>
f90018c8:	fff00713          	li	a4,-1
f90018cc:	000b8793          	mv	a5,s7
  for (s = str; *s && maxsize--; ++s);
f90018d0:	0007c603          	lbu	a2,0(a5)
f90018d4:	02060063          	beqz	a2,f90018f4 <_vsnprintf+0x78c>
f90018d8:	fff70613          	addi	a2,a4,-1
f90018dc:	00070c63          	beqz	a4,f90018f4 <_vsnprintf+0x78c>
f90018e0:	00178793          	addi	a5,a5,1
f90018e4:	00060713          	mv	a4,a2
f90018e8:	fe9ff06f          	j	f90018d0 <_vsnprintf+0x768>
        unsigned int l = _strnlen_s(p, precision ? precision : (size_t)-1);
f90018ec:	000a8713          	mv	a4,s5
f90018f0:	fddff06f          	j	f90018cc <_vsnprintf+0x764>
  return (unsigned int)(s - str);
f90018f4:	417784b3          	sub	s1,a5,s7
        // pre padding
        if (flags & FLAGS_PRECISION) {
f90018f8:	4006fc93          	andi	s9,a3,1024
f90018fc:	000c8663          	beqz	s9,f9001908 <_vsnprintf+0x7a0>
          l = (l < precision ? l : precision);
f9001900:	009af463          	bgeu	s5,s1,f9001908 <_vsnprintf+0x7a0>
f9001904:	000a8493          	mv	s1,s5
        }
        if (!(flags & FLAGS_LEFT)) {
f9001908:	0026fd13          	andi	s10,a3,2
f900190c:	040d1c63          	bnez	s10,f9001964 <_vsnprintf+0x7fc>
f9001910:	0240006f          	j	f9001934 <_vsnprintf+0x7cc>
          while (l++ < width) {
            out(' ', buffer, idx++, maxlen);
f9001914:	00140d93          	addi	s11,s0,1
f9001918:	00090693          	mv	a3,s2
f900191c:	00040613          	mv	a2,s0
f9001920:	00098593          	mv	a1,s3
f9001924:	02000513          	li	a0,32
f9001928:	000a00e7          	jalr	s4
          while (l++ < width) {
f900192c:	000c0493          	mv	s1,s8
            out(' ', buffer, idx++, maxlen);
f9001930:	000d8413          	mv	s0,s11
          while (l++ < width) {
f9001934:	00148c13          	addi	s8,s1,1
f9001938:	fd64eee3          	bltu	s1,s6,f9001914 <_vsnprintf+0x7ac>
f900193c:	000c0493          	mv	s1,s8
f9001940:	0240006f          	j	f9001964 <_vsnprintf+0x7fc>
          }
        }
        // string output
        while ((*p != 0) && (!(flags & FLAGS_PRECISION) || precision--)) {
f9001944:	00078a93          	mv	s5,a5
          out(*(p++), buffer, idx++, maxlen);
f9001948:	001b8b93          	addi	s7,s7,1
f900194c:	00140c13          	addi	s8,s0,1
f9001950:	00090693          	mv	a3,s2
f9001954:	00040613          	mv	a2,s0
f9001958:	00098593          	mv	a1,s3
f900195c:	000a00e7          	jalr	s4
f9001960:	000c0413          	mv	s0,s8
        while ((*p != 0) && (!(flags & FLAGS_PRECISION) || precision--)) {
f9001964:	000bc503          	lbu	a0,0(s7)
f9001968:	00050863          	beqz	a0,f9001978 <_vsnprintf+0x810>
f900196c:	fc0c8ee3          	beqz	s9,f9001948 <_vsnprintf+0x7e0>
f9001970:	fffa8793          	addi	a5,s5,-1
f9001974:	fc0a98e3          	bnez	s5,f9001944 <_vsnprintf+0x7dc>
        }
        // post padding
        if (flags & FLAGS_LEFT) {
f9001978:	020d1a63          	bnez	s10,f90019ac <_vsnprintf+0x844>
          while (l++ < width) {
            out(' ', buffer, idx++, maxlen);
          }
        }
        format++;
f900197c:	01c12783          	lw	a5,28(sp)
f9001980:	00178793          	addi	a5,a5,1
f9001984:	00f12e23          	sw	a5,28(sp)
        break;
f9001988:	835ff06f          	j	f90011bc <_vsnprintf+0x54>
            out(' ', buffer, idx++, maxlen);
f900198c:	00140b93          	addi	s7,s0,1
f9001990:	00090693          	mv	a3,s2
f9001994:	00040613          	mv	a2,s0
f9001998:	00098593          	mv	a1,s3
f900199c:	02000513          	li	a0,32
f90019a0:	000a00e7          	jalr	s4
          while (l++ < width) {
f90019a4:	000a8493          	mv	s1,s5
            out(' ', buffer, idx++, maxlen);
f90019a8:	000b8413          	mv	s0,s7
          while (l++ < width) {
f90019ac:	00148a93          	addi	s5,s1,1
f90019b0:	fd64eee3          	bltu	s1,s6,f900198c <_vsnprintf+0x824>
f90019b4:	fc9ff06f          	j	f900197c <_vsnprintf+0x814>
      }

      case 'p' : {
        width = sizeof(void*) * 2U;
        flags |= FLAGS_ZEROPAD | FLAGS_UPPERCASE;
f90019b8:	0216e693          	ori	a3,a3,33
        if (is_ll) {
          idx = _ntoa_long_long(out, buffer, idx, maxlen, (uintptr_t)va_arg(va, void*), false, 16U, precision, width, flags);
        }
        else {
#endif
          idx = _ntoa_long(out, buffer, idx, maxlen, (unsigned long)((uintptr_t)va_arg(va, void*)), false, 16U, precision, width, flags);
f90019bc:	01812783          	lw	a5,24(sp)
f90019c0:	00478713          	addi	a4,a5,4
f90019c4:	00e12c23          	sw	a4,24(sp)
f90019c8:	0007a703          	lw	a4,0(a5)
f90019cc:	00d12223          	sw	a3,4(sp)
f90019d0:	00800793          	li	a5,8
f90019d4:	00f12023          	sw	a5,0(sp)
f90019d8:	000a8893          	mv	a7,s5
f90019dc:	01000813          	li	a6,16
f90019e0:	00000793          	li	a5,0
f90019e4:	00090693          	mv	a3,s2
f90019e8:	00040613          	mv	a2,s0
f90019ec:	00098593          	mv	a1,s3
f90019f0:	000a0513          	mv	a0,s4
f90019f4:	a81fe0ef          	jal	ra,f9000474 <_ntoa_long>
f90019f8:	00050413          	mv	s0,a0
#if defined(PRINTF_SUPPORT_LONG_LONG)
        }
#endif
        format++;
f90019fc:	01c12783          	lw	a5,28(sp)
f9001a00:	00178793          	addi	a5,a5,1
f9001a04:	00f12e23          	sw	a5,28(sp)
        break;
f9001a08:	fb4ff06f          	j	f90011bc <_vsnprintf+0x54>
      }

      case '%' :
        out('%', buffer, idx++, maxlen);
f9001a0c:	00140493          	addi	s1,s0,1
f9001a10:	00090693          	mv	a3,s2
f9001a14:	00040613          	mv	a2,s0
f9001a18:	00098593          	mv	a1,s3
f9001a1c:	02500513          	li	a0,37
f9001a20:	000a00e7          	jalr	s4
        format++;
f9001a24:	01c12783          	lw	a5,28(sp)
f9001a28:	00178793          	addi	a5,a5,1
f9001a2c:	00f12e23          	sw	a5,28(sp)
        out('%', buffer, idx++, maxlen);
f9001a30:	00048413          	mv	s0,s1
        break;
f9001a34:	f88ff06f          	j	f90011bc <_vsnprintf+0x54>

      default :
        out(*format, buffer, idx++, maxlen);
f9001a38:	00140493          	addi	s1,s0,1
f9001a3c:	00090693          	mv	a3,s2
f9001a40:	00040613          	mv	a2,s0
f9001a44:	00098593          	mv	a1,s3
f9001a48:	000a00e7          	jalr	s4
        format++;
f9001a4c:	01c12783          	lw	a5,28(sp)
f9001a50:	00178793          	addi	a5,a5,1
f9001a54:	00f12e23          	sw	a5,28(sp)
        out(*format, buffer, idx++, maxlen);
f9001a58:	00048413          	mv	s0,s1
        break;
f9001a5c:	f60ff06f          	j	f90011bc <_vsnprintf+0x54>
    out = _out_null;
f9001a60:	f9000a37          	lui	s4,0xf9000
f9001a64:	15ca0a13          	addi	s4,s4,348 # f900015c <__freertos_irq_stack_top+0xffff691c>
f9001a68:	f50ff06f          	j	f90011b8 <_vsnprintf+0x50>
    }
  }

  // termination
  out((char)0, buffer, idx < maxlen ? idx : maxlen - 1U, maxlen);
f9001a6c:	05246c63          	bltu	s0,s2,f9001ac4 <_vsnprintf+0x95c>
f9001a70:	fff90613          	addi	a2,s2,-1
f9001a74:	00090693          	mv	a3,s2
f9001a78:	00098593          	mv	a1,s3
f9001a7c:	00000513          	li	a0,0
f9001a80:	000a00e7          	jalr	s4

  // return written chars without terminating \0
  return (int)idx;
}
f9001a84:	00040513          	mv	a0,s0
f9001a88:	05c12083          	lw	ra,92(sp)
f9001a8c:	05812403          	lw	s0,88(sp)
f9001a90:	05412483          	lw	s1,84(sp)
f9001a94:	05012903          	lw	s2,80(sp)
f9001a98:	04c12983          	lw	s3,76(sp)
f9001a9c:	04812a03          	lw	s4,72(sp)
f9001aa0:	04412a83          	lw	s5,68(sp)
f9001aa4:	04012b03          	lw	s6,64(sp)
f9001aa8:	03c12b83          	lw	s7,60(sp)
f9001aac:	03812c03          	lw	s8,56(sp)
f9001ab0:	03412c83          	lw	s9,52(sp)
f9001ab4:	03012d03          	lw	s10,48(sp)
f9001ab8:	02c12d83          	lw	s11,44(sp)
f9001abc:	06010113          	addi	sp,sp,96
f9001ac0:	00008067          	ret
  out((char)0, buffer, idx < maxlen ? idx : maxlen - 1U, maxlen);
f9001ac4:	00040613          	mv	a2,s0
f9001ac8:	fadff06f          	j	f9001a74 <_vsnprintf+0x90c>

f9001acc <bsp_printf>:
* @param format Format string followed by the arguments to be formatted.
* @param ... Variable arguments corresponding to the format specifiers in 'format'.
*
******************************************************************************/
    static int bsp_printf(const char* format, ...)
    {
f9001acc:	f6010113          	addi	sp,sp,-160
f9001ad0:	06112e23          	sw	ra,124(sp)
f9001ad4:	06812c23          	sw	s0,120(sp)
f9001ad8:	08b12223          	sw	a1,132(sp)
f9001adc:	08c12423          	sw	a2,136(sp)
f9001ae0:	08d12623          	sw	a3,140(sp)
f9001ae4:	08e12823          	sw	a4,144(sp)
f9001ae8:	08f12a23          	sw	a5,148(sp)
f9001aec:	09012c23          	sw	a6,152(sp)
f9001af0:	09112e23          	sw	a7,156(sp)
      va_list va;
      va_start(va, format);
f9001af4:	08410713          	addi	a4,sp,132
f9001af8:	06e12623          	sw	a4,108(sp)

      char buffer[MAX_STRING_BUFFER_SIZE];
        const int ret = _vsnprintf(_out_buffer, buffer, (size_t)-1, format, va);
f9001afc:	00050693          	mv	a3,a0
f9001b00:	fff00613          	li	a2,-1
f9001b04:	00810593          	addi	a1,sp,8
f9001b08:	f9000537          	lui	a0,0xf9000
f9001b0c:	14c50513          	addi	a0,a0,332 # f900014c <__freertos_irq_stack_top+0xffff690c>
f9001b10:	e58ff0ef          	jal	ra,f9001168 <_vsnprintf>
f9001b14:	00050413          	mv	s0,a0
        _putchar_s(buffer);
f9001b18:	00810513          	addi	a0,sp,8
f9001b1c:	e18fe0ef          	jal	ra,f9000134 <_putchar_s>

      va_end(va);
      return ret;
    }
f9001b20:	00040513          	mv	a0,s0
f9001b24:	07c12083          	lw	ra,124(sp)
f9001b28:	07812403          	lw	s0,120(sp)
f9001b2c:	0a010113          	addi	sp,sp,160
f9001b30:	00008067          	ret

f9001b34 <apb3_read>:
*          so the 'volatile' keyword is used to prevent the compiler from
*          optimizing away or reordering the read operation.
*
******************************************************************************/
    static inline u32 read_u32(u32 address){
        return *((volatile u32*) address);
f9001b34:	00052503          	lw	a0,0(a0)
*
******************************************************************************/
	u32 apb3_read(u32 slave)
	{
		return read_u32(slave+EXAMPLE_APB3_SLV_REG0_OFFSET);	
	}
f9001b38:	00008067          	ret

f9001b3c <apb3_ctrl_write>:
* @param ctrl_reg* Control register.
*
******************************************************************************/   
	void apb3_ctrl_write(u32 slave, struct ctrl_reg *cfg)
	{
	    write_u32(*(int *)cfg, slave+EXAMPLE_APB3_SLV_REG1_OFFSET);
f9001b3c:	0005a783          	lw	a5,0(a1)
*          optimizing away or reordering the write operation.
*
******************************************************************************/

    static inline void write_u32(u32 data, u32 address){
        *((volatile u32*) address) = data;
f9001b40:	00f52223          	sw	a5,4(a0)
	}
f9001b44:	00008067          	ret

f9001b48 <cfg_write>:
* @param ctrl_reg* Control register.
*
******************************************************************************/ 
	void cfg_write(u32 slave, struct ctrl_reg2 *cfg)
	{
		write_u32(*(int *)cfg, slave+EXAMPLE_APB3_SLV_REG3_OFFSET);
f9001b48:	0005a783          	lw	a5,0(a1)
f9001b4c:	00f52623          	sw	a5,12(a0)
	}
f9001b50:	00008067          	ret

f9001b54 <cfg_data>:
f9001b54:	00b52823          	sw	a1,16(a0)
*
******************************************************************************/ 
	void cfg_data(u32 slave, u32 data)
	{
		write_u32(data, slave+EXAMPLE_APB3_SLV_REG4_OFFSET);
	}
f9001b58:	00008067          	ret

f9001b5c <cfg_addr>:
f9001b5c:	00b52a23          	sw	a1,20(a0)
*
******************************************************************************/ 
	void cfg_addr(u32 slave, u32  addr)
	{
		write_u32(addr, slave+EXAMPLE_APB3_SLV_REG5_OFFSET);
	}
f9001b60:	00008067          	ret

f9001b64 <error_state>:
*
* @brief This function prints error message on terminal and enters an infinite loop
*         to halt the program's execution.
*
******************************************************************************/
void error_state() {
f9001b64:	ff010113          	addi	sp,sp,-16
f9001b68:	00112623          	sw	ra,12(sp)
    bsp_printf("Failed! \r\n");
f9001b6c:	f9005537          	lui	a0,0xf9005
f9001b70:	ba050513          	addi	a0,a0,-1120 # f9004ba0 <__freertos_irq_stack_top+0xffffb360>
f9001b74:	f59ff0ef          	jal	ra,f9001acc <bsp_printf>
    while (1) {}
f9001b78:	0000006f          	j	f9001b78 <error_state+0x14>

f9001b7c <main>:
uint32_t j = 0;


uint32_t cycle_times = 10800;
extern char gImage_hit_logo[]; //展示校徽
void main() {
f9001b7c:	ff010113          	addi	sp,sp,-16
f9001b80:	00112623          	sw	ra,12(sp)

    bsp_init();

#ifdef IO_APB_SLAVE_0_INPUT

        bsp_printf("apb3 picture transfer ! \r\n");
f9001b84:	f9005537          	lui	a0,0xf9005
f9001b88:	bac50513          	addi	a0,a0,-1108 # f9004bac <__freertos_irq_stack_top+0xffffb36c>
f9001b8c:	f41ff0ef          	jal	ra,f9001acc <bsp_printf>

	    temp = 3;


	   for (i = 0; i < cycle_times; i++) {
f9001b90:	8c01a023          	sw	zero,-1856(gp) # f9007828 <i>
f9001b94:	0340006f          	j	f9001bc8 <main+0x4c>
	   	    temp = gImage_hit_logo[i];//展示校徽
f9001b98:	f9005737          	lui	a4,0xf9005
f9001b9c:	bc870713          	addi	a4,a4,-1080 # f9004bc8 <__freertos_irq_stack_top+0xffffb388>
f9001ba0:	00f70733          	add	a4,a4,a5
f9001ba4:	00074703          	lbu	a4,0(a4)
f9001ba8:	8ce18223          	sb	a4,-1852(gp) # f900782c <temp>
//		   temp = i;
	             write_u32(temp, APB0 + 4*i);
f9001bac:	3e0406b7          	lui	a3,0x3e040
f9001bb0:	00d787b3          	add	a5,a5,a3
f9001bb4:	00279793          	slli	a5,a5,0x2
f9001bb8:	00e7a023          	sw	a4,0(a5)
	   for (i = 0; i < cycle_times; i++) {
f9001bbc:	8c01a783          	lw	a5,-1856(gp) # f9007828 <i>
f9001bc0:	00178793          	addi	a5,a5,1
f9001bc4:	8cf1a023          	sw	a5,-1856(gp) # f9007828 <i>
f9001bc8:	8c01a783          	lw	a5,-1856(gp) # f9007828 <i>
f9001bcc:	8101a703          	lw	a4,-2032(gp) # f9007778 <cycle_times>
f9001bd0:	fce7e4e3          	bltu	a5,a4,f9001b98 <main+0x1c>
#endif

    while (1)
    {

    }
f9001bd4:	0000006f          	j	f9001bd4 <main+0x58>
	...

f9001be0 <__udivdi3>:
f9001be0:	00068793          	mv	a5,a3
f9001be4:	00060893          	mv	a7,a2
f9001be8:	00050313          	mv	t1,a0
f9001bec:	00058813          	mv	a6,a1
f9001bf0:	1a069663          	bnez	a3,f9001d9c <__udivdi3+0x1bc>
f9001bf4:	0cc5fc63          	bgeu	a1,a2,f9001ccc <__udivdi3+0xec>
f9001bf8:	00010737          	lui	a4,0x10
f9001bfc:	22e66463          	bltu	a2,a4,f9001e24 <__udivdi3+0x244>
f9001c00:	010007b7          	lui	a5,0x1000
f9001c04:	40f66a63          	bltu	a2,a5,f9002018 <__udivdi3+0x438>
f9001c08:	01865693          	srli	a3,a2,0x18
f9001c0c:	01800793          	li	a5,24
f9001c10:	00006717          	auipc	a4,0x6
f9001c14:	a6870713          	addi	a4,a4,-1432 # f9007678 <__clz_tab>
f9001c18:	00d70733          	add	a4,a4,a3
f9001c1c:	00074703          	lbu	a4,0(a4)
f9001c20:	00f707b3          	add	a5,a4,a5
f9001c24:	02000713          	li	a4,32
f9001c28:	40f70733          	sub	a4,a4,a5
f9001c2c:	00070c63          	beqz	a4,f9001c44 <__udivdi3+0x64>
f9001c30:	00e59833          	sll	a6,a1,a4
f9001c34:	00f557b3          	srl	a5,a0,a5
f9001c38:	00e618b3          	sll	a7,a2,a4
f9001c3c:	0107e833          	or	a6,a5,a6
f9001c40:	00e51333          	sll	t1,a0,a4
f9001c44:	0108d613          	srli	a2,a7,0x10
f9001c48:	02c85533          	divu	a0,a6,a2
f9001c4c:	01089693          	slli	a3,a7,0x10
f9001c50:	0106d693          	srli	a3,a3,0x10
f9001c54:	01035793          	srli	a5,t1,0x10
f9001c58:	02c87733          	remu	a4,a6,a2
f9001c5c:	02a685b3          	mul	a1,a3,a0
f9001c60:	01071713          	slli	a4,a4,0x10
f9001c64:	00f76833          	or	a6,a4,a5
f9001c68:	00b87c63          	bgeu	a6,a1,f9001c80 <__udivdi3+0xa0>
f9001c6c:	01180833          	add	a6,a6,a7
f9001c70:	fff50793          	addi	a5,a0,-1
f9001c74:	01186463          	bltu	a6,a7,f9001c7c <__udivdi3+0x9c>
f9001c78:	3eb86863          	bltu	a6,a1,f9002068 <__udivdi3+0x488>
f9001c7c:	00078513          	mv	a0,a5
f9001c80:	40b80833          	sub	a6,a6,a1
f9001c84:	02c85733          	divu	a4,a6,a2
f9001c88:	01031313          	slli	t1,t1,0x10
f9001c8c:	01035313          	srli	t1,t1,0x10
f9001c90:	02c87833          	remu	a6,a6,a2
f9001c94:	02e686b3          	mul	a3,a3,a4
f9001c98:	01081813          	slli	a6,a6,0x10
f9001c9c:	00686833          	or	a6,a6,t1
f9001ca0:	00d87e63          	bgeu	a6,a3,f9001cbc <__udivdi3+0xdc>
f9001ca4:	01088833          	add	a6,a7,a6
f9001ca8:	fff70793          	addi	a5,a4,-1
f9001cac:	01186663          	bltu	a6,a7,f9001cb8 <__udivdi3+0xd8>
f9001cb0:	ffe70713          	addi	a4,a4,-2
f9001cb4:	00d86463          	bltu	a6,a3,f9001cbc <__udivdi3+0xdc>
f9001cb8:	00078713          	mv	a4,a5
f9001cbc:	01051513          	slli	a0,a0,0x10
f9001cc0:	00e56533          	or	a0,a0,a4
f9001cc4:	00000593          	li	a1,0
f9001cc8:	00008067          	ret
f9001ccc:	00061663          	bnez	a2,f9001cd8 <__udivdi3+0xf8>
f9001cd0:	00100713          	li	a4,1
f9001cd4:	02c758b3          	divu	a7,a4,a2
f9001cd8:	00010737          	lui	a4,0x10
f9001cdc:	12e8e863          	bltu	a7,a4,f9001e0c <__udivdi3+0x22c>
f9001ce0:	010007b7          	lui	a5,0x1000
f9001ce4:	34f8e063          	bltu	a7,a5,f9002024 <__udivdi3+0x444>
f9001ce8:	0188d693          	srli	a3,a7,0x18
f9001cec:	01800793          	li	a5,24
f9001cf0:	00006717          	auipc	a4,0x6
f9001cf4:	98870713          	addi	a4,a4,-1656 # f9007678 <__clz_tab>
f9001cf8:	00d70733          	add	a4,a4,a3
f9001cfc:	00074683          	lbu	a3,0(a4)
f9001d00:	00f686b3          	add	a3,a3,a5
f9001d04:	02000793          	li	a5,32
f9001d08:	40d787b3          	sub	a5,a5,a3
f9001d0c:	12079863          	bnez	a5,f9001e3c <__udivdi3+0x25c>
f9001d10:	01089e93          	slli	t4,a7,0x10
f9001d14:	41158733          	sub	a4,a1,a7
f9001d18:	0108df13          	srli	t5,a7,0x10
f9001d1c:	010ede93          	srli	t4,t4,0x10
f9001d20:	00100593          	li	a1,1
f9001d24:	01035793          	srli	a5,t1,0x10
f9001d28:	03e75533          	divu	a0,a4,t5
f9001d2c:	03e77733          	remu	a4,a4,t5
f9001d30:	03d506b3          	mul	a3,a0,t4
f9001d34:	01071713          	slli	a4,a4,0x10
f9001d38:	00f767b3          	or	a5,a4,a5
f9001d3c:	00d7fc63          	bgeu	a5,a3,f9001d54 <__udivdi3+0x174>
f9001d40:	011787b3          	add	a5,a5,a7
f9001d44:	fff50713          	addi	a4,a0,-1
f9001d48:	0117e463          	bltu	a5,a7,f9001d50 <__udivdi3+0x170>
f9001d4c:	32d7e463          	bltu	a5,a3,f9002074 <__udivdi3+0x494>
f9001d50:	00070513          	mv	a0,a4
f9001d54:	40d787b3          	sub	a5,a5,a3
f9001d58:	03e7d733          	divu	a4,a5,t5
f9001d5c:	01031313          	slli	t1,t1,0x10
f9001d60:	01035313          	srli	t1,t1,0x10
f9001d64:	03e7f7b3          	remu	a5,a5,t5
f9001d68:	03d70eb3          	mul	t4,a4,t4
f9001d6c:	01079793          	slli	a5,a5,0x10
f9001d70:	0067e7b3          	or	a5,a5,t1
f9001d74:	01d7fe63          	bgeu	a5,t4,f9001d90 <__udivdi3+0x1b0>
f9001d78:	00f887b3          	add	a5,a7,a5
f9001d7c:	fff70693          	addi	a3,a4,-1
f9001d80:	0117e663          	bltu	a5,a7,f9001d8c <__udivdi3+0x1ac>
f9001d84:	ffe70713          	addi	a4,a4,-2
f9001d88:	01d7e463          	bltu	a5,t4,f9001d90 <__udivdi3+0x1b0>
f9001d8c:	00068713          	mv	a4,a3
f9001d90:	01051513          	slli	a0,a0,0x10
f9001d94:	00e56533          	or	a0,a0,a4
f9001d98:	00008067          	ret
f9001d9c:	04d5e863          	bltu	a1,a3,f9001dec <__udivdi3+0x20c>
f9001da0:	000107b7          	lui	a5,0x10
f9001da4:	04f6ea63          	bltu	a3,a5,f9001df8 <__udivdi3+0x218>
f9001da8:	010007b7          	lui	a5,0x1000
f9001dac:	26f6e063          	bltu	a3,a5,f900200c <__udivdi3+0x42c>
f9001db0:	0186d713          	srli	a4,a3,0x18
f9001db4:	01800813          	li	a6,24
f9001db8:	00006797          	auipc	a5,0x6
f9001dbc:	8c078793          	addi	a5,a5,-1856 # f9007678 <__clz_tab>
f9001dc0:	00e787b3          	add	a5,a5,a4
f9001dc4:	0007c703          	lbu	a4,0(a5)
f9001dc8:	02000e13          	li	t3,32
f9001dcc:	01070733          	add	a4,a4,a6
f9001dd0:	40ee0e33          	sub	t3,t3,a4
f9001dd4:	100e1663          	bnez	t3,f9001ee0 <__udivdi3+0x300>
f9001dd8:	24b6ec63          	bltu	a3,a1,f9002030 <__udivdi3+0x450>
f9001ddc:	00c53533          	sltu	a0,a0,a2
f9001de0:	00154513          	xori	a0,a0,1
f9001de4:	00000593          	li	a1,0
f9001de8:	00008067          	ret
f9001dec:	00000593          	li	a1,0
f9001df0:	00000513          	li	a0,0
f9001df4:	00008067          	ret
f9001df8:	0ff00793          	li	a5,255
f9001dfc:	24d7f063          	bgeu	a5,a3,f900203c <__udivdi3+0x45c>
f9001e00:	0086d713          	srli	a4,a3,0x8
f9001e04:	00800813          	li	a6,8
f9001e08:	fb1ff06f          	j	f9001db8 <__udivdi3+0x1d8>
f9001e0c:	0ff00713          	li	a4,255
f9001e10:	00088693          	mv	a3,a7
f9001e14:	ed177ee3          	bgeu	a4,a7,f9001cf0 <__udivdi3+0x110>
f9001e18:	0088d693          	srli	a3,a7,0x8
f9001e1c:	00800793          	li	a5,8
f9001e20:	ed1ff06f          	j	f9001cf0 <__udivdi3+0x110>
f9001e24:	0ff00713          	li	a4,255
f9001e28:	00060693          	mv	a3,a2
f9001e2c:	dec772e3          	bgeu	a4,a2,f9001c10 <__udivdi3+0x30>
f9001e30:	00865693          	srli	a3,a2,0x8
f9001e34:	00800793          	li	a5,8
f9001e38:	dd9ff06f          	j	f9001c10 <__udivdi3+0x30>
f9001e3c:	00f898b3          	sll	a7,a7,a5
f9001e40:	00d5d633          	srl	a2,a1,a3
f9001e44:	0108df13          	srli	t5,a7,0x10
f9001e48:	03e65e33          	divu	t3,a2,t5
f9001e4c:	00f59733          	sll	a4,a1,a5
f9001e50:	00d556b3          	srl	a3,a0,a3
f9001e54:	00e6e733          	or	a4,a3,a4
f9001e58:	01089e93          	slli	t4,a7,0x10
f9001e5c:	010ede93          	srli	t4,t4,0x10
f9001e60:	00f51333          	sll	t1,a0,a5
f9001e64:	01075593          	srli	a1,a4,0x10
f9001e68:	03e676b3          	remu	a3,a2,t5
f9001e6c:	03ce87b3          	mul	a5,t4,t3
f9001e70:	01069693          	slli	a3,a3,0x10
f9001e74:	00b6e6b3          	or	a3,a3,a1
f9001e78:	00f6fe63          	bgeu	a3,a5,f9001e94 <__udivdi3+0x2b4>
f9001e7c:	011686b3          	add	a3,a3,a7
f9001e80:	fffe0613          	addi	a2,t3,-1
f9001e84:	1d16ee63          	bltu	a3,a7,f9002060 <__udivdi3+0x480>
f9001e88:	1cf6fc63          	bgeu	a3,a5,f9002060 <__udivdi3+0x480>
f9001e8c:	ffee0e13          	addi	t3,t3,-2
f9001e90:	011686b3          	add	a3,a3,a7
f9001e94:	40f686b3          	sub	a3,a3,a5
f9001e98:	03e6d633          	divu	a2,a3,t5
f9001e9c:	01071793          	slli	a5,a4,0x10
f9001ea0:	0107d793          	srli	a5,a5,0x10
f9001ea4:	03e6f6b3          	remu	a3,a3,t5
f9001ea8:	02ce8533          	mul	a0,t4,a2
f9001eac:	01069713          	slli	a4,a3,0x10
f9001eb0:	00f76733          	or	a4,a4,a5
f9001eb4:	00a77e63          	bgeu	a4,a0,f9001ed0 <__udivdi3+0x2f0>
f9001eb8:	01170733          	add	a4,a4,a7
f9001ebc:	fff60793          	addi	a5,a2,-1
f9001ec0:	19176863          	bltu	a4,a7,f9002050 <__udivdi3+0x470>
f9001ec4:	18a77663          	bgeu	a4,a0,f9002050 <__udivdi3+0x470>
f9001ec8:	ffe60613          	addi	a2,a2,-2
f9001ecc:	01170733          	add	a4,a4,a7
f9001ed0:	010e1593          	slli	a1,t3,0x10
f9001ed4:	40a70733          	sub	a4,a4,a0
f9001ed8:	00c5e5b3          	or	a1,a1,a2
f9001edc:	e49ff06f          	j	f9001d24 <__udivdi3+0x144>
f9001ee0:	00e657b3          	srl	a5,a2,a4
f9001ee4:	01c696b3          	sll	a3,a3,t3
f9001ee8:	00d7e6b3          	or	a3,a5,a3
f9001eec:	00e5d333          	srl	t1,a1,a4
f9001ef0:	0106df13          	srli	t5,a3,0x10
f9001ef4:	03e357b3          	divu	a5,t1,t5
f9001ef8:	01069e93          	slli	t4,a3,0x10
f9001efc:	010ede93          	srli	t4,t4,0x10
f9001f00:	01c59833          	sll	a6,a1,t3
f9001f04:	00e55733          	srl	a4,a0,a4
f9001f08:	01076833          	or	a6,a4,a6
f9001f0c:	01085893          	srli	a7,a6,0x10
f9001f10:	01c61633          	sll	a2,a2,t3
f9001f14:	03e37333          	remu	t1,t1,t5
f9001f18:	02fe85b3          	mul	a1,t4,a5
f9001f1c:	01031313          	slli	t1,t1,0x10
f9001f20:	011368b3          	or	a7,t1,a7
f9001f24:	00b8fe63          	bgeu	a7,a1,f9001f40 <__udivdi3+0x360>
f9001f28:	00d888b3          	add	a7,a7,a3
f9001f2c:	fff78713          	addi	a4,a5,-1
f9001f30:	12d8e463          	bltu	a7,a3,f9002058 <__udivdi3+0x478>
f9001f34:	12b8f263          	bgeu	a7,a1,f9002058 <__udivdi3+0x478>
f9001f38:	ffe78793          	addi	a5,a5,-2
f9001f3c:	00d888b3          	add	a7,a7,a3
f9001f40:	40b888b3          	sub	a7,a7,a1
f9001f44:	03e8d733          	divu	a4,a7,t5
f9001f48:	01081813          	slli	a6,a6,0x10
f9001f4c:	01085813          	srli	a6,a6,0x10
f9001f50:	03e8f8b3          	remu	a7,a7,t5
f9001f54:	02ee8333          	mul	t1,t4,a4
f9001f58:	01089893          	slli	a7,a7,0x10
f9001f5c:	0108e5b3          	or	a1,a7,a6
f9001f60:	0065fe63          	bgeu	a1,t1,f9001f7c <__udivdi3+0x39c>
f9001f64:	00d585b3          	add	a1,a1,a3
f9001f68:	fff70813          	addi	a6,a4,-1
f9001f6c:	0cd5ee63          	bltu	a1,a3,f9002048 <__udivdi3+0x468>
f9001f70:	0c65fc63          	bgeu	a1,t1,f9002048 <__udivdi3+0x468>
f9001f74:	ffe70713          	addi	a4,a4,-2
f9001f78:	00d585b3          	add	a1,a1,a3
f9001f7c:	01079793          	slli	a5,a5,0x10
f9001f80:	00010f37          	lui	t5,0x10
f9001f84:	00e7e7b3          	or	a5,a5,a4
f9001f88:	ffff0713          	addi	a4,t5,-1 # ffff <__stack_size+0xdfff>
f9001f8c:	00e7f6b3          	and	a3,a5,a4
f9001f90:	0107d893          	srli	a7,a5,0x10
f9001f94:	00e67733          	and	a4,a2,a4
f9001f98:	01065613          	srli	a2,a2,0x10
f9001f9c:	02e68eb3          	mul	t4,a3,a4
f9001fa0:	406585b3          	sub	a1,a1,t1
f9001fa4:	02c686b3          	mul	a3,a3,a2
f9001fa8:	010ed813          	srli	a6,t4,0x10
f9001fac:	02e88733          	mul	a4,a7,a4
f9001fb0:	00e686b3          	add	a3,a3,a4
f9001fb4:	00d806b3          	add	a3,a6,a3
f9001fb8:	02c88633          	mul	a2,a7,a2
f9001fbc:	00e6f463          	bgeu	a3,a4,f9001fc4 <__udivdi3+0x3e4>
f9001fc0:	01e60633          	add	a2,a2,t5
f9001fc4:	0106d893          	srli	a7,a3,0x10
f9001fc8:	00c88633          	add	a2,a7,a2
f9001fcc:	02c5ea63          	bltu	a1,a2,f9002000 <__udivdi3+0x420>
f9001fd0:	00c58863          	beq	a1,a2,f9001fe0 <__udivdi3+0x400>
f9001fd4:	00078513          	mv	a0,a5
f9001fd8:	00000593          	li	a1,0
f9001fdc:	00008067          	ret
f9001fe0:	00010737          	lui	a4,0x10
f9001fe4:	fff70713          	addi	a4,a4,-1 # ffff <__stack_size+0xdfff>
f9001fe8:	00e6f6b3          	and	a3,a3,a4
f9001fec:	01069693          	slli	a3,a3,0x10
f9001ff0:	00eefeb3          	and	t4,t4,a4
f9001ff4:	01c51533          	sll	a0,a0,t3
f9001ff8:	01d686b3          	add	a3,a3,t4
f9001ffc:	fcd57ce3          	bgeu	a0,a3,f9001fd4 <__udivdi3+0x3f4>
f9002000:	fff78513          	addi	a0,a5,-1
f9002004:	00000593          	li	a1,0
f9002008:	00008067          	ret
f900200c:	0106d713          	srli	a4,a3,0x10
f9002010:	01000813          	li	a6,16
f9002014:	da5ff06f          	j	f9001db8 <__udivdi3+0x1d8>
f9002018:	01065693          	srli	a3,a2,0x10
f900201c:	01000793          	li	a5,16
f9002020:	bf1ff06f          	j	f9001c10 <__udivdi3+0x30>
f9002024:	0108d693          	srli	a3,a7,0x10
f9002028:	01000793          	li	a5,16
f900202c:	cc5ff06f          	j	f9001cf0 <__udivdi3+0x110>
f9002030:	00000593          	li	a1,0
f9002034:	00100513          	li	a0,1
f9002038:	00008067          	ret
f900203c:	00068713          	mv	a4,a3
f9002040:	00000813          	li	a6,0
f9002044:	d75ff06f          	j	f9001db8 <__udivdi3+0x1d8>
f9002048:	00080713          	mv	a4,a6
f900204c:	f31ff06f          	j	f9001f7c <__udivdi3+0x39c>
f9002050:	00078613          	mv	a2,a5
f9002054:	e7dff06f          	j	f9001ed0 <__udivdi3+0x2f0>
f9002058:	00070793          	mv	a5,a4
f900205c:	ee5ff06f          	j	f9001f40 <__udivdi3+0x360>
f9002060:	00060e13          	mv	t3,a2
f9002064:	e31ff06f          	j	f9001e94 <__udivdi3+0x2b4>
f9002068:	ffe50513          	addi	a0,a0,-2
f900206c:	01180833          	add	a6,a6,a7
f9002070:	c11ff06f          	j	f9001c80 <__udivdi3+0xa0>
f9002074:	ffe50513          	addi	a0,a0,-2
f9002078:	011787b3          	add	a5,a5,a7
f900207c:	cd9ff06f          	j	f9001d54 <__udivdi3+0x174>

f9002080 <__umoddi3>:
f9002080:	00068793          	mv	a5,a3
f9002084:	00060813          	mv	a6,a2
f9002088:	00050313          	mv	t1,a0
f900208c:	00058713          	mv	a4,a1
f9002090:	00058e13          	mv	t3,a1
f9002094:	18069263          	bnez	a3,f9002218 <__umoddi3+0x198>
f9002098:	0cc5f063          	bgeu	a1,a2,f9002158 <__umoddi3+0xd8>
f900209c:	00010737          	lui	a4,0x10
f90020a0:	20e67463          	bgeu	a2,a4,f90022a8 <__umoddi3+0x228>
f90020a4:	0ff00713          	li	a4,255
f90020a8:	00060693          	mv	a3,a2
f90020ac:	00c77663          	bgeu	a4,a2,f90020b8 <__umoddi3+0x38>
f90020b0:	00865693          	srli	a3,a2,0x8
f90020b4:	00800793          	li	a5,8
f90020b8:	00005717          	auipc	a4,0x5
f90020bc:	5c070713          	addi	a4,a4,1472 # f9007678 <__clz_tab>
f90020c0:	00d70733          	add	a4,a4,a3
f90020c4:	00074703          	lbu	a4,0(a4)
f90020c8:	02000893          	li	a7,32
f90020cc:	00f707b3          	add	a5,a4,a5
f90020d0:	40f888b3          	sub	a7,a7,a5
f90020d4:	00088c63          	beqz	a7,f90020ec <__umoddi3+0x6c>
f90020d8:	011595b3          	sll	a1,a1,a7
f90020dc:	00f557b3          	srl	a5,a0,a5
f90020e0:	01161833          	sll	a6,a2,a7
f90020e4:	00b7ee33          	or	t3,a5,a1
f90020e8:	01151333          	sll	t1,a0,a7
f90020ec:	01085613          	srli	a2,a6,0x10
f90020f0:	02ce57b3          	divu	a5,t3,a2
f90020f4:	01081513          	slli	a0,a6,0x10
f90020f8:	01055513          	srli	a0,a0,0x10
f90020fc:	01035693          	srli	a3,t1,0x10
f9002100:	02ce7e33          	remu	t3,t3,a2
f9002104:	02f507b3          	mul	a5,a0,a5
f9002108:	010e1e13          	slli	t3,t3,0x10
f900210c:	00de6733          	or	a4,t3,a3
f9002110:	00f77a63          	bgeu	a4,a5,f9002124 <__umoddi3+0xa4>
f9002114:	01070733          	add	a4,a4,a6
f9002118:	01076663          	bltu	a4,a6,f9002124 <__umoddi3+0xa4>
f900211c:	00f77463          	bgeu	a4,a5,f9002124 <__umoddi3+0xa4>
f9002120:	01070733          	add	a4,a4,a6
f9002124:	40f70733          	sub	a4,a4,a5
f9002128:	02c756b3          	divu	a3,a4,a2
f900212c:	01031793          	slli	a5,t1,0x10
f9002130:	0107d793          	srli	a5,a5,0x10
f9002134:	02c77733          	remu	a4,a4,a2
f9002138:	02d50533          	mul	a0,a0,a3
f900213c:	01071713          	slli	a4,a4,0x10
f9002140:	00f767b3          	or	a5,a4,a5
f9002144:	0aa7ea63          	bltu	a5,a0,f90021f8 <__umoddi3+0x178>
f9002148:	40a78533          	sub	a0,a5,a0
f900214c:	01155533          	srl	a0,a0,a7
f9002150:	00000593          	li	a1,0
f9002154:	00008067          	ret
f9002158:	00061663          	bnez	a2,f9002164 <__umoddi3+0xe4>
f900215c:	00100713          	li	a4,1
f9002160:	02c75833          	divu	a6,a4,a2
f9002164:	00010737          	lui	a4,0x10
f9002168:	12e86463          	bltu	a6,a4,f9002290 <__umoddi3+0x210>
f900216c:	010007b7          	lui	a5,0x1000
f9002170:	32f86a63          	bltu	a6,a5,f90024a4 <__umoddi3+0x424>
f9002174:	01885693          	srli	a3,a6,0x18
f9002178:	01800793          	li	a5,24
f900217c:	00005717          	auipc	a4,0x5
f9002180:	4fc70713          	addi	a4,a4,1276 # f9007678 <__clz_tab>
f9002184:	00d70733          	add	a4,a4,a3
f9002188:	00074703          	lbu	a4,0(a4)
f900218c:	02000893          	li	a7,32
f9002190:	00f707b3          	add	a5,a4,a5
f9002194:	40f888b3          	sub	a7,a7,a5
f9002198:	24089c63          	bnez	a7,f90023f0 <__umoddi3+0x370>
f900219c:	01081e13          	slli	t3,a6,0x10
f90021a0:	410585b3          	sub	a1,a1,a6
f90021a4:	01085613          	srli	a2,a6,0x10
f90021a8:	010e5e13          	srli	t3,t3,0x10
f90021ac:	01035713          	srli	a4,t1,0x10
f90021b0:	02c5d6b3          	divu	a3,a1,a2
f90021b4:	02c5f5b3          	remu	a1,a1,a2
f90021b8:	03c686b3          	mul	a3,a3,t3
f90021bc:	01059593          	slli	a1,a1,0x10
f90021c0:	00e5e733          	or	a4,a1,a4
f90021c4:	00d77863          	bgeu	a4,a3,f90021d4 <__umoddi3+0x154>
f90021c8:	01070733          	add	a4,a4,a6
f90021cc:	01076463          	bltu	a4,a6,f90021d4 <__umoddi3+0x154>
f90021d0:	30d76463          	bltu	a4,a3,f90024d8 <__umoddi3+0x458>
f90021d4:	40d70733          	sub	a4,a4,a3
f90021d8:	02c75533          	divu	a0,a4,a2
f90021dc:	01031313          	slli	t1,t1,0x10
f90021e0:	01035313          	srli	t1,t1,0x10
f90021e4:	02c77733          	remu	a4,a4,a2
f90021e8:	03c50533          	mul	a0,a0,t3
f90021ec:	01071713          	slli	a4,a4,0x10
f90021f0:	006767b3          	or	a5,a4,t1
f90021f4:	00a7fa63          	bgeu	a5,a0,f9002208 <__umoddi3+0x188>
f90021f8:	010787b3          	add	a5,a5,a6
f90021fc:	0107e663          	bltu	a5,a6,f9002208 <__umoddi3+0x188>
f9002200:	00a7f463          	bgeu	a5,a0,f9002208 <__umoddi3+0x188>
f9002204:	010787b3          	add	a5,a5,a6
f9002208:	40a78533          	sub	a0,a5,a0
f900220c:	01155533          	srl	a0,a0,a7
f9002210:	00000593          	li	a1,0
f9002214:	00008067          	ret
f9002218:	00050813          	mv	a6,a0
f900221c:	f2d5ece3          	bltu	a1,a3,f9002154 <__umoddi3+0xd4>
f9002220:	000107b7          	lui	a5,0x10
f9002224:	04f6ec63          	bltu	a3,a5,f900227c <__umoddi3+0x1fc>
f9002228:	010007b7          	lui	a5,0x1000
f900222c:	26f6e663          	bltu	a3,a5,f9002498 <__umoddi3+0x418>
f9002230:	0186d313          	srli	t1,a3,0x18
f9002234:	01800893          	li	a7,24
f9002238:	00005797          	auipc	a5,0x5
f900223c:	44078793          	addi	a5,a5,1088 # f9007678 <__clz_tab>
f9002240:	006787b3          	add	a5,a5,t1
f9002244:	0007ce03          	lbu	t3,0(a5)
f9002248:	02000313          	li	t1,32
f900224c:	011e0e33          	add	t3,t3,a7
f9002250:	41c30333          	sub	t1,t1,t3
f9002254:	06031463          	bnez	t1,f90022bc <__umoddi3+0x23c>
f9002258:	00b6e463          	bltu	a3,a1,f9002260 <__umoddi3+0x1e0>
f900225c:	00c56a63          	bltu	a0,a2,f9002270 <__umoddi3+0x1f0>
f9002260:	40c50833          	sub	a6,a0,a2
f9002264:	40d585b3          	sub	a1,a1,a3
f9002268:	01053733          	sltu	a4,a0,a6
f900226c:	40e58733          	sub	a4,a1,a4
f9002270:	00080513          	mv	a0,a6
f9002274:	00070593          	mv	a1,a4
f9002278:	00008067          	ret
f900227c:	0ff00793          	li	a5,255
f9002280:	22d7fe63          	bgeu	a5,a3,f90024bc <__umoddi3+0x43c>
f9002284:	0086d313          	srli	t1,a3,0x8
f9002288:	00800893          	li	a7,8
f900228c:	fadff06f          	j	f9002238 <__umoddi3+0x1b8>
f9002290:	0ff00713          	li	a4,255
f9002294:	00080693          	mv	a3,a6
f9002298:	ef0772e3          	bgeu	a4,a6,f900217c <__umoddi3+0xfc>
f900229c:	00885693          	srli	a3,a6,0x8
f90022a0:	00800793          	li	a5,8
f90022a4:	ed9ff06f          	j	f900217c <__umoddi3+0xfc>
f90022a8:	010007b7          	lui	a5,0x1000
f90022ac:	20f66263          	bltu	a2,a5,f90024b0 <__umoddi3+0x430>
f90022b0:	01865693          	srli	a3,a2,0x18
f90022b4:	01800793          	li	a5,24
f90022b8:	e01ff06f          	j	f90020b8 <__umoddi3+0x38>
f90022bc:	01c657b3          	srl	a5,a2,t3
f90022c0:	006696b3          	sll	a3,a3,t1
f90022c4:	00d7e6b3          	or	a3,a5,a3
f90022c8:	01c5d8b3          	srl	a7,a1,t3
f90022cc:	0106d713          	srli	a4,a3,0x10
f90022d0:	02e8deb3          	divu	t4,a7,a4
f90022d4:	01069f13          	slli	t5,a3,0x10
f90022d8:	01c557b3          	srl	a5,a0,t3
f90022dc:	010f5f13          	srli	t5,t5,0x10
f90022e0:	006595b3          	sll	a1,a1,t1
f90022e4:	00b7e5b3          	or	a1,a5,a1
f90022e8:	0105d813          	srli	a6,a1,0x10
f90022ec:	00661633          	sll	a2,a2,t1
f90022f0:	00651533          	sll	a0,a0,t1
f90022f4:	02e8f8b3          	remu	a7,a7,a4
f90022f8:	03df07b3          	mul	a5,t5,t4
f90022fc:	01089893          	slli	a7,a7,0x10
f9002300:	0108e833          	or	a6,a7,a6
f9002304:	00f87e63          	bgeu	a6,a5,f9002320 <__umoddi3+0x2a0>
f9002308:	00d80833          	add	a6,a6,a3
f900230c:	fffe8893          	addi	a7,t4,-1
f9002310:	1cd86063          	bltu	a6,a3,f90024d0 <__umoddi3+0x450>
f9002314:	1af87e63          	bgeu	a6,a5,f90024d0 <__umoddi3+0x450>
f9002318:	ffee8e93          	addi	t4,t4,-2
f900231c:	00d80833          	add	a6,a6,a3
f9002320:	40f80833          	sub	a6,a6,a5
f9002324:	02e857b3          	divu	a5,a6,a4
f9002328:	01059593          	slli	a1,a1,0x10
f900232c:	0105d593          	srli	a1,a1,0x10
f9002330:	02e87833          	remu	a6,a6,a4
f9002334:	02ff0f33          	mul	t5,t5,a5
f9002338:	01081713          	slli	a4,a6,0x10
f900233c:	00b76733          	or	a4,a4,a1
f9002340:	01e77e63          	bgeu	a4,t5,f900235c <__umoddi3+0x2dc>
f9002344:	00d70733          	add	a4,a4,a3
f9002348:	fff78593          	addi	a1,a5,-1 # ffffff <__stack_size+0xffdfff>
f900234c:	16d76e63          	bltu	a4,a3,f90024c8 <__umoddi3+0x448>
f9002350:	17e77c63          	bgeu	a4,t5,f90024c8 <__umoddi3+0x448>
f9002354:	ffe78793          	addi	a5,a5,-2
f9002358:	00d70733          	add	a4,a4,a3
f900235c:	010e9e93          	slli	t4,t4,0x10
f9002360:	000102b7          	lui	t0,0x10
f9002364:	00feeeb3          	or	t4,t4,a5
f9002368:	fff28813          	addi	a6,t0,-1 # ffff <__stack_size+0xdfff>
f900236c:	010ef8b3          	and	a7,t4,a6
f9002370:	01065593          	srli	a1,a2,0x10
f9002374:	010ede93          	srli	t4,t4,0x10
f9002378:	01067833          	and	a6,a2,a6
f900237c:	03088fb3          	mul	t6,a7,a6
f9002380:	41e70733          	sub	a4,a4,t5
f9002384:	030e8833          	mul	a6,t4,a6
f9002388:	010fd793          	srli	a5,t6,0x10
f900238c:	02b888b3          	mul	a7,a7,a1
f9002390:	010888b3          	add	a7,a7,a6
f9002394:	011787b3          	add	a5,a5,a7
f9002398:	02be8eb3          	mul	t4,t4,a1
f900239c:	0107f463          	bgeu	a5,a6,f90023a4 <__umoddi3+0x324>
f90023a0:	005e8eb3          	add	t4,t4,t0
f90023a4:	00010837          	lui	a6,0x10
f90023a8:	fff80813          	addi	a6,a6,-1 # ffff <__stack_size+0xdfff>
f90023ac:	0107d593          	srli	a1,a5,0x10
f90023b0:	0107f7b3          	and	a5,a5,a6
f90023b4:	01079793          	slli	a5,a5,0x10
f90023b8:	010fffb3          	and	t6,t6,a6
f90023bc:	01d585b3          	add	a1,a1,t4
f90023c0:	01f787b3          	add	a5,a5,t6
f90023c4:	0ab76e63          	bltu	a4,a1,f9002480 <__umoddi3+0x400>
f90023c8:	0ab70a63          	beq	a4,a1,f900247c <__umoddi3+0x3fc>
f90023cc:	40f507b3          	sub	a5,a0,a5
f90023d0:	00f53533          	sltu	a0,a0,a5
f90023d4:	40b705b3          	sub	a1,a4,a1
f90023d8:	40a585b3          	sub	a1,a1,a0
f90023dc:	01c59e33          	sll	t3,a1,t3
f90023e0:	0067d533          	srl	a0,a5,t1
f90023e4:	00ae6533          	or	a0,t3,a0
f90023e8:	0065d5b3          	srl	a1,a1,t1
f90023ec:	00008067          	ret
f90023f0:	01181833          	sll	a6,a6,a7
f90023f4:	00f5d733          	srl	a4,a1,a5
f90023f8:	01085613          	srli	a2,a6,0x10
f90023fc:	02c756b3          	divu	a3,a4,a2
f9002400:	01081e13          	slli	t3,a6,0x10
f9002404:	00f557b3          	srl	a5,a0,a5
f9002408:	010e5e13          	srli	t3,t3,0x10
f900240c:	011595b3          	sll	a1,a1,a7
f9002410:	00b7e5b3          	or	a1,a5,a1
f9002414:	0105de93          	srli	t4,a1,0x10
f9002418:	01151333          	sll	t1,a0,a7
f900241c:	02c77733          	remu	a4,a4,a2
f9002420:	02de07b3          	mul	a5,t3,a3
f9002424:	01071693          	slli	a3,a4,0x10
f9002428:	01d6e6b3          	or	a3,a3,t4
f900242c:	00f6fa63          	bgeu	a3,a5,f9002440 <__umoddi3+0x3c0>
f9002430:	010686b3          	add	a3,a3,a6
f9002434:	0106e663          	bltu	a3,a6,f9002440 <__umoddi3+0x3c0>
f9002438:	00f6f463          	bgeu	a3,a5,f9002440 <__umoddi3+0x3c0>
f900243c:	010686b3          	add	a3,a3,a6
f9002440:	40f686b3          	sub	a3,a3,a5
f9002444:	02c6d733          	divu	a4,a3,a2
f9002448:	01059793          	slli	a5,a1,0x10
f900244c:	0107d793          	srli	a5,a5,0x10
f9002450:	02c6f6b3          	remu	a3,a3,a2
f9002454:	02ee0733          	mul	a4,t3,a4
f9002458:	01069593          	slli	a1,a3,0x10
f900245c:	00f5e5b3          	or	a1,a1,a5
f9002460:	00e5fa63          	bgeu	a1,a4,f9002474 <__umoddi3+0x3f4>
f9002464:	010585b3          	add	a1,a1,a6
f9002468:	0105e663          	bltu	a1,a6,f9002474 <__umoddi3+0x3f4>
f900246c:	00e5f463          	bgeu	a1,a4,f9002474 <__umoddi3+0x3f4>
f9002470:	010585b3          	add	a1,a1,a6
f9002474:	40e585b3          	sub	a1,a1,a4
f9002478:	d35ff06f          	j	f90021ac <__umoddi3+0x12c>
f900247c:	f4f578e3          	bgeu	a0,a5,f90023cc <__umoddi3+0x34c>
f9002480:	40c78633          	sub	a2,a5,a2
f9002484:	00c7b7b3          	sltu	a5,a5,a2
f9002488:	00d787b3          	add	a5,a5,a3
f900248c:	40f585b3          	sub	a1,a1,a5
f9002490:	00060793          	mv	a5,a2
f9002494:	f39ff06f          	j	f90023cc <__umoddi3+0x34c>
f9002498:	0106d313          	srli	t1,a3,0x10
f900249c:	01000893          	li	a7,16
f90024a0:	d99ff06f          	j	f9002238 <__umoddi3+0x1b8>
f90024a4:	01085693          	srli	a3,a6,0x10
f90024a8:	01000793          	li	a5,16
f90024ac:	cd1ff06f          	j	f900217c <__umoddi3+0xfc>
f90024b0:	01065693          	srli	a3,a2,0x10
f90024b4:	01000793          	li	a5,16
f90024b8:	c01ff06f          	j	f90020b8 <__umoddi3+0x38>
f90024bc:	00068313          	mv	t1,a3
f90024c0:	00000893          	li	a7,0
f90024c4:	d75ff06f          	j	f9002238 <__umoddi3+0x1b8>
f90024c8:	00058793          	mv	a5,a1
f90024cc:	e91ff06f          	j	f900235c <__umoddi3+0x2dc>
f90024d0:	00088e93          	mv	t4,a7
f90024d4:	e4dff06f          	j	f9002320 <__umoddi3+0x2a0>
f90024d8:	01070733          	add	a4,a4,a6
f90024dc:	cf9ff06f          	j	f90021d4 <__umoddi3+0x154>

f90024e0 <__adddf3>:
f90024e0:	00100837          	lui	a6,0x100
f90024e4:	fe010113          	addi	sp,sp,-32
f90024e8:	fff80813          	addi	a6,a6,-1 # fffff <__stack_size+0xfdfff>
f90024ec:	00b87733          	and	a4,a6,a1
f90024f0:	00912a23          	sw	s1,20(sp)
f90024f4:	00d87833          	and	a6,a6,a3
f90024f8:	0145d493          	srli	s1,a1,0x14
f90024fc:	0146d313          	srli	t1,a3,0x14
f9002500:	00371e13          	slli	t3,a4,0x3
f9002504:	01312623          	sw	s3,12(sp)
f9002508:	01d55713          	srli	a4,a0,0x1d
f900250c:	00381813          	slli	a6,a6,0x3
f9002510:	01d65793          	srli	a5,a2,0x1d
f9002514:	7ff4f493          	andi	s1,s1,2047
f9002518:	7ff37313          	andi	t1,t1,2047
f900251c:	00112e23          	sw	ra,28(sp)
f9002520:	00812c23          	sw	s0,24(sp)
f9002524:	01212823          	sw	s2,16(sp)
f9002528:	01f5d993          	srli	s3,a1,0x1f
f900252c:	01f6de93          	srli	t4,a3,0x1f
f9002530:	01c76733          	or	a4,a4,t3
f9002534:	00351f13          	slli	t5,a0,0x3
f9002538:	0107e833          	or	a6,a5,a6
f900253c:	00361f93          	slli	t6,a2,0x3
f9002540:	40648e33          	sub	t3,s1,t1
f9002544:	1dd98463          	beq	s3,t4,f900270c <__adddf3+0x22c>
f9002548:	17c05863          	blez	t3,f90026b8 <__adddf3+0x1d8>
f900254c:	20030a63          	beqz	t1,f9002760 <__adddf3+0x280>
f9002550:	008006b7          	lui	a3,0x800
f9002554:	7ff00793          	li	a5,2047
f9002558:	00d86833          	or	a6,a6,a3
f900255c:	40f48e63          	beq	s1,a5,f9002978 <__adddf3+0x498>
f9002560:	03800793          	li	a5,56
f9002564:	3dc7ca63          	blt	a5,t3,f9002938 <__adddf3+0x458>
f9002568:	01f00793          	li	a5,31
f900256c:	55c7c663          	blt	a5,t3,f9002ab8 <__adddf3+0x5d8>
f9002570:	02000513          	li	a0,32
f9002574:	41c50533          	sub	a0,a0,t3
f9002578:	01cfd7b3          	srl	a5,t6,t3
f900257c:	00a816b3          	sll	a3,a6,a0
f9002580:	00af9933          	sll	s2,t6,a0
f9002584:	00f6e6b3          	or	a3,a3,a5
f9002588:	01203933          	snez	s2,s2
f900258c:	01c857b3          	srl	a5,a6,t3
f9002590:	0126e933          	or	s2,a3,s2
f9002594:	40f70733          	sub	a4,a4,a5
f9002598:	412f0933          	sub	s2,t5,s2
f900259c:	012f37b3          	sltu	a5,t5,s2
f90025a0:	40f70633          	sub	a2,a4,a5
f90025a4:	00861793          	slli	a5,a2,0x8
f90025a8:	2a07d263          	bgez	a5,f900284c <__adddf3+0x36c>
f90025ac:	00800737          	lui	a4,0x800
f90025b0:	fff70713          	addi	a4,a4,-1 # 7fffff <__stack_size+0x7fdfff>
f90025b4:	00e67433          	and	s0,a2,a4
f90025b8:	34040e63          	beqz	s0,f9002914 <__adddf3+0x434>
f90025bc:	00040513          	mv	a0,s0
f90025c0:	2c8020ef          	jal	ra,f9004888 <__clzsi2>
f90025c4:	ff850713          	addi	a4,a0,-8
f90025c8:	02000793          	li	a5,32
f90025cc:	40e787b3          	sub	a5,a5,a4
f90025d0:	00f957b3          	srl	a5,s2,a5
f90025d4:	00e41633          	sll	a2,s0,a4
f90025d8:	00c7e7b3          	or	a5,a5,a2
f90025dc:	00e91933          	sll	s2,s2,a4
f90025e0:	30974c63          	blt	a4,s1,f90028f8 <__adddf3+0x418>
f90025e4:	40970533          	sub	a0,a4,s1
f90025e8:	00150613          	addi	a2,a0,1
f90025ec:	01f00713          	li	a4,31
f90025f0:	44c74663          	blt	a4,a2,f9002a3c <__adddf3+0x55c>
f90025f4:	02000713          	li	a4,32
f90025f8:	40c70733          	sub	a4,a4,a2
f90025fc:	00c956b3          	srl	a3,s2,a2
f9002600:	00e91933          	sll	s2,s2,a4
f9002604:	00e79733          	sll	a4,a5,a4
f9002608:	00d76733          	or	a4,a4,a3
f900260c:	01203933          	snez	s2,s2
f9002610:	01276933          	or	s2,a4,s2
f9002614:	00c7d633          	srl	a2,a5,a2
f9002618:	00000493          	li	s1,0
f900261c:	00797793          	andi	a5,s2,7
f9002620:	02078063          	beqz	a5,f9002640 <__adddf3+0x160>
f9002624:	00f97713          	andi	a4,s2,15
f9002628:	00400793          	li	a5,4
f900262c:	00f70a63          	beq	a4,a5,f9002640 <__adddf3+0x160>
f9002630:	00490713          	addi	a4,s2,4
f9002634:	01273933          	sltu	s2,a4,s2
f9002638:	01260633          	add	a2,a2,s2
f900263c:	00070913          	mv	s2,a4
f9002640:	00861793          	slli	a5,a2,0x8
f9002644:	2007d863          	bgez	a5,f9002854 <__adddf3+0x374>
f9002648:	00148513          	addi	a0,s1,1
f900264c:	7ff00793          	li	a5,2047
f9002650:	00098593          	mv	a1,s3
f9002654:	24f50c63          	beq	a0,a5,f90028ac <__adddf3+0x3cc>
f9002658:	ff8007b7          	lui	a5,0xff800
f900265c:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0x67f67bf>
f9002660:	00f677b3          	and	a5,a2,a5
f9002664:	01d79893          	slli	a7,a5,0x1d
f9002668:	00395913          	srli	s2,s2,0x3
f900266c:	00979793          	slli	a5,a5,0x9
f9002670:	0128e8b3          	or	a7,a7,s2
f9002674:	00c7d793          	srli	a5,a5,0xc
f9002678:	7ff57513          	andi	a0,a0,2047
f900267c:	00c79693          	slli	a3,a5,0xc
f9002680:	01451513          	slli	a0,a0,0x14
f9002684:	01c12083          	lw	ra,28(sp)
f9002688:	01812403          	lw	s0,24(sp)
f900268c:	00c6d693          	srli	a3,a3,0xc
f9002690:	01f59593          	slli	a1,a1,0x1f
f9002694:	00a6e6b3          	or	a3,a3,a0
f9002698:	00b6e6b3          	or	a3,a3,a1
f900269c:	01412483          	lw	s1,20(sp)
f90026a0:	01012903          	lw	s2,16(sp)
f90026a4:	00c12983          	lw	s3,12(sp)
f90026a8:	00088513          	mv	a0,a7
f90026ac:	00068593          	mv	a1,a3
f90026b0:	02010113          	addi	sp,sp,32
f90026b4:	00008067          	ret
f90026b8:	0c0e1463          	bnez	t3,f9002780 <__adddf3+0x2a0>
f90026bc:	00148313          	addi	t1,s1,1
f90026c0:	7fe37313          	andi	t1,t1,2046
f90026c4:	28031063          	bnez	t1,f9002944 <__adddf3+0x464>
f90026c8:	01e767b3          	or	a5,a4,t5
f90026cc:	01f868b3          	or	a7,a6,t6
f90026d0:	1e049663          	bnez	s1,f90028bc <__adddf3+0x3dc>
f90026d4:	4c078063          	beqz	a5,f9002b94 <__adddf3+0x6b4>
f90026d8:	50088863          	beqz	a7,f9002be8 <__adddf3+0x708>
f90026dc:	41ff0933          	sub	s2,t5,t6
f90026e0:	410707b3          	sub	a5,a4,a6
f90026e4:	012f3633          	sltu	a2,t5,s2
f90026e8:	40c78633          	sub	a2,a5,a2
f90026ec:	00861793          	slli	a5,a2,0x8
f90026f0:	5a07d463          	bgez	a5,f9002c98 <__adddf3+0x7b8>
f90026f4:	41ef8933          	sub	s2,t6,t5
f90026f8:	40e807b3          	sub	a5,a6,a4
f90026fc:	012fb633          	sltu	a2,t6,s2
f9002700:	40c78633          	sub	a2,a5,a2
f9002704:	000e8993          	mv	s3,t4
f9002708:	f15ff06f          	j	f900261c <__adddf3+0x13c>
f900270c:	0fc05a63          	blez	t3,f9002800 <__adddf3+0x320>
f9002710:	0c030863          	beqz	t1,f90027e0 <__adddf3+0x300>
f9002714:	008006b7          	lui	a3,0x800
f9002718:	7ff00793          	li	a5,2047
f900271c:	00d86833          	or	a6,a6,a3
f9002720:	44f48e63          	beq	s1,a5,f9002b7c <__adddf3+0x69c>
f9002724:	03800793          	li	a5,56
f9002728:	15c7cc63          	blt	a5,t3,f9002880 <__adddf3+0x3a0>
f900272c:	01f00793          	li	a5,31
f9002730:	3fc7da63          	bge	a5,t3,f9002b24 <__adddf3+0x644>
f9002734:	fe0e0913          	addi	s2,t3,-32
f9002738:	02000793          	li	a5,32
f900273c:	012856b3          	srl	a3,a6,s2
f9002740:	00fe0a63          	beq	t3,a5,f9002754 <__adddf3+0x274>
f9002744:	04000913          	li	s2,64
f9002748:	41c90933          	sub	s2,s2,t3
f900274c:	01281933          	sll	s2,a6,s2
f9002750:	012fefb3          	or	t6,t6,s2
f9002754:	01f03933          	snez	s2,t6
f9002758:	00d96933          	or	s2,s2,a3
f900275c:	12c0006f          	j	f9002888 <__adddf3+0x3a8>
f9002760:	01f867b3          	or	a5,a6,t6
f9002764:	22078663          	beqz	a5,f9002990 <__adddf3+0x4b0>
f9002768:	fffe0793          	addi	a5,t3,-1
f900276c:	44078463          	beqz	a5,f9002bb4 <__adddf3+0x6d4>
f9002770:	7ff00693          	li	a3,2047
f9002774:	20de0263          	beq	t3,a3,f9002978 <__adddf3+0x498>
f9002778:	00078e13          	mv	t3,a5
f900277c:	de5ff06f          	j	f9002560 <__adddf3+0x80>
f9002780:	409305b3          	sub	a1,t1,s1
f9002784:	28049663          	bnez	s1,f9002a10 <__adddf3+0x530>
f9002788:	01e767b3          	or	a5,a4,t5
f900278c:	3c078263          	beqz	a5,f9002b50 <__adddf3+0x670>
f9002790:	fff58793          	addi	a5,a1,-1
f9002794:	50078c63          	beqz	a5,f9002cac <__adddf3+0x7cc>
f9002798:	7ff00693          	li	a3,2047
f900279c:	28d58263          	beq	a1,a3,f9002a20 <__adddf3+0x540>
f90027a0:	00078593          	mv	a1,a5
f90027a4:	03800793          	li	a5,56
f90027a8:	32b7ce63          	blt	a5,a1,f9002ae4 <__adddf3+0x604>
f90027ac:	01f00793          	li	a5,31
f90027b0:	4ab7c263          	blt	a5,a1,f9002c54 <__adddf3+0x774>
f90027b4:	02000793          	li	a5,32
f90027b8:	40b787b3          	sub	a5,a5,a1
f90027bc:	00f71933          	sll	s2,a4,a5
f90027c0:	00bf56b3          	srl	a3,t5,a1
f90027c4:	00ff17b3          	sll	a5,t5,a5
f90027c8:	00d96933          	or	s2,s2,a3
f90027cc:	00f037b3          	snez	a5,a5
f90027d0:	00b75733          	srl	a4,a4,a1
f90027d4:	00f96933          	or	s2,s2,a5
f90027d8:	40e80833          	sub	a6,a6,a4
f90027dc:	3100006f          	j	f9002aec <__adddf3+0x60c>
f90027e0:	01f867b3          	or	a5,a6,t6
f90027e4:	3e078463          	beqz	a5,f9002bcc <__adddf3+0x6ec>
f90027e8:	fffe0793          	addi	a5,t3,-1
f90027ec:	28078263          	beqz	a5,f9002a70 <__adddf3+0x590>
f90027f0:	7ff00693          	li	a3,2047
f90027f4:	38de0463          	beq	t3,a3,f9002b7c <__adddf3+0x69c>
f90027f8:	00078e13          	mv	t3,a5
f90027fc:	f29ff06f          	j	f9002724 <__adddf3+0x244>
f9002800:	1a0e1663          	bnez	t3,f90029ac <__adddf3+0x4cc>
f9002804:	00148693          	addi	a3,s1,1
f9002808:	7fe6f793          	andi	a5,a3,2046
f900280c:	3e079a63          	bnez	a5,f9002c00 <__adddf3+0x720>
f9002810:	01e767b3          	or	a5,a4,t5
f9002814:	34049e63          	bnez	s1,f9002b70 <__adddf3+0x690>
f9002818:	4a078863          	beqz	a5,f9002cc8 <__adddf3+0x7e8>
f900281c:	01f867b3          	or	a5,a6,t6
f9002820:	3c078463          	beqz	a5,f9002be8 <__adddf3+0x708>
f9002824:	01ff0933          	add	s2,t5,t6
f9002828:	010707b3          	add	a5,a4,a6
f900282c:	01e93f33          	sltu	t5,s2,t5
f9002830:	01e78633          	add	a2,a5,t5
f9002834:	00861793          	slli	a5,a2,0x8
f9002838:	0007da63          	bgez	a5,f900284c <__adddf3+0x36c>
f900283c:	ff8007b7          	lui	a5,0xff800
f9002840:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0x67f67bf>
f9002844:	00f67633          	and	a2,a2,a5
f9002848:	00100493          	li	s1,1
f900284c:	00797793          	andi	a5,s2,7
f9002850:	dc079ae3          	bnez	a5,f9002624 <__adddf3+0x144>
f9002854:	01d61793          	slli	a5,a2,0x1d
f9002858:	00395893          	srli	a7,s2,0x3
f900285c:	00f8e8b3          	or	a7,a7,a5
f9002860:	00365793          	srli	a5,a2,0x3
f9002864:	7ff00713          	li	a4,2047
f9002868:	06e48a63          	beq	s1,a4,f90028dc <__adddf3+0x3fc>
f900286c:	00c79793          	slli	a5,a5,0xc
f9002870:	00c7d793          	srli	a5,a5,0xc
f9002874:	7ff4f513          	andi	a0,s1,2047
f9002878:	00098593          	mv	a1,s3
f900287c:	e01ff06f          	j	f900267c <__adddf3+0x19c>
f9002880:	01f86933          	or	s2,a6,t6
f9002884:	01203933          	snez	s2,s2
f9002888:	01e90933          	add	s2,s2,t5
f900288c:	01e937b3          	sltu	a5,s2,t5
f9002890:	00e78633          	add	a2,a5,a4
f9002894:	00861793          	slli	a5,a2,0x8
f9002898:	fa07dae3          	bgez	a5,f900284c <__adddf3+0x36c>
f900289c:	00148493          	addi	s1,s1,1
f90028a0:	7ff00793          	li	a5,2047
f90028a4:	1ef49663          	bne	s1,a5,f9002a90 <__adddf3+0x5b0>
f90028a8:	00098593          	mv	a1,s3
f90028ac:	7ff00513          	li	a0,2047
f90028b0:	00000793          	li	a5,0
f90028b4:	00000893          	li	a7,0
f90028b8:	dc5ff06f          	j	f900267c <__adddf3+0x19c>
f90028bc:	0a079c63          	bnez	a5,f9002974 <__adddf3+0x494>
f90028c0:	46088463          	beqz	a7,f9002d28 <__adddf3+0x848>
f90028c4:	00361693          	slli	a3,a2,0x3
f90028c8:	01d81793          	slli	a5,a6,0x1d
f90028cc:	0036d693          	srli	a3,a3,0x3
f90028d0:	00d7e8b3          	or	a7,a5,a3
f90028d4:	000e8993          	mv	s3,t4
f90028d8:	00385793          	srli	a5,a6,0x3
f90028dc:	00f8e7b3          	or	a5,a7,a5
f90028e0:	fc0784e3          	beqz	a5,f90028a8 <__adddf3+0x3c8>
f90028e4:	00000593          	li	a1,0
f90028e8:	7ff00513          	li	a0,2047
f90028ec:	000807b7          	lui	a5,0x80
f90028f0:	00000893          	li	a7,0
f90028f4:	d89ff06f          	j	f900267c <__adddf3+0x19c>
f90028f8:	ff800637          	lui	a2,0xff800
f90028fc:	fff60613          	addi	a2,a2,-1 # ff7fffff <__freertos_irq_stack_top+0x67f67bf>
f9002900:	00c7f633          	and	a2,a5,a2
f9002904:	00797793          	andi	a5,s2,7
f9002908:	40e484b3          	sub	s1,s1,a4
f900290c:	d0079ce3          	bnez	a5,f9002624 <__adddf3+0x144>
f9002910:	f45ff06f          	j	f9002854 <__adddf3+0x374>
f9002914:	00090513          	mv	a0,s2
f9002918:	771010ef          	jal	ra,f9004888 <__clzsi2>
f900291c:	01850713          	addi	a4,a0,24
f9002920:	01f00793          	li	a5,31
f9002924:	cae7d2e3          	bge	a5,a4,f90025c8 <__adddf3+0xe8>
f9002928:	ff850613          	addi	a2,a0,-8
f900292c:	00c917b3          	sll	a5,s2,a2
f9002930:	00000913          	li	s2,0
f9002934:	cadff06f          	j	f90025e0 <__adddf3+0x100>
f9002938:	01f86933          	or	s2,a6,t6
f900293c:	01203933          	snez	s2,s2
f9002940:	c59ff06f          	j	f9002598 <__adddf3+0xb8>
f9002944:	41ff0933          	sub	s2,t5,t6
f9002948:	41070633          	sub	a2,a4,a6
f900294c:	012f3433          	sltu	s0,t5,s2
f9002950:	40860433          	sub	s0,a2,s0
f9002954:	00841793          	slli	a5,s0,0x8
f9002958:	2c07cc63          	bltz	a5,f9002c30 <__adddf3+0x750>
f900295c:	008968b3          	or	a7,s2,s0
f9002960:	c4089ce3          	bnez	a7,f90025b8 <__adddf3+0xd8>
f9002964:	00000793          	li	a5,0
f9002968:	00000993          	li	s3,0
f900296c:	00000493          	li	s1,0
f9002970:	efdff06f          	j	f900286c <__adddf3+0x38c>
f9002974:	f60898e3          	bnez	a7,f90028e4 <__adddf3+0x404>
f9002978:	00351513          	slli	a0,a0,0x3
f900297c:	01d71793          	slli	a5,a4,0x1d
f9002980:	00355513          	srli	a0,a0,0x3
f9002984:	00a7e8b3          	or	a7,a5,a0
f9002988:	00375793          	srli	a5,a4,0x3
f900298c:	f51ff06f          	j	f90028dc <__adddf3+0x3fc>
f9002990:	00351513          	slli	a0,a0,0x3
f9002994:	01d71793          	slli	a5,a4,0x1d
f9002998:	00355513          	srli	a0,a0,0x3
f900299c:	00a7e8b3          	or	a7,a5,a0
f90029a0:	000e0493          	mv	s1,t3
f90029a4:	00375793          	srli	a5,a4,0x3
f90029a8:	ebdff06f          	j	f9002864 <__adddf3+0x384>
f90029ac:	40930533          	sub	a0,t1,s1
f90029b0:	14048a63          	beqz	s1,f9002b04 <__adddf3+0x624>
f90029b4:	008006b7          	lui	a3,0x800
f90029b8:	7ff00793          	li	a5,2047
f90029bc:	00d76733          	or	a4,a4,a3
f90029c0:	38f30663          	beq	t1,a5,f9002d4c <__adddf3+0x86c>
f90029c4:	03800793          	li	a5,56
f90029c8:	28a7c063          	blt	a5,a0,f9002c48 <__adddf3+0x768>
f90029cc:	01f00793          	li	a5,31
f90029d0:	32a7c663          	blt	a5,a0,f9002cfc <__adddf3+0x81c>
f90029d4:	02000793          	li	a5,32
f90029d8:	40a787b3          	sub	a5,a5,a0
f90029dc:	00f71933          	sll	s2,a4,a5
f90029e0:	00af56b3          	srl	a3,t5,a0
f90029e4:	00ff17b3          	sll	a5,t5,a5
f90029e8:	00d96933          	or	s2,s2,a3
f90029ec:	00f037b3          	snez	a5,a5
f90029f0:	00a75733          	srl	a4,a4,a0
f90029f4:	00f96933          	or	s2,s2,a5
f90029f8:	00e80833          	add	a6,a6,a4
f90029fc:	01f90933          	add	s2,s2,t6
f9002a00:	01f937b3          	sltu	a5,s2,t6
f9002a04:	01078633          	add	a2,a5,a6
f9002a08:	00030493          	mv	s1,t1
f9002a0c:	e89ff06f          	j	f9002894 <__adddf3+0x3b4>
f9002a10:	008006b7          	lui	a3,0x800
f9002a14:	7ff00793          	li	a5,2047
f9002a18:	00d76733          	or	a4,a4,a3
f9002a1c:	d8f314e3          	bne	t1,a5,f90027a4 <__adddf3+0x2c4>
f9002a20:	00361793          	slli	a5,a2,0x3
f9002a24:	0037d793          	srli	a5,a5,0x3
f9002a28:	01d81893          	slli	a7,a6,0x1d
f9002a2c:	0117e8b3          	or	a7,a5,a7
f9002a30:	000e8993          	mv	s3,t4
f9002a34:	00385793          	srli	a5,a6,0x3
f9002a38:	ea5ff06f          	j	f90028dc <__adddf3+0x3fc>
f9002a3c:	fe150713          	addi	a4,a0,-31
f9002a40:	02000693          	li	a3,32
f9002a44:	00e7d733          	srl	a4,a5,a4
f9002a48:	00d60a63          	beq	a2,a3,f9002a5c <__adddf3+0x57c>
f9002a4c:	04000693          	li	a3,64
f9002a50:	40c68633          	sub	a2,a3,a2
f9002a54:	00c79633          	sll	a2,a5,a2
f9002a58:	00c96933          	or	s2,s2,a2
f9002a5c:	01203933          	snez	s2,s2
f9002a60:	00e96933          	or	s2,s2,a4
f9002a64:	00000613          	li	a2,0
f9002a68:	00000493          	li	s1,0
f9002a6c:	de1ff06f          	j	f900284c <__adddf3+0x36c>
f9002a70:	01ff0933          	add	s2,t5,t6
f9002a74:	010707b3          	add	a5,a4,a6
f9002a78:	01e93633          	sltu	a2,s2,t5
f9002a7c:	00c78633          	add	a2,a5,a2
f9002a80:	00861793          	slli	a5,a2,0x8
f9002a84:	00100493          	li	s1,1
f9002a88:	dc07d2e3          	bgez	a5,f900284c <__adddf3+0x36c>
f9002a8c:	00200493          	li	s1,2
f9002a90:	ff8007b7          	lui	a5,0xff800
f9002a94:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0x67f67bf>
f9002a98:	00f677b3          	and	a5,a2,a5
f9002a9c:	00195713          	srli	a4,s2,0x1
f9002aa0:	00197913          	andi	s2,s2,1
f9002aa4:	01276933          	or	s2,a4,s2
f9002aa8:	01f79893          	slli	a7,a5,0x1f
f9002aac:	0128e933          	or	s2,a7,s2
f9002ab0:	0017d613          	srli	a2,a5,0x1
f9002ab4:	b69ff06f          	j	f900261c <__adddf3+0x13c>
f9002ab8:	fe0e0913          	addi	s2,t3,-32
f9002abc:	02000793          	li	a5,32
f9002ac0:	012856b3          	srl	a3,a6,s2
f9002ac4:	00fe0a63          	beq	t3,a5,f9002ad8 <__adddf3+0x5f8>
f9002ac8:	04000913          	li	s2,64
f9002acc:	41c90933          	sub	s2,s2,t3
f9002ad0:	01281933          	sll	s2,a6,s2
f9002ad4:	012fefb3          	or	t6,t6,s2
f9002ad8:	01f03933          	snez	s2,t6
f9002adc:	00d96933          	or	s2,s2,a3
f9002ae0:	ab9ff06f          	j	f9002598 <__adddf3+0xb8>
f9002ae4:	01e76933          	or	s2,a4,t5
f9002ae8:	01203933          	snez	s2,s2
f9002aec:	412f8933          	sub	s2,t6,s2
f9002af0:	012fb7b3          	sltu	a5,t6,s2
f9002af4:	40f80633          	sub	a2,a6,a5
f9002af8:	00030493          	mv	s1,t1
f9002afc:	000e8993          	mv	s3,t4
f9002b00:	aa5ff06f          	j	f90025a4 <__adddf3+0xc4>
f9002b04:	01e767b3          	or	a5,a4,t5
f9002b08:	1c078c63          	beqz	a5,f9002ce0 <__adddf3+0x800>
f9002b0c:	fff50793          	addi	a5,a0,-1
f9002b10:	22078463          	beqz	a5,f9002d38 <__adddf3+0x858>
f9002b14:	7ff00693          	li	a3,2047
f9002b18:	16d50463          	beq	a0,a3,f9002c80 <__adddf3+0x7a0>
f9002b1c:	00078513          	mv	a0,a5
f9002b20:	ea5ff06f          	j	f90029c4 <__adddf3+0x4e4>
f9002b24:	02000793          	li	a5,32
f9002b28:	41c787b3          	sub	a5,a5,t3
f9002b2c:	00f816b3          	sll	a3,a6,a5
f9002b30:	00ff9933          	sll	s2,t6,a5
f9002b34:	01cfd633          	srl	a2,t6,t3
f9002b38:	00c6e6b3          	or	a3,a3,a2
f9002b3c:	01203933          	snez	s2,s2
f9002b40:	01c857b3          	srl	a5,a6,t3
f9002b44:	0126e933          	or	s2,a3,s2
f9002b48:	00f70733          	add	a4,a4,a5
f9002b4c:	d3dff06f          	j	f9002888 <__adddf3+0x3a8>
f9002b50:	00361793          	slli	a5,a2,0x3
f9002b54:	0037d793          	srli	a5,a5,0x3
f9002b58:	01d81893          	slli	a7,a6,0x1d
f9002b5c:	0117e8b3          	or	a7,a5,a7
f9002b60:	00058493          	mv	s1,a1
f9002b64:	00385793          	srli	a5,a6,0x3
f9002b68:	000e8993          	mv	s3,t4
f9002b6c:	cf9ff06f          	j	f9002864 <__adddf3+0x384>
f9002b70:	10078863          	beqz	a5,f9002c80 <__adddf3+0x7a0>
f9002b74:	01f86933          	or	s2,a6,t6
f9002b78:	d60916e3          	bnez	s2,f90028e4 <__adddf3+0x404>
f9002b7c:	00351513          	slli	a0,a0,0x3
f9002b80:	01d71793          	slli	a5,a4,0x1d
f9002b84:	00355513          	srli	a0,a0,0x3
f9002b88:	00f568b3          	or	a7,a0,a5
f9002b8c:	00375793          	srli	a5,a4,0x3
f9002b90:	d4dff06f          	j	f90028dc <__adddf3+0x3fc>
f9002b94:	10088663          	beqz	a7,f9002ca0 <__adddf3+0x7c0>
f9002b98:	00361693          	slli	a3,a2,0x3
f9002b9c:	01d81793          	slli	a5,a6,0x1d
f9002ba0:	0036d693          	srli	a3,a3,0x3
f9002ba4:	00d7e8b3          	or	a7,a5,a3
f9002ba8:	000e8993          	mv	s3,t4
f9002bac:	00385793          	srli	a5,a6,0x3
f9002bb0:	cbdff06f          	j	f900286c <__adddf3+0x38c>
f9002bb4:	41ff0933          	sub	s2,t5,t6
f9002bb8:	410707b3          	sub	a5,a4,a6
f9002bbc:	012f3f33          	sltu	t5,t5,s2
f9002bc0:	41e78633          	sub	a2,a5,t5
f9002bc4:	00100493          	li	s1,1
f9002bc8:	9ddff06f          	j	f90025a4 <__adddf3+0xc4>
f9002bcc:	00351513          	slli	a0,a0,0x3
f9002bd0:	01d71793          	slli	a5,a4,0x1d
f9002bd4:	00355513          	srli	a0,a0,0x3
f9002bd8:	00f568b3          	or	a7,a0,a5
f9002bdc:	000e0493          	mv	s1,t3
f9002be0:	00375793          	srli	a5,a4,0x3
f9002be4:	c81ff06f          	j	f9002864 <__adddf3+0x384>
f9002be8:	00351513          	slli	a0,a0,0x3
f9002bec:	01d71793          	slli	a5,a4,0x1d
f9002bf0:	00355513          	srli	a0,a0,0x3
f9002bf4:	00a7e8b3          	or	a7,a5,a0
f9002bf8:	00375793          	srli	a5,a4,0x3
f9002bfc:	c71ff06f          	j	f900286c <__adddf3+0x38c>
f9002c00:	7ff00793          	li	a5,2047
f9002c04:	caf682e3          	beq	a3,a5,f90028a8 <__adddf3+0x3c8>
f9002c08:	01ff0933          	add	s2,t5,t6
f9002c0c:	01e93633          	sltu	a2,s2,t5
f9002c10:	010707b3          	add	a5,a4,a6
f9002c14:	00c787b3          	add	a5,a5,a2
f9002c18:	01f79893          	slli	a7,a5,0x1f
f9002c1c:	00195913          	srli	s2,s2,0x1
f9002c20:	0128e933          	or	s2,a7,s2
f9002c24:	0017d613          	srli	a2,a5,0x1
f9002c28:	00068493          	mv	s1,a3
f9002c2c:	c21ff06f          	j	f900284c <__adddf3+0x36c>
f9002c30:	41ef8933          	sub	s2,t6,t5
f9002c34:	40e80733          	sub	a4,a6,a4
f9002c38:	012fb633          	sltu	a2,t6,s2
f9002c3c:	40c70433          	sub	s0,a4,a2
f9002c40:	000e8993          	mv	s3,t4
f9002c44:	975ff06f          	j	f90025b8 <__adddf3+0xd8>
f9002c48:	01e76933          	or	s2,a4,t5
f9002c4c:	01203933          	snez	s2,s2
f9002c50:	dadff06f          	j	f90029fc <__adddf3+0x51c>
f9002c54:	fe058793          	addi	a5,a1,-32
f9002c58:	02000693          	li	a3,32
f9002c5c:	00f757b3          	srl	a5,a4,a5
f9002c60:	00d58a63          	beq	a1,a3,f9002c74 <__adddf3+0x794>
f9002c64:	04000693          	li	a3,64
f9002c68:	40b685b3          	sub	a1,a3,a1
f9002c6c:	00b71733          	sll	a4,a4,a1
f9002c70:	00ef6f33          	or	t5,t5,a4
f9002c74:	01e03933          	snez	s2,t5
f9002c78:	00f96933          	or	s2,s2,a5
f9002c7c:	e71ff06f          	j	f9002aec <__adddf3+0x60c>
f9002c80:	00361793          	slli	a5,a2,0x3
f9002c84:	0037d793          	srli	a5,a5,0x3
f9002c88:	01d81893          	slli	a7,a6,0x1d
f9002c8c:	0117e8b3          	or	a7,a5,a7
f9002c90:	00385793          	srli	a5,a6,0x3
f9002c94:	c49ff06f          	j	f90028dc <__adddf3+0x3fc>
f9002c98:	00c968b3          	or	a7,s2,a2
f9002c9c:	ba0898e3          	bnez	a7,f900284c <__adddf3+0x36c>
f9002ca0:	00000793          	li	a5,0
f9002ca4:	00000993          	li	s3,0
f9002ca8:	bc5ff06f          	j	f900286c <__adddf3+0x38c>
f9002cac:	41ef8933          	sub	s2,t6,t5
f9002cb0:	40e807b3          	sub	a5,a6,a4
f9002cb4:	012fb633          	sltu	a2,t6,s2
f9002cb8:	40c78633          	sub	a2,a5,a2
f9002cbc:	000e8993          	mv	s3,t4
f9002cc0:	00100493          	li	s1,1
f9002cc4:	8e1ff06f          	j	f90025a4 <__adddf3+0xc4>
f9002cc8:	00361693          	slli	a3,a2,0x3
f9002ccc:	01d81793          	slli	a5,a6,0x1d
f9002cd0:	0036d693          	srli	a3,a3,0x3
f9002cd4:	00d7e8b3          	or	a7,a5,a3
f9002cd8:	00385793          	srli	a5,a6,0x3
f9002cdc:	b91ff06f          	j	f900286c <__adddf3+0x38c>
f9002ce0:	00361693          	slli	a3,a2,0x3
f9002ce4:	01d81793          	slli	a5,a6,0x1d
f9002ce8:	0036d693          	srli	a3,a3,0x3
f9002cec:	00d7e8b3          	or	a7,a5,a3
f9002cf0:	00050493          	mv	s1,a0
f9002cf4:	00385793          	srli	a5,a6,0x3
f9002cf8:	b6dff06f          	j	f9002864 <__adddf3+0x384>
f9002cfc:	fe050793          	addi	a5,a0,-32
f9002d00:	02000693          	li	a3,32
f9002d04:	00f757b3          	srl	a5,a4,a5
f9002d08:	00d50a63          	beq	a0,a3,f9002d1c <__adddf3+0x83c>
f9002d0c:	04000693          	li	a3,64
f9002d10:	40a68533          	sub	a0,a3,a0
f9002d14:	00a71733          	sll	a4,a4,a0
f9002d18:	00ef6f33          	or	t5,t5,a4
f9002d1c:	01e03933          	snez	s2,t5
f9002d20:	00f96933          	or	s2,s2,a5
f9002d24:	cd9ff06f          	j	f90029fc <__adddf3+0x51c>
f9002d28:	00000593          	li	a1,0
f9002d2c:	7ff00513          	li	a0,2047
f9002d30:	000807b7          	lui	a5,0x80
f9002d34:	949ff06f          	j	f900267c <__adddf3+0x19c>
f9002d38:	01ff0933          	add	s2,t5,t6
f9002d3c:	010707b3          	add	a5,a4,a6
f9002d40:	01f93633          	sltu	a2,s2,t6
f9002d44:	00c78633          	add	a2,a5,a2
f9002d48:	d39ff06f          	j	f9002a80 <__adddf3+0x5a0>
f9002d4c:	00361693          	slli	a3,a2,0x3
f9002d50:	01d81793          	slli	a5,a6,0x1d
f9002d54:	0036d693          	srli	a3,a3,0x3
f9002d58:	00d7e8b3          	or	a7,a5,a3
f9002d5c:	00385793          	srli	a5,a6,0x3
f9002d60:	b7dff06f          	j	f90028dc <__adddf3+0x3fc>

f9002d64 <__divdf3>:
f9002d64:	fc010113          	addi	sp,sp,-64
f9002d68:	0145d793          	srli	a5,a1,0x14
f9002d6c:	02812c23          	sw	s0,56(sp)
f9002d70:	02912a23          	sw	s1,52(sp)
f9002d74:	03312623          	sw	s3,44(sp)
f9002d78:	00050493          	mv	s1,a0
f9002d7c:	00c59413          	slli	s0,a1,0xc
f9002d80:	02112e23          	sw	ra,60(sp)
f9002d84:	03212823          	sw	s2,48(sp)
f9002d88:	03412423          	sw	s4,40(sp)
f9002d8c:	03512223          	sw	s5,36(sp)
f9002d90:	03612023          	sw	s6,32(sp)
f9002d94:	01712e23          	sw	s7,28(sp)
f9002d98:	7ff7f513          	andi	a0,a5,2047
f9002d9c:	00c45413          	srli	s0,s0,0xc
f9002da0:	01f5d993          	srli	s3,a1,0x1f
f9002da4:	16050863          	beqz	a0,f9002f14 <__divdf3+0x1b0>
f9002da8:	7ff00793          	li	a5,2047
f9002dac:	1cf50263          	beq	a0,a5,f9002f70 <__divdf3+0x20c>
f9002db0:	01d4da93          	srli	s5,s1,0x1d
f9002db4:	00341413          	slli	s0,s0,0x3
f9002db8:	008ae433          	or	s0,s5,s0
f9002dbc:	00800ab7          	lui	s5,0x800
f9002dc0:	00349b13          	slli	s6,s1,0x3
f9002dc4:	01546ab3          	or	s5,s0,s5
f9002dc8:	c0150913          	addi	s2,a0,-1023
f9002dcc:	00000493          	li	s1,0
f9002dd0:	00000b93          	li	s7,0
f9002dd4:	0146d713          	srli	a4,a3,0x14
f9002dd8:	00c69413          	slli	s0,a3,0xc
f9002ddc:	7ff77713          	andi	a4,a4,2047
f9002de0:	00c45413          	srli	s0,s0,0xc
f9002de4:	01f6da13          	srli	s4,a3,0x1f
f9002de8:	0e070063          	beqz	a4,f9002ec8 <__divdf3+0x164>
f9002dec:	7ff00793          	li	a5,2047
f9002df0:	04f70863          	beq	a4,a5,f9002e40 <__divdf3+0xdc>
f9002df4:	00341793          	slli	a5,s0,0x3
f9002df8:	01d65413          	srli	s0,a2,0x1d
f9002dfc:	00f467b3          	or	a5,s0,a5
f9002e00:	c0170713          	addi	a4,a4,-1023
f9002e04:	00800437          	lui	s0,0x800
f9002e08:	0087e433          	or	s0,a5,s0
f9002e0c:	00361813          	slli	a6,a2,0x3
f9002e10:	40e90933          	sub	s2,s2,a4
f9002e14:	00000693          	li	a3,0
f9002e18:	00f00793          	li	a5,15
f9002e1c:	0149c5b3          	xor	a1,s3,s4
f9002e20:	2497ec63          	bltu	a5,s1,f9003078 <__divdf3+0x314>
f9002e24:	00004717          	auipc	a4,0x4
f9002e28:	7d470713          	addi	a4,a4,2004 # f90075f8 <gImage_hit_logo+0x2a30>
f9002e2c:	00249493          	slli	s1,s1,0x2
f9002e30:	00e484b3          	add	s1,s1,a4
f9002e34:	0004a783          	lw	a5,0(s1)
f9002e38:	00e787b3          	add	a5,a5,a4
f9002e3c:	00078067          	jr	a5 # 80000 <__stack_size+0x7e000>
f9002e40:	00c46833          	or	a6,s0,a2
f9002e44:	80190913          	addi	s2,s2,-2047
f9002e48:	18081063          	bnez	a6,f9002fc8 <__divdf3+0x264>
f9002e4c:	0024e493          	ori	s1,s1,2
f9002e50:	00000413          	li	s0,0
f9002e54:	00200693          	li	a3,2
f9002e58:	fc1ff06f          	j	f9002e18 <__divdf3+0xb4>
f9002e5c:	7ff00713          	li	a4,2047
f9002e60:	00000793          	li	a5,0
f9002e64:	00000413          	li	s0,0
f9002e68:	00c79793          	slli	a5,a5,0xc
f9002e6c:	00040513          	mv	a0,s0
f9002e70:	03c12083          	lw	ra,60(sp)
f9002e74:	03812403          	lw	s0,56(sp)
f9002e78:	01471713          	slli	a4,a4,0x14
f9002e7c:	00c7d793          	srli	a5,a5,0xc
f9002e80:	01f59593          	slli	a1,a1,0x1f
f9002e84:	00e7e7b3          	or	a5,a5,a4
f9002e88:	00b7e7b3          	or	a5,a5,a1
f9002e8c:	03412483          	lw	s1,52(sp)
f9002e90:	03012903          	lw	s2,48(sp)
f9002e94:	02c12983          	lw	s3,44(sp)
f9002e98:	02812a03          	lw	s4,40(sp)
f9002e9c:	02412a83          	lw	s5,36(sp)
f9002ea0:	02012b03          	lw	s6,32(sp)
f9002ea4:	01c12b83          	lw	s7,28(sp)
f9002ea8:	00078593          	mv	a1,a5
f9002eac:	04010113          	addi	sp,sp,64
f9002eb0:	00008067          	ret
f9002eb4:	00000593          	li	a1,0
f9002eb8:	7ff00713          	li	a4,2047
f9002ebc:	000807b7          	lui	a5,0x80
f9002ec0:	00000413          	li	s0,0
f9002ec4:	fa5ff06f          	j	f9002e68 <__divdf3+0x104>
f9002ec8:	00c46833          	or	a6,s0,a2
f9002ecc:	0e080663          	beqz	a6,f9002fb8 <__divdf3+0x254>
f9002ed0:	3e040a63          	beqz	s0,f90032c4 <__divdf3+0x560>
f9002ed4:	00040513          	mv	a0,s0
f9002ed8:	00c12423          	sw	a2,8(sp)
f9002edc:	1ad010ef          	jal	ra,f9004888 <__clzsi2>
f9002ee0:	00812603          	lw	a2,8(sp)
f9002ee4:	ff550593          	addi	a1,a0,-11
f9002ee8:	01d00693          	li	a3,29
f9002eec:	ff850713          	addi	a4,a0,-8
f9002ef0:	40b686b3          	sub	a3,a3,a1
f9002ef4:	00e417b3          	sll	a5,s0,a4
f9002ef8:	00d656b3          	srl	a3,a2,a3
f9002efc:	00f6e433          	or	s0,a3,a5
f9002f00:	00e61833          	sll	a6,a2,a4
f9002f04:	01250533          	add	a0,a0,s2
f9002f08:	3f350913          	addi	s2,a0,1011
f9002f0c:	00000693          	li	a3,0
f9002f10:	f09ff06f          	j	f9002e18 <__divdf3+0xb4>
f9002f14:	00946ab3          	or	s5,s0,s1
f9002f18:	080a8663          	beqz	s5,f9002fa4 <__divdf3+0x240>
f9002f1c:	00d12623          	sw	a3,12(sp)
f9002f20:	00c12423          	sw	a2,8(sp)
f9002f24:	36040863          	beqz	s0,f9003294 <__divdf3+0x530>
f9002f28:	00040513          	mv	a0,s0
f9002f2c:	15d010ef          	jal	ra,f9004888 <__clzsi2>
f9002f30:	00812603          	lw	a2,8(sp)
f9002f34:	00c12683          	lw	a3,12(sp)
f9002f38:	00050913          	mv	s2,a0
f9002f3c:	ff550713          	addi	a4,a0,-11
f9002f40:	01d00a93          	li	s5,29
f9002f44:	ff890b13          	addi	s6,s2,-8
f9002f48:	40ea8ab3          	sub	s5,s5,a4
f9002f4c:	01641433          	sll	s0,s0,s6
f9002f50:	0154dab3          	srl	s5,s1,s5
f9002f54:	008aeab3          	or	s5,s5,s0
f9002f58:	01649b33          	sll	s6,s1,s6
f9002f5c:	c0d00513          	li	a0,-1011
f9002f60:	41250933          	sub	s2,a0,s2
f9002f64:	00000493          	li	s1,0
f9002f68:	00000b93          	li	s7,0
f9002f6c:	e69ff06f          	j	f9002dd4 <__divdf3+0x70>
f9002f70:	00946ab3          	or	s5,s0,s1
f9002f74:	000a9c63          	bnez	s5,f9002f8c <__divdf3+0x228>
f9002f78:	00000b13          	li	s6,0
f9002f7c:	00800493          	li	s1,8
f9002f80:	7ff00913          	li	s2,2047
f9002f84:	00200b93          	li	s7,2
f9002f88:	e4dff06f          	j	f9002dd4 <__divdf3+0x70>
f9002f8c:	00048b13          	mv	s6,s1
f9002f90:	00040a93          	mv	s5,s0
f9002f94:	00c00493          	li	s1,12
f9002f98:	7ff00913          	li	s2,2047
f9002f9c:	00300b93          	li	s7,3
f9002fa0:	e35ff06f          	j	f9002dd4 <__divdf3+0x70>
f9002fa4:	00000b13          	li	s6,0
f9002fa8:	00400493          	li	s1,4
f9002fac:	00000913          	li	s2,0
f9002fb0:	00100b93          	li	s7,1
f9002fb4:	e21ff06f          	j	f9002dd4 <__divdf3+0x70>
f9002fb8:	0014e493          	ori	s1,s1,1
f9002fbc:	00000413          	li	s0,0
f9002fc0:	00100693          	li	a3,1
f9002fc4:	e55ff06f          	j	f9002e18 <__divdf3+0xb4>
f9002fc8:	0034e493          	ori	s1,s1,3
f9002fcc:	00060813          	mv	a6,a2
f9002fd0:	00300693          	li	a3,3
f9002fd4:	e45ff06f          	j	f9002e18 <__divdf3+0xb4>
f9002fd8:	3c070063          	beqz	a4,f9003398 <__divdf3+0x634>
f9002fdc:	00100793          	li	a5,1
f9002fe0:	40e787b3          	sub	a5,a5,a4
f9002fe4:	03800693          	li	a3,56
f9002fe8:	42f6d063          	bge	a3,a5,f9003408 <__divdf3+0x6a4>
f9002fec:	00000713          	li	a4,0
f9002ff0:	00000793          	li	a5,0
f9002ff4:	00000413          	li	s0,0
f9002ff8:	e71ff06f          	j	f9002e68 <__divdf3+0x104>
f9002ffc:	000a0593          	mv	a1,s4
f9003000:	00200793          	li	a5,2
f9003004:	e4f68ce3          	beq	a3,a5,f9002e5c <__divdf3+0xf8>
f9003008:	00300793          	li	a5,3
f900300c:	eaf684e3          	beq	a3,a5,f9002eb4 <__divdf3+0x150>
f9003010:	00100793          	li	a5,1
f9003014:	fcf68ce3          	beq	a3,a5,f9002fec <__divdf3+0x288>
f9003018:	3ff90713          	addi	a4,s2,1023
f900301c:	fae05ee3          	blez	a4,f9002fd8 <__divdf3+0x274>
f9003020:	00787793          	andi	a5,a6,7
f9003024:	32079c63          	bnez	a5,f900335c <__divdf3+0x5f8>
f9003028:	00385813          	srli	a6,a6,0x3
f900302c:	00741793          	slli	a5,s0,0x7
f9003030:	0007da63          	bgez	a5,f9003044 <__divdf3+0x2e0>
f9003034:	ff0007b7          	lui	a5,0xff000
f9003038:	fff78793          	addi	a5,a5,-1 # feffffff <__freertos_irq_stack_top+0x5ff67bf>
f900303c:	00f47433          	and	s0,s0,a5
f9003040:	40090713          	addi	a4,s2,1024
f9003044:	7fe00793          	li	a5,2046
f9003048:	e0e7cae3          	blt	a5,a4,f9002e5c <__divdf3+0xf8>
f900304c:	00941793          	slli	a5,s0,0x9
f9003050:	01d41693          	slli	a3,s0,0x1d
f9003054:	0106e433          	or	s0,a3,a6
f9003058:	00c7d793          	srli	a5,a5,0xc
f900305c:	7ff77713          	andi	a4,a4,2047
f9003060:	e09ff06f          	j	f9002e68 <__divdf3+0x104>
f9003064:	00098593          	mv	a1,s3
f9003068:	000a8413          	mv	s0,s5
f900306c:	000b0813          	mv	a6,s6
f9003070:	000b8693          	mv	a3,s7
f9003074:	f8dff06f          	j	f9003000 <__divdf3+0x29c>
f9003078:	2b546863          	bltu	s0,s5,f9003328 <__divdf3+0x5c4>
f900307c:	2a8a8463          	beq	s5,s0,f9003324 <__divdf3+0x5c0>
f9003080:	000b0713          	mv	a4,s6
f9003084:	fff90913          	addi	s2,s2,-1
f9003088:	00000b13          	li	s6,0
f900308c:	00841793          	slli	a5,s0,0x8
f9003090:	01885893          	srli	a7,a6,0x18
f9003094:	00f8e8b3          	or	a7,a7,a5
f9003098:	0108de13          	srli	t3,a7,0x10
f900309c:	03cad7b3          	divu	a5,s5,t3
f90030a0:	01089e93          	slli	t4,a7,0x10
f90030a4:	010ede93          	srli	t4,t4,0x10
f90030a8:	01075613          	srli	a2,a4,0x10
f90030ac:	00881313          	slli	t1,a6,0x8
f90030b0:	03cafab3          	remu	s5,s5,t3
f90030b4:	02fe86b3          	mul	a3,t4,a5
f90030b8:	010a9a93          	slli	s5,s5,0x10
f90030bc:	01566633          	or	a2,a2,s5
f90030c0:	00d67e63          	bgeu	a2,a3,f90030dc <__divdf3+0x378>
f90030c4:	01160633          	add	a2,a2,a7
f90030c8:	fff78513          	addi	a0,a5,-1
f90030cc:	33166a63          	bltu	a2,a7,f9003400 <__divdf3+0x69c>
f90030d0:	32d67863          	bgeu	a2,a3,f9003400 <__divdf3+0x69c>
f90030d4:	ffe78793          	addi	a5,a5,-2
f90030d8:	01160633          	add	a2,a2,a7
f90030dc:	40d60633          	sub	a2,a2,a3
f90030e0:	03c65433          	divu	s0,a2,t3
f90030e4:	01071713          	slli	a4,a4,0x10
f90030e8:	01075713          	srli	a4,a4,0x10
f90030ec:	03c67633          	remu	a2,a2,t3
f90030f0:	028e86b3          	mul	a3,t4,s0
f90030f4:	01061613          	slli	a2,a2,0x10
f90030f8:	00c76633          	or	a2,a4,a2
f90030fc:	00d67e63          	bgeu	a2,a3,f9003118 <__divdf3+0x3b4>
f9003100:	01160633          	add	a2,a2,a7
f9003104:	fff40713          	addi	a4,s0,-1 # 7fffff <__stack_size+0x7fdfff>
f9003108:	2f166863          	bltu	a2,a7,f90033f8 <__divdf3+0x694>
f900310c:	2ed67663          	bgeu	a2,a3,f90033f8 <__divdf3+0x694>
f9003110:	ffe40413          	addi	s0,s0,-2
f9003114:	01160633          	add	a2,a2,a7
f9003118:	01079793          	slli	a5,a5,0x10
f900311c:	000103b7          	lui	t2,0x10
f9003120:	0087e433          	or	s0,a5,s0
f9003124:	fff38793          	addi	a5,t2,-1 # ffff <__stack_size+0xdfff>
f9003128:	00f47833          	and	a6,s0,a5
f900312c:	01045f13          	srli	t5,s0,0x10
f9003130:	01035513          	srli	a0,t1,0x10
f9003134:	00f377b3          	and	a5,t1,a5
f9003138:	02f80fb3          	mul	t6,a6,a5
f900313c:	40d60733          	sub	a4,a2,a3
f9003140:	02ff02b3          	mul	t0,t5,a5
f9003144:	010fd613          	srli	a2,t6,0x10
f9003148:	030506b3          	mul	a3,a0,a6
f900314c:	005686b3          	add	a3,a3,t0
f9003150:	00d606b3          	add	a3,a2,a3
f9003154:	02af0833          	mul	a6,t5,a0
f9003158:	0056f463          	bgeu	a3,t0,f9003160 <__divdf3+0x3fc>
f900315c:	00780833          	add	a6,a6,t2
f9003160:	00010f37          	lui	t5,0x10
f9003164:	ffff0f13          	addi	t5,t5,-1 # ffff <__stack_size+0xdfff>
f9003168:	0106d613          	srli	a2,a3,0x10
f900316c:	01e6f6b3          	and	a3,a3,t5
f9003170:	01069693          	slli	a3,a3,0x10
f9003174:	01efff33          	and	t5,t6,t5
f9003178:	01060633          	add	a2,a2,a6
f900317c:	01e686b3          	add	a3,a3,t5
f9003180:	16c76e63          	bltu	a4,a2,f90032fc <__divdf3+0x598>
f9003184:	16c70a63          	beq	a4,a2,f90032f8 <__divdf3+0x594>
f9003188:	40db06b3          	sub	a3,s6,a3
f900318c:	40c70733          	sub	a4,a4,a2
f9003190:	00db3b33          	sltu	s6,s6,a3
f9003194:	41670b33          	sub	s6,a4,s6
f9003198:	3ff90713          	addi	a4,s2,1023
f900319c:	1f688263          	beq	a7,s6,f9003380 <__divdf3+0x61c>
f90031a0:	03cb5833          	divu	a6,s6,t3
f90031a4:	0106d613          	srli	a2,a3,0x10
f90031a8:	03cb7b33          	remu	s6,s6,t3
f90031ac:	030e8f33          	mul	t5,t4,a6
f90031b0:	010b1b13          	slli	s6,s6,0x10
f90031b4:	01666b33          	or	s6,a2,s6
f90031b8:	01eb7e63          	bgeu	s6,t5,f90031d4 <__divdf3+0x470>
f90031bc:	011b0b33          	add	s6,s6,a7
f90031c0:	fff80613          	addi	a2,a6,-1
f90031c4:	2d1b6863          	bltu	s6,a7,f9003494 <__divdf3+0x730>
f90031c8:	2deb7663          	bgeu	s6,t5,f9003494 <__divdf3+0x730>
f90031cc:	ffe80813          	addi	a6,a6,-2
f90031d0:	011b0b33          	add	s6,s6,a7
f90031d4:	41eb0b33          	sub	s6,s6,t5
f90031d8:	03cb5633          	divu	a2,s6,t3
f90031dc:	01069693          	slli	a3,a3,0x10
f90031e0:	0106d693          	srli	a3,a3,0x10
f90031e4:	03cb7b33          	remu	s6,s6,t3
f90031e8:	02ce8eb3          	mul	t4,t4,a2
f90031ec:	010b1b13          	slli	s6,s6,0x10
f90031f0:	0166e6b3          	or	a3,a3,s6
f90031f4:	01d6fe63          	bgeu	a3,t4,f9003210 <__divdf3+0x4ac>
f90031f8:	011686b3          	add	a3,a3,a7
f90031fc:	fff60e13          	addi	t3,a2,-1
f9003200:	2916e663          	bltu	a3,a7,f900348c <__divdf3+0x728>
f9003204:	29d6f463          	bgeu	a3,t4,f900348c <__divdf3+0x728>
f9003208:	ffe60613          	addi	a2,a2,-2
f900320c:	011686b3          	add	a3,a3,a7
f9003210:	01081813          	slli	a6,a6,0x10
f9003214:	00c86833          	or	a6,a6,a2
f9003218:	01081e13          	slli	t3,a6,0x10
f900321c:	01085f93          	srli	t6,a6,0x10
f9003220:	010e5e13          	srli	t3,t3,0x10
f9003224:	02fe0f33          	mul	t5,t3,a5
f9003228:	41d686b3          	sub	a3,a3,t4
f900322c:	03c50e33          	mul	t3,a0,t3
f9003230:	010f5613          	srli	a2,t5,0x10
f9003234:	02ff87b3          	mul	a5,t6,a5
f9003238:	00fe0e33          	add	t3,t3,a5
f900323c:	01c60633          	add	a2,a2,t3
f9003240:	03f50533          	mul	a0,a0,t6
f9003244:	00f67663          	bgeu	a2,a5,f9003250 <__divdf3+0x4ec>
f9003248:	000107b7          	lui	a5,0x10
f900324c:	00f50533          	add	a0,a0,a5
f9003250:	00010e37          	lui	t3,0x10
f9003254:	fffe0e13          	addi	t3,t3,-1 # ffff <__stack_size+0xdfff>
f9003258:	01065793          	srli	a5,a2,0x10
f900325c:	01c67633          	and	a2,a2,t3
f9003260:	01061613          	slli	a2,a2,0x10
f9003264:	01cf7f33          	and	t5,t5,t3
f9003268:	00a78533          	add	a0,a5,a0
f900326c:	01e60633          	add	a2,a2,t5
f9003270:	0ca6f863          	bgeu	a3,a0,f9003340 <__divdf3+0x5dc>
f9003274:	00d886b3          	add	a3,a7,a3
f9003278:	fff80793          	addi	a5,a6,-1
f900327c:	2516e463          	bltu	a3,a7,f90034c4 <__divdf3+0x760>
f9003280:	20a6ee63          	bltu	a3,a0,f900349c <__divdf3+0x738>
f9003284:	24a68663          	beq	a3,a0,f90034d0 <__divdf3+0x76c>
f9003288:	00078813          	mv	a6,a5
f900328c:	00186813          	ori	a6,a6,1
f9003290:	d8dff06f          	j	f900301c <__divdf3+0x2b8>
f9003294:	00048513          	mv	a0,s1
f9003298:	5f0010ef          	jal	ra,f9004888 <__clzsi2>
f900329c:	01550713          	addi	a4,a0,21
f90032a0:	01c00593          	li	a1,28
f90032a4:	02050913          	addi	s2,a0,32
f90032a8:	00812603          	lw	a2,8(sp)
f90032ac:	00c12683          	lw	a3,12(sp)
f90032b0:	c8e5d8e3          	bge	a1,a4,f9002f40 <__divdf3+0x1dc>
f90032b4:	ff850413          	addi	s0,a0,-8
f90032b8:	00849ab3          	sll	s5,s1,s0
f90032bc:	00000b13          	li	s6,0
f90032c0:	c9dff06f          	j	f9002f5c <__divdf3+0x1f8>
f90032c4:	00060513          	mv	a0,a2
f90032c8:	00c12423          	sw	a2,8(sp)
f90032cc:	5bc010ef          	jal	ra,f9004888 <__clzsi2>
f90032d0:	01550593          	addi	a1,a0,21
f90032d4:	01c00713          	li	a4,28
f90032d8:	00050793          	mv	a5,a0
f90032dc:	00812603          	lw	a2,8(sp)
f90032e0:	02050513          	addi	a0,a0,32
f90032e4:	c0b752e3          	bge	a4,a1,f9002ee8 <__divdf3+0x184>
f90032e8:	ff878793          	addi	a5,a5,-8 # fff8 <__stack_size+0xdff8>
f90032ec:	00000813          	li	a6,0
f90032f0:	00f61433          	sll	s0,a2,a5
f90032f4:	c11ff06f          	j	f9002f04 <__divdf3+0x1a0>
f90032f8:	e8db78e3          	bgeu	s6,a3,f9003188 <__divdf3+0x424>
f90032fc:	006b0b33          	add	s6,s6,t1
f9003300:	006b3833          	sltu	a6,s6,t1
f9003304:	01180833          	add	a6,a6,a7
f9003308:	01070733          	add	a4,a4,a6
f900330c:	fff40813          	addi	a6,s0,-1
f9003310:	02e8fe63          	bgeu	a7,a4,f900334c <__divdf3+0x5e8>
f9003314:	16c76063          	bltu	a4,a2,f9003474 <__divdf3+0x710>
f9003318:	14e60c63          	beq	a2,a4,f9003470 <__divdf3+0x70c>
f900331c:	00080413          	mv	s0,a6
f9003320:	e69ff06f          	j	f9003188 <__divdf3+0x424>
f9003324:	d50b6ee3          	bltu	s6,a6,f9003080 <__divdf3+0x31c>
f9003328:	01fa9713          	slli	a4,s5,0x1f
f900332c:	001b5613          	srli	a2,s6,0x1
f9003330:	001ada93          	srli	s5,s5,0x1
f9003334:	00c76733          	or	a4,a4,a2
f9003338:	01fb1b13          	slli	s6,s6,0x1f
f900333c:	d51ff06f          	j	f900308c <__divdf3+0x328>
f9003340:	f4a696e3          	bne	a3,a0,f900328c <__divdf3+0x528>
f9003344:	cc060ce3          	beqz	a2,f900301c <__divdf3+0x2b8>
f9003348:	f2dff06f          	j	f9003274 <__divdf3+0x510>
f900334c:	fce898e3          	bne	a7,a4,f900331c <__divdf3+0x5b8>
f9003350:	fc6b72e3          	bgeu	s6,t1,f9003314 <__divdf3+0x5b0>
f9003354:	00080413          	mv	s0,a6
f9003358:	e31ff06f          	j	f9003188 <__divdf3+0x424>
f900335c:	00f87793          	andi	a5,a6,15
f9003360:	00400693          	li	a3,4
f9003364:	ccd782e3          	beq	a5,a3,f9003028 <__divdf3+0x2c4>
f9003368:	ffc83793          	sltiu	a5,a6,-4
f900336c:	00480813          	addi	a6,a6,4
f9003370:	0017c793          	xori	a5,a5,1
f9003374:	00385813          	srli	a6,a6,0x3
f9003378:	00f40433          	add	s0,s0,a5
f900337c:	cb1ff06f          	j	f900302c <__divdf3+0x2c8>
f9003380:	00000813          	li	a6,0
f9003384:	00100793          	li	a5,1
f9003388:	fee048e3          	bgtz	a4,f9003378 <__divdf3+0x614>
f900338c:	fff00813          	li	a6,-1
f9003390:	c40716e3          	bnez	a4,f9002fdc <__divdf3+0x278>
f9003394:	c0100913          	li	s2,-1023
f9003398:	00100793          	li	a5,1
f900339c:	41e90513          	addi	a0,s2,1054
f90033a0:	00a41733          	sll	a4,s0,a0
f90033a4:	00f856b3          	srl	a3,a6,a5
f90033a8:	00a81533          	sll	a0,a6,a0
f90033ac:	00d76733          	or	a4,a4,a3
f90033b0:	00a03533          	snez	a0,a0
f90033b4:	00a76733          	or	a4,a4,a0
f90033b8:	00777693          	andi	a3,a4,7
f90033bc:	00f45433          	srl	s0,s0,a5
f90033c0:	02068063          	beqz	a3,f90033e0 <__divdf3+0x67c>
f90033c4:	00f77793          	andi	a5,a4,15
f90033c8:	00400693          	li	a3,4
f90033cc:	00d78a63          	beq	a5,a3,f90033e0 <__divdf3+0x67c>
f90033d0:	00470793          	addi	a5,a4,4
f90033d4:	00e7b733          	sltu	a4,a5,a4
f90033d8:	00e40433          	add	s0,s0,a4
f90033dc:	00078713          	mv	a4,a5
f90033e0:	00841793          	slli	a5,s0,0x8
f90033e4:	0607d863          	bgez	a5,f9003454 <__divdf3+0x6f0>
f90033e8:	00100713          	li	a4,1
f90033ec:	00000793          	li	a5,0
f90033f0:	00000413          	li	s0,0
f90033f4:	a75ff06f          	j	f9002e68 <__divdf3+0x104>
f90033f8:	00070413          	mv	s0,a4
f90033fc:	d1dff06f          	j	f9003118 <__divdf3+0x3b4>
f9003400:	00050793          	mv	a5,a0
f9003404:	cd9ff06f          	j	f90030dc <__divdf3+0x378>
f9003408:	01f00693          	li	a3,31
f900340c:	f8f6d8e3          	bge	a3,a5,f900339c <__divdf3+0x638>
f9003410:	fe100693          	li	a3,-31
f9003414:	40e68733          	sub	a4,a3,a4
f9003418:	02000613          	li	a2,32
f900341c:	00e456b3          	srl	a3,s0,a4
f9003420:	00c78863          	beq	a5,a2,f9003430 <__divdf3+0x6cc>
f9003424:	43e90793          	addi	a5,s2,1086
f9003428:	00f417b3          	sll	a5,s0,a5
f900342c:	00f86833          	or	a6,a6,a5
f9003430:	01003733          	snez	a4,a6
f9003434:	00d76733          	or	a4,a4,a3
f9003438:	00777413          	andi	s0,a4,7
f900343c:	00000793          	li	a5,0
f9003440:	02040063          	beqz	s0,f9003460 <__divdf3+0x6fc>
f9003444:	00f77793          	andi	a5,a4,15
f9003448:	00400693          	li	a3,4
f900344c:	00000413          	li	s0,0
f9003450:	f8d790e3          	bne	a5,a3,f90033d0 <__divdf3+0x66c>
f9003454:	00941793          	slli	a5,s0,0x9
f9003458:	00c7d793          	srli	a5,a5,0xc
f900345c:	01d41413          	slli	s0,s0,0x1d
f9003460:	00375713          	srli	a4,a4,0x3
f9003464:	00876433          	or	s0,a4,s0
f9003468:	00000713          	li	a4,0
f900346c:	9fdff06f          	j	f9002e68 <__divdf3+0x104>
f9003470:	eadb76e3          	bgeu	s6,a3,f900331c <__divdf3+0x5b8>
f9003474:	006b0b33          	add	s6,s6,t1
f9003478:	006b3833          	sltu	a6,s6,t1
f900347c:	01180833          	add	a6,a6,a7
f9003480:	ffe40413          	addi	s0,s0,-2
f9003484:	01070733          	add	a4,a4,a6
f9003488:	d01ff06f          	j	f9003188 <__divdf3+0x424>
f900348c:	000e0613          	mv	a2,t3
f9003490:	d81ff06f          	j	f9003210 <__divdf3+0x4ac>
f9003494:	00060813          	mv	a6,a2
f9003498:	d3dff06f          	j	f90031d4 <__divdf3+0x470>
f900349c:	00131793          	slli	a5,t1,0x1
f90034a0:	0067b333          	sltu	t1,a5,t1
f90034a4:	011308b3          	add	a7,t1,a7
f90034a8:	011686b3          	add	a3,a3,a7
f90034ac:	ffe80813          	addi	a6,a6,-2
f90034b0:	00078313          	mv	t1,a5
f90034b4:	dca69ce3          	bne	a3,a0,f900328c <__divdf3+0x528>
f90034b8:	b6c302e3          	beq	t1,a2,f900301c <__divdf3+0x2b8>
f90034bc:	00186813          	ori	a6,a6,1
f90034c0:	b5dff06f          	j	f900301c <__divdf3+0x2b8>
f90034c4:	00078813          	mv	a6,a5
f90034c8:	fea688e3          	beq	a3,a0,f90034b8 <__divdf3+0x754>
f90034cc:	dc1ff06f          	j	f900328c <__divdf3+0x528>
f90034d0:	fcc366e3          	bltu	t1,a2,f900349c <__divdf3+0x738>
f90034d4:	00078813          	mv	a6,a5
f90034d8:	fec312e3          	bne	t1,a2,f90034bc <__divdf3+0x758>
f90034dc:	b41ff06f          	j	f900301c <__divdf3+0x2b8>

f90034e0 <__eqdf2>:
f90034e0:	0145d713          	srli	a4,a1,0x14
f90034e4:	001007b7          	lui	a5,0x100
f90034e8:	fff78793          	addi	a5,a5,-1 # fffff <__stack_size+0xfdfff>
f90034ec:	0146d813          	srli	a6,a3,0x14
f90034f0:	7ff77713          	andi	a4,a4,2047
f90034f4:	7ff00893          	li	a7,2047
f90034f8:	00b7fe33          	and	t3,a5,a1
f90034fc:	00050e93          	mv	t4,a0
f9003500:	00d7f7b3          	and	a5,a5,a3
f9003504:	01f5d593          	srli	a1,a1,0x1f
f9003508:	00060f13          	mv	t5,a2
f900350c:	7ff87813          	andi	a6,a6,2047
f9003510:	01f6d693          	srli	a3,a3,0x1f
f9003514:	01170e63          	beq	a4,a7,f9003530 <__eqdf2+0x50>
f9003518:	00100313          	li	t1,1
f900351c:	01180663          	beq	a6,a7,f9003528 <__eqdf2+0x48>
f9003520:	01071463          	bne	a4,a6,f9003528 <__eqdf2+0x48>
f9003524:	02fe0263          	beq	t3,a5,f9003548 <__eqdf2+0x68>
f9003528:	00030513          	mv	a0,t1
f900352c:	00008067          	ret
f9003530:	00ae68b3          	or	a7,t3,a0
f9003534:	00100313          	li	t1,1
f9003538:	fe0898e3          	bnez	a7,f9003528 <__eqdf2+0x48>
f900353c:	fee816e3          	bne	a6,a4,f9003528 <__eqdf2+0x48>
f9003540:	00c7e7b3          	or	a5,a5,a2
f9003544:	fe0792e3          	bnez	a5,f9003528 <__eqdf2+0x48>
f9003548:	00100313          	li	t1,1
f900354c:	fdee9ee3          	bne	t4,t5,f9003528 <__eqdf2+0x48>
f9003550:	00000313          	li	t1,0
f9003554:	fcd58ae3          	beq	a1,a3,f9003528 <__eqdf2+0x48>
f9003558:	00100313          	li	t1,1
f900355c:	fc0716e3          	bnez	a4,f9003528 <__eqdf2+0x48>
f9003560:	00ae6533          	or	a0,t3,a0
f9003564:	00a03333          	snez	t1,a0
f9003568:	fc1ff06f          	j	f9003528 <__eqdf2+0x48>

f900356c <__gedf2>:
f900356c:	0145d713          	srli	a4,a1,0x14
f9003570:	001007b7          	lui	a5,0x100
f9003574:	fff78793          	addi	a5,a5,-1 # fffff <__stack_size+0xfdfff>
f9003578:	0146d813          	srli	a6,a3,0x14
f900357c:	7ff77713          	andi	a4,a4,2047
f9003580:	7ff00893          	li	a7,2047
f9003584:	00b7f333          	and	t1,a5,a1
f9003588:	00050e13          	mv	t3,a0
f900358c:	00d7f7b3          	and	a5,a5,a3
f9003590:	01f5d593          	srli	a1,a1,0x1f
f9003594:	00060e93          	mv	t4,a2
f9003598:	7ff87813          	andi	a6,a6,2047
f900359c:	01f6d693          	srli	a3,a3,0x1f
f90035a0:	05170263          	beq	a4,a7,f90035e4 <__gedf2+0x78>
f90035a4:	03180863          	beq	a6,a7,f90035d4 <__gedf2+0x68>
f90035a8:	04071463          	bnez	a4,f90035f0 <__gedf2+0x84>
f90035ac:	00a36533          	or	a0,t1,a0
f90035b0:	00081663          	bnez	a6,f90035bc <__gedf2+0x50>
f90035b4:	00c7e633          	or	a2,a5,a2
f90035b8:	06060263          	beqz	a2,f900361c <__gedf2+0xb0>
f90035bc:	04050a63          	beqz	a0,f9003610 <__gedf2+0xa4>
f90035c0:	06d58c63          	beq	a1,a3,f9003638 <__gedf2+0xcc>
f90035c4:	00100693          	li	a3,1
f90035c8:	04059663          	bnez	a1,f9003614 <__gedf2+0xa8>
f90035cc:	00068513          	mv	a0,a3
f90035d0:	00008067          	ret
f90035d4:	00c7e8b3          	or	a7,a5,a2
f90035d8:	fc0888e3          	beqz	a7,f90035a8 <__gedf2+0x3c>
f90035dc:	ffe00693          	li	a3,-2
f90035e0:	fedff06f          	j	f90035cc <__gedf2+0x60>
f90035e4:	00a36533          	or	a0,t1,a0
f90035e8:	fe051ae3          	bnez	a0,f90035dc <__gedf2+0x70>
f90035ec:	02e80e63          	beq	a6,a4,f9003628 <__gedf2+0xbc>
f90035f0:	00081663          	bnez	a6,f90035fc <__gedf2+0x90>
f90035f4:	00c7e633          	or	a2,a5,a2
f90035f8:	fc0606e3          	beqz	a2,f90035c4 <__gedf2+0x58>
f90035fc:	fcd594e3          	bne	a1,a3,f90035c4 <__gedf2+0x58>
f9003600:	02e85c63          	bge	a6,a4,f9003638 <__gedf2+0xcc>
f9003604:	00069863          	bnez	a3,f9003614 <__gedf2+0xa8>
f9003608:	00100693          	li	a3,1
f900360c:	fc1ff06f          	j	f90035cc <__gedf2+0x60>
f9003610:	fa069ee3          	bnez	a3,f90035cc <__gedf2+0x60>
f9003614:	fff00693          	li	a3,-1
f9003618:	fb5ff06f          	j	f90035cc <__gedf2+0x60>
f900361c:	00000693          	li	a3,0
f9003620:	fa0506e3          	beqz	a0,f90035cc <__gedf2+0x60>
f9003624:	fa1ff06f          	j	f90035c4 <__gedf2+0x58>
f9003628:	00c7e633          	or	a2,a5,a2
f900362c:	fc0608e3          	beqz	a2,f90035fc <__gedf2+0x90>
f9003630:	ffe00693          	li	a3,-2
f9003634:	f99ff06f          	j	f90035cc <__gedf2+0x60>
f9003638:	01074a63          	blt	a4,a6,f900364c <__gedf2+0xe0>
f900363c:	f867e4e3          	bltu	a5,t1,f90035c4 <__gedf2+0x58>
f9003640:	00f30c63          	beq	t1,a5,f9003658 <__gedf2+0xec>
f9003644:	00000693          	li	a3,0
f9003648:	f8f372e3          	bgeu	t1,a5,f90035cc <__gedf2+0x60>
f900364c:	fc0584e3          	beqz	a1,f9003614 <__gedf2+0xa8>
f9003650:	00058693          	mv	a3,a1
f9003654:	f79ff06f          	j	f90035cc <__gedf2+0x60>
f9003658:	f7cee6e3          	bltu	t4,t3,f90035c4 <__gedf2+0x58>
f900365c:	00000693          	li	a3,0
f9003660:	f7de76e3          	bgeu	t3,t4,f90035cc <__gedf2+0x60>
f9003664:	fe9ff06f          	j	f900364c <__gedf2+0xe0>

f9003668 <__ledf2>:
f9003668:	0145d713          	srli	a4,a1,0x14
f900366c:	001007b7          	lui	a5,0x100
f9003670:	fff78793          	addi	a5,a5,-1 # fffff <__stack_size+0xfdfff>
f9003674:	0146d813          	srli	a6,a3,0x14
f9003678:	7ff77713          	andi	a4,a4,2047
f900367c:	7ff00893          	li	a7,2047
f9003680:	00b7f333          	and	t1,a5,a1
f9003684:	00050e13          	mv	t3,a0
f9003688:	00d7f7b3          	and	a5,a5,a3
f900368c:	01f5d593          	srli	a1,a1,0x1f
f9003690:	00060e93          	mv	t4,a2
f9003694:	7ff87813          	andi	a6,a6,2047
f9003698:	01f6d693          	srli	a3,a3,0x1f
f900369c:	05170a63          	beq	a4,a7,f90036f0 <__ledf2+0x88>
f90036a0:	03180263          	beq	a6,a7,f90036c4 <__ledf2+0x5c>
f90036a4:	04071c63          	bnez	a4,f90036fc <__ledf2+0x94>
f90036a8:	00a36533          	or	a0,t1,a0
f90036ac:	02081663          	bnez	a6,f90036d8 <__ledf2+0x70>
f90036b0:	00c7e633          	or	a2,a5,a2
f90036b4:	02061263          	bnez	a2,f90036d8 <__ledf2+0x70>
f90036b8:	00000693          	li	a3,0
f90036bc:	06050263          	beqz	a0,f9003720 <__ledf2+0xb8>
f90036c0:	0200006f          	j	f90036e0 <__ledf2+0x78>
f90036c4:	00c7e8b3          	or	a7,a5,a2
f90036c8:	fc088ee3          	beqz	a7,f90036a4 <__ledf2+0x3c>
f90036cc:	00200693          	li	a3,2
f90036d0:	00068513          	mv	a0,a3
f90036d4:	00008067          	ret
f90036d8:	04050263          	beqz	a0,f900371c <__ledf2+0xb4>
f90036dc:	04d58e63          	beq	a1,a3,f9003738 <__ledf2+0xd0>
f90036e0:	00100693          	li	a3,1
f90036e4:	02058e63          	beqz	a1,f9003720 <__ledf2+0xb8>
f90036e8:	fff00693          	li	a3,-1
f90036ec:	0340006f          	j	f9003720 <__ledf2+0xb8>
f90036f0:	00a36533          	or	a0,t1,a0
f90036f4:	fc051ce3          	bnez	a0,f90036cc <__ledf2+0x64>
f90036f8:	02e80863          	beq	a6,a4,f9003728 <__ledf2+0xc0>
f90036fc:	00081663          	bnez	a6,f9003708 <__ledf2+0xa0>
f9003700:	00c7e633          	or	a2,a5,a2
f9003704:	fc060ee3          	beqz	a2,f90036e0 <__ledf2+0x78>
f9003708:	fcd59ce3          	bne	a1,a3,f90036e0 <__ledf2+0x78>
f900370c:	02e85663          	bge	a6,a4,f9003738 <__ledf2+0xd0>
f9003710:	fc069ce3          	bnez	a3,f90036e8 <__ledf2+0x80>
f9003714:	00100693          	li	a3,1
f9003718:	0080006f          	j	f9003720 <__ledf2+0xb8>
f900371c:	fc0686e3          	beqz	a3,f90036e8 <__ledf2+0x80>
f9003720:	00068513          	mv	a0,a3
f9003724:	00008067          	ret
f9003728:	00c7e633          	or	a2,a5,a2
f900372c:	fc060ee3          	beqz	a2,f9003708 <__ledf2+0xa0>
f9003730:	00200693          	li	a3,2
f9003734:	f9dff06f          	j	f90036d0 <__ledf2+0x68>
f9003738:	01074a63          	blt	a4,a6,f900374c <__ledf2+0xe4>
f900373c:	fa67e2e3          	bltu	a5,t1,f90036e0 <__ledf2+0x78>
f9003740:	00f30c63          	beq	t1,a5,f9003758 <__ledf2+0xf0>
f9003744:	00000693          	li	a3,0
f9003748:	fcf37ce3          	bgeu	t1,a5,f9003720 <__ledf2+0xb8>
f900374c:	f8058ee3          	beqz	a1,f90036e8 <__ledf2+0x80>
f9003750:	00058693          	mv	a3,a1
f9003754:	fcdff06f          	j	f9003720 <__ledf2+0xb8>
f9003758:	f9cee4e3          	bltu	t4,t3,f90036e0 <__ledf2+0x78>
f900375c:	00000693          	li	a3,0
f9003760:	fdde70e3          	bgeu	t3,t4,f9003720 <__ledf2+0xb8>
f9003764:	fe9ff06f          	j	f900374c <__ledf2+0xe4>

f9003768 <__muldf3>:
f9003768:	fc010113          	addi	sp,sp,-64
f900376c:	0145d793          	srli	a5,a1,0x14
f9003770:	02812c23          	sw	s0,56(sp)
f9003774:	03212823          	sw	s2,48(sp)
f9003778:	03412423          	sw	s4,40(sp)
f900377c:	00c59413          	slli	s0,a1,0xc
f9003780:	02112e23          	sw	ra,60(sp)
f9003784:	02912a23          	sw	s1,52(sp)
f9003788:	03312623          	sw	s3,44(sp)
f900378c:	03512223          	sw	s5,36(sp)
f9003790:	03612023          	sw	s6,32(sp)
f9003794:	01712e23          	sw	s7,28(sp)
f9003798:	7ff7f793          	andi	a5,a5,2047
f900379c:	00050913          	mv	s2,a0
f90037a0:	00c45413          	srli	s0,s0,0xc
f90037a4:	01f5da13          	srli	s4,a1,0x1f
f90037a8:	14078c63          	beqz	a5,f9003900 <__muldf3+0x198>
f90037ac:	7ff00713          	li	a4,2047
f90037b0:	20e78863          	beq	a5,a4,f90039c0 <__muldf3+0x258>
f90037b4:	00341513          	slli	a0,s0,0x3
f90037b8:	01d95413          	srli	s0,s2,0x1d
f90037bc:	00a46433          	or	s0,s0,a0
f90037c0:	00800537          	lui	a0,0x800
f90037c4:	00a46433          	or	s0,s0,a0
f90037c8:	00391493          	slli	s1,s2,0x3
f90037cc:	c0178b13          	addi	s6,a5,-1023
f90037d0:	00000993          	li	s3,0
f90037d4:	00000b93          	li	s7,0
f90037d8:	0146d793          	srli	a5,a3,0x14
f90037dc:	00c69913          	slli	s2,a3,0xc
f90037e0:	7ff7f793          	andi	a5,a5,2047
f90037e4:	00c95913          	srli	s2,s2,0xc
f90037e8:	01f6da93          	srli	s5,a3,0x1f
f90037ec:	18078263          	beqz	a5,f9003970 <__muldf3+0x208>
f90037f0:	7ff00713          	li	a4,2047
f90037f4:	04e78c63          	beq	a5,a4,f900384c <__muldf3+0xe4>
f90037f8:	00391513          	slli	a0,s2,0x3
f90037fc:	01d65913          	srli	s2,a2,0x1d
f9003800:	00a96933          	or	s2,s2,a0
f9003804:	c0178793          	addi	a5,a5,-1023
f9003808:	00800537          	lui	a0,0x800
f900380c:	00a96933          	or	s2,s2,a0
f9003810:	00361593          	slli	a1,a2,0x3
f9003814:	00fb0b33          	add	s6,s6,a5
f9003818:	00000813          	li	a6,0
f900381c:	015a46b3          	xor	a3,s4,s5
f9003820:	00f00793          	li	a5,15
f9003824:	00068513          	mv	a0,a3
f9003828:	001b0613          	addi	a2,s6,1
f900382c:	2137ec63          	bltu	a5,s3,f9003a44 <__muldf3+0x2dc>
f9003830:	00004797          	auipc	a5,0x4
f9003834:	e0878793          	addi	a5,a5,-504 # f9007638 <gImage_hit_logo+0x2a70>
f9003838:	00299993          	slli	s3,s3,0x2
f900383c:	00f989b3          	add	s3,s3,a5
f9003840:	0009a703          	lw	a4,0(s3)
f9003844:	00f70733          	add	a4,a4,a5
f9003848:	00070067          	jr	a4
f900384c:	00c965b3          	or	a1,s2,a2
f9003850:	7ffb0b13          	addi	s6,s6,2047
f9003854:	1c059063          	bnez	a1,f9003a14 <__muldf3+0x2ac>
f9003858:	0029e993          	ori	s3,s3,2
f900385c:	00000913          	li	s2,0
f9003860:	00200813          	li	a6,2
f9003864:	fb9ff06f          	j	f900381c <__muldf3+0xb4>
f9003868:	00000693          	li	a3,0
f900386c:	7ff00793          	li	a5,2047
f9003870:	00080437          	lui	s0,0x80
f9003874:	00000493          	li	s1,0
f9003878:	00c41413          	slli	s0,s0,0xc
f900387c:	01479793          	slli	a5,a5,0x14
f9003880:	00c45413          	srli	s0,s0,0xc
f9003884:	01f69693          	slli	a3,a3,0x1f
f9003888:	00f46433          	or	s0,s0,a5
f900388c:	00d46433          	or	s0,s0,a3
f9003890:	00040593          	mv	a1,s0
f9003894:	03c12083          	lw	ra,60(sp)
f9003898:	03812403          	lw	s0,56(sp)
f900389c:	00048513          	mv	a0,s1
f90038a0:	03012903          	lw	s2,48(sp)
f90038a4:	03412483          	lw	s1,52(sp)
f90038a8:	02c12983          	lw	s3,44(sp)
f90038ac:	02812a03          	lw	s4,40(sp)
f90038b0:	02412a83          	lw	s5,36(sp)
f90038b4:	02012b03          	lw	s6,32(sp)
f90038b8:	01c12b83          	lw	s7,28(sp)
f90038bc:	04010113          	addi	sp,sp,64
f90038c0:	00008067          	ret
f90038c4:	000a8513          	mv	a0,s5
f90038c8:	00090413          	mv	s0,s2
f90038cc:	00058493          	mv	s1,a1
f90038d0:	00080b93          	mv	s7,a6
f90038d4:	00200793          	li	a5,2
f90038d8:	14fb8c63          	beq	s7,a5,f9003a30 <__muldf3+0x2c8>
f90038dc:	00300793          	li	a5,3
f90038e0:	f8fb84e3          	beq	s7,a5,f9003868 <__muldf3+0x100>
f90038e4:	00100793          	li	a5,1
f90038e8:	00050693          	mv	a3,a0
f90038ec:	4cfb9463          	bne	s7,a5,f9003db4 <__muldf3+0x64c>
f90038f0:	00000793          	li	a5,0
f90038f4:	00000413          	li	s0,0
f90038f8:	00000493          	li	s1,0
f90038fc:	f7dff06f          	j	f9003878 <__muldf3+0x110>
f9003900:	00a464b3          	or	s1,s0,a0
f9003904:	0e048e63          	beqz	s1,f9003a00 <__muldf3+0x298>
f9003908:	00d12623          	sw	a3,12(sp)
f900390c:	00c12423          	sw	a2,8(sp)
f9003910:	38040863          	beqz	s0,f9003ca0 <__muldf3+0x538>
f9003914:	00040513          	mv	a0,s0
f9003918:	771000ef          	jal	ra,f9004888 <__clzsi2>
f900391c:	00812603          	lw	a2,8(sp)
f9003920:	00c12683          	lw	a3,12(sp)
f9003924:	00050793          	mv	a5,a0
f9003928:	ff550593          	addi	a1,a0,-11 # 7ffff5 <__stack_size+0x7fdff5>
f900392c:	01d00713          	li	a4,29
f9003930:	ff878493          	addi	s1,a5,-8
f9003934:	40b70733          	sub	a4,a4,a1
f9003938:	00941433          	sll	s0,s0,s1
f900393c:	00e95733          	srl	a4,s2,a4
f9003940:	00876433          	or	s0,a4,s0
f9003944:	009914b3          	sll	s1,s2,s1
f9003948:	c0d00b13          	li	s6,-1011
f900394c:	40fb0b33          	sub	s6,s6,a5
f9003950:	0146d793          	srli	a5,a3,0x14
f9003954:	00c69913          	slli	s2,a3,0xc
f9003958:	7ff7f793          	andi	a5,a5,2047
f900395c:	00000993          	li	s3,0
f9003960:	00000b93          	li	s7,0
f9003964:	00c95913          	srli	s2,s2,0xc
f9003968:	01f6da93          	srli	s5,a3,0x1f
f900396c:	e80792e3          	bnez	a5,f90037f0 <__muldf3+0x88>
f9003970:	00c965b3          	or	a1,s2,a2
f9003974:	06058463          	beqz	a1,f90039dc <__muldf3+0x274>
f9003978:	2e090c63          	beqz	s2,f9003c70 <__muldf3+0x508>
f900397c:	00090513          	mv	a0,s2
f9003980:	00c12423          	sw	a2,8(sp)
f9003984:	705000ef          	jal	ra,f9004888 <__clzsi2>
f9003988:	00812603          	lw	a2,8(sp)
f900398c:	00050793          	mv	a5,a0
f9003990:	ff550693          	addi	a3,a0,-11
f9003994:	01d00713          	li	a4,29
f9003998:	ff878593          	addi	a1,a5,-8
f900399c:	40d70733          	sub	a4,a4,a3
f90039a0:	00b91933          	sll	s2,s2,a1
f90039a4:	00e65733          	srl	a4,a2,a4
f90039a8:	01276933          	or	s2,a4,s2
f90039ac:	00b615b3          	sll	a1,a2,a1
f90039b0:	40fb07b3          	sub	a5,s6,a5
f90039b4:	c0d78b13          	addi	s6,a5,-1011
f90039b8:	00000813          	li	a6,0
f90039bc:	e61ff06f          	j	f900381c <__muldf3+0xb4>
f90039c0:	00a464b3          	or	s1,s0,a0
f90039c4:	02049463          	bnez	s1,f90039ec <__muldf3+0x284>
f90039c8:	00000413          	li	s0,0
f90039cc:	00800993          	li	s3,8
f90039d0:	7ff00b13          	li	s6,2047
f90039d4:	00200b93          	li	s7,2
f90039d8:	e01ff06f          	j	f90037d8 <__muldf3+0x70>
f90039dc:	0019e993          	ori	s3,s3,1
f90039e0:	00000913          	li	s2,0
f90039e4:	00100813          	li	a6,1
f90039e8:	e35ff06f          	j	f900381c <__muldf3+0xb4>
f90039ec:	00050493          	mv	s1,a0
f90039f0:	00c00993          	li	s3,12
f90039f4:	7ff00b13          	li	s6,2047
f90039f8:	00300b93          	li	s7,3
f90039fc:	dddff06f          	j	f90037d8 <__muldf3+0x70>
f9003a00:	00000413          	li	s0,0
f9003a04:	00400993          	li	s3,4
f9003a08:	00000b13          	li	s6,0
f9003a0c:	00100b93          	li	s7,1
f9003a10:	dc9ff06f          	j	f90037d8 <__muldf3+0x70>
f9003a14:	0039e993          	ori	s3,s3,3
f9003a18:	00060593          	mv	a1,a2
f9003a1c:	00300813          	li	a6,3
f9003a20:	dfdff06f          	j	f900381c <__muldf3+0xb4>
f9003a24:	00200793          	li	a5,2
f9003a28:	000a0513          	mv	a0,s4
f9003a2c:	eafb98e3          	bne	s7,a5,f90038dc <__muldf3+0x174>
f9003a30:	00050693          	mv	a3,a0
f9003a34:	7ff00793          	li	a5,2047
f9003a38:	00000413          	li	s0,0
f9003a3c:	00000493          	li	s1,0
f9003a40:	e39ff06f          	j	f9003878 <__muldf3+0x110>
f9003a44:	00010e37          	lui	t3,0x10
f9003a48:	fffe0713          	addi	a4,t3,-1 # ffff <__stack_size+0xdfff>
f9003a4c:	0104d793          	srli	a5,s1,0x10
f9003a50:	0105d813          	srli	a6,a1,0x10
f9003a54:	00e4f4b3          	and	s1,s1,a4
f9003a58:	00e5f5b3          	and	a1,a1,a4
f9003a5c:	02958733          	mul	a4,a1,s1
f9003a60:	02b78333          	mul	t1,a5,a1
f9003a64:	01075513          	srli	a0,a4,0x10
f9003a68:	029808b3          	mul	a7,a6,s1
f9003a6c:	006888b3          	add	a7,a7,t1
f9003a70:	01150533          	add	a0,a0,a7
f9003a74:	03078f33          	mul	t5,a5,a6
f9003a78:	00657463          	bgeu	a0,t1,f9003a80 <__muldf3+0x318>
f9003a7c:	01cf0f33          	add	t5,t5,t3
f9003a80:	00010eb7          	lui	t4,0x10
f9003a84:	fffe8893          	addi	a7,t4,-1 # ffff <__stack_size+0xdfff>
f9003a88:	01095293          	srli	t0,s2,0x10
f9003a8c:	01197933          	and	s2,s2,a7
f9003a90:	01157333          	and	t1,a0,a7
f9003a94:	01177733          	and	a4,a4,a7
f9003a98:	01031313          	slli	t1,t1,0x10
f9003a9c:	029908b3          	mul	a7,s2,s1
f9003aa0:	00e30333          	add	t1,t1,a4
f9003aa4:	01055513          	srli	a0,a0,0x10
f9003aa8:	03278fb3          	mul	t6,a5,s2
f9003aac:	0108de13          	srli	t3,a7,0x10
f9003ab0:	029284b3          	mul	s1,t0,s1
f9003ab4:	01f484b3          	add	s1,s1,t6
f9003ab8:	009e04b3          	add	s1,t3,s1
f9003abc:	02578733          	mul	a4,a5,t0
f9003ac0:	01f4f463          	bgeu	s1,t6,f9003ac8 <__muldf3+0x360>
f9003ac4:	01d70733          	add	a4,a4,t4
f9003ac8:	000109b7          	lui	s3,0x10
f9003acc:	fff98e13          	addi	t3,s3,-1 # ffff <__stack_size+0xdfff>
f9003ad0:	01c477b3          	and	a5,s0,t3
f9003ad4:	01c4feb3          	and	t4,s1,t3
f9003ad8:	01045f93          	srli	t6,s0,0x10
f9003adc:	0104d493          	srli	s1,s1,0x10
f9003ae0:	01c8f8b3          	and	a7,a7,t3
f9003ae4:	02f583b3          	mul	t2,a1,a5
f9003ae8:	00e48e33          	add	t3,s1,a4
f9003aec:	010e9e93          	slli	t4,t4,0x10
f9003af0:	011e8eb3          	add	t4,t4,a7
f9003af4:	01d50533          	add	a0,a0,t4
f9003af8:	02f80733          	mul	a4,a6,a5
f9003afc:	0103d893          	srli	a7,t2,0x10
f9003b00:	02bf85b3          	mul	a1,t6,a1
f9003b04:	00b70733          	add	a4,a4,a1
f9003b08:	00e888b3          	add	a7,a7,a4
f9003b0c:	03f80833          	mul	a6,a6,t6
f9003b10:	00b8f463          	bgeu	a7,a1,f9003b18 <__muldf3+0x3b0>
f9003b14:	01380833          	add	a6,a6,s3
f9003b18:	00010737          	lui	a4,0x10
f9003b1c:	fff70413          	addi	s0,a4,-1 # ffff <__stack_size+0xdfff>
f9003b20:	0088f5b3          	and	a1,a7,s0
f9003b24:	0108d893          	srli	a7,a7,0x10
f9003b28:	010888b3          	add	a7,a7,a6
f9003b2c:	0083f3b3          	and	t2,t2,s0
f9003b30:	01059593          	slli	a1,a1,0x10
f9003b34:	02f90833          	mul	a6,s2,a5
f9003b38:	007585b3          	add	a1,a1,t2
f9003b3c:	032f8933          	mul	s2,t6,s2
f9003b40:	01085413          	srli	s0,a6,0x10
f9003b44:	02f287b3          	mul	a5,t0,a5
f9003b48:	012787b3          	add	a5,a5,s2
f9003b4c:	00f407b3          	add	a5,s0,a5
f9003b50:	03f28fb3          	mul	t6,t0,t6
f9003b54:	0127f463          	bgeu	a5,s2,f9003b5c <__muldf3+0x3f4>
f9003b58:	00ef8fb3          	add	t6,t6,a4
f9003b5c:	000102b7          	lui	t0,0x10
f9003b60:	fff28293          	addi	t0,t0,-1 # ffff <__stack_size+0xdfff>
f9003b64:	0057f733          	and	a4,a5,t0
f9003b68:	00587833          	and	a6,a6,t0
f9003b6c:	01071713          	slli	a4,a4,0x10
f9003b70:	01e50533          	add	a0,a0,t5
f9003b74:	01070733          	add	a4,a4,a6
f9003b78:	01d53eb3          	sltu	t4,a0,t4
f9003b7c:	01c70733          	add	a4,a4,t3
f9003b80:	00b50533          	add	a0,a0,a1
f9003b84:	01d70433          	add	s0,a4,t4
f9003b88:	00b535b3          	sltu	a1,a0,a1
f9003b8c:	01140833          	add	a6,s0,a7
f9003b90:	00b80f33          	add	t5,a6,a1
f9003b94:	01c73733          	sltu	a4,a4,t3
f9003b98:	01d43433          	sltu	s0,s0,t4
f9003b9c:	00876433          	or	s0,a4,s0
f9003ba0:	0107d793          	srli	a5,a5,0x10
f9003ba4:	011838b3          	sltu	a7,a6,a7
f9003ba8:	00bf35b3          	sltu	a1,t5,a1
f9003bac:	00f40433          	add	s0,s0,a5
f9003bb0:	00b8e5b3          	or	a1,a7,a1
f9003bb4:	00951493          	slli	s1,a0,0x9
f9003bb8:	00b40433          	add	s0,s0,a1
f9003bbc:	01f40433          	add	s0,s0,t6
f9003bc0:	0064e4b3          	or	s1,s1,t1
f9003bc4:	00941713          	slli	a4,s0,0x9
f9003bc8:	009034b3          	snez	s1,s1
f9003bcc:	017f5413          	srli	s0,t5,0x17
f9003bd0:	01755513          	srli	a0,a0,0x17
f9003bd4:	009f1793          	slli	a5,t5,0x9
f9003bd8:	00a4e4b3          	or	s1,s1,a0
f9003bdc:	00876433          	or	s0,a4,s0
f9003be0:	00f4e4b3          	or	s1,s1,a5
f9003be4:	00741793          	slli	a5,s0,0x7
f9003be8:	0207d063          	bgez	a5,f9003c08 <__muldf3+0x4a0>
f9003bec:	0014d793          	srli	a5,s1,0x1
f9003bf0:	0014f493          	andi	s1,s1,1
f9003bf4:	01f41713          	slli	a4,s0,0x1f
f9003bf8:	0097e4b3          	or	s1,a5,s1
f9003bfc:	00e4e4b3          	or	s1,s1,a4
f9003c00:	00145413          	srli	s0,s0,0x1
f9003c04:	00060b13          	mv	s6,a2
f9003c08:	3ffb0713          	addi	a4,s6,1023
f9003c0c:	0ce05063          	blez	a4,f9003ccc <__muldf3+0x564>
f9003c10:	0074f793          	andi	a5,s1,7
f9003c14:	02078063          	beqz	a5,f9003c34 <__muldf3+0x4cc>
f9003c18:	00f4f793          	andi	a5,s1,15
f9003c1c:	00400613          	li	a2,4
f9003c20:	00c78a63          	beq	a5,a2,f9003c34 <__muldf3+0x4cc>
f9003c24:	00448793          	addi	a5,s1,4
f9003c28:	0097b4b3          	sltu	s1,a5,s1
f9003c2c:	00940433          	add	s0,s0,s1
f9003c30:	00078493          	mv	s1,a5
f9003c34:	00741793          	slli	a5,s0,0x7
f9003c38:	0007da63          	bgez	a5,f9003c4c <__muldf3+0x4e4>
f9003c3c:	ff0007b7          	lui	a5,0xff000
f9003c40:	fff78793          	addi	a5,a5,-1 # feffffff <__freertos_irq_stack_top+0x5ff67bf>
f9003c44:	00f47433          	and	s0,s0,a5
f9003c48:	400b0713          	addi	a4,s6,1024
f9003c4c:	7fe00793          	li	a5,2046
f9003c50:	14e7ca63          	blt	a5,a4,f9003da4 <__muldf3+0x63c>
f9003c54:	0034d793          	srli	a5,s1,0x3
f9003c58:	01d41493          	slli	s1,s0,0x1d
f9003c5c:	00941413          	slli	s0,s0,0x9
f9003c60:	00f4e4b3          	or	s1,s1,a5
f9003c64:	00c45413          	srli	s0,s0,0xc
f9003c68:	7ff77793          	andi	a5,a4,2047
f9003c6c:	c0dff06f          	j	f9003878 <__muldf3+0x110>
f9003c70:	00060513          	mv	a0,a2
f9003c74:	00c12423          	sw	a2,8(sp)
f9003c78:	411000ef          	jal	ra,f9004888 <__clzsi2>
f9003c7c:	01550693          	addi	a3,a0,21
f9003c80:	01c00713          	li	a4,28
f9003c84:	02050793          	addi	a5,a0,32
f9003c88:	00812603          	lw	a2,8(sp)
f9003c8c:	d0d754e3          	bge	a4,a3,f9003994 <__muldf3+0x22c>
f9003c90:	ff850513          	addi	a0,a0,-8
f9003c94:	00000593          	li	a1,0
f9003c98:	00a61933          	sll	s2,a2,a0
f9003c9c:	d15ff06f          	j	f90039b0 <__muldf3+0x248>
f9003ca0:	3e9000ef          	jal	ra,f9004888 <__clzsi2>
f9003ca4:	01550593          	addi	a1,a0,21
f9003ca8:	01c00713          	li	a4,28
f9003cac:	02050793          	addi	a5,a0,32
f9003cb0:	00812603          	lw	a2,8(sp)
f9003cb4:	00c12683          	lw	a3,12(sp)
f9003cb8:	c6b75ae3          	bge	a4,a1,f900392c <__muldf3+0x1c4>
f9003cbc:	ff850513          	addi	a0,a0,-8
f9003cc0:	00000493          	li	s1,0
f9003cc4:	00a91433          	sll	s0,s2,a0
f9003cc8:	c81ff06f          	j	f9003948 <__muldf3+0x1e0>
f9003ccc:	00100613          	li	a2,1
f9003cd0:	40e60633          	sub	a2,a2,a4
f9003cd4:	06071063          	bnez	a4,f9003d34 <__muldf3+0x5cc>
f9003cd8:	41eb0793          	addi	a5,s6,1054
f9003cdc:	00f49733          	sll	a4,s1,a5
f9003ce0:	00f417b3          	sll	a5,s0,a5
f9003ce4:	00c4d4b3          	srl	s1,s1,a2
f9003ce8:	0097e4b3          	or	s1,a5,s1
f9003cec:	00e03733          	snez	a4,a4
f9003cf0:	00e4e4b3          	or	s1,s1,a4
f9003cf4:	0074f793          	andi	a5,s1,7
f9003cf8:	00c45633          	srl	a2,s0,a2
f9003cfc:	02078063          	beqz	a5,f9003d1c <__muldf3+0x5b4>
f9003d00:	00f4f793          	andi	a5,s1,15
f9003d04:	00400713          	li	a4,4
f9003d08:	00e78a63          	beq	a5,a4,f9003d1c <__muldf3+0x5b4>
f9003d0c:	00448793          	addi	a5,s1,4
f9003d10:	0097b4b3          	sltu	s1,a5,s1
f9003d14:	00960633          	add	a2,a2,s1
f9003d18:	00078493          	mv	s1,a5
f9003d1c:	00861793          	slli	a5,a2,0x8
f9003d20:	0607d463          	bgez	a5,f9003d88 <__muldf3+0x620>
f9003d24:	00100793          	li	a5,1
f9003d28:	00000413          	li	s0,0
f9003d2c:	00000493          	li	s1,0
f9003d30:	b49ff06f          	j	f9003878 <__muldf3+0x110>
f9003d34:	03800793          	li	a5,56
f9003d38:	bac7cce3          	blt	a5,a2,f90038f0 <__muldf3+0x188>
f9003d3c:	01f00793          	li	a5,31
f9003d40:	f8c7dce3          	bge	a5,a2,f9003cd8 <__muldf3+0x570>
f9003d44:	fe100793          	li	a5,-31
f9003d48:	40e78733          	sub	a4,a5,a4
f9003d4c:	02000793          	li	a5,32
f9003d50:	00e45733          	srl	a4,s0,a4
f9003d54:	00f60863          	beq	a2,a5,f9003d64 <__muldf3+0x5fc>
f9003d58:	43eb0793          	addi	a5,s6,1086
f9003d5c:	00f417b3          	sll	a5,s0,a5
f9003d60:	00f4e4b3          	or	s1,s1,a5
f9003d64:	009034b3          	snez	s1,s1
f9003d68:	00e4e4b3          	or	s1,s1,a4
f9003d6c:	0074f613          	andi	a2,s1,7
f9003d70:	00000413          	li	s0,0
f9003d74:	02060063          	beqz	a2,f9003d94 <__muldf3+0x62c>
f9003d78:	00f4f793          	andi	a5,s1,15
f9003d7c:	00400713          	li	a4,4
f9003d80:	00000613          	li	a2,0
f9003d84:	f8e794e3          	bne	a5,a4,f9003d0c <__muldf3+0x5a4>
f9003d88:	00961413          	slli	s0,a2,0x9
f9003d8c:	00c45413          	srli	s0,s0,0xc
f9003d90:	01d61613          	slli	a2,a2,0x1d
f9003d94:	0034d493          	srli	s1,s1,0x3
f9003d98:	00c4e4b3          	or	s1,s1,a2
f9003d9c:	00000793          	li	a5,0
f9003da0:	ad9ff06f          	j	f9003878 <__muldf3+0x110>
f9003da4:	7ff00793          	li	a5,2047
f9003da8:	00000413          	li	s0,0
f9003dac:	00000493          	li	s1,0
f9003db0:	ac9ff06f          	j	f9003878 <__muldf3+0x110>
f9003db4:	00060b13          	mv	s6,a2
f9003db8:	e51ff06f          	j	f9003c08 <__muldf3+0x4a0>

f9003dbc <__subdf3>:
f9003dbc:	00100737          	lui	a4,0x100
f9003dc0:	fff70713          	addi	a4,a4,-1 # fffff <__stack_size+0xfdfff>
f9003dc4:	fe010113          	addi	sp,sp,-32
f9003dc8:	00b77333          	and	t1,a4,a1
f9003dcc:	0146d893          	srli	a7,a3,0x14
f9003dd0:	00d77733          	and	a4,a4,a3
f9003dd4:	01d65e93          	srli	t4,a2,0x1d
f9003dd8:	00812c23          	sw	s0,24(sp)
f9003ddc:	00912a23          	sw	s1,20(sp)
f9003de0:	00331313          	slli	t1,t1,0x3
f9003de4:	0145d493          	srli	s1,a1,0x14
f9003de8:	01d55793          	srli	a5,a0,0x1d
f9003dec:	00371713          	slli	a4,a4,0x3
f9003df0:	00112e23          	sw	ra,28(sp)
f9003df4:	01212823          	sw	s2,16(sp)
f9003df8:	01312623          	sw	s3,12(sp)
f9003dfc:	7ff8f893          	andi	a7,a7,2047
f9003e00:	7ff00e13          	li	t3,2047
f9003e04:	00eee733          	or	a4,t4,a4
f9003e08:	7ff4f493          	andi	s1,s1,2047
f9003e0c:	01f5d413          	srli	s0,a1,0x1f
f9003e10:	0067e333          	or	t1,a5,t1
f9003e14:	00351f13          	slli	t5,a0,0x3
f9003e18:	01f6d693          	srli	a3,a3,0x1f
f9003e1c:	00361e93          	slli	t4,a2,0x3
f9003e20:	1dc88663          	beq	a7,t3,f9003fec <__subdf3+0x230>
f9003e24:	0016c693          	xori	a3,a3,1
f9003e28:	411485b3          	sub	a1,s1,a7
f9003e2c:	16d40863          	beq	s0,a3,f9003f9c <__subdf3+0x1e0>
f9003e30:	1cb05863          	blez	a1,f9004000 <__subdf3+0x244>
f9003e34:	20088463          	beqz	a7,f900403c <__subdf3+0x280>
f9003e38:	008007b7          	lui	a5,0x800
f9003e3c:	00f76733          	or	a4,a4,a5
f9003e40:	67c48a63          	beq	s1,t3,f90044b4 <__subdf3+0x6f8>
f9003e44:	03800793          	li	a5,56
f9003e48:	3eb7c263          	blt	a5,a1,f900422c <__subdf3+0x470>
f9003e4c:	01f00793          	li	a5,31
f9003e50:	54b7ca63          	blt	a5,a1,f90043a4 <__subdf3+0x5e8>
f9003e54:	02000793          	li	a5,32
f9003e58:	40b787b3          	sub	a5,a5,a1
f9003e5c:	00bed9b3          	srl	s3,t4,a1
f9003e60:	00f71833          	sll	a6,a4,a5
f9003e64:	00fe9eb3          	sll	t4,t4,a5
f9003e68:	01386833          	or	a6,a6,s3
f9003e6c:	00b75733          	srl	a4,a4,a1
f9003e70:	01d039b3          	snez	s3,t4
f9003e74:	01386833          	or	a6,a6,s3
f9003e78:	40e30333          	sub	t1,t1,a4
f9003e7c:	410f09b3          	sub	s3,t5,a6
f9003e80:	013f37b3          	sltu	a5,t5,s3
f9003e84:	40f30633          	sub	a2,t1,a5
f9003e88:	00861793          	slli	a5,a2,0x8
f9003e8c:	2a07d863          	bgez	a5,f900413c <__subdf3+0x380>
f9003e90:	00800937          	lui	s2,0x800
f9003e94:	fff90913          	addi	s2,s2,-1 # 7fffff <__stack_size+0x7fdfff>
f9003e98:	01267933          	and	s2,a2,s2
f9003e9c:	36090663          	beqz	s2,f9004208 <__subdf3+0x44c>
f9003ea0:	00090513          	mv	a0,s2
f9003ea4:	1e5000ef          	jal	ra,f9004888 <__clzsi2>
f9003ea8:	ff850713          	addi	a4,a0,-8
f9003eac:	02000793          	li	a5,32
f9003eb0:	40e787b3          	sub	a5,a5,a4
f9003eb4:	00f9d7b3          	srl	a5,s3,a5
f9003eb8:	00e91633          	sll	a2,s2,a4
f9003ebc:	00c7e7b3          	or	a5,a5,a2
f9003ec0:	00e999b3          	sll	s3,s3,a4
f9003ec4:	32974463          	blt	a4,s1,f90041ec <__subdf3+0x430>
f9003ec8:	40970733          	sub	a4,a4,s1
f9003ecc:	00170613          	addi	a2,a4,1
f9003ed0:	01f00693          	li	a3,31
f9003ed4:	44c6ca63          	blt	a3,a2,f9004328 <__subdf3+0x56c>
f9003ed8:	02000713          	li	a4,32
f9003edc:	40c70733          	sub	a4,a4,a2
f9003ee0:	00c9d6b3          	srl	a3,s3,a2
f9003ee4:	00e99833          	sll	a6,s3,a4
f9003ee8:	00e79733          	sll	a4,a5,a4
f9003eec:	00d76733          	or	a4,a4,a3
f9003ef0:	01003833          	snez	a6,a6
f9003ef4:	010769b3          	or	s3,a4,a6
f9003ef8:	00c7d633          	srl	a2,a5,a2
f9003efc:	00000493          	li	s1,0
f9003f00:	0079f793          	andi	a5,s3,7
f9003f04:	02078063          	beqz	a5,f9003f24 <__subdf3+0x168>
f9003f08:	00f9f693          	andi	a3,s3,15
f9003f0c:	00400793          	li	a5,4
f9003f10:	00f68a63          	beq	a3,a5,f9003f24 <__subdf3+0x168>
f9003f14:	00498693          	addi	a3,s3,4
f9003f18:	0136b833          	sltu	a6,a3,s3
f9003f1c:	01060633          	add	a2,a2,a6
f9003f20:	00068993          	mv	s3,a3
f9003f24:	00861793          	slli	a5,a2,0x8
f9003f28:	2007de63          	bgez	a5,f9004144 <__subdf3+0x388>
f9003f2c:	00148713          	addi	a4,s1,1
f9003f30:	7ff00793          	li	a5,2047
f9003f34:	00147413          	andi	s0,s0,1
f9003f38:	26f70463          	beq	a4,a5,f90041a0 <__subdf3+0x3e4>
f9003f3c:	ff8007b7          	lui	a5,0xff800
f9003f40:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0x67f67bf>
f9003f44:	00f677b3          	and	a5,a2,a5
f9003f48:	01d79813          	slli	a6,a5,0x1d
f9003f4c:	0039d993          	srli	s3,s3,0x3
f9003f50:	00979793          	slli	a5,a5,0x9
f9003f54:	01386833          	or	a6,a6,s3
f9003f58:	00c7d793          	srli	a5,a5,0xc
f9003f5c:	7ff77713          	andi	a4,a4,2047
f9003f60:	00c79693          	slli	a3,a5,0xc
f9003f64:	01471713          	slli	a4,a4,0x14
f9003f68:	00c6d693          	srli	a3,a3,0xc
f9003f6c:	01f41413          	slli	s0,s0,0x1f
f9003f70:	00e6e6b3          	or	a3,a3,a4
f9003f74:	0086e6b3          	or	a3,a3,s0
f9003f78:	01c12083          	lw	ra,28(sp)
f9003f7c:	01812403          	lw	s0,24(sp)
f9003f80:	01412483          	lw	s1,20(sp)
f9003f84:	01012903          	lw	s2,16(sp)
f9003f88:	00c12983          	lw	s3,12(sp)
f9003f8c:	00080513          	mv	a0,a6
f9003f90:	00068593          	mv	a1,a3
f9003f94:	02010113          	addi	sp,sp,32
f9003f98:	00008067          	ret
f9003f9c:	0ab05e63          	blez	a1,f9004058 <__subdf3+0x29c>
f9003fa0:	14088a63          	beqz	a7,f90040f4 <__subdf3+0x338>
f9003fa4:	008007b7          	lui	a5,0x800
f9003fa8:	00f76733          	or	a4,a4,a5
f9003fac:	33c48c63          	beq	s1,t3,f90042e4 <__subdf3+0x528>
f9003fb0:	03800793          	li	a5,56
f9003fb4:	1cb7c063          	blt	a5,a1,f9004174 <__subdf3+0x3b8>
f9003fb8:	01f00793          	li	a5,31
f9003fbc:	44b7da63          	bge	a5,a1,f9004410 <__subdf3+0x654>
f9003fc0:	fe058813          	addi	a6,a1,-32
f9003fc4:	02000793          	li	a5,32
f9003fc8:	010759b3          	srl	s3,a4,a6
f9003fcc:	00f58a63          	beq	a1,a5,f9003fe0 <__subdf3+0x224>
f9003fd0:	04000793          	li	a5,64
f9003fd4:	40b785b3          	sub	a1,a5,a1
f9003fd8:	00b71733          	sll	a4,a4,a1
f9003fdc:	00eeeeb3          	or	t4,t4,a4
f9003fe0:	01d03833          	snez	a6,t4
f9003fe4:	01386833          	or	a6,a6,s3
f9003fe8:	1940006f          	j	f900417c <__subdf3+0x3c0>
f9003fec:	01d767b3          	or	a5,a4,t4
f9003ff0:	80148593          	addi	a1,s1,-2047
f9003ff4:	00079463          	bnez	a5,f9003ffc <__subdf3+0x240>
f9003ff8:	0016c693          	xori	a3,a3,1
f9003ffc:	04d40e63          	beq	s0,a3,f9004058 <__subdf3+0x29c>
f9004000:	08059a63          	bnez	a1,f9004094 <__subdf3+0x2d8>
f9004004:	00148793          	addi	a5,s1,1
f9004008:	7fe7f793          	andi	a5,a5,2046
f900400c:	24079263          	bnez	a5,f9004250 <__subdf3+0x494>
f9004010:	01e367b3          	or	a5,t1,t5
f9004014:	01d76833          	or	a6,a4,t4
f9004018:	18049c63          	bnez	s1,f90041b0 <__subdf3+0x3f4>
f900401c:	46078063          	beqz	a5,f900447c <__subdf3+0x6c0>
f9004020:	4c081e63          	bnez	a6,f90044fc <__subdf3+0x740>
f9004024:	00351813          	slli	a6,a0,0x3
f9004028:	01d31693          	slli	a3,t1,0x1d
f900402c:	00385813          	srli	a6,a6,0x3
f9004030:	0106e833          	or	a6,a3,a6
f9004034:	00335793          	srli	a5,t1,0x3
f9004038:	1280006f          	j	f9004160 <__subdf3+0x3a4>
f900403c:	01d767b3          	or	a5,a4,t4
f9004040:	1e078c63          	beqz	a5,f9004238 <__subdf3+0x47c>
f9004044:	fff58793          	addi	a5,a1,-1
f9004048:	44078a63          	beqz	a5,f900449c <__subdf3+0x6e0>
f900404c:	29c58c63          	beq	a1,t3,f90042e4 <__subdf3+0x528>
f9004050:	00078593          	mv	a1,a5
f9004054:	df1ff06f          	j	f9003e44 <__subdf3+0x88>
f9004058:	22059263          	bnez	a1,f900427c <__subdf3+0x4c0>
f900405c:	00148693          	addi	a3,s1,1
f9004060:	7fe6f793          	andi	a5,a3,2046
f9004064:	0a079663          	bnez	a5,f9004110 <__subdf3+0x354>
f9004068:	01e367b3          	or	a5,t1,t5
f900406c:	3e049663          	bnez	s1,f9004458 <__subdf3+0x69c>
f9004070:	50078863          	beqz	a5,f9004580 <__subdf3+0x7c4>
f9004074:	01d767b3          	or	a5,a4,t4
f9004078:	52079063          	bnez	a5,f9004598 <__subdf3+0x7dc>
f900407c:	00351513          	slli	a0,a0,0x3
f9004080:	01d31813          	slli	a6,t1,0x1d
f9004084:	00355513          	srli	a0,a0,0x3
f9004088:	00a86833          	or	a6,a6,a0
f900408c:	00335793          	srli	a5,t1,0x3
f9004090:	0d00006f          	j	f9004160 <__subdf3+0x3a4>
f9004094:	409885b3          	sub	a1,a7,s1
f9004098:	26049263          	bnez	s1,f90042fc <__subdf3+0x540>
f900409c:	01e367b3          	or	a5,t1,t5
f90040a0:	38078e63          	beqz	a5,f900443c <__subdf3+0x680>
f90040a4:	fff58793          	addi	a5,a1,-1
f90040a8:	4a078e63          	beqz	a5,f9004564 <__subdf3+0x7a8>
f90040ac:	7ff00513          	li	a0,2047
f90040b0:	24a58e63          	beq	a1,a0,f900430c <__subdf3+0x550>
f90040b4:	00078593          	mv	a1,a5
f90040b8:	03800793          	li	a5,56
f90040bc:	30b7ca63          	blt	a5,a1,f90043d0 <__subdf3+0x614>
f90040c0:	01f00793          	li	a5,31
f90040c4:	46b7ca63          	blt	a5,a1,f9004538 <__subdf3+0x77c>
f90040c8:	02000793          	li	a5,32
f90040cc:	40b787b3          	sub	a5,a5,a1
f90040d0:	00f31833          	sll	a6,t1,a5
f90040d4:	00bf5633          	srl	a2,t5,a1
f90040d8:	00ff17b3          	sll	a5,t5,a5
f90040dc:	00c86833          	or	a6,a6,a2
f90040e0:	00f039b3          	snez	s3,a5
f90040e4:	00b35333          	srl	t1,t1,a1
f90040e8:	01386833          	or	a6,a6,s3
f90040ec:	40670733          	sub	a4,a4,t1
f90040f0:	2e80006f          	j	f90043d8 <__subdf3+0x61c>
f90040f4:	01d767b3          	or	a5,a4,t4
f90040f8:	14078063          	beqz	a5,f9004238 <__subdf3+0x47c>
f90040fc:	fff58793          	addi	a5,a1,-1
f9004100:	24078e63          	beqz	a5,f900435c <__subdf3+0x5a0>
f9004104:	37c58063          	beq	a1,t3,f9004464 <__subdf3+0x6a8>
f9004108:	00078593          	mv	a1,a5
f900410c:	ea5ff06f          	j	f9003fb0 <__subdf3+0x1f4>
f9004110:	7ff00793          	li	a5,2047
f9004114:	08f68463          	beq	a3,a5,f900419c <__subdf3+0x3e0>
f9004118:	01df0eb3          	add	t4,t5,t4
f900411c:	01eeb633          	sltu	a2,t4,t5
f9004120:	00e307b3          	add	a5,t1,a4
f9004124:	00c787b3          	add	a5,a5,a2
f9004128:	01f79813          	slli	a6,a5,0x1f
f900412c:	001ede93          	srli	t4,t4,0x1
f9004130:	01d869b3          	or	s3,a6,t4
f9004134:	0017d613          	srli	a2,a5,0x1
f9004138:	00068493          	mv	s1,a3
f900413c:	0079f793          	andi	a5,s3,7
f9004140:	dc0794e3          	bnez	a5,f9003f08 <__subdf3+0x14c>
f9004144:	01d61793          	slli	a5,a2,0x1d
f9004148:	0039d813          	srli	a6,s3,0x3
f900414c:	00f86833          	or	a6,a6,a5
f9004150:	00048593          	mv	a1,s1
f9004154:	00365793          	srli	a5,a2,0x3
f9004158:	7ff00713          	li	a4,2047
f900415c:	06e58a63          	beq	a1,a4,f90041d0 <__subdf3+0x414>
f9004160:	00c79793          	slli	a5,a5,0xc
f9004164:	00c7d793          	srli	a5,a5,0xc
f9004168:	7ff5f713          	andi	a4,a1,2047
f900416c:	00147413          	andi	s0,s0,1
f9004170:	df1ff06f          	j	f9003f60 <__subdf3+0x1a4>
f9004174:	01d76733          	or	a4,a4,t4
f9004178:	00e03833          	snez	a6,a4
f900417c:	01e809b3          	add	s3,a6,t5
f9004180:	01e9b7b3          	sltu	a5,s3,t5
f9004184:	00678633          	add	a2,a5,t1
f9004188:	00861793          	slli	a5,a2,0x8
f900418c:	fa07d8e3          	bgez	a5,f900413c <__subdf3+0x380>
f9004190:	00148493          	addi	s1,s1,1
f9004194:	7ff00793          	li	a5,2047
f9004198:	1ef49263          	bne	s1,a5,f900437c <__subdf3+0x5c0>
f900419c:	00147413          	andi	s0,s0,1
f90041a0:	7ff00713          	li	a4,2047
f90041a4:	00000793          	li	a5,0
f90041a8:	00000813          	li	a6,0
f90041ac:	db5ff06f          	j	f9003f60 <__subdf3+0x1a4>
f90041b0:	12079863          	bnez	a5,f90042e0 <__subdf3+0x524>
f90041b4:	46080063          	beqz	a6,f9004614 <__subdf3+0x858>
f90041b8:	00361813          	slli	a6,a2,0x3
f90041bc:	01d71793          	slli	a5,a4,0x1d
f90041c0:	00385813          	srli	a6,a6,0x3
f90041c4:	00f86833          	or	a6,a6,a5
f90041c8:	00068413          	mv	s0,a3
f90041cc:	00375793          	srli	a5,a4,0x3
f90041d0:	00f867b3          	or	a5,a6,a5
f90041d4:	fc0784e3          	beqz	a5,f900419c <__subdf3+0x3e0>
f90041d8:	00000413          	li	s0,0
f90041dc:	7ff00713          	li	a4,2047
f90041e0:	000807b7          	lui	a5,0x80
f90041e4:	00000813          	li	a6,0
f90041e8:	d79ff06f          	j	f9003f60 <__subdf3+0x1a4>
f90041ec:	ff800637          	lui	a2,0xff800
f90041f0:	fff60613          	addi	a2,a2,-1 # ff7fffff <__freertos_irq_stack_top+0x67f67bf>
f90041f4:	00c7f633          	and	a2,a5,a2
f90041f8:	0079f793          	andi	a5,s3,7
f90041fc:	40e484b3          	sub	s1,s1,a4
f9004200:	d00794e3          	bnez	a5,f9003f08 <__subdf3+0x14c>
f9004204:	f41ff06f          	j	f9004144 <__subdf3+0x388>
f9004208:	00098513          	mv	a0,s3
f900420c:	67c000ef          	jal	ra,f9004888 <__clzsi2>
f9004210:	01850713          	addi	a4,a0,24
f9004214:	01f00793          	li	a5,31
f9004218:	c8e7dae3          	bge	a5,a4,f9003eac <__subdf3+0xf0>
f900421c:	ff850613          	addi	a2,a0,-8
f9004220:	00c997b3          	sll	a5,s3,a2
f9004224:	00000993          	li	s3,0
f9004228:	c9dff06f          	j	f9003ec4 <__subdf3+0x108>
f900422c:	01d76833          	or	a6,a4,t4
f9004230:	01003833          	snez	a6,a6
f9004234:	c49ff06f          	j	f9003e7c <__subdf3+0xc0>
f9004238:	00351813          	slli	a6,a0,0x3
f900423c:	01d31793          	slli	a5,t1,0x1d
f9004240:	00385813          	srli	a6,a6,0x3
f9004244:	00f86833          	or	a6,a6,a5
f9004248:	00335793          	srli	a5,t1,0x3
f900424c:	f0dff06f          	j	f9004158 <__subdf3+0x39c>
f9004250:	41df09b3          	sub	s3,t5,t4
f9004254:	40e30933          	sub	s2,t1,a4
f9004258:	013f3633          	sltu	a2,t5,s3
f900425c:	40c90933          	sub	s2,s2,a2
f9004260:	00891793          	slli	a5,s2,0x8
f9004264:	2607c463          	bltz	a5,f90044cc <__subdf3+0x710>
f9004268:	0129e833          	or	a6,s3,s2
f900426c:	c20818e3          	bnez	a6,f9003e9c <__subdf3+0xe0>
f9004270:	00000793          	li	a5,0
f9004274:	00000413          	li	s0,0
f9004278:	ee9ff06f          	j	f9004160 <__subdf3+0x3a4>
f900427c:	409885b3          	sub	a1,a7,s1
f9004280:	16048863          	beqz	s1,f90043f0 <__subdf3+0x634>
f9004284:	008006b7          	lui	a3,0x800
f9004288:	7ff00793          	li	a5,2047
f900428c:	00d36333          	or	t1,t1,a3
f9004290:	24f88a63          	beq	a7,a5,f90044e4 <__subdf3+0x728>
f9004294:	03800793          	li	a5,56
f9004298:	28b7ca63          	blt	a5,a1,f900452c <__subdf3+0x770>
f900429c:	01f00793          	li	a5,31
f90042a0:	34b7c463          	blt	a5,a1,f90045e8 <__subdf3+0x82c>
f90042a4:	02000793          	li	a5,32
f90042a8:	40b787b3          	sub	a5,a5,a1
f90042ac:	00f31833          	sll	a6,t1,a5
f90042b0:	00bf56b3          	srl	a3,t5,a1
f90042b4:	00ff17b3          	sll	a5,t5,a5
f90042b8:	00d86833          	or	a6,a6,a3
f90042bc:	00f039b3          	snez	s3,a5
f90042c0:	00b35333          	srl	t1,t1,a1
f90042c4:	01386833          	or	a6,a6,s3
f90042c8:	00670733          	add	a4,a4,t1
f90042cc:	01d809b3          	add	s3,a6,t4
f90042d0:	01d9b7b3          	sltu	a5,s3,t4
f90042d4:	00e78633          	add	a2,a5,a4
f90042d8:	00088493          	mv	s1,a7
f90042dc:	eadff06f          	j	f9004188 <__subdf3+0x3cc>
f90042e0:	ee081ce3          	bnez	a6,f90041d8 <__subdf3+0x41c>
f90042e4:	00351813          	slli	a6,a0,0x3
f90042e8:	01d31793          	slli	a5,t1,0x1d
f90042ec:	00385813          	srli	a6,a6,0x3
f90042f0:	00f86833          	or	a6,a6,a5
f90042f4:	00335793          	srli	a5,t1,0x3
f90042f8:	ed9ff06f          	j	f90041d0 <__subdf3+0x414>
f90042fc:	00800537          	lui	a0,0x800
f9004300:	7ff00793          	li	a5,2047
f9004304:	00a36333          	or	t1,t1,a0
f9004308:	daf898e3          	bne	a7,a5,f90040b8 <__subdf3+0x2fc>
f900430c:	00361613          	slli	a2,a2,0x3
f9004310:	01d71813          	slli	a6,a4,0x1d
f9004314:	00365613          	srli	a2,a2,0x3
f9004318:	00c86833          	or	a6,a6,a2
f900431c:	00375793          	srli	a5,a4,0x3
f9004320:	00068413          	mv	s0,a3
f9004324:	eadff06f          	j	f90041d0 <__subdf3+0x414>
f9004328:	fe170713          	addi	a4,a4,-31
f900432c:	02000693          	li	a3,32
f9004330:	00e7d733          	srl	a4,a5,a4
f9004334:	00d60a63          	beq	a2,a3,f9004348 <__subdf3+0x58c>
f9004338:	04000693          	li	a3,64
f900433c:	40c68633          	sub	a2,a3,a2
f9004340:	00c79633          	sll	a2,a5,a2
f9004344:	00c9e9b3          	or	s3,s3,a2
f9004348:	01303833          	snez	a6,s3
f900434c:	00e869b3          	or	s3,a6,a4
f9004350:	00000613          	li	a2,0
f9004354:	00000493          	li	s1,0
f9004358:	de5ff06f          	j	f900413c <__subdf3+0x380>
f900435c:	01df09b3          	add	s3,t5,t4
f9004360:	00e307b3          	add	a5,t1,a4
f9004364:	01e9bf33          	sltu	t5,s3,t5
f9004368:	01e78633          	add	a2,a5,t5
f900436c:	00861793          	slli	a5,a2,0x8
f9004370:	00100493          	li	s1,1
f9004374:	dc07d4e3          	bgez	a5,f900413c <__subdf3+0x380>
f9004378:	00200493          	li	s1,2
f900437c:	ff8007b7          	lui	a5,0xff800
f9004380:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0x67f67bf>
f9004384:	00f677b3          	and	a5,a2,a5
f9004388:	0019d713          	srli	a4,s3,0x1
f900438c:	0019f813          	andi	a6,s3,1
f9004390:	01076833          	or	a6,a4,a6
f9004394:	01f79993          	slli	s3,a5,0x1f
f9004398:	0109e9b3          	or	s3,s3,a6
f900439c:	0017d613          	srli	a2,a5,0x1
f90043a0:	b61ff06f          	j	f9003f00 <__subdf3+0x144>
f90043a4:	fe058813          	addi	a6,a1,-32
f90043a8:	02000793          	li	a5,32
f90043ac:	010759b3          	srl	s3,a4,a6
f90043b0:	00f58a63          	beq	a1,a5,f90043c4 <__subdf3+0x608>
f90043b4:	04000793          	li	a5,64
f90043b8:	40b785b3          	sub	a1,a5,a1
f90043bc:	00b71733          	sll	a4,a4,a1
f90043c0:	00eeeeb3          	or	t4,t4,a4
f90043c4:	01d03833          	snez	a6,t4
f90043c8:	01386833          	or	a6,a6,s3
f90043cc:	ab1ff06f          	j	f9003e7c <__subdf3+0xc0>
f90043d0:	01e36333          	or	t1,t1,t5
f90043d4:	00603833          	snez	a6,t1
f90043d8:	410e89b3          	sub	s3,t4,a6
f90043dc:	013eb7b3          	sltu	a5,t4,s3
f90043e0:	40f70633          	sub	a2,a4,a5
f90043e4:	00088493          	mv	s1,a7
f90043e8:	00068413          	mv	s0,a3
f90043ec:	a9dff06f          	j	f9003e88 <__subdf3+0xcc>
f90043f0:	01e367b3          	or	a5,t1,t5
f90043f4:	1c078863          	beqz	a5,f90045c4 <__subdf3+0x808>
f90043f8:	fff58793          	addi	a5,a1,-1
f90043fc:	22078463          	beqz	a5,f9004624 <__subdf3+0x868>
f9004400:	7ff00693          	li	a3,2047
f9004404:	0ed58063          	beq	a1,a3,f90044e4 <__subdf3+0x728>
f9004408:	00078593          	mv	a1,a5
f900440c:	e89ff06f          	j	f9004294 <__subdf3+0x4d8>
f9004410:	02000793          	li	a5,32
f9004414:	40b787b3          	sub	a5,a5,a1
f9004418:	00bed9b3          	srl	s3,t4,a1
f900441c:	00f71833          	sll	a6,a4,a5
f9004420:	00fe9eb3          	sll	t4,t4,a5
f9004424:	01386833          	or	a6,a6,s3
f9004428:	00b75733          	srl	a4,a4,a1
f900442c:	01d039b3          	snez	s3,t4
f9004430:	01386833          	or	a6,a6,s3
f9004434:	00e30333          	add	t1,t1,a4
f9004438:	d45ff06f          	j	f900417c <__subdf3+0x3c0>
f900443c:	00361813          	slli	a6,a2,0x3
f9004440:	01d71793          	slli	a5,a4,0x1d
f9004444:	00385813          	srli	a6,a6,0x3
f9004448:	0107e833          	or	a6,a5,a6
f900444c:	00068413          	mv	s0,a3
f9004450:	00375793          	srli	a5,a4,0x3
f9004454:	d05ff06f          	j	f9004158 <__subdf3+0x39c>
f9004458:	08078663          	beqz	a5,f90044e4 <__subdf3+0x728>
f900445c:	01d76733          	or	a4,a4,t4
f9004460:	d6071ce3          	bnez	a4,f90041d8 <__subdf3+0x41c>
f9004464:	00351513          	slli	a0,a0,0x3
f9004468:	01d31813          	slli	a6,t1,0x1d
f900446c:	00355513          	srli	a0,a0,0x3
f9004470:	00a86833          	or	a6,a6,a0
f9004474:	00335793          	srli	a5,t1,0x3
f9004478:	d59ff06f          	j	f90041d0 <__subdf3+0x414>
f900447c:	de080ae3          	beqz	a6,f9004270 <__subdf3+0x4b4>
f9004480:	00361813          	slli	a6,a2,0x3
f9004484:	01d71793          	slli	a5,a4,0x1d
f9004488:	00385813          	srli	a6,a6,0x3
f900448c:	00f86833          	or	a6,a6,a5
f9004490:	00068413          	mv	s0,a3
f9004494:	00375793          	srli	a5,a4,0x3
f9004498:	cc9ff06f          	j	f9004160 <__subdf3+0x3a4>
f900449c:	41df09b3          	sub	s3,t5,t4
f90044a0:	40e307b3          	sub	a5,t1,a4
f90044a4:	013f3f33          	sltu	t5,t5,s3
f90044a8:	41e78633          	sub	a2,a5,t5
f90044ac:	00100493          	li	s1,1
f90044b0:	9d9ff06f          	j	f9003e88 <__subdf3+0xcc>
f90044b4:	00351813          	slli	a6,a0,0x3
f90044b8:	01d31693          	slli	a3,t1,0x1d
f90044bc:	00385813          	srli	a6,a6,0x3
f90044c0:	0106e833          	or	a6,a3,a6
f90044c4:	00335793          	srli	a5,t1,0x3
f90044c8:	d09ff06f          	j	f90041d0 <__subdf3+0x414>
f90044cc:	41ee89b3          	sub	s3,t4,t5
f90044d0:	40670633          	sub	a2,a4,t1
f90044d4:	013eb933          	sltu	s2,t4,s3
f90044d8:	41260933          	sub	s2,a2,s2
f90044dc:	00068413          	mv	s0,a3
f90044e0:	9bdff06f          	j	f9003e9c <__subdf3+0xe0>
f90044e4:	00361613          	slli	a2,a2,0x3
f90044e8:	01d71813          	slli	a6,a4,0x1d
f90044ec:	00365613          	srli	a2,a2,0x3
f90044f0:	00c86833          	or	a6,a6,a2
f90044f4:	00375793          	srli	a5,a4,0x3
f90044f8:	cd9ff06f          	j	f90041d0 <__subdf3+0x414>
f90044fc:	41df09b3          	sub	s3,t5,t4
f9004500:	40e307b3          	sub	a5,t1,a4
f9004504:	013f3633          	sltu	a2,t5,s3
f9004508:	40c78633          	sub	a2,a5,a2
f900450c:	00861793          	slli	a5,a2,0x8
f9004510:	0c07d663          	bgez	a5,f90045dc <__subdf3+0x820>
f9004514:	41ee89b3          	sub	s3,t4,t5
f9004518:	406707b3          	sub	a5,a4,t1
f900451c:	013ebeb3          	sltu	t4,t4,s3
f9004520:	41d78633          	sub	a2,a5,t4
f9004524:	00068413          	mv	s0,a3
f9004528:	9d9ff06f          	j	f9003f00 <__subdf3+0x144>
f900452c:	01e36333          	or	t1,t1,t5
f9004530:	00603833          	snez	a6,t1
f9004534:	d99ff06f          	j	f90042cc <__subdf3+0x510>
f9004538:	fe058813          	addi	a6,a1,-32
f900453c:	02000793          	li	a5,32
f9004540:	010359b3          	srl	s3,t1,a6
f9004544:	00f58a63          	beq	a1,a5,f9004558 <__subdf3+0x79c>
f9004548:	04000793          	li	a5,64
f900454c:	40b785b3          	sub	a1,a5,a1
f9004550:	00b31333          	sll	t1,t1,a1
f9004554:	006f6f33          	or	t5,t5,t1
f9004558:	01e03833          	snez	a6,t5
f900455c:	01386833          	or	a6,a6,s3
f9004560:	e79ff06f          	j	f90043d8 <__subdf3+0x61c>
f9004564:	41ee89b3          	sub	s3,t4,t5
f9004568:	406707b3          	sub	a5,a4,t1
f900456c:	013ebeb3          	sltu	t4,t4,s3
f9004570:	41d78633          	sub	a2,a5,t4
f9004574:	00068413          	mv	s0,a3
f9004578:	00100493          	li	s1,1
f900457c:	90dff06f          	j	f9003e88 <__subdf3+0xcc>
f9004580:	00361813          	slli	a6,a2,0x3
f9004584:	01d71793          	slli	a5,a4,0x1d
f9004588:	00385813          	srli	a6,a6,0x3
f900458c:	00f86833          	or	a6,a6,a5
f9004590:	00375793          	srli	a5,a4,0x3
f9004594:	bcdff06f          	j	f9004160 <__subdf3+0x3a4>
f9004598:	01df09b3          	add	s3,t5,t4
f900459c:	00e307b3          	add	a5,t1,a4
f90045a0:	01e9bf33          	sltu	t5,s3,t5
f90045a4:	01e78633          	add	a2,a5,t5
f90045a8:	00861793          	slli	a5,a2,0x8
f90045ac:	b807d8e3          	bgez	a5,f900413c <__subdf3+0x380>
f90045b0:	ff8007b7          	lui	a5,0xff800
f90045b4:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0x67f67bf>
f90045b8:	00f67633          	and	a2,a2,a5
f90045bc:	00100493          	li	s1,1
f90045c0:	b7dff06f          	j	f900413c <__subdf3+0x380>
f90045c4:	00361613          	slli	a2,a2,0x3
f90045c8:	01d71813          	slli	a6,a4,0x1d
f90045cc:	00365613          	srli	a2,a2,0x3
f90045d0:	00c86833          	or	a6,a6,a2
f90045d4:	00375793          	srli	a5,a4,0x3
f90045d8:	b81ff06f          	j	f9004158 <__subdf3+0x39c>
f90045dc:	00c9e833          	or	a6,s3,a2
f90045e0:	c80808e3          	beqz	a6,f9004270 <__subdf3+0x4b4>
f90045e4:	b59ff06f          	j	f900413c <__subdf3+0x380>
f90045e8:	fe058813          	addi	a6,a1,-32
f90045ec:	02000793          	li	a5,32
f90045f0:	010359b3          	srl	s3,t1,a6
f90045f4:	00f58a63          	beq	a1,a5,f9004608 <__subdf3+0x84c>
f90045f8:	04000793          	li	a5,64
f90045fc:	40b785b3          	sub	a1,a5,a1
f9004600:	00b31333          	sll	t1,t1,a1
f9004604:	006f6f33          	or	t5,t5,t1
f9004608:	01e03833          	snez	a6,t5
f900460c:	01386833          	or	a6,a6,s3
f9004610:	cbdff06f          	j	f90042cc <__subdf3+0x510>
f9004614:	00000413          	li	s0,0
f9004618:	7ff00713          	li	a4,2047
f900461c:	000807b7          	lui	a5,0x80
f9004620:	941ff06f          	j	f9003f60 <__subdf3+0x1a4>
f9004624:	01df09b3          	add	s3,t5,t4
f9004628:	00e307b3          	add	a5,t1,a4
f900462c:	01d9beb3          	sltu	t4,s3,t4
f9004630:	01d78633          	add	a2,a5,t4
f9004634:	d39ff06f          	j	f900436c <__subdf3+0x5b0>

f9004638 <__fixdfsi>:
f9004638:	0145d793          	srli	a5,a1,0x14
f900463c:	001006b7          	lui	a3,0x100
f9004640:	fff68713          	addi	a4,a3,-1 # fffff <__stack_size+0xfdfff>
f9004644:	7ff7f793          	andi	a5,a5,2047
f9004648:	3fe00613          	li	a2,1022
f900464c:	00b77733          	and	a4,a4,a1
f9004650:	01f5d593          	srli	a1,a1,0x1f
f9004654:	00f65e63          	bge	a2,a5,f9004670 <__fixdfsi+0x38>
f9004658:	41d00613          	li	a2,1053
f900465c:	00f65e63          	bge	a2,a5,f9004678 <__fixdfsi+0x40>
f9004660:	80000537          	lui	a0,0x80000
f9004664:	fff54513          	not	a0,a0
f9004668:	00a58533          	add	a0,a1,a0
f900466c:	00008067          	ret
f9004670:	00000513          	li	a0,0
f9004674:	00008067          	ret
f9004678:	43300613          	li	a2,1075
f900467c:	40f60633          	sub	a2,a2,a5
f9004680:	01f00813          	li	a6,31
f9004684:	00d76733          	or	a4,a4,a3
f9004688:	02c85063          	bge	a6,a2,f90046a8 <__fixdfsi+0x70>
f900468c:	41300693          	li	a3,1043
f9004690:	40f687b3          	sub	a5,a3,a5
f9004694:	00f757b3          	srl	a5,a4,a5
f9004698:	40f00533          	neg	a0,a5
f900469c:	fc059ce3          	bnez	a1,f9004674 <__fixdfsi+0x3c>
f90046a0:	00078513          	mv	a0,a5
f90046a4:	00008067          	ret
f90046a8:	bed78793          	addi	a5,a5,-1043 # 7fbed <__stack_size+0x7dbed>
f90046ac:	00f717b3          	sll	a5,a4,a5
f90046b0:	00c55533          	srl	a0,a0,a2
f90046b4:	00a7e7b3          	or	a5,a5,a0
f90046b8:	fe1ff06f          	j	f9004698 <__fixdfsi+0x60>

f90046bc <__fixunsdfsi>:
f90046bc:	0145d793          	srli	a5,a1,0x14
f90046c0:	001006b7          	lui	a3,0x100
f90046c4:	fff68713          	addi	a4,a3,-1 # fffff <__stack_size+0xfdfff>
f90046c8:	7ff7f793          	andi	a5,a5,2047
f90046cc:	3fe00613          	li	a2,1022
f90046d0:	00050813          	mv	a6,a0
f90046d4:	00b77733          	and	a4,a4,a1
f90046d8:	00000513          	li	a0,0
f90046dc:	01f5d593          	srli	a1,a1,0x1f
f90046e0:	00f65663          	bge	a2,a5,f90046ec <__fixunsdfsi+0x30>
f90046e4:	00058663          	beqz	a1,f90046f0 <__fixunsdfsi+0x34>
f90046e8:	00008067          	ret
f90046ec:	00008067          	ret
f90046f0:	41e00613          	li	a2,1054
f90046f4:	fff00513          	li	a0,-1
f90046f8:	fef648e3          	blt	a2,a5,f90046e8 <__fixunsdfsi+0x2c>
f90046fc:	43300513          	li	a0,1075
f9004700:	40f50533          	sub	a0,a0,a5
f9004704:	01f00613          	li	a2,31
f9004708:	00d76733          	or	a4,a4,a3
f900470c:	00a64c63          	blt	a2,a0,f9004724 <__fixunsdfsi+0x68>
f9004710:	bed78793          	addi	a5,a5,-1043
f9004714:	00f71733          	sll	a4,a4,a5
f9004718:	00a85533          	srl	a0,a6,a0
f900471c:	00a76533          	or	a0,a4,a0
f9004720:	00008067          	ret
f9004724:	41300513          	li	a0,1043
f9004728:	40f507b3          	sub	a5,a0,a5
f900472c:	00f75533          	srl	a0,a4,a5
f9004730:	00008067          	ret

f9004734 <__floatsidf>:
f9004734:	ff010113          	addi	sp,sp,-16
f9004738:	00112623          	sw	ra,12(sp)
f900473c:	00812423          	sw	s0,8(sp)
f9004740:	00912223          	sw	s1,4(sp)
f9004744:	04050a63          	beqz	a0,f9004798 <__floatsidf+0x64>
f9004748:	41f55793          	srai	a5,a0,0x1f
f900474c:	00a7c4b3          	xor	s1,a5,a0
f9004750:	40f484b3          	sub	s1,s1,a5
f9004754:	00050413          	mv	s0,a0
f9004758:	00048513          	mv	a0,s1
f900475c:	12c000ef          	jal	ra,f9004888 <__clzsi2>
f9004760:	41e00693          	li	a3,1054
f9004764:	40a686b3          	sub	a3,a3,a0
f9004768:	00a00793          	li	a5,10
f900476c:	01f45413          	srli	s0,s0,0x1f
f9004770:	7ff6f693          	andi	a3,a3,2047
f9004774:	06a7c463          	blt	a5,a0,f90047dc <__floatsidf+0xa8>
f9004778:	00b00713          	li	a4,11
f900477c:	40a70733          	sub	a4,a4,a0
f9004780:	00e4d7b3          	srl	a5,s1,a4
f9004784:	01550513          	addi	a0,a0,21 # 80000015 <__freertos_irq_stack_top+0x86ff67d5>
f9004788:	00c79793          	slli	a5,a5,0xc
f900478c:	00a494b3          	sll	s1,s1,a0
f9004790:	00c7d793          	srli	a5,a5,0xc
f9004794:	0140006f          	j	f90047a8 <__floatsidf+0x74>
f9004798:	00000413          	li	s0,0
f900479c:	00000693          	li	a3,0
f90047a0:	00000793          	li	a5,0
f90047a4:	00000493          	li	s1,0
f90047a8:	00c79793          	slli	a5,a5,0xc
f90047ac:	01469693          	slli	a3,a3,0x14
f90047b0:	00c7d793          	srli	a5,a5,0xc
f90047b4:	01f41413          	slli	s0,s0,0x1f
f90047b8:	00d7e7b3          	or	a5,a5,a3
f90047bc:	0087e7b3          	or	a5,a5,s0
f90047c0:	00c12083          	lw	ra,12(sp)
f90047c4:	00812403          	lw	s0,8(sp)
f90047c8:	00048513          	mv	a0,s1
f90047cc:	00078593          	mv	a1,a5
f90047d0:	00412483          	lw	s1,4(sp)
f90047d4:	01010113          	addi	sp,sp,16
f90047d8:	00008067          	ret
f90047dc:	ff550513          	addi	a0,a0,-11
f90047e0:	00a497b3          	sll	a5,s1,a0
f90047e4:	00c79793          	slli	a5,a5,0xc
f90047e8:	00c7d793          	srli	a5,a5,0xc
f90047ec:	00000493          	li	s1,0
f90047f0:	fb9ff06f          	j	f90047a8 <__floatsidf+0x74>

f90047f4 <__floatunsidf>:
f90047f4:	ff010113          	addi	sp,sp,-16
f90047f8:	00812423          	sw	s0,8(sp)
f90047fc:	00112623          	sw	ra,12(sp)
f9004800:	00050413          	mv	s0,a0
f9004804:	02050e63          	beqz	a0,f9004840 <__floatunsidf+0x4c>
f9004808:	080000ef          	jal	ra,f9004888 <__clzsi2>
f900480c:	41e00713          	li	a4,1054
f9004810:	40a70733          	sub	a4,a4,a0
f9004814:	00a00793          	li	a5,10
f9004818:	7ff77713          	andi	a4,a4,2047
f900481c:	04a7ca63          	blt	a5,a0,f9004870 <__floatunsidf+0x7c>
f9004820:	00b00793          	li	a5,11
f9004824:	40a787b3          	sub	a5,a5,a0
f9004828:	00f457b3          	srl	a5,s0,a5
f900482c:	01550513          	addi	a0,a0,21
f9004830:	00c79793          	slli	a5,a5,0xc
f9004834:	00a41433          	sll	s0,s0,a0
f9004838:	00c7d793          	srli	a5,a5,0xc
f900483c:	00c0006f          	j	f9004848 <__floatunsidf+0x54>
f9004840:	00000713          	li	a4,0
f9004844:	00000793          	li	a5,0
f9004848:	00040513          	mv	a0,s0
f900484c:	00c12083          	lw	ra,12(sp)
f9004850:	00812403          	lw	s0,8(sp)
f9004854:	00c79793          	slli	a5,a5,0xc
f9004858:	01471713          	slli	a4,a4,0x14
f900485c:	00c7d793          	srli	a5,a5,0xc
f9004860:	00e7e7b3          	or	a5,a5,a4
f9004864:	00078593          	mv	a1,a5
f9004868:	01010113          	addi	sp,sp,16
f900486c:	00008067          	ret
f9004870:	ff550513          	addi	a0,a0,-11
f9004874:	00a417b3          	sll	a5,s0,a0
f9004878:	00c79793          	slli	a5,a5,0xc
f900487c:	00c7d793          	srli	a5,a5,0xc
f9004880:	00000413          	li	s0,0
f9004884:	fc5ff06f          	j	f9004848 <__floatunsidf+0x54>

f9004888 <__clzsi2>:
f9004888:	000107b7          	lui	a5,0x10
f900488c:	04f57463          	bgeu	a0,a5,f90048d4 <__clzsi2+0x4c>
f9004890:	0ff00793          	li	a5,255
f9004894:	02000713          	li	a4,32
f9004898:	00a7ee63          	bltu	a5,a0,f90048b4 <__clzsi2+0x2c>
f900489c:	00003797          	auipc	a5,0x3
f90048a0:	ddc78793          	addi	a5,a5,-548 # f9007678 <__clz_tab>
f90048a4:	00a787b3          	add	a5,a5,a0
f90048a8:	0007c503          	lbu	a0,0(a5)
f90048ac:	40a70533          	sub	a0,a4,a0
f90048b0:	00008067          	ret
f90048b4:	00855513          	srli	a0,a0,0x8
f90048b8:	00003797          	auipc	a5,0x3
f90048bc:	dc078793          	addi	a5,a5,-576 # f9007678 <__clz_tab>
f90048c0:	00a787b3          	add	a5,a5,a0
f90048c4:	0007c503          	lbu	a0,0(a5)
f90048c8:	01800713          	li	a4,24
f90048cc:	40a70533          	sub	a0,a4,a0
f90048d0:	00008067          	ret
f90048d4:	010007b7          	lui	a5,0x1000
f90048d8:	02f56263          	bltu	a0,a5,f90048fc <__clzsi2+0x74>
f90048dc:	01855513          	srli	a0,a0,0x18
f90048e0:	00003797          	auipc	a5,0x3
f90048e4:	d9878793          	addi	a5,a5,-616 # f9007678 <__clz_tab>
f90048e8:	00a787b3          	add	a5,a5,a0
f90048ec:	0007c503          	lbu	a0,0(a5)
f90048f0:	00800713          	li	a4,8
f90048f4:	40a70533          	sub	a0,a4,a0
f90048f8:	00008067          	ret
f90048fc:	01055513          	srli	a0,a0,0x10
f9004900:	00003797          	auipc	a5,0x3
f9004904:	d7878793          	addi	a5,a5,-648 # f9007678 <__clz_tab>
f9004908:	00a787b3          	add	a5,a5,a0
f900490c:	0007c503          	lbu	a0,0(a5)
f9004910:	01000713          	li	a4,16
f9004914:	40a70533          	sub	a0,a4,a0
f9004918:	00008067          	ret
