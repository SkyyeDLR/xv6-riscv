
user/_sleep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"

int main (int argc, char *argv[]) {
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
	if (argc != 2) {
   8:	4789                	li	a5,2
   a:	00f50c63          	beq	a0,a5,22 <main+0x22>
		fprintf(2, "Usage: sleep ticks\n");
   e:	00001597          	auipc	a1,0x1
  12:	8f258593          	addi	a1,a1,-1806 # 900 <malloc+0xf6>
  16:	853e                	mv	a0,a5
  18:	70c000ef          	jal	724 <fprintf>
		exit(1);
  1c:	4505                	li	a0,1
  1e:	2ca000ef          	jal	2e8 <exit>
	}
	
	pause(atoi(argv[1]));
  22:	6588                	ld	a0,8(a1)
  24:	19e000ef          	jal	1c2 <atoi>
  28:	350000ef          	jal	378 <pause>
	exit(0);
  2c:	4501                	li	a0,0
  2e:	2ba000ef          	jal	2e8 <exit>

0000000000000032 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  32:	1141                	addi	sp,sp,-16
  34:	e406                	sd	ra,8(sp)
  36:	e022                	sd	s0,0(sp)
  38:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  3a:	fc7ff0ef          	jal	0 <main>
  exit(r);
  3e:	2aa000ef          	jal	2e8 <exit>

0000000000000042 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
  42:	1141                	addi	sp,sp,-16
  44:	e406                	sd	ra,8(sp)
  46:	e022                	sd	s0,0(sp)
  48:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  4a:	87aa                	mv	a5,a0
  4c:	0585                	addi	a1,a1,1
  4e:	0785                	addi	a5,a5,1
  50:	fff5c703          	lbu	a4,-1(a1)
  54:	fee78fa3          	sb	a4,-1(a5)
  58:	fb75                	bnez	a4,4c <strcpy+0xa>
    ;
  return os;
}
  5a:	60a2                	ld	ra,8(sp)
  5c:	6402                	ld	s0,0(sp)
  5e:	0141                	addi	sp,sp,16
  60:	8082                	ret

0000000000000062 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  62:	1141                	addi	sp,sp,-16
  64:	e406                	sd	ra,8(sp)
  66:	e022                	sd	s0,0(sp)
  68:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
  6a:	00054783          	lbu	a5,0(a0)
  6e:	cb91                	beqz	a5,82 <strcmp+0x20>
  70:	0005c703          	lbu	a4,0(a1)
  74:	00f71763          	bne	a4,a5,82 <strcmp+0x20>
    p++, q++;
  78:	0505                	addi	a0,a0,1
  7a:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
  7c:	00054783          	lbu	a5,0(a0)
  80:	fbe5                	bnez	a5,70 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  82:	0005c503          	lbu	a0,0(a1)
}
  86:	40a7853b          	subw	a0,a5,a0
  8a:	60a2                	ld	ra,8(sp)
  8c:	6402                	ld	s0,0(sp)
  8e:	0141                	addi	sp,sp,16
  90:	8082                	ret

0000000000000092 <strlen>:

uint
strlen(const char *s)
{
  92:	1141                	addi	sp,sp,-16
  94:	e406                	sd	ra,8(sp)
  96:	e022                	sd	s0,0(sp)
  98:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
  9a:	00054783          	lbu	a5,0(a0)
  9e:	cf91                	beqz	a5,ba <strlen+0x28>
  a0:	00150793          	addi	a5,a0,1
  a4:	86be                	mv	a3,a5
  a6:	0785                	addi	a5,a5,1
  a8:	fff7c703          	lbu	a4,-1(a5)
  ac:	ff65                	bnez	a4,a4 <strlen+0x12>
  ae:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
  b2:	60a2                	ld	ra,8(sp)
  b4:	6402                	ld	s0,0(sp)
  b6:	0141                	addi	sp,sp,16
  b8:	8082                	ret
  for (n = 0; s[n]; n++)
  ba:	4501                	li	a0,0
  bc:	bfdd                	j	b2 <strlen+0x20>

00000000000000be <memset>:

void *
memset(void *dst, int c, uint n)
{
  be:	1141                	addi	sp,sp,-16
  c0:	e406                	sd	ra,8(sp)
  c2:	e022                	sd	s0,0(sp)
  c4:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
  c6:	ca19                	beqz	a2,dc <memset+0x1e>
  c8:	87aa                	mv	a5,a0
  ca:	1602                	slli	a2,a2,0x20
  cc:	9201                	srli	a2,a2,0x20
  ce:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  d2:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
  d6:	0785                	addi	a5,a5,1
  d8:	fee79de3          	bne	a5,a4,d2 <memset+0x14>
  }
  return dst;
}
  dc:	60a2                	ld	ra,8(sp)
  de:	6402                	ld	s0,0(sp)
  e0:	0141                	addi	sp,sp,16
  e2:	8082                	ret

00000000000000e4 <strchr>:

char *
strchr(const char *s, char c)
{
  e4:	1141                	addi	sp,sp,-16
  e6:	e406                	sd	ra,8(sp)
  e8:	e022                	sd	s0,0(sp)
  ea:	0800                	addi	s0,sp,16
  for (; *s; s++)
  ec:	00054783          	lbu	a5,0(a0)
  f0:	c799                	beqz	a5,fe <strchr+0x1a>
    if (*s == c)
  f2:	00f58763          	beq	a1,a5,100 <strchr+0x1c>
  for (; *s; s++)
  f6:	0505                	addi	a0,a0,1
  f8:	00054783          	lbu	a5,0(a0)
  fc:	fbfd                	bnez	a5,f2 <strchr+0xe>
      return (char *)s;
  return 0;
  fe:	4501                	li	a0,0
}
 100:	60a2                	ld	ra,8(sp)
 102:	6402                	ld	s0,0(sp)
 104:	0141                	addi	sp,sp,16
 106:	8082                	ret

