
user/_hello:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"

int
main (int argc, char *argv[]) {
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16

	if (argc == 2) {
   8:	4789                	li	a5,2
   a:	00f50b63          	beq	a0,a5,20 <main+0x20>
		printf("Hello, %s!\n", argv[1]);
	} else {
		printf("Hello!\n");
   e:	00001517          	auipc	a0,0x1
  12:	90250513          	addi	a0,a0,-1790 # 910 <malloc+0x108>
  16:	736000ef          	jal	74c <printf>
	}

	exit(0);
  1a:	4501                	li	a0,0
  1c:	2ca000ef          	jal	2e6 <exit>
		printf("Hello, %s!\n", argv[1]);
  20:	658c                	ld	a1,8(a1)
  22:	00001517          	auipc	a0,0x1
  26:	8de50513          	addi	a0,a0,-1826 # 900 <malloc+0xf8>
  2a:	722000ef          	jal	74c <printf>
  2e:	b7f5                	j	1a <main+0x1a>

0000000000000030 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  30:	1141                	addi	sp,sp,-16
  32:	e406                	sd	ra,8(sp)
  34:	e022                	sd	s0,0(sp)
  36:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  38:	fc9ff0ef          	jal	0 <main>
  exit(r);
  3c:	2aa000ef          	jal	2e6 <exit>

0000000000000040 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
  40:	1141                	addi	sp,sp,-16
  42:	e406                	sd	ra,8(sp)
  44:	e022                	sd	s0,0(sp)
  46:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  48:	87aa                	mv	a5,a0
  4a:	0585                	addi	a1,a1,1
  4c:	0785                	addi	a5,a5,1
  4e:	fff5c703          	lbu	a4,-1(a1)
  52:	fee78fa3          	sb	a4,-1(a5)
  56:	fb75                	bnez	a4,4a <strcpy+0xa>
    ;
  return os;
}
  58:	60a2                	ld	ra,8(sp)
  5a:	6402                	ld	s0,0(sp)
  5c:	0141                	addi	sp,sp,16
  5e:	8082                	ret

0000000000000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	1141                	addi	sp,sp,-16
  62:	e406                	sd	ra,8(sp)
  64:	e022                	sd	s0,0(sp)
  66:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
  68:	00054783          	lbu	a5,0(a0)
  6c:	cb91                	beqz	a5,80 <strcmp+0x20>
  6e:	0005c703          	lbu	a4,0(a1)
  72:	00f71763          	bne	a4,a5,80 <strcmp+0x20>
    p++, q++;
  76:	0505                	addi	a0,a0,1
  78:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
  7a:	00054783          	lbu	a5,0(a0)
  7e:	fbe5                	bnez	a5,6e <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  80:	0005c503          	lbu	a0,0(a1)
}
  84:	40a7853b          	subw	a0,a5,a0
  88:	60a2                	ld	ra,8(sp)
  8a:	6402                	ld	s0,0(sp)
  8c:	0141                	addi	sp,sp,16
  8e:	8082                	ret

0000000000000090 <strlen>:

uint
strlen(const char *s)
{
  90:	1141                	addi	sp,sp,-16
  92:	e406                	sd	ra,8(sp)
  94:	e022                	sd	s0,0(sp)
  96:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
  98:	00054783          	lbu	a5,0(a0)
  9c:	cf91                	beqz	a5,b8 <strlen+0x28>
  9e:	00150793          	addi	a5,a0,1
  a2:	86be                	mv	a3,a5
  a4:	0785                	addi	a5,a5,1
  a6:	fff7c703          	lbu	a4,-1(a5)
  aa:	ff65                	bnez	a4,a2 <strlen+0x12>
  ac:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
  b0:	60a2                	ld	ra,8(sp)
  b2:	6402                	ld	s0,0(sp)
  b4:	0141                	addi	sp,sp,16
  b6:	8082                	ret
  for (n = 0; s[n]; n++)
  b8:	4501                	li	a0,0
  ba:	bfdd                	j	b0 <strlen+0x20>

00000000000000bc <memset>:

void *
memset(void *dst, int c, uint n)
{
  bc:	1141                	addi	sp,sp,-16
  be:	e406                	sd	ra,8(sp)
  c0:	e022                	sd	s0,0(sp)
  c2:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
  c4:	ca19                	beqz	a2,da <memset+0x1e>
  c6:	87aa                	mv	a5,a0
  c8:	1602                	slli	a2,a2,0x20
  ca:	9201                	srli	a2,a2,0x20
  cc:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  d0:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
  d4:	0785                	addi	a5,a5,1
  d6:	fee79de3          	bne	a5,a4,d0 <memset+0x14>
  }
  return dst;
}
  da:	60a2                	ld	ra,8(sp)
  dc:	6402                	ld	s0,0(sp)
  de:	0141                	addi	sp,sp,16
  e0:	8082                	ret

00000000000000e2 <strchr>:

char *
strchr(const char *s, char c)
{
  e2:	1141                	addi	sp,sp,-16
  e4:	e406                	sd	ra,8(sp)
  e6:	e022                	sd	s0,0(sp)
  e8:	0800                	addi	s0,sp,16
  for (; *s; s++)
  ea:	00054783          	lbu	a5,0(a0)
  ee:	c799                	beqz	a5,fc <strchr+0x1a>
    if (*s == c)
  f0:	00f58763          	beq	a1,a5,fe <strchr+0x1c>
  for (; *s; s++)
  f4:	0505                	addi	a0,a0,1
  f6:	00054783          	lbu	a5,0(a0)
  fa:	fbfd                	bnez	a5,f0 <strchr+0xe>
      return (char *)s;
  return 0;
  fc:	4501                	li	a0,0
}
  fe:	60a2                	ld	ra,8(sp)
 100:	6402                	ld	s0,0(sp)
 102:	0141                	addi	sp,sp,16
 104:	8082                	ret

0000000000000106 <gets>:

char *
gets(char *buf, int max)
{
 106:	711d                	addi	sp,sp,-96
 108:	ec86                	sd	ra,88(sp)
 10a:	e8a2                	sd	s0,80(sp)
 10c:	e4a6                	sd	s1,72(sp)
 10e:	e0ca                	sd	s2,64(sp)
 110:	fc4e                	sd	s3,56(sp)
 112:	f852                	sd	s4,48(sp)
 114:	f456                	sd	s5,40(sp)
 116:	f05a                	sd	s6,32(sp)
 118:	ec5e                	sd	s7,24(sp)
 11a:	e862                	sd	s8,16(sp)
 11c:	1080                	addi	s0,sp,96
 11e:	8baa                	mv	s7,a0
 120:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
 122:	892a                	mv	s2,a0
 124:	4481                	li	s1,0
    cc = read(0, &c, 1);
 126:	faf40b13          	addi	s6,s0,-81
 12a:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;) {
 12c:	8c26                	mv	s8,s1
 12e:	0014899b          	addiw	s3,s1,1
 132:	84ce                	mv	s1,s3
 134:	0349d863          	bge	s3,s4,164 <gets+0x5e>
    cc = read(0, &c, 1);
 138:	8656                	mv	a2,s5
 13a:	85da                	mv	a1,s6
 13c:	4501                	li	a0,0
 13e:	1c0000ef          	jal	2fe <read>
    if (cc < 1)
 142:	02a05163          	blez	a0,164 <gets+0x5e>
      break;
    buf[i++] = c;
 146:	faf44783          	lbu	a5,-81(s0)
 14a:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 14e:	0905                	addi	s2,s2,1
 150:	ff678713          	addi	a4,a5,-10
 154:	00173713          	seqz	a4,a4
 158:	17cd                	addi	a5,a5,-13
 15a:	0017b793          	seqz	a5,a5
 15e:	8fd9                	or	a5,a5,a4
 160:	d7f1                	beqz	a5,12c <gets+0x26>
    buf[i++] = c;
 162:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 164:	9c5e                	add	s8,s8,s7
 166:	000c0023          	sb	zero,0(s8)
  return buf;
}
 16a:	855e                	mv	a0,s7
 16c:	60e6                	ld	ra,88(sp)
 16e:	6446                	ld	s0,80(sp)
 170:	64a6                	ld	s1,72(sp)
 172:	6906                	ld	s2,64(sp)
 174:	79e2                	ld	s3,56(sp)
 176:	7a42                	ld	s4,48(sp)
 178:	7aa2                	ld	s5,40(sp)
 17a:	7b02                	ld	s6,32(sp)
 17c:	6be2                	ld	s7,24(sp)
 17e:	6c42                	ld	s8,16(sp)
 180:	6125                	addi	sp,sp,96
 182:	8082                	ret

0000000000000184 <stat>:

int
stat(const char *n, struct stat *st)
{
 184:	1101                	addi	sp,sp,-32
 186:	ec06                	sd	ra,24(sp)
 188:	e822                	sd	s0,16(sp)
 18a:	e04a                	sd	s2,0(sp)
 18c:	1000                	addi	s0,sp,32
 18e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 190:	4581                	li	a1,0
 192:	194000ef          	jal	326 <open>
  if (fd < 0)
 196:	02054263          	bltz	a0,1ba <stat+0x36>
 19a:	e426                	sd	s1,8(sp)
 19c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 19e:	85ca                	mv	a1,s2
 1a0:	19e000ef          	jal	33e <fstat>
 1a4:	892a                	mv	s2,a0
  close(fd);
 1a6:	8526                	mv	a0,s1
 1a8:	166000ef          	jal	30e <close>
  return r;
 1ac:	64a2                	ld	s1,8(sp)
}
 1ae:	854a                	mv	a0,s2
 1b0:	60e2                	ld	ra,24(sp)
 1b2:	6442                	ld	s0,16(sp)
 1b4:	6902                	ld	s2,0(sp)
 1b6:	6105                	addi	sp,sp,32
 1b8:	8082                	ret
    return -1;
 1ba:	57fd                	li	a5,-1
 1bc:	893e                	mv	s2,a5
 1be:	bfc5                	j	1ae <stat+0x2a>

00000000000001c0 <atoi>:

int
atoi(const char *s)
{
 1c0:	1141                	addi	sp,sp,-16
 1c2:	e406                	sd	ra,8(sp)
 1c4:	e022                	sd	s0,0(sp)
 1c6:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 1c8:	00054683          	lbu	a3,0(a0)
 1cc:	fd06879b          	addiw	a5,a3,-48
 1d0:	0ff7f793          	zext.b	a5,a5
 1d4:	4625                	li	a2,9
 1d6:	02f66963          	bltu	a2,a5,208 <atoi+0x48>
 1da:	872a                	mv	a4,a0
  n = 0;
 1dc:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 1de:	0705                	addi	a4,a4,1
 1e0:	0025179b          	slliw	a5,a0,0x2
 1e4:	9fa9                	addw	a5,a5,a0
 1e6:	0017979b          	slliw	a5,a5,0x1
 1ea:	9fb5                	addw	a5,a5,a3
 1ec:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 1f0:	00074683          	lbu	a3,0(a4)
 1f4:	fd06879b          	addiw	a5,a3,-48
 1f8:	0ff7f793          	zext.b	a5,a5
 1fc:	fef671e3          	bgeu	a2,a5,1de <atoi+0x1e>
  return n;
}
 200:	60a2                	ld	ra,8(sp)
 202:	6402                	ld	s0,0(sp)
 204:	0141                	addi	sp,sp,16
 206:	8082                	ret
  n = 0;
 208:	4501                	li	a0,0
 20a:	bfdd                	j	200 <atoi+0x40>