0000000000000108 <gets>:

char *
gets(char *buf, int max)
{
 108:	711d                	addi	sp,sp,-96
 10a:	ec86                	sd	ra,88(sp)
 10c:	e8a2                	sd	s0,80(sp)
 10e:	e4a6                	sd	s1,72(sp)
 110:	e0ca                	sd	s2,64(sp)
 112:	fc4e                	sd	s3,56(sp)
 114:	f852                	sd	s4,48(sp)
 116:	f456                	sd	s5,40(sp)
 118:	f05a                	sd	s6,32(sp)
 11a:	ec5e                	sd	s7,24(sp)
 11c:	e862                	sd	s8,16(sp)
 11e:	1080                	addi	s0,sp,96
 120:	8baa                	mv	s7,a0
 122:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
 124:	892a                	mv	s2,a0
 126:	4481                	li	s1,0
    cc = read(0, &c, 1);
 128:	faf40b13          	addi	s6,s0,-81
 12c:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;) {
 12e:	8c26                	mv	s8,s1
 130:	0014899b          	addiw	s3,s1,1
 134:	84ce                	mv	s1,s3
 136:	0349d863          	bge	s3,s4,166 <gets+0x5e>
    cc = read(0, &c, 1);
 13a:	8656                	mv	a2,s5
 13c:	85da                	mv	a1,s6
 13e:	4501                	li	a0,0
 140:	1c0000ef          	jal	300 <read>
    if (cc < 1)
 144:	02a05163          	blez	a0,166 <gets+0x5e>
      break;
    buf[i++] = c;
 148:	faf44783          	lbu	a5,-81(s0)
 14c:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 150:	0905                	addi	s2,s2,1
 152:	ff678713          	addi	a4,a5,-10
 156:	00173713          	seqz	a4,a4
 15a:	17cd                	addi	a5,a5,-13
 15c:	0017b793          	seqz	a5,a5
 160:	8fd9                	or	a5,a5,a4
 162:	d7f1                	beqz	a5,12e <gets+0x26>
    buf[i++] = c;
 164:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 166:	9c5e                	add	s8,s8,s7
 168:	000c0023          	sb	zero,0(s8)
  return buf;
}
 16c:	855e                	mv	a0,s7
 16e:	60e6                	ld	ra,88(sp)
 170:	6446                	ld	s0,80(sp)
 172:	64a6                	ld	s1,72(sp)
 174:	6906                	ld	s2,64(sp)
 176:	79e2                	ld	s3,56(sp)
 178:	7a42                	ld	s4,48(sp)
 17a:	7aa2                	ld	s5,40(sp)
 17c:	7b02                	ld	s6,32(sp)
 17e:	6be2                	ld	s7,24(sp)
 180:	6c42                	ld	s8,16(sp)
 182:	6125                	addi	sp,sp,96
 184:	8082                	ret

0000000000000186 <stat>:

int
stat(const char *n, struct stat *st)
{
 186:	1101                	addi	sp,sp,-32
 188:	ec06                	sd	ra,24(sp)
 18a:	e822                	sd	s0,16(sp)
 18c:	e04a                	sd	s2,0(sp)
 18e:	1000                	addi	s0,sp,32
 190:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 192:	4581                	li	a1,0
 194:	194000ef          	jal	328 <open>
  if (fd < 0)
 198:	02054263          	bltz	a0,1bc <stat+0x36>
 19c:	e426                	sd	s1,8(sp)
 19e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1a0:	85ca                	mv	a1,s2
 1a2:	19e000ef          	jal	340 <fstat>
 1a6:	892a                	mv	s2,a0
  close(fd);
 1a8:	8526                	mv	a0,s1
 1aa:	166000ef          	jal	310 <close>
  return r;
 1ae:	64a2                	ld	s1,8(sp)
}
 1b0:	854a                	mv	a0,s2
 1b2:	60e2                	ld	ra,24(sp)
 1b4:	6442                	ld	s0,16(sp)
 1b6:	6902                	ld	s2,0(sp)
 1b8:	6105                	addi	sp,sp,32
 1ba:	8082                	ret
    return -1;
 1bc:	57fd                	li	a5,-1
 1be:	893e                	mv	s2,a5
 1c0:	bfc5                	j	1b0 <stat+0x2a>

00000000000001c2 <atoi>:

int
atoi(const char *s)
{
 1c2:	1141                	addi	sp,sp,-16
 1c4:	e406                	sd	ra,8(sp)
 1c6:	e022                	sd	s0,0(sp)
 1c8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 1ca:	00054683          	lbu	a3,0(a0)
 1ce:	fd06879b          	addiw	a5,a3,-48
 1d2:	0ff7f793          	zext.b	a5,a5
 1d6:	4625                	li	a2,9
 1d8:	02f66963          	bltu	a2,a5,20a <atoi+0x48>
 1dc:	872a                	mv	a4,a0
  n = 0;
 1de:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 1e0:	0705                	addi	a4,a4,1
 1e2:	0025179b          	slliw	a5,a0,0x2
 1e6:	9fa9                	addw	a5,a5,a0
 1e8:	0017979b          	slliw	a5,a5,0x1
 1ec:	9fb5                	addw	a5,a5,a3
 1ee:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 1f2:	00074683          	lbu	a3,0(a4)
 1f6:	fd06879b          	addiw	a5,a3,-48
 1fa:	0ff7f793          	zext.b	a5,a5
 1fe:	fef671e3          	bgeu	a2,a5,1e0 <atoi+0x1e>
  return n;
}
 202:	60a2                	ld	ra,8(sp)
 204:	6402                	ld	s0,0(sp)
 206:	0141                	addi	sp,sp,16
 208:	8082                	ret
  n = 0;
 20a:	4501                	li	a0,0
 20c:	bfdd                	j	202 <atoi+0x40>

000000000000020e <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 20e:	1141                	addi	sp,sp,-16
 210:	e406                	sd	ra,8(sp)
 212:	e022                	sd	s0,0(sp)
 214:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 216:	02b57563          	bgeu	a0,a1,240 <memmove+0x32>
    while (n-- > 0)
 21a:	00c05f63          	blez	a2,238 <memmove+0x2a>
 21e:	1602                	slli	a2,a2,0x20
 220:	9201                	srli	a2,a2,0x20
 222:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 226:	872a                	mv	a4,a0
      *dst++ = *src++;
 228:	0585                	addi	a1,a1,1
 22a:	0705                	addi	a4,a4,1
 22c:	fff5c683          	lbu	a3,-1(a1)
 230:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 234:	fee79ae3          	bne	a5,a4,228 <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 238:	60a2                	ld	ra,8(sp)
 23a:	6402                	ld	s0,0(sp)
 23c:	0141                	addi	sp,sp,16
 23e:	8082                	ret
    while (n-- > 0)
 240:	fec05ce3          	blez	a2,238 <memmove+0x2a>
    dst += n;
 244:	00c50733          	add	a4,a0,a2
    src += n;
 248:	95b2                	add	a1,a1,a2
 24a:	fff6079b          	addiw	a5,a2,-1
 24e:	1782                	slli	a5,a5,0x20
 250:	9381                	srli	a5,a5,0x20
 252:	fff7c793          	not	a5,a5
 256:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 258:	15fd                	addi	a1,a1,-1
 25a:	177d                	addi	a4,a4,-1
 25c:	0005c683          	lbu	a3,0(a1)
 260:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 264:	fef71ae3          	bne	a4,a5,258 <memmove+0x4a>
 268:	bfc1                	j	238 <memmove+0x2a>

000000000000026a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 26a:	1141                	addi	sp,sp,-16
 26c:	e406                	sd	ra,8(sp)
 26e:	e022                	sd	s0,0(sp)
 270:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 272:	ce19                	beqz	a2,290 <memcmp+0x26>
 274:	1602                	slli	a2,a2,0x20
 276:	9201                	srli	a2,a2,0x20
 278:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 27c:	00054783          	lbu	a5,0(a0)
 280:	0005c703          	lbu	a4,0(a1)
 284:	00e79b63          	bne	a5,a4,29a <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 288:	0505                	addi	a0,a0,1
    p2++;
 28a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 28c:	fed518e3          	bne	a0,a3,27c <memcmp+0x12>
  }
  return 0;
 290:	4501                	li	a0,0
}
 292:	60a2                	ld	ra,8(sp)
 294:	6402                	ld	s0,0(sp)
 296:	0141                	addi	sp,sp,16
 298:	8082                	ret
      return *p1 - *p2;
 29a:	40e7853b          	subw	a0,a5,a4
 29e:	bfd5                	j	292 <memcmp+0x28>

00000000000002a0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2a0:	1141                	addi	sp,sp,-16
 2a2:	e406                	sd	ra,8(sp)
 2a4:	e022                	sd	s0,0(sp)
 2a6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2a8:	f67ff0ef          	jal	20e <memmove>
}
 2ac:	60a2                	ld	ra,8(sp)
 2ae:	6402                	ld	s0,0(sp)
 2b0:	0141                	addi	sp,sp,16
 2b2:	8082                	ret

00000000000002b4 <sbrk>:

char *
sbrk(int n)
{
 2b4:	1141                	addi	sp,sp,-16
 2b6:	e406                	sd	ra,8(sp)
 2b8:	e022                	sd	s0,0(sp)
 2ba:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 2bc:	4585                	li	a1,1
 2be:	0b2000ef          	jal	370 <sys_sbrk>
}
 2c2:	60a2                	ld	ra,8(sp)
 2c4:	6402                	ld	s0,0(sp)
 2c6:	0141                	addi	sp,sp,16
 2c8:	8082                	ret

00000000000002ca <sbrklazy>:

char *
sbrklazy(int n)
{
 2ca:	1141                	addi	sp,sp,-16
 2cc:	e406                	sd	ra,8(sp)
 2ce:	e022                	sd	s0,0(sp)
 2d0:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 2d2:	4589                	li	a1,2
 2d4:	09c000ef          	jal	370 <sys_sbrk>
}
 2d8:	60a2                	ld	ra,8(sp)
 2da:	6402                	ld	s0,0(sp)
 2dc:	0141                	addi	sp,sp,16
 2de:	8082                	ret

00000000000002e0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2e0:	4885                	li	a7,1
 ecall
 2e2:	00000073          	ecall
 ret
 2e6:	8082                	ret

00000000000002e8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2e8:	4889                	li	a7,2
 ecall
 2ea:	00000073          	ecall
 ret
 2ee:	8082                	ret

00000000000002f0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 2f0:	488d                	li	a7,3
 ecall
 2f2:	00000073          	ecall
 ret
 2f6:	8082                	ret

00000000000002f8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2f8:	4891                	li	a7,4
 ecall
 2fa:	00000073          	ecall
 ret
 2fe:	8082                	ret

0000000000000300 <read>:
.global read
read:
 li a7, SYS_read
 300:	4895                	li	a7,5
 ecall
 302:	00000073          	ecall
 ret
 306:	8082                	ret

0000000000000308 <write>:
.global write
write:
 li a7, SYS_write
 308:	48c1                	li	a7,16
 ecall
 30a:	00000073          	ecall
 ret
 30e:	8082                	ret

0000000000000310 <close>:
.global close
close:
 li a7, SYS_close
 310:	48d5                	li	a7,21
 ecall
 312:	00000073          	ecall
 ret
 316:	8082                	ret

0000000000000318 <kill>:
.global kill
kill:
 li a7, SYS_kill
 318:	4899                	li	a7,6
 ecall
 31a:	00000073          	ecall
 ret
 31e:	8082                	ret