000000000000020c <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 20c:	1141                	addi	sp,sp,-16
 20e:	e406                	sd	ra,8(sp)
 210:	e022                	sd	s0,0(sp)
 212:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 214:	02b57563          	bgeu	a0,a1,23e <memmove+0x32>
    while (n-- > 0)
 218:	00c05f63          	blez	a2,236 <memmove+0x2a>
 21c:	1602                	slli	a2,a2,0x20
 21e:	9201                	srli	a2,a2,0x20
 220:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 224:	872a                	mv	a4,a0
      *dst++ = *src++;
 226:	0585                	addi	a1,a1,1
 228:	0705                	addi	a4,a4,1
 22a:	fff5c683          	lbu	a3,-1(a1)
 22e:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 232:	fee79ae3          	bne	a5,a4,226 <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 236:	60a2                	ld	ra,8(sp)
 238:	6402                	ld	s0,0(sp)
 23a:	0141                	addi	sp,sp,16
 23c:	8082                	ret
    while (n-- > 0)
 23e:	fec05ce3          	blez	a2,236 <memmove+0x2a>
    dst += n;
 242:	00c50733          	add	a4,a0,a2
    src += n;
 246:	95b2                	add	a1,a1,a2
 248:	fff6079b          	addiw	a5,a2,-1
 24c:	1782                	slli	a5,a5,0x20
 24e:	9381                	srli	a5,a5,0x20
 250:	fff7c793          	not	a5,a5
 254:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 256:	15fd                	addi	a1,a1,-1
 258:	177d                	addi	a4,a4,-1
 25a:	0005c683          	lbu	a3,0(a1)
 25e:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 262:	fef71ae3          	bne	a4,a5,256 <memmove+0x4a>
 266:	bfc1                	j	236 <memmove+0x2a>

0000000000000268 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 268:	1141                	addi	sp,sp,-16
 26a:	e406                	sd	ra,8(sp)
 26c:	e022                	sd	s0,0(sp)
 26e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 270:	ce19                	beqz	a2,28e <memcmp+0x26>
 272:	1602                	slli	a2,a2,0x20
 274:	9201                	srli	a2,a2,0x20
 276:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 27a:	00054783          	lbu	a5,0(a0)
 27e:	0005c703          	lbu	a4,0(a1)
 282:	00e79b63          	bne	a5,a4,298 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 286:	0505                	addi	a0,a0,1
    p2++;
 288:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 28a:	fed518e3          	bne	a0,a3,27a <memcmp+0x12>
  }
  return 0;
 28e:	4501                	li	a0,0
}
 290:	60a2                	ld	ra,8(sp)
 292:	6402                	ld	s0,0(sp)
 294:	0141                	addi	sp,sp,16
 296:	8082                	ret
      return *p1 - *p2;
 298:	40e7853b          	subw	a0,a5,a4
 29c:	bfd5                	j	290 <memcmp+0x28>

000000000000029e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 29e:	1141                	addi	sp,sp,-16
 2a0:	e406                	sd	ra,8(sp)
 2a2:	e022                	sd	s0,0(sp)
 2a4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2a6:	f67ff0ef          	jal	20c <memmove>
}
 2aa:	60a2                	ld	ra,8(sp)
 2ac:	6402                	ld	s0,0(sp)
 2ae:	0141                	addi	sp,sp,16
 2b0:	8082                	ret

00000000000002b2 <sbrk>:

char *
sbrk(int n)
{
 2b2:	1141                	addi	sp,sp,-16
 2b4:	e406                	sd	ra,8(sp)
 2b6:	e022                	sd	s0,0(sp)
 2b8:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 2ba:	4585                	li	a1,1
 2bc:	0b2000ef          	jal	36e <sys_sbrk>
}
 2c0:	60a2                	ld	ra,8(sp)
 2c2:	6402                	ld	s0,0(sp)
 2c4:	0141                	addi	sp,sp,16
 2c6:	8082                	ret

00000000000002c8 <sbrklazy>:

char *
sbrklazy(int n)
{
 2c8:	1141                	addi	sp,sp,-16
 2ca:	e406                	sd	ra,8(sp)
 2cc:	e022                	sd	s0,0(sp)
 2ce:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 2d0:	4589                	li	a1,2
 2d2:	09c000ef          	jal	36e <sys_sbrk>
}
 2d6:	60a2                	ld	ra,8(sp)
 2d8:	6402                	ld	s0,0(sp)
 2da:	0141                	addi	sp,sp,16
 2dc:	8082                	ret

00000000000002de <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2de:	4885                	li	a7,1
 ecall
 2e0:	00000073          	ecall
 ret
 2e4:	8082                	ret

00000000000002e6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2e6:	4889                	li	a7,2
 ecall
 2e8:	00000073          	ecall
 ret
 2ec:	8082                	ret

00000000000002ee <wait>:
.global wait
wait:
 li a7, SYS_wait
 2ee:	488d                	li	a7,3
 ecall
 2f0:	00000073          	ecall
 ret
 2f4:	8082                	ret

00000000000002f6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2f6:	4891                	li	a7,4
 ecall
 2f8:	00000073          	ecall
 ret
 2fc:	8082                	ret

00000000000002fe <read>:
.global read
read:
 li a7, SYS_read
 2fe:	4895                	li	a7,5
 ecall
 300:	00000073          	ecall
 ret
 304:	8082                	ret

0000000000000306 <write>:
.global write
write:
 li a7, SYS_write
 306:	48c1                	li	a7,16
 ecall
 308:	00000073          	ecall
 ret
 30c:	8082                	ret

000000000000030e <close>:
.global close
close:
 li a7, SYS_close
 30e:	48d5                	li	a7,21
 ecall
 310:	00000073          	ecall
 ret
 314:	8082                	ret

0000000000000316 <kill>:
.global kill
kill:
 li a7, SYS_kill
 316:	4899                	li	a7,6
 ecall
 318:	00000073          	ecall
 ret
 31c:	8082                	ret

000000000000031e <exec>:
.global exec
exec:
 li a7, SYS_exec
 31e:	489d                	li	a7,7
 ecall
 320:	00000073          	ecall
 ret
 324:	8082                	ret