0000000000000320 <exec>:
.global exec
exec:
 li a7, SYS_exec
 320:	489d                	li	a7,7
 ecall
 322:	00000073          	ecall
 ret
 326:	8082                	ret

0000000000000328 <open>:
.global open
open:
 li a7, SYS_open
 328:	48bd                	li	a7,15
 ecall
 32a:	00000073          	ecall
 ret
 32e:	8082                	ret

0000000000000330 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 330:	48c5                	li	a7,17
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 338:	48c9                	li	a7,18
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 340:	48a1                	li	a7,8
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <link>:
.global link
link:
 li a7, SYS_link
 348:	48cd                	li	a7,19
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 350:	48d1                	li	a7,20
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 358:	48a5                	li	a7,9
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <dup>:
.global dup
dup:
 li a7, SYS_dup
 360:	48a9                	li	a7,10
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 368:	48ad                	li	a7,11
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 370:	48b1                	li	a7,12
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <pause>:
.global pause
pause:
 li a7, SYS_pause
 378:	48b5                	li	a7,13
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 380:	48b9                	li	a7,14
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <sync>:
.global sync
sync:
 li a7, SYS_sync
 388:	48d9                	li	a7,22
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <wait2>:
.global wait2
wait2:
 li a7, SYS_wait2
 390:	48dd                	li	a7,23
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 398:	1101                	addi	sp,sp,-32
 39a:	ec06                	sd	ra,24(sp)
 39c:	e822                	sd	s0,16(sp)
 39e:	1000                	addi	s0,sp,32
 3a0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3a4:	4605                	li	a2,1
 3a6:	fef40593          	addi	a1,s0,-17
 3aa:	f5fff0ef          	jal	308 <write>
}
 3ae:	60e2                	ld	ra,24(sp)
 3b0:	6442                	ld	s0,16(sp)
 3b2:	6105                	addi	sp,sp,32
 3b4:	8082                	ret

00000000000003b6 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 3b6:	715d                	addi	sp,sp,-80
 3b8:	e486                	sd	ra,72(sp)
 3ba:	e0a2                	sd	s0,64(sp)
 3bc:	f84a                	sd	s2,48(sp)
 3be:	f44e                	sd	s3,40(sp)
 3c0:	0880                	addi	s0,sp,80
 3c2:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
 3c4:	00d036b3          	snez	a3,a3
 3c8:	03f5d793          	srli	a5,a1,0x3f
 3cc:	8efd                	and	a3,a3,a5
  neg = 0;
 3ce:	4301                	li	t1,0
  if (sgn && xx < 0) {
 3d0:	c681                	beqz	a3,3d8 <printint+0x22>
    neg = 1;
    x = -xx;
 3d2:	40b005b3          	neg	a1,a1
    neg = 1;
 3d6:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 3d8:	fb840993          	addi	s3,s0,-72
  neg = 0;
 3dc:	86ce                	mv	a3,s3
  i = 0;
 3de:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
 3e0:	00000817          	auipc	a6,0x0
 3e4:	54080813          	addi	a6,a6,1344 # 920 <digits>
 3e8:	88ba                	mv	a7,a4
 3ea:	0017051b          	addiw	a0,a4,1
 3ee:	872a                	mv	a4,a0
 3f0:	02c5f7b3          	remu	a5,a1,a2
 3f4:	97c2                	add	a5,a5,a6
 3f6:	0007c783          	lbu	a5,0(a5)
 3fa:	00f68023          	sb	a5,0(a3)
  } while ((x /= base) != 0);
 3fe:	87ae                	mv	a5,a1
 400:	02c5d5b3          	divu	a1,a1,a2
 404:	0685                	addi	a3,a3,1
 406:	fec7f1e3          	bgeu	a5,a2,3e8 <printint+0x32>
  if (neg)
 40a:	00030b63          	beqz	t1,420 <printint+0x6a>
    buf[i++] = '-';
 40e:	fd040793          	addi	a5,s0,-48
 412:	953e                	add	a0,a0,a5
 414:	02d00793          	li	a5,45
 418:	fef50423          	sb	a5,-24(a0)
 41c:	0028871b          	addiw	a4,a7,2

  while (--i >= 0)
 420:	02e05563          	blez	a4,44a <printint+0x94>
 424:	fc26                	sd	s1,56(sp)
 426:	377d                	addiw	a4,a4,-1
 428:	00e984b3          	add	s1,s3,a4
 42c:	19fd                	addi	s3,s3,-1
 42e:	99ba                	add	s3,s3,a4
 430:	1702                	slli	a4,a4,0x20
 432:	9301                	srli	a4,a4,0x20
 434:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 438:	0004c583          	lbu	a1,0(s1)
 43c:	854a                	mv	a0,s2
 43e:	f5bff0ef          	jal	398 <putc>
  while (--i >= 0)
 442:	14fd                	addi	s1,s1,-1
 444:	ff349ae3          	bne	s1,s3,438 <printint+0x82>
 448:	74e2                	ld	s1,56(sp)
}
 44a:	60a6                	ld	ra,72(sp)
 44c:	6406                	ld	s0,64(sp)
 44e:	7942                	ld	s2,48(sp)
 450:	79a2                	ld	s3,40(sp)
 452:	6161                	addi	sp,sp,80
 454:	8082                	ret