0000000000000326 <open>:
.global open
open:
 li a7, SYS_open
 326:	48bd                	li	a7,15
 ecall
 328:	00000073          	ecall
 ret
 32c:	8082                	ret

000000000000032e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 32e:	48c5                	li	a7,17
 ecall
 330:	00000073          	ecall
 ret
 334:	8082                	ret

0000000000000336 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 336:	48c9                	li	a7,18
 ecall
 338:	00000073          	ecall
 ret
 33c:	8082                	ret

000000000000033e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 33e:	48a1                	li	a7,8
 ecall
 340:	00000073          	ecall
 ret
 344:	8082                	ret

0000000000000346 <link>:
.global link
link:
 li a7, SYS_link
 346:	48cd                	li	a7,19
 ecall
 348:	00000073          	ecall
 ret
 34c:	8082                	ret

000000000000034e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 34e:	48d1                	li	a7,20
 ecall
 350:	00000073          	ecall
 ret
 354:	8082                	ret

0000000000000356 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 356:	48a5                	li	a7,9
 ecall
 358:	00000073          	ecall
 ret
 35c:	8082                	ret

000000000000035e <dup>:
.global dup
dup:
 li a7, SYS_dup
 35e:	48a9                	li	a7,10
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 366:	48ad                	li	a7,11
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 36e:	48b1                	li	a7,12
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <pause>:
.global pause
pause:
 li a7, SYS_pause
 376:	48b5                	li	a7,13
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 37e:	48b9                	li	a7,14
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <sync>:
.global sync
sync:
 li a7, SYS_sync
 386:	48d9                	li	a7,22
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <wait2>:
.global wait2
wait2:
 li a7, SYS_wait2
 38e:	48dd                	li	a7,23
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 396:	1101                	addi	sp,sp,-32
 398:	ec06                	sd	ra,24(sp)
 39a:	e822                	sd	s0,16(sp)
 39c:	1000                	addi	s0,sp,32
 39e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3a2:	4605                	li	a2,1
 3a4:	fef40593          	addi	a1,s0,-17
 3a8:	f5fff0ef          	jal	306 <write>
}
 3ac:	60e2                	ld	ra,24(sp)
 3ae:	6442                	ld	s0,16(sp)
 3b0:	6105                	addi	sp,sp,32
 3b2:	8082                	ret

00000000000003b4 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 3b4:	715d                	addi	sp,sp,-80
 3b6:	e486                	sd	ra,72(sp)
 3b8:	e0a2                	sd	s0,64(sp)
 3ba:	f84a                	sd	s2,48(sp)
 3bc:	f44e                	sd	s3,40(sp)
 3be:	0880                	addi	s0,sp,80
 3c0:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
 3c2:	00d036b3          	snez	a3,a3
 3c6:	03f5d793          	srli	a5,a1,0x3f
 3ca:	8efd                	and	a3,a3,a5
  neg = 0;
 3cc:	4301                	li	t1,0
  if (sgn && xx < 0) {
 3ce:	c681                	beqz	a3,3d6 <printint+0x22>
    neg = 1;
    x = -xx;
 3d0:	40b005b3          	neg	a1,a1
    neg = 1;
 3d4:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 3d6:	fb840993          	addi	s3,s0,-72
  neg = 0;
 3da:	86ce                	mv	a3,s3
  i = 0;
 3dc:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
 3de:	00000817          	auipc	a6,0x0
 3e2:	54280813          	addi	a6,a6,1346 # 920 <digits>
 3e6:	88ba                	mv	a7,a4
 3e8:	0017051b          	addiw	a0,a4,1
 3ec:	872a                	mv	a4,a0
 3ee:	02c5f7b3          	remu	a5,a1,a2
 3f2:	97c2                	add	a5,a5,a6
 3f4:	0007c783          	lbu	a5,0(a5)
 3f8:	00f68023          	sb	a5,0(a3)
  } while ((x /= base) != 0);
 3fc:	87ae                	mv	a5,a1
 3fe:	02c5d5b3          	divu	a1,a1,a2
 402:	0685                	addi	a3,a3,1
 404:	fec7f1e3          	bgeu	a5,a2,3e6 <printint+0x32>
  if (neg)
 408:	00030b63          	beqz	t1,41e <printint+0x6a>
    buf[i++] = '-';
 40c:	fd040793          	addi	a5,s0,-48
 410:	953e                	add	a0,a0,a5
 412:	02d00793          	li	a5,45
 416:	fef50423          	sb	a5,-24(a0)
 41a:	0028871b          	addiw	a4,a7,2

  while (--i >= 0)
 41e:	02e05563          	blez	a4,448 <printint+0x94>
 422:	fc26                	sd	s1,56(sp)
 424:	377d                	addiw	a4,a4,-1
 426:	00e984b3          	add	s1,s3,a4
 42a:	19fd                	addi	s3,s3,-1
 42c:	99ba                	add	s3,s3,a4
 42e:	1702                	slli	a4,a4,0x20
 430:	9301                	srli	a4,a4,0x20
 432:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 436:	0004c583          	lbu	a1,0(s1)
 43a:	854a                	mv	a0,s2
 43c:	f5bff0ef          	jal	396 <putc>
  while (--i >= 0)
 440:	14fd                	addi	s1,s1,-1
 442:	ff349ae3          	bne	s1,s3,436 <printint+0x82>
 446:	74e2                	ld	s1,56(sp)
}
 448:	60a6                	ld	ra,72(sp)
 44a:	6406                	ld	s0,64(sp)
 44c:	7942                	ld	s2,48(sp)
 44e:	79a2                	ld	s3,40(sp)
 450:	6161                	addi	sp,sp,80
 452:	8082                	ret

0000000000000454 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 454:	711d                	addi	sp,sp,-96
 456:	ec86                	sd	ra,88(sp)
 458:	e8a2                	sd	s0,80(sp)
 45a:	e4a6                	sd	s1,72(sp)
 45c:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 45e:	0005c483          	lbu	s1,0(a1)
 462:	2a048063          	beqz	s1,702 <vprintf+0x2ae>
 466:	e0ca                	sd	s2,64(sp)
 468:	fc4e                	sd	s3,56(sp)
 46a:	f852                	sd	s4,48(sp)
 46c:	f456                	sd	s5,40(sp)
 46e:	f05a                	sd	s6,32(sp)
 470:	ec5e                	sd	s7,24(sp)
 472:	e862                	sd	s8,16(sp)
 474:	8b2a                	mv	s6,a0
 476:	8a2e                	mv	s4,a1
 478:	8bb2                	mv	s7,a2
  state = 0;
 47a:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
 47c:	4901                	li	s2,0
 47e:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
 480:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
 484:	06400c13          	li	s8,100
 488:	a00d                	j	4aa <vprintf+0x56>
        putc(fd, c0);
 48a:	85a6                	mv	a1,s1
 48c:	855a                	mv	a0,s6
 48e:	f09ff0ef          	jal	396 <putc>
 492:	a019                	j	498 <vprintf+0x44>
    } else if (state == '%') {
 494:	03598363          	beq	s3,s5,4ba <vprintf+0x66>
  for (i = 0; fmt[i]; i++) {
 498:	0019079b          	addiw	a5,s2,1
 49c:	893e                	mv	s2,a5
 49e:	873e                	mv	a4,a5
 4a0:	97d2                	add	a5,a5,s4
 4a2:	0007c483          	lbu	s1,0(a5)
 4a6:	24048763          	beqz	s1,6f4 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 4aa:	0004879b          	sext.w	a5,s1
    if (state == 0) {
 4ae:	fe0993e3          	bnez	s3,494 <vprintf+0x40>
      if (c0 == '%') {
 4b2:	fd579ce3          	bne	a5,s5,48a <vprintf+0x36>
        state = '%';
 4b6:	89be                	mv	s3,a5
 4b8:	b7c5                	j	498 <vprintf+0x44>
        c1 = fmt[i + 1] & 0xff;
 4ba:	00ea06b3          	add	a3,s4,a4
 4be:	0016c603          	lbu	a2,1(a3)
      if (c1)
 4c2:	24060563          	beqz	a2,70c <vprintf+0x2b8>
      if (c0 == 'd') {
 4c6:	0b878763          	beq	a5,s8,574 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
 4ca:	f9478693          	addi	a3,a5,-108
 4ce:	0016b693          	seqz	a3,a3
 4d2:	f9c60593          	addi	a1,a2,-100
 4d6:	0015b593          	seqz	a1,a1
 4da:	8df5                	and	a1,a1,a3
 4dc:	e9c5                	bnez	a1,58c <vprintf+0x138>
        c2 = fmt[i + 2] & 0xff;
 4de:	9752                	add	a4,a4,s4
 4e0:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 4e4:	f9460713          	addi	a4,a2,-108
 4e8:	00173713          	seqz	a4,a4
 4ec:	8f75                	and	a4,a4,a3
 4ee:	f9c50593          	addi	a1,a0,-100
 4f2:	0015b593          	seqz	a1,a1
 4f6:	8df9                	and	a1,a1,a4
 4f8:	e5dd                	bnez	a1,5a6 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
 4fa:	07500593          	li	a1,117
 4fe:	0cb78163          	beq	a5,a1,5c0 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if (c0 == 'l' && c1 == 'u') {
 502:	f8b60593          	addi	a1,a2,-117
 506:	0015b593          	seqz	a1,a1
 50a:	8df5                	and	a1,a1,a3
 50c:	e5f1                	bnez	a1,5d8 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
 50e:	f8b50593          	addi	a1,a0,-117
 512:	0015b593          	seqz	a1,a1
 516:	8df9                	and	a1,a1,a4
 518:	ede9                	bnez	a1,5f2 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
 51a:	07800593          	li	a1,120
 51e:	0eb78763          	beq	a5,a1,60c <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if (c0 == 'l' && c1 == 'x') {
 522:	f8860613          	addi	a2,a2,-120
 526:	00163613          	seqz	a2,a2
 52a:	8ef1                	and	a3,a3,a2
 52c:	0e069c63          	bnez	a3,624 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
 530:	f8850513          	addi	a0,a0,-120
 534:	00153513          	seqz	a0,a0
 538:	8f69                	and	a4,a4,a0
 53a:	10071263          	bnez	a4,63e <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
 53e:	07000713          	li	a4,112
 542:	10e78a63          	beq	a5,a4,656 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
 546:	06300713          	li	a4,99
 54a:	14e78a63          	beq	a5,a4,69e <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
 54e:	07300713          	li	a4,115
 552:	16e78063          	beq	a5,a4,6b2 <vprintf+0x25e>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
 556:	02500713          	li	a4,37
 55a:	18e78863          	beq	a5,a4,6ea <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 55e:	02500593          	li	a1,37
 562:	855a                	mv	a0,s6
 564:	e33ff0ef          	jal	396 <putc>
        putc(fd, c0);
 568:	85a6                	mv	a1,s1
 56a:	855a                	mv	a0,s6
 56c:	e2bff0ef          	jal	396 <putc>
      }

      state = 0;
 570:	4981                	li	s3,0
 572:	b71d                	j	498 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 574:	008b8493          	addi	s1,s7,8
 578:	4685                	li	a3,1
 57a:	4629                	li	a2,10
 57c:	000ba583          	lw	a1,0(s7)
 580:	855a                	mv	a0,s6
 582:	e33ff0ef          	jal	3b4 <printint>
 586:	8ba6                	mv	s7,s1
      state = 0;
 588:	4981                	li	s3,0
 58a:	b739                	j	498 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 58c:	008b8493          	addi	s1,s7,8
 590:	4685                	li	a3,1
 592:	4629                	li	a2,10
 594:	000bb583          	ld	a1,0(s7)
 598:	855a                	mv	a0,s6
 59a:	e1bff0ef          	jal	3b4 <printint>
        i += 1;
 59e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 5a0:	8ba6                	mv	s7,s1
      state = 0;
 5a2:	4981                	li	s3,0
 5a4:	bdd5                	j	498 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5a6:	008b8493          	addi	s1,s7,8
 5aa:	4685                	li	a3,1
 5ac:	4629                	li	a2,10
 5ae:	000bb583          	ld	a1,0(s7)
 5b2:	855a                	mv	a0,s6
 5b4:	e01ff0ef          	jal	3b4 <printint>
        i += 2;
 5b8:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 5ba:	8ba6                	mv	s7,s1
      state = 0;
 5bc:	4981                	li	s3,0
        i += 2;
 5be:	bde9                	j	498 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 5c0:	008b8493          	addi	s1,s7,8
 5c4:	4681                	li	a3,0
 5c6:	4629                	li	a2,10
 5c8:	000be583          	lwu	a1,0(s7)
 5cc:	855a                	mv	a0,s6
 5ce:	de7ff0ef          	jal	3b4 <printint>
 5d2:	8ba6                	mv	s7,s1
      state = 0;
 5d4:	4981                	li	s3,0
 5d6:	b5c9                	j	498 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5d8:	008b8493          	addi	s1,s7,8
 5dc:	4681                	li	a3,0
 5de:	4629                	li	a2,10
 5e0:	000bb583          	ld	a1,0(s7)
 5e4:	855a                	mv	a0,s6
 5e6:	dcfff0ef          	jal	3b4 <printint>
        i += 1;
 5ea:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 5ec:	8ba6                	mv	s7,s1
      state = 0;
 5ee:	4981                	li	s3,0
 5f0:	b565                	j	498 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5f2:	008b8493          	addi	s1,s7,8
 5f6:	4681                	li	a3,0
 5f8:	4629                	li	a2,10
 5fa:	000bb583          	ld	a1,0(s7)
 5fe:	855a                	mv	a0,s6
 600:	db5ff0ef          	jal	3b4 <printint>
        i += 2;
 604:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 606:	8ba6                	mv	s7,s1
      state = 0;
 608:	4981                	li	s3,0
        i += 2;
 60a:	b579                	j	498 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 60c:	008b8493          	addi	s1,s7,8
 610:	4681                	li	a3,0
 612:	4641                	li	a2,16
 614:	000be583          	lwu	a1,0(s7)
 618:	855a                	mv	a0,s6
 61a:	d9bff0ef          	jal	3b4 <printint>
 61e:	8ba6                	mv	s7,s1
      state = 0;
 620:	4981                	li	s3,0
 622:	bd9d                	j	498 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 624:	008b8493          	addi	s1,s7,8
 628:	4681                	li	a3,0
 62a:	4641                	li	a2,16
 62c:	000bb583          	ld	a1,0(s7)
 630:	855a                	mv	a0,s6
 632:	d83ff0ef          	jal	3b4 <printint>
        i += 1;
 636:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 638:	8ba6                	mv	s7,s1
      state = 0;
 63a:	4981                	li	s3,0
 63c:	bdb1                	j	498 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 63e:	008b8493          	addi	s1,s7,8
 642:	4641                	li	a2,16
 644:	000bb583          	ld	a1,0(s7)
 648:	855a                	mv	a0,s6
 64a:	d6bff0ef          	jal	3b4 <printint>
        i += 2;
 64e:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 650:	8ba6                	mv	s7,s1
      state = 0;
 652:	4981                	li	s3,0
        i += 2;
 654:	b591                	j	498 <vprintf+0x44>
 656:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 658:	008b8793          	addi	a5,s7,8
 65c:	8cbe                	mv	s9,a5
 65e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 662:	03000593          	li	a1,48
 666:	855a                	mv	a0,s6
 668:	d2fff0ef          	jal	396 <putc>
  putc(fd, 'x');
 66c:	07800593          	li	a1,120
 670:	855a                	mv	a0,s6
 672:	d25ff0ef          	jal	396 <putc>
 676:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 678:	00000b97          	auipc	s7,0x0
 67c:	2a8b8b93          	addi	s7,s7,680 # 920 <digits>
 680:	03c9d793          	srli	a5,s3,0x3c
 684:	97de                	add	a5,a5,s7
 686:	0007c583          	lbu	a1,0(a5)
 68a:	855a                	mv	a0,s6
 68c:	d0bff0ef          	jal	396 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 690:	0992                	slli	s3,s3,0x4
 692:	34fd                	addiw	s1,s1,-1
 694:	f4f5                	bnez	s1,680 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 696:	8be6                	mv	s7,s9
      state = 0;
 698:	4981                	li	s3,0
 69a:	6ca2                	ld	s9,8(sp)
 69c:	bbf5                	j	498 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 69e:	008b8493          	addi	s1,s7,8
 6a2:	000bc583          	lbu	a1,0(s7)
 6a6:	855a                	mv	a0,s6
 6a8:	cefff0ef          	jal	396 <putc>
 6ac:	8ba6                	mv	s7,s1
      state = 0;
 6ae:	4981                	li	s3,0
 6b0:	b3e5                	j	498 <vprintf+0x44>
        if ((s = va_arg(ap, char *)) == 0)
 6b2:	008b8993          	addi	s3,s7,8
 6b6:	000bb483          	ld	s1,0(s7)
 6ba:	cc91                	beqz	s1,6d6 <vprintf+0x282>
        for (; *s; s++)
 6bc:	0004c583          	lbu	a1,0(s1)
 6c0:	c195                	beqz	a1,6e4 <vprintf+0x290>
          putc(fd, *s);
 6c2:	855a                	mv	a0,s6
 6c4:	cd3ff0ef          	jal	396 <putc>
        for (; *s; s++)
 6c8:	0485                	addi	s1,s1,1
 6ca:	0004c583          	lbu	a1,0(s1)
 6ce:	f9f5                	bnez	a1,6c2 <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 6d0:	8bce                	mv	s7,s3
      state = 0;
 6d2:	4981                	li	s3,0
 6d4:	b3d1                	j	498 <vprintf+0x44>
          s = "(null)";
 6d6:	00000497          	auipc	s1,0x0
 6da:	24248493          	addi	s1,s1,578 # 918 <malloc+0x110>
        for (; *s; s++)
 6de:	02800593          	li	a1,40
 6e2:	b7c5                	j	6c2 <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 6e4:	8bce                	mv	s7,s3
      state = 0;
 6e6:	4981                	li	s3,0
 6e8:	bb45                	j	498 <vprintf+0x44>
        putc(fd, '%');
 6ea:	85be                	mv	a1,a5
 6ec:	855a                	mv	a0,s6
 6ee:	ca9ff0ef          	jal	396 <putc>
 6f2:	bdbd                	j	570 <vprintf+0x11c>
 6f4:	6906                	ld	s2,64(sp)
 6f6:	79e2                	ld	s3,56(sp)
 6f8:	7a42                	ld	s4,48(sp)
 6fa:	7aa2                	ld	s5,40(sp)
 6fc:	7b02                	ld	s6,32(sp)
 6fe:	6be2                	ld	s7,24(sp)
 700:	6c42                	ld	s8,16(sp)
    }
  }
}
 702:	60e6                	ld	ra,88(sp)
 704:	6446                	ld	s0,80(sp)
 706:	64a6                	ld	s1,72(sp)
 708:	6125                	addi	sp,sp,96
 70a:	8082                	ret
      if (c0 == 'd') {
 70c:	06400713          	li	a4,100
 710:	e6e782e3          	beq	a5,a4,574 <vprintf+0x120>
      } else if (c0 == 'l' && c1 == 'd') {
 714:	f9478693          	addi	a3,a5,-108
 718:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 71c:	8532                	mv	a0,a2
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 71e:	4701                	li	a4,0
 720:	bbe9                	j	4fa <vprintf+0xa6>

0000000000000722 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 722:	715d                	addi	sp,sp,-80
 724:	ec06                	sd	ra,24(sp)
 726:	e822                	sd	s0,16(sp)
 728:	1000                	addi	s0,sp,32
 72a:	e010                	sd	a2,0(s0)
 72c:	e414                	sd	a3,8(s0)
 72e:	e818                	sd	a4,16(s0)
 730:	ec1c                	sd	a5,24(s0)
 732:	03043023          	sd	a6,32(s0)
 736:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 73a:	8622                	mv	a2,s0
 73c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 740:	d15ff0ef          	jal	454 <vprintf>
}
 744:	60e2                	ld	ra,24(sp)
 746:	6442                	ld	s0,16(sp)
 748:	6161                	addi	sp,sp,80
 74a:	8082                	ret

000000000000074c <printf>:

void
printf(const char *fmt, ...)
{
 74c:	711d                	addi	sp,sp,-96
 74e:	ec06                	sd	ra,24(sp)
 750:	e822                	sd	s0,16(sp)
 752:	1000                	addi	s0,sp,32
 754:	e40c                	sd	a1,8(s0)
 756:	e810                	sd	a2,16(s0)
 758:	ec14                	sd	a3,24(s0)
 75a:	f018                	sd	a4,32(s0)
 75c:	f41c                	sd	a5,40(s0)
 75e:	03043823          	sd	a6,48(s0)
 762:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 766:	00840613          	addi	a2,s0,8
 76a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 76e:	85aa                	mv	a1,a0
 770:	4505                	li	a0,1
 772:	ce3ff0ef          	jal	454 <vprintf>
}
 776:	60e2                	ld	ra,24(sp)
 778:	6442                	ld	s0,16(sp)
 77a:	6125                	addi	sp,sp,96
 77c:	8082                	ret

000000000000077e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 77e:	1141                	addi	sp,sp,-16
 780:	e406                	sd	ra,8(sp)
 782:	e022                	sd	s0,0(sp)
 784:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 786:	ff050713          	addi	a4,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 78a:	00001797          	auipc	a5,0x1
 78e:	8767b783          	ld	a5,-1930(a5) # 1000 <freep>
 792:	a095                	j	7f6 <free+0x78>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if (bp + bp->s.size == p->s.ptr) {
 794:	ff852583          	lw	a1,-8(a0)
 798:	6390                	ld	a2,0(a5)
 79a:	02059813          	slli	a6,a1,0x20
 79e:	01c85693          	srli	a3,a6,0x1c
 7a2:	96ba                	add	a3,a3,a4
 7a4:	02d60563          	beq	a2,a3,7ce <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 7a8:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
 7ac:	4790                	lw	a2,8(a5)
 7ae:	02061593          	slli	a1,a2,0x20
 7b2:	01c5d693          	srli	a3,a1,0x1c
 7b6:	96be                	add	a3,a3,a5
 7b8:	02d70263          	beq	a4,a3,7dc <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 7bc:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7be:	00001717          	auipc	a4,0x1
 7c2:	84f73123          	sd	a5,-1982(a4) # 1000 <freep>
}
 7c6:	60a2                	ld	ra,8(sp)
 7c8:	6402                	ld	s0,0(sp)
 7ca:	0141                	addi	sp,sp,16
 7cc:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 7ce:	4614                	lw	a3,8(a2)
 7d0:	9ead                	addw	a3,a3,a1
 7d2:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7d6:	6394                	ld	a3,0(a5)
 7d8:	6290                	ld	a2,0(a3)
 7da:	b7f9                	j	7a8 <free+0x2a>
    p->s.size += bp->s.size;
 7dc:	ff852703          	lw	a4,-8(a0)
 7e0:	9f31                	addw	a4,a4,a2
 7e2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7e4:	ff053703          	ld	a4,-16(a0)
 7e8:	bfd1                	j	7bc <free+0x3e>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ea:	6394                	ld	a3,0(a5)
 7ec:	00d7e463          	bltu	a5,a3,7f4 <free+0x76>
 7f0:	fad762e3          	bltu	a4,a3,794 <free+0x16>
 7f4:	87b6                	mv	a5,a3
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f6:	fee7fae3          	bgeu	a5,a4,7ea <free+0x6c>
 7fa:	6394                	ld	a3,0(a5)
 7fc:	f8d76ce3          	bltu	a4,a3,794 <free+0x16>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 800:	f8d7fae3          	bgeu	a5,a3,794 <free+0x16>
 804:	87b6                	mv	a5,a3
 806:	bfc5                	j	7f6 <free+0x78>

0000000000000808 <malloc>:
  return freep;
}

void *
malloc(uint nbytes)
{
 808:	7139                	addi	sp,sp,-64
 80a:	fc06                	sd	ra,56(sp)
 80c:	f822                	sd	s0,48(sp)
 80e:	f04a                	sd	s2,32(sp)
 810:	ec4e                	sd	s3,24(sp)
 812:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 814:	02051993          	slli	s3,a0,0x20
 818:	0209d993          	srli	s3,s3,0x20
 81c:	09bd                	addi	s3,s3,15
 81e:	0049d993          	srli	s3,s3,0x4
 822:	2985                	addiw	s3,s3,1
 824:	894e                	mv	s2,s3
  if ((prevp = freep) == 0) {
 826:	00000517          	auipc	a0,0x0
 82a:	7da53503          	ld	a0,2010(a0) # 1000 <freep>
 82e:	c905                	beqz	a0,85e <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 830:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 832:	4798                	lw	a4,8(a5)
 834:	09377663          	bgeu	a4,s3,8c0 <malloc+0xb8>
 838:	f426                	sd	s1,40(sp)
 83a:	e852                	sd	s4,16(sp)
 83c:	e456                	sd	s5,8(sp)
 83e:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 840:	8a4e                	mv	s4,s3
 842:	6705                	lui	a4,0x1
 844:	00e9f363          	bgeu	s3,a4,84a <malloc+0x42>
 848:	6a05                	lui	s4,0x1
 84a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 84e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
 852:	00000497          	auipc	s1,0x0
 856:	7ae48493          	addi	s1,s1,1966 # 1000 <freep>
  if (p == SBRK_ERROR)
 85a:	5afd                	li	s5,-1
 85c:	a83d                	j	89a <malloc+0x92>
 85e:	f426                	sd	s1,40(sp)
 860:	e852                	sd	s4,16(sp)
 862:	e456                	sd	s5,8(sp)
 864:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 866:	00000797          	auipc	a5,0x0
 86a:	7aa78793          	addi	a5,a5,1962 # 1010 <base>
 86e:	00000717          	auipc	a4,0x0
 872:	78f73923          	sd	a5,1938(a4) # 1000 <freep>
 876:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 878:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
 87c:	b7d1                	j	840 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 87e:	6398                	ld	a4,0(a5)
 880:	e118                	sd	a4,0(a0)
 882:	a899                	j	8d8 <malloc+0xd0>
  hp->s.size = nu;
 884:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
 888:	0541                	addi	a0,a0,16
 88a:	ef5ff0ef          	jal	77e <free>
  return freep;
 88e:	6088                	ld	a0,0(s1)
      if ((p = morecore(nunits)) == 0)
 890:	c125                	beqz	a0,8f0 <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 892:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 894:	4798                	lw	a4,8(a5)
 896:	03277163          	bgeu	a4,s2,8b8 <malloc+0xb0>
    if (p == freep)
 89a:	6098                	ld	a4,0(s1)
 89c:	853e                	mv	a0,a5
 89e:	fef71ae3          	bne	a4,a5,892 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 8a2:	8552                	mv	a0,s4
 8a4:	a0fff0ef          	jal	2b2 <sbrk>
  if (p == SBRK_ERROR)
 8a8:	fd551ee3          	bne	a0,s5,884 <malloc+0x7c>
        return 0;
 8ac:	4501                	li	a0,0
 8ae:	74a2                	ld	s1,40(sp)
 8b0:	6a42                	ld	s4,16(sp)
 8b2:	6aa2                	ld	s5,8(sp)
 8b4:	6b02                	ld	s6,0(sp)
 8b6:	a03d                	j	8e4 <malloc+0xdc>
 8b8:	74a2                	ld	s1,40(sp)
 8ba:	6a42                	ld	s4,16(sp)
 8bc:	6aa2                	ld	s5,8(sp)
 8be:	6b02                	ld	s6,0(sp)
      if (p->s.size == nunits)
 8c0:	fae90fe3          	beq	s2,a4,87e <malloc+0x76>
        p->s.size -= nunits;
 8c4:	4137073b          	subw	a4,a4,s3
 8c8:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8ca:	02071693          	slli	a3,a4,0x20
 8ce:	01c6d713          	srli	a4,a3,0x1c
 8d2:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8d4:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8d8:	00000717          	auipc	a4,0x0
 8dc:	72a73423          	sd	a0,1832(a4) # 1000 <freep>
      return (void *)(p + 1);
 8e0:	01078513          	addi	a0,a5,16
  }
}
 8e4:	70e2                	ld	ra,56(sp)
 8e6:	7442                	ld	s0,48(sp)
 8e8:	7902                	ld	s2,32(sp)
 8ea:	69e2                	ld	s3,24(sp)
 8ec:	6121                	addi	sp,sp,64
 8ee:	8082                	ret
 8f0:	74a2                	ld	s1,40(sp)
 8f2:	6a42                	ld	s4,16(sp)
 8f4:	6aa2                	ld	s5,8(sp)
 8f6:	6b02                	ld	s6,0(sp)
 8f8:	b7f5                	j	8e4 <malloc+0xdc>