0000000000000456 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 456:	711d                	addi	sp,sp,-96
 458:	ec86                	sd	ra,88(sp)
 45a:	e8a2                	sd	s0,80(sp)
 45c:	e4a6                	sd	s1,72(sp)
 45e:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 460:	0005c483          	lbu	s1,0(a1)
 464:	2a048063          	beqz	s1,704 <vprintf+0x2ae>
 468:	e0ca                	sd	s2,64(sp)
 46a:	fc4e                	sd	s3,56(sp)
 46c:	f852                	sd	s4,48(sp)
 46e:	f456                	sd	s5,40(sp)
 470:	f05a                	sd	s6,32(sp)
 472:	ec5e                	sd	s7,24(sp)
 474:	e862                	sd	s8,16(sp)
 476:	8b2a                	mv	s6,a0
 478:	8a2e                	mv	s4,a1
 47a:	8bb2                	mv	s7,a2
  state = 0;
 47c:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
 47e:	4901                	li	s2,0
 480:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
 482:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
 486:	06400c13          	li	s8,100
 48a:	a00d                	j	4ac <vprintf+0x56>
        putc(fd, c0);
 48c:	85a6                	mv	a1,s1
 48e:	855a                	mv	a0,s6
 490:	f09ff0ef          	jal	398 <putc>
 494:	a019                	j	49a <vprintf+0x44>
    } else if (state == '%') {
 496:	03598363          	beq	s3,s5,4bc <vprintf+0x66>
  for (i = 0; fmt[i]; i++) {
 49a:	0019079b          	addiw	a5,s2,1
 49e:	893e                	mv	s2,a5
 4a0:	873e                	mv	a4,a5
 4a2:	97d2                	add	a5,a5,s4
 4a4:	0007c483          	lbu	s1,0(a5)
 4a8:	24048763          	beqz	s1,6f6 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 4ac:	0004879b          	sext.w	a5,s1
    if (state == 0) {
 4b0:	fe0993e3          	bnez	s3,496 <vprintf+0x40>
      if (c0 == '%') {
 4b4:	fd579ce3          	bne	a5,s5,48c <vprintf+0x36>
        state = '%';
 4b8:	89be                	mv	s3,a5
 4ba:	b7c5                	j	49a <vprintf+0x44>
        c1 = fmt[i + 1] & 0xff;
 4bc:	00ea06b3          	add	a3,s4,a4
 4c0:	0016c603          	lbu	a2,1(a3)
      if (c1)
 4c4:	24060563          	beqz	a2,70e <vprintf+0x2b8>
      if (c0 == 'd') {
 4c8:	0b878763          	beq	a5,s8,576 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
 4cc:	f9478693          	addi	a3,a5,-108
 4d0:	0016b693          	seqz	a3,a3
 4d4:	f9c60593          	addi	a1,a2,-100
 4d8:	0015b593          	seqz	a1,a1
 4dc:	8df5                	and	a1,a1,a3
 4de:	e9c5                	bnez	a1,58e <vprintf+0x138>
        c2 = fmt[i + 2] & 0xff;
 4e0:	9752                	add	a4,a4,s4
 4e2:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 4e6:	f9460713          	addi	a4,a2,-108
 4ea:	00173713          	seqz	a4,a4
 4ee:	8f75                	and	a4,a4,a3
 4f0:	f9c50593          	addi	a1,a0,-100
 4f4:	0015b593          	seqz	a1,a1
 4f8:	8df9                	and	a1,a1,a4
 4fa:	e5dd                	bnez	a1,5a8 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
 4fc:	07500593          	li	a1,117
 500:	0cb78163          	beq	a5,a1,5c2 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if (c0 == 'l' && c1 == 'u') {
 504:	f8b60593          	addi	a1,a2,-117
 508:	0015b593          	seqz	a1,a1
 50c:	8df5                	and	a1,a1,a3
 50e:	e5f1                	bnez	a1,5da <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
 510:	f8b50593          	addi	a1,a0,-117
 514:	0015b593          	seqz	a1,a1
 518:	8df9                	and	a1,a1,a4
 51a:	ede9                	bnez	a1,5f4 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
 51c:	07800593          	li	a1,120
 520:	0eb78763          	beq	a5,a1,60e <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if (c0 == 'l' && c1 == 'x') {
 524:	f8860613          	addi	a2,a2,-120
 528:	00163613          	seqz	a2,a2
 52c:	8ef1                	and	a3,a3,a2
 52e:	0e069c63          	bnez	a3,626 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
 532:	f8850513          	addi	a0,a0,-120
 536:	00153513          	seqz	a0,a0
 53a:	8f69                	and	a4,a4,a0
 53c:	10071263          	bnez	a4,640 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
 540:	07000713          	li	a4,112
 544:	10e78a63          	beq	a5,a4,658 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
 548:	06300713          	li	a4,99
 54c:	14e78a63          	beq	a5,a4,6a0 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
 550:	07300713          	li	a4,115
 554:	16e78063          	beq	a5,a4,6b4 <vprintf+0x25e>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
 558:	02500713          	li	a4,37
 55c:	18e78863          	beq	a5,a4,6ec <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 560:	02500593          	li	a1,37
 564:	855a                	mv	a0,s6
 566:	e33ff0ef          	jal	398 <putc>
        putc(fd, c0);
 56a:	85a6                	mv	a1,s1
 56c:	855a                	mv	a0,s6
 56e:	e2bff0ef          	jal	398 <putc>
      }

      state = 0;
 572:	4981                	li	s3,0
 574:	b71d                	j	49a <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 576:	008b8493          	addi	s1,s7,8
 57a:	4685                	li	a3,1
 57c:	4629                	li	a2,10
 57e:	000ba583          	lw	a1,0(s7)
 582:	855a                	mv	a0,s6
 584:	e33ff0ef          	jal	3b6 <printint>
 588:	8ba6                	mv	s7,s1
      state = 0;
 58a:	4981                	li	s3,0
 58c:	b739                	j	49a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 58e:	008b8493          	addi	s1,s7,8
 592:	4685                	li	a3,1
 594:	4629                	li	a2,10
 596:	000bb583          	ld	a1,0(s7)
 59a:	855a                	mv	a0,s6
 59c:	e1bff0ef          	jal	3b6 <printint>
        i += 1;
 5a0:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 5a2:	8ba6                	mv	s7,s1
      state = 0;
 5a4:	4981                	li	s3,0
 5a6:	bdd5                	j	49a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5a8:	008b8493          	addi	s1,s7,8
 5ac:	4685                	li	a3,1
 5ae:	4629                	li	a2,10
 5b0:	000bb583          	ld	a1,0(s7)
 5b4:	855a                	mv	a0,s6
 5b6:	e01ff0ef          	jal	3b6 <printint>
        i += 2;
 5ba:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 5bc:	8ba6                	mv	s7,s1
      state = 0;
 5be:	4981                	li	s3,0
        i += 2;
 5c0:	bde9                	j	49a <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 5c2:	008b8493          	addi	s1,s7,8
 5c6:	4681                	li	a3,0
 5c8:	4629                	li	a2,10
 5ca:	000be583          	lwu	a1,0(s7)
 5ce:	855a                	mv	a0,s6
 5d0:	de7ff0ef          	jal	3b6 <printint>
 5d4:	8ba6                	mv	s7,s1
      state = 0;
 5d6:	4981                	li	s3,0
 5d8:	b5c9                	j	49a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5da:	008b8493          	addi	s1,s7,8
 5de:	4681                	li	a3,0
 5e0:	4629                	li	a2,10
 5e2:	000bb583          	ld	a1,0(s7)
 5e6:	855a                	mv	a0,s6
 5e8:	dcfff0ef          	jal	3b6 <printint>
        i += 1;
 5ec:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 5ee:	8ba6                	mv	s7,s1
      state = 0;
 5f0:	4981                	li	s3,0
 5f2:	b565                	j	49a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5f4:	008b8493          	addi	s1,s7,8
 5f8:	4681                	li	a3,0
 5fa:	4629                	li	a2,10
 5fc:	000bb583          	ld	a1,0(s7)
 600:	855a                	mv	a0,s6
 602:	db5ff0ef          	jal	3b6 <printint>
        i += 2;
 606:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 608:	8ba6                	mv	s7,s1
      state = 0;
 60a:	4981                	li	s3,0
        i += 2;
 60c:	b579                	j	49a <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 60e:	008b8493          	addi	s1,s7,8
 612:	4681                	li	a3,0
 614:	4641                	li	a2,16
 616:	000be583          	lwu	a1,0(s7)
 61a:	855a                	mv	a0,s6
 61c:	d9bff0ef          	jal	3b6 <printint>
 620:	8ba6                	mv	s7,s1
      state = 0;
 622:	4981                	li	s3,0
 624:	bd9d                	j	49a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 626:	008b8493          	addi	s1,s7,8
 62a:	4681                	li	a3,0
 62c:	4641                	li	a2,16
 62e:	000bb583          	ld	a1,0(s7)
 632:	855a                	mv	a0,s6
 634:	d83ff0ef          	jal	3b6 <printint>
        i += 1;
 638:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 63a:	8ba6                	mv	s7,s1
      state = 0;
 63c:	4981                	li	s3,0
 63e:	bdb1                	j	49a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 640:	008b8493          	addi	s1,s7,8
 644:	4641                	li	a2,16
 646:	000bb583          	ld	a1,0(s7)
 64a:	855a                	mv	a0,s6
 64c:	d6bff0ef          	jal	3b6 <printint>
        i += 2;
 650:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 652:	8ba6                	mv	s7,s1
      state = 0;
 654:	4981                	li	s3,0
        i += 2;
 656:	b591                	j	49a <vprintf+0x44>
 658:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 65a:	008b8793          	addi	a5,s7,8
 65e:	8cbe                	mv	s9,a5
 660:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 664:	03000593          	li	a1,48
 668:	855a                	mv	a0,s6
 66a:	d2fff0ef          	jal	398 <putc>
  putc(fd, 'x');
 66e:	07800593          	li	a1,120
 672:	855a                	mv	a0,s6
 674:	d25ff0ef          	jal	398 <putc>
 678:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 67a:	00000b97          	auipc	s7,0x0
 67e:	2a6b8b93          	addi	s7,s7,678 # 920 <digits>
 682:	03c9d793          	srli	a5,s3,0x3c
 686:	97de                	add	a5,a5,s7
 688:	0007c583          	lbu	a1,0(a5)
 68c:	855a                	mv	a0,s6
 68e:	d0bff0ef          	jal	398 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 692:	0992                	slli	s3,s3,0x4
 694:	34fd                	addiw	s1,s1,-1
 696:	f4f5                	bnez	s1,682 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 698:	8be6                	mv	s7,s9
      state = 0;
 69a:	4981                	li	s3,0
 69c:	6ca2                	ld	s9,8(sp)
 69e:	bbf5                	j	49a <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 6a0:	008b8493          	addi	s1,s7,8
 6a4:	000bc583          	lbu	a1,0(s7)
 6a8:	855a                	mv	a0,s6
 6aa:	cefff0ef          	jal	398 <putc>
 6ae:	8ba6                	mv	s7,s1
      state = 0;
 6b0:	4981                	li	s3,0
 6b2:	b3e5                	j	49a <vprintf+0x44>
        if ((s = va_arg(ap, char *)) == 0)
 6b4:	008b8993          	addi	s3,s7,8
 6b8:	000bb483          	ld	s1,0(s7)
 6bc:	cc91                	beqz	s1,6d8 <vprintf+0x282>
        for (; *s; s++)
 6be:	0004c583          	lbu	a1,0(s1)
 6c2:	c195                	beqz	a1,6e6 <vprintf+0x290>
          putc(fd, *s);
 6c4:	855a                	mv	a0,s6
 6c6:	cd3ff0ef          	jal	398 <putc>
        for (; *s; s++)
 6ca:	0485                	addi	s1,s1,1
 6cc:	0004c583          	lbu	a1,0(s1)
 6d0:	f9f5                	bnez	a1,6c4 <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 6d2:	8bce                	mv	s7,s3
      state = 0;
 6d4:	4981                	li	s3,0
 6d6:	b3d1                	j	49a <vprintf+0x44>
          s = "(null)";
 6d8:	00000497          	auipc	s1,0x0
 6dc:	24048493          	addi	s1,s1,576 # 918 <malloc+0x10e>
        for (; *s; s++)
 6e0:	02800593          	li	a1,40
 6e4:	b7c5                	j	6c4 <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 6e6:	8bce                	mv	s7,s3
      state = 0;
 6e8:	4981                	li	s3,0
 6ea:	bb45                	j	49a <vprintf+0x44>
        putc(fd, '%');
 6ec:	85be                	mv	a1,a5
 6ee:	855a                	mv	a0,s6
 6f0:	ca9ff0ef          	jal	398 <putc>
 6f4:	bdbd                	j	572 <vprintf+0x11c>
 6f6:	6906                	ld	s2,64(sp)
 6f8:	79e2                	ld	s3,56(sp)
 6fa:	7a42                	ld	s4,48(sp)
 6fc:	7aa2                	ld	s5,40(sp)
 6fe:	7b02                	ld	s6,32(sp)
 700:	6be2                	ld	s7,24(sp)
 702:	6c42                	ld	s8,16(sp)
    }
  }
}
 704:	60e6                	ld	ra,88(sp)
 706:	6446                	ld	s0,80(sp)
 708:	64a6                	ld	s1,72(sp)
 70a:	6125                	addi	sp,sp,96
 70c:	8082                	ret
      if (c0 == 'd') {
 70e:	06400713          	li	a4,100
 712:	e6e782e3          	beq	a5,a4,576 <vprintf+0x120>
      } else if (c0 == 'l' && c1 == 'd') {
 716:	f9478693          	addi	a3,a5,-108
 71a:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 71e:	8532                	mv	a0,a2
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 720:	4701                	li	a4,0
 722:	bbe9                	j	4fc <vprintf+0xa6>

0000000000000724 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 724:	715d                	addi	sp,sp,-80
 726:	ec06                	sd	ra,24(sp)
 728:	e822                	sd	s0,16(sp)
 72a:	1000                	addi	s0,sp,32
 72c:	e010                	sd	a2,0(s0)
 72e:	e414                	sd	a3,8(s0)
 730:	e818                	sd	a4,16(s0)
 732:	ec1c                	sd	a5,24(s0)
 734:	03043023          	sd	a6,32(s0)
 738:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 73c:	8622                	mv	a2,s0
 73e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 742:	d15ff0ef          	jal	456 <vprintf>
}
 746:	60e2                	ld	ra,24(sp)
 748:	6442                	ld	s0,16(sp)
 74a:	6161                	addi	sp,sp,80
 74c:	8082                	ret

000000000000074e <printf>:

void
printf(const char *fmt, ...)
{
 74e:	711d                	addi	sp,sp,-96
 750:	ec06                	sd	ra,24(sp)
 752:	e822                	sd	s0,16(sp)
 754:	1000                	addi	s0,sp,32
 756:	e40c                	sd	a1,8(s0)
 758:	e810                	sd	a2,16(s0)
 75a:	ec14                	sd	a3,24(s0)
 75c:	f018                	sd	a4,32(s0)
 75e:	f41c                	sd	a5,40(s0)
 760:	03043823          	sd	a6,48(s0)
 764:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 768:	00840613          	addi	a2,s0,8
 76c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 770:	85aa                	mv	a1,a0
 772:	4505                	li	a0,1
 774:	ce3ff0ef          	jal	456 <vprintf>
}
 778:	60e2                	ld	ra,24(sp)
 77a:	6442                	ld	s0,16(sp)
 77c:	6125                	addi	sp,sp,96
 77e:	8082                	ret

0000000000000780 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 780:	1141                	addi	sp,sp,-16
 782:	e406                	sd	ra,8(sp)
 784:	e022                	sd	s0,0(sp)
 786:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 788:	ff050713          	addi	a4,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 78c:	00001797          	auipc	a5,0x1
 790:	8747b783          	ld	a5,-1932(a5) # 1000 <freep>
 794:	a095                	j	7f8 <free+0x78>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if (bp + bp->s.size == p->s.ptr) {
 796:	ff852583          	lw	a1,-8(a0)
 79a:	6390                	ld	a2,0(a5)
 79c:	02059813          	slli	a6,a1,0x20
 7a0:	01c85693          	srli	a3,a6,0x1c
 7a4:	96ba                	add	a3,a3,a4
 7a6:	02d60563          	beq	a2,a3,7d0 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 7aa:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
 7ae:	4790                	lw	a2,8(a5)
 7b0:	02061593          	slli	a1,a2,0x20
 7b4:	01c5d693          	srli	a3,a1,0x1c
 7b8:	96be                	add	a3,a3,a5
 7ba:	02d70263          	beq	a4,a3,7de <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 7be:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7c0:	00001717          	auipc	a4,0x1
 7c4:	84f73023          	sd	a5,-1984(a4) # 1000 <freep>
}
 7c8:	60a2                	ld	ra,8(sp)
 7ca:	6402                	ld	s0,0(sp)
 7cc:	0141                	addi	sp,sp,16
 7ce:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 7d0:	4614                	lw	a3,8(a2)
 7d2:	9ead                	addw	a3,a3,a1
 7d4:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7d8:	6394                	ld	a3,0(a5)
 7da:	6290                	ld	a2,0(a3)
 7dc:	b7f9                	j	7aa <free+0x2a>
    p->s.size += bp->s.size;
 7de:	ff852703          	lw	a4,-8(a0)
 7e2:	9f31                	addw	a4,a4,a2
 7e4:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7e6:	ff053703          	ld	a4,-16(a0)
 7ea:	bfd1                	j	7be <free+0x3e>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ec:	6394                	ld	a3,0(a5)
 7ee:	00d7e463          	bltu	a5,a3,7f6 <free+0x76>
 7f2:	fad762e3          	bltu	a4,a3,796 <free+0x16>
 7f6:	87b6                	mv	a5,a3
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f8:	fee7fae3          	bgeu	a5,a4,7ec <free+0x6c>
 7fc:	6394                	ld	a3,0(a5)
 7fe:	f8d76ce3          	bltu	a4,a3,796 <free+0x16>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 802:	f8d7fae3          	bgeu	a5,a3,796 <free+0x16>
 806:	87b6                	mv	a5,a3
 808:	bfc5                	j	7f8 <free+0x78>

000000000000080a <malloc>:
  return freep;
}

void *
malloc(uint nbytes)
{
 80a:	7139                	addi	sp,sp,-64
 80c:	fc06                	sd	ra,56(sp)
 80e:	f822                	sd	s0,48(sp)
 810:	f04a                	sd	s2,32(sp)
 812:	ec4e                	sd	s3,24(sp)
 814:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 816:	02051993          	slli	s3,a0,0x20
 81a:	0209d993          	srli	s3,s3,0x20
 81e:	09bd                	addi	s3,s3,15
 820:	0049d993          	srli	s3,s3,0x4
 824:	2985                	addiw	s3,s3,1
 826:	894e                	mv	s2,s3
  if ((prevp = freep) == 0) {
 828:	00000517          	auipc	a0,0x0
 82c:	7d853503          	ld	a0,2008(a0) # 1000 <freep>
 830:	c905                	beqz	a0,860 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 832:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 834:	4798                	lw	a4,8(a5)
 836:	09377663          	bgeu	a4,s3,8c2 <malloc+0xb8>
 83a:	f426                	sd	s1,40(sp)
 83c:	e852                	sd	s4,16(sp)
 83e:	e456                	sd	s5,8(sp)
 840:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 842:	8a4e                	mv	s4,s3
 844:	6705                	lui	a4,0x1
 846:	00e9f363          	bgeu	s3,a4,84c <malloc+0x42>
 84a:	6a05                	lui	s4,0x1
 84c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 850:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
 854:	00000497          	auipc	s1,0x0
 858:	7ac48493          	addi	s1,s1,1964 # 1000 <freep>
  if (p == SBRK_ERROR)
 85c:	5afd                	li	s5,-1
 85e:	a83d                	j	89c <malloc+0x92>
 860:	f426                	sd	s1,40(sp)
 862:	e852                	sd	s4,16(sp)
 864:	e456                	sd	s5,8(sp)
 866:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 868:	00000797          	auipc	a5,0x0
 86c:	7a878793          	addi	a5,a5,1960 # 1010 <base>
 870:	00000717          	auipc	a4,0x0
 874:	78f73823          	sd	a5,1936(a4) # 1000 <freep>
 878:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 87a:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
 87e:	b7d1                	j	842 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 880:	6398                	ld	a4,0(a5)
 882:	e118                	sd	a4,0(a0)
 884:	a899                	j	8da <malloc+0xd0>
  hp->s.size = nu;
 886:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
 88a:	0541                	addi	a0,a0,16
 88c:	ef5ff0ef          	jal	780 <free>
  return freep;
 890:	6088                	ld	a0,0(s1)
      if ((p = morecore(nunits)) == 0)
 892:	c125                	beqz	a0,8f2 <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 894:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 896:	4798                	lw	a4,8(a5)
 898:	03277163          	bgeu	a4,s2,8ba <malloc+0xb0>
    if (p == freep)
 89c:	6098                	ld	a4,0(s1)
 89e:	853e                	mv	a0,a5
 8a0:	fef71ae3          	bne	a4,a5,894 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 8a4:	8552                	mv	a0,s4
 8a6:	a0fff0ef          	jal	2b4 <sbrk>
  if (p == SBRK_ERROR)
 8aa:	fd551ee3          	bne	a0,s5,886 <malloc+0x7c>
        return 0;
 8ae:	4501                	li	a0,0
 8b0:	74a2                	ld	s1,40(sp)
 8b2:	6a42                	ld	s4,16(sp)
 8b4:	6aa2                	ld	s5,8(sp)
 8b6:	6b02                	ld	s6,0(sp)
 8b8:	a03d                	j	8e6 <malloc+0xdc>
 8ba:	74a2                	ld	s1,40(sp)
 8bc:	6a42                	ld	s4,16(sp)
 8be:	6aa2                	ld	s5,8(sp)
 8c0:	6b02                	ld	s6,0(sp)
      if (p->s.size == nunits)
 8c2:	fae90fe3          	beq	s2,a4,880 <malloc+0x76>
        p->s.size -= nunits;
 8c6:	4137073b          	subw	a4,a4,s3
 8ca:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8cc:	02071693          	slli	a3,a4,0x20
 8d0:	01c6d713          	srli	a4,a3,0x1c
 8d4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8d6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8da:	00000717          	auipc	a4,0x0
 8de:	72a73323          	sd	a0,1830(a4) # 1000 <freep>
      return (void *)(p + 1);
 8e2:	01078513          	addi	a0,a5,16
  }
}
 8e6:	70e2                	ld	ra,56(sp)
 8e8:	7442                	ld	s0,48(sp)
 8ea:	7902                	ld	s2,32(sp)
 8ec:	69e2                	ld	s3,24(sp)
 8ee:	6121                	addi	sp,sp,64
 8f0:	8082                	ret
 8f2:	74a2                	ld	s1,40(sp)
 8f4:	6a42                	ld	s4,16(sp)
 8f6:	6aa2                	ld	s5,8(sp)
 8f8:	6b02                	ld	s6,0(sp)
 8fa:	b7f5                	j	8e6 <malloc+0xdc>
