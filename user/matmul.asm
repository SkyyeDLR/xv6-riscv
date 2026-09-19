
user/_matmul:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user/user.h"

#define ROWS 1000
#define COLUMNS 1000

int main(int argc, char **argv) {
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	84aa                	mv	s1,a0
  10:	89ae                	mv	s3,a1
  int a[ROWS][COLUMNS];
  int b[ROWS][COLUMNS];
  int c[ROWS][COLUMNS];
 
  /* Start timing */
  int start_time = uptime(); 
  12:	3b0000ef          	jal	3c2 <uptime>
  16:	892a                	mv	s2,a0

  iterations = 1;
  if (argc == 2)
  18:	4789                	li	a5,2
  iterations = 1;
  1a:	4605                	li	a2,1
  if (argc == 2)
  1c:	04f48463          	beq	s1,a5,64 <main+0x64>
  iterations = 1;
  20:	4581                	li	a1,0
int main(int argc, char **argv) {
  22:	3e800693          	li	a3,1000
  26:	8736                	mv	a4,a3
  28:	87b6                	mv	a5,a3
    iterations = atoi(argv[1]);

  for (ii = 0; ii < iterations; ii++) {
  /* Initialize */
  for (i=0; i<ROWS; i++) {
    for (j=0; j<COLUMNS; j++) {
  2a:	37fd                	addiw	a5,a5,-1
  2c:	fffd                	bnez	a5,2a <main+0x2a>
  for (i=0; i<ROWS; i++) {
  2e:	377d                	addiw	a4,a4,-1
  30:	ff65                	bnez	a4,28 <main+0x28>
  32:	8536                	mv	a0,a3
int main(int argc, char **argv) {
  34:	8736                	mv	a4,a3
  36:	87b6                	mv	a5,a3
    Multiply Matrices 
    (SQUARE)
  */
  for (i=0; i<ROWS; i++) {
    for (j=0; j<COLUMNS; j++) {
      for (k=0; k<COLUMNS; k++) {
  38:	37fd                	addiw	a5,a5,-1
  3a:	fffd                	bnez	a5,38 <main+0x38>
    for (j=0; j<COLUMNS; j++) {
  3c:	377d                	addiw	a4,a4,-1
  3e:	ff65                	bnez	a4,36 <main+0x36>
  for (i=0; i<ROWS; i++) {
  40:	357d                	addiw	a0,a0,-1
  42:	f96d                	bnez	a0,34 <main+0x34>
  for (ii = 0; ii < iterations; ii++) {
  44:	2585                	addiw	a1,a1,1
  46:	fec590e3          	bne	a1,a2,26 <main+0x26>
      printf("\n");
    }
  }
  }
  /* Stop Timing */
  int end_time = uptime();
  4a:	378000ef          	jal	3c2 <uptime>

  /* Report Time */
  printf("Time: %d ticks\n", end_time - start_time);
  4e:	412505bb          	subw	a1,a0,s2
  52:	00001517          	auipc	a0,0x1
  56:	8ee50513          	addi	a0,a0,-1810 # 940 <malloc+0xf4>
  5a:	736000ef          	jal	790 <printf>

  exit(0);
  5e:	4501                	li	a0,0
  60:	2ca000ef          	jal	32a <exit>
    iterations = atoi(argv[1]);
  64:	0089b503          	ld	a0,8(s3)
  68:	19c000ef          	jal	204 <atoi>
  6c:	862a                	mv	a2,a0
  for (ii = 0; ii < iterations; ii++) {
  6e:	fca05ee3          	blez	a0,4a <main+0x4a>
  72:	b77d                	j	20 <main+0x20>

0000000000000074 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  74:	1141                	addi	sp,sp,-16
  76:	e406                	sd	ra,8(sp)
  78:	e022                	sd	s0,0(sp)
  7a:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  7c:	f85ff0ef          	jal	0 <main>
  exit(r);
  80:	2aa000ef          	jal	32a <exit>

0000000000000084 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
  84:	1141                	addi	sp,sp,-16
  86:	e406                	sd	ra,8(sp)
  88:	e022                	sd	s0,0(sp)
  8a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  8c:	87aa                	mv	a5,a0
  8e:	0585                	addi	a1,a1,1
  90:	0785                	addi	a5,a5,1
  92:	fff5c703          	lbu	a4,-1(a1)
  96:	fee78fa3          	sb	a4,-1(a5)
  9a:	fb75                	bnez	a4,8e <strcpy+0xa>
    ;
  return os;
}
  9c:	60a2                	ld	ra,8(sp)
  9e:	6402                	ld	s0,0(sp)
  a0:	0141                	addi	sp,sp,16
  a2:	8082                	ret

00000000000000a4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a4:	1141                	addi	sp,sp,-16
  a6:	e406                	sd	ra,8(sp)
  a8:	e022                	sd	s0,0(sp)
  aa:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
  ac:	00054783          	lbu	a5,0(a0)
  b0:	cb91                	beqz	a5,c4 <strcmp+0x20>
  b2:	0005c703          	lbu	a4,0(a1)
  b6:	00f71763          	bne	a4,a5,c4 <strcmp+0x20>
    p++, q++;
  ba:	0505                	addi	a0,a0,1
  bc:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
  be:	00054783          	lbu	a5,0(a0)
  c2:	fbe5                	bnez	a5,b2 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  c4:	0005c503          	lbu	a0,0(a1)
}
  c8:	40a7853b          	subw	a0,a5,a0
  cc:	60a2                	ld	ra,8(sp)
  ce:	6402                	ld	s0,0(sp)
  d0:	0141                	addi	sp,sp,16
  d2:	8082                	ret

00000000000000d4 <strlen>:

uint
strlen(const char *s)
{
  d4:	1141                	addi	sp,sp,-16
  d6:	e406                	sd	ra,8(sp)
  d8:	e022                	sd	s0,0(sp)
  da:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
  dc:	00054783          	lbu	a5,0(a0)
  e0:	cf91                	beqz	a5,fc <strlen+0x28>
  e2:	00150793          	addi	a5,a0,1
  e6:	86be                	mv	a3,a5
  e8:	0785                	addi	a5,a5,1
  ea:	fff7c703          	lbu	a4,-1(a5)
  ee:	ff65                	bnez	a4,e6 <strlen+0x12>
  f0:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
  f4:	60a2                	ld	ra,8(sp)
  f6:	6402                	ld	s0,0(sp)
  f8:	0141                	addi	sp,sp,16
  fa:	8082                	ret
  for (n = 0; s[n]; n++)
  fc:	4501                	li	a0,0
  fe:	bfdd                	j	f4 <strlen+0x20>

0000000000000100 <memset>:

void *
memset(void *dst, int c, uint n)
{
 100:	1141                	addi	sp,sp,-16
 102:	e406                	sd	ra,8(sp)
 104:	e022                	sd	s0,0(sp)
 106:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
 108:	ca19                	beqz	a2,11e <memset+0x1e>
 10a:	87aa                	mv	a5,a0
 10c:	1602                	slli	a2,a2,0x20
 10e:	9201                	srli	a2,a2,0x20
 110:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 114:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
 118:	0785                	addi	a5,a5,1
 11a:	fee79de3          	bne	a5,a4,114 <memset+0x14>
  }
  return dst;
}
 11e:	60a2                	ld	ra,8(sp)
 120:	6402                	ld	s0,0(sp)
 122:	0141                	addi	sp,sp,16
 124:	8082                	ret

0000000000000126 <strchr>:

char *
strchr(const char *s, char c)
{
 126:	1141                	addi	sp,sp,-16
 128:	e406                	sd	ra,8(sp)
 12a:	e022                	sd	s0,0(sp)
 12c:	0800                	addi	s0,sp,16
  for (; *s; s++)
 12e:	00054783          	lbu	a5,0(a0)
 132:	c799                	beqz	a5,140 <strchr+0x1a>
    if (*s == c)
 134:	00f58763          	beq	a1,a5,142 <strchr+0x1c>
  for (; *s; s++)
 138:	0505                	addi	a0,a0,1
 13a:	00054783          	lbu	a5,0(a0)
 13e:	fbfd                	bnez	a5,134 <strchr+0xe>
      return (char *)s;
  return 0;
 140:	4501                	li	a0,0
}
 142:	60a2                	ld	ra,8(sp)
 144:	6402                	ld	s0,0(sp)
 146:	0141                	addi	sp,sp,16
 148:	8082                	ret

000000000000014a <gets>:

char *
gets(char *buf, int max)
{
 14a:	711d                	addi	sp,sp,-96
 14c:	ec86                	sd	ra,88(sp)
 14e:	e8a2                	sd	s0,80(sp)
 150:	e4a6                	sd	s1,72(sp)
 152:	e0ca                	sd	s2,64(sp)
 154:	fc4e                	sd	s3,56(sp)
 156:	f852                	sd	s4,48(sp)
 158:	f456                	sd	s5,40(sp)
 15a:	f05a                	sd	s6,32(sp)
 15c:	ec5e                	sd	s7,24(sp)
 15e:	e862                	sd	s8,16(sp)
 160:	1080                	addi	s0,sp,96
 162:	8baa                	mv	s7,a0
 164:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
 166:	892a                	mv	s2,a0
 168:	4481                	li	s1,0
    cc = read(0, &c, 1);
 16a:	faf40b13          	addi	s6,s0,-81
 16e:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;) {
 170:	8c26                	mv	s8,s1
 172:	0014899b          	addiw	s3,s1,1
 176:	84ce                	mv	s1,s3
 178:	0349d863          	bge	s3,s4,1a8 <gets+0x5e>
    cc = read(0, &c, 1);
 17c:	8656                	mv	a2,s5
 17e:	85da                	mv	a1,s6
 180:	4501                	li	a0,0
 182:	1c0000ef          	jal	342 <read>
    if (cc < 1)
 186:	02a05163          	blez	a0,1a8 <gets+0x5e>
      break;
    buf[i++] = c;
 18a:	faf44783          	lbu	a5,-81(s0)
 18e:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 192:	0905                	addi	s2,s2,1
 194:	ff678713          	addi	a4,a5,-10
 198:	00173713          	seqz	a4,a4
 19c:	17cd                	addi	a5,a5,-13
 19e:	0017b793          	seqz	a5,a5
 1a2:	8fd9                	or	a5,a5,a4
 1a4:	d7f1                	beqz	a5,170 <gets+0x26>
    buf[i++] = c;
 1a6:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 1a8:	9c5e                	add	s8,s8,s7
 1aa:	000c0023          	sb	zero,0(s8)
  return buf;
}
 1ae:	855e                	mv	a0,s7
 1b0:	60e6                	ld	ra,88(sp)
 1b2:	6446                	ld	s0,80(sp)
 1b4:	64a6                	ld	s1,72(sp)
 1b6:	6906                	ld	s2,64(sp)
 1b8:	79e2                	ld	s3,56(sp)
 1ba:	7a42                	ld	s4,48(sp)
 1bc:	7aa2                	ld	s5,40(sp)
 1be:	7b02                	ld	s6,32(sp)
 1c0:	6be2                	ld	s7,24(sp)
 1c2:	6c42                	ld	s8,16(sp)
 1c4:	6125                	addi	sp,sp,96
 1c6:	8082                	ret

00000000000001c8 <stat>:

int
stat(const char *n, struct stat *st)
{
 1c8:	1101                	addi	sp,sp,-32
 1ca:	ec06                	sd	ra,24(sp)
 1cc:	e822                	sd	s0,16(sp)
 1ce:	e04a                	sd	s2,0(sp)
 1d0:	1000                	addi	s0,sp,32
 1d2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d4:	4581                	li	a1,0
 1d6:	194000ef          	jal	36a <open>
  if (fd < 0)
 1da:	02054263          	bltz	a0,1fe <stat+0x36>
 1de:	e426                	sd	s1,8(sp)
 1e0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1e2:	85ca                	mv	a1,s2
 1e4:	19e000ef          	jal	382 <fstat>
 1e8:	892a                	mv	s2,a0
  close(fd);
 1ea:	8526                	mv	a0,s1
 1ec:	166000ef          	jal	352 <close>
  return r;
 1f0:	64a2                	ld	s1,8(sp)
}
 1f2:	854a                	mv	a0,s2
 1f4:	60e2                	ld	ra,24(sp)
 1f6:	6442                	ld	s0,16(sp)
 1f8:	6902                	ld	s2,0(sp)
 1fa:	6105                	addi	sp,sp,32
 1fc:	8082                	ret
    return -1;
 1fe:	57fd                	li	a5,-1
 200:	893e                	mv	s2,a5
 202:	bfc5                	j	1f2 <stat+0x2a>

0000000000000204 <atoi>:

int
atoi(const char *s)
{
 204:	1141                	addi	sp,sp,-16
 206:	e406                	sd	ra,8(sp)
 208:	e022                	sd	s0,0(sp)
 20a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 20c:	00054683          	lbu	a3,0(a0)
 210:	fd06879b          	addiw	a5,a3,-48
 214:	0ff7f793          	zext.b	a5,a5
 218:	4625                	li	a2,9
 21a:	02f66963          	bltu	a2,a5,24c <atoi+0x48>
 21e:	872a                	mv	a4,a0
  n = 0;
 220:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 222:	0705                	addi	a4,a4,1
 224:	0025179b          	slliw	a5,a0,0x2
 228:	9fa9                	addw	a5,a5,a0
 22a:	0017979b          	slliw	a5,a5,0x1
 22e:	9fb5                	addw	a5,a5,a3
 230:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 234:	00074683          	lbu	a3,0(a4)
 238:	fd06879b          	addiw	a5,a3,-48
 23c:	0ff7f793          	zext.b	a5,a5
 240:	fef671e3          	bgeu	a2,a5,222 <atoi+0x1e>
  return n;
}
 244:	60a2                	ld	ra,8(sp)
 246:	6402                	ld	s0,0(sp)
 248:	0141                	addi	sp,sp,16
 24a:	8082                	ret
  n = 0;
 24c:	4501                	li	a0,0
 24e:	bfdd                	j	244 <atoi+0x40>

0000000000000250 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 250:	1141                	addi	sp,sp,-16
 252:	e406                	sd	ra,8(sp)
 254:	e022                	sd	s0,0(sp)
 256:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 258:	02b57563          	bgeu	a0,a1,282 <memmove+0x32>
    while (n-- > 0)
 25c:	00c05f63          	blez	a2,27a <memmove+0x2a>
 260:	1602                	slli	a2,a2,0x20
 262:	9201                	srli	a2,a2,0x20
 264:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 268:	872a                	mv	a4,a0
      *dst++ = *src++;
 26a:	0585                	addi	a1,a1,1
 26c:	0705                	addi	a4,a4,1
 26e:	fff5c683          	lbu	a3,-1(a1)
 272:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 276:	fee79ae3          	bne	a5,a4,26a <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 27a:	60a2                	ld	ra,8(sp)
 27c:	6402                	ld	s0,0(sp)
 27e:	0141                	addi	sp,sp,16
 280:	8082                	ret
    while (n-- > 0)
 282:	fec05ce3          	blez	a2,27a <memmove+0x2a>
    dst += n;
 286:	00c50733          	add	a4,a0,a2
    src += n;
 28a:	95b2                	add	a1,a1,a2
 28c:	fff6079b          	addiw	a5,a2,-1
 290:	1782                	slli	a5,a5,0x20
 292:	9381                	srli	a5,a5,0x20
 294:	fff7c793          	not	a5,a5
 298:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 29a:	15fd                	addi	a1,a1,-1
 29c:	177d                	addi	a4,a4,-1
 29e:	0005c683          	lbu	a3,0(a1)
 2a2:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 2a6:	fef71ae3          	bne	a4,a5,29a <memmove+0x4a>
 2aa:	bfc1                	j	27a <memmove+0x2a>

00000000000002ac <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2ac:	1141                	addi	sp,sp,-16
 2ae:	e406                	sd	ra,8(sp)
 2b0:	e022                	sd	s0,0(sp)
 2b2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2b4:	ce19                	beqz	a2,2d2 <memcmp+0x26>
 2b6:	1602                	slli	a2,a2,0x20
 2b8:	9201                	srli	a2,a2,0x20
 2ba:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 2be:	00054783          	lbu	a5,0(a0)
 2c2:	0005c703          	lbu	a4,0(a1)
 2c6:	00e79b63          	bne	a5,a4,2dc <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 2ca:	0505                	addi	a0,a0,1
    p2++;
 2cc:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2ce:	fed518e3          	bne	a0,a3,2be <memcmp+0x12>
  }
  return 0;
 2d2:	4501                	li	a0,0
}
 2d4:	60a2                	ld	ra,8(sp)
 2d6:	6402                	ld	s0,0(sp)
 2d8:	0141                	addi	sp,sp,16
 2da:	8082                	ret
      return *p1 - *p2;
 2dc:	40e7853b          	subw	a0,a5,a4
 2e0:	bfd5                	j	2d4 <memcmp+0x28>

00000000000002e2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2e2:	1141                	addi	sp,sp,-16
 2e4:	e406                	sd	ra,8(sp)
 2e6:	e022                	sd	s0,0(sp)
 2e8:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2ea:	f67ff0ef          	jal	250 <memmove>
}
 2ee:	60a2                	ld	ra,8(sp)
 2f0:	6402                	ld	s0,0(sp)
 2f2:	0141                	addi	sp,sp,16
 2f4:	8082                	ret

00000000000002f6 <sbrk>:

char *
sbrk(int n)
{
 2f6:	1141                	addi	sp,sp,-16
 2f8:	e406                	sd	ra,8(sp)
 2fa:	e022                	sd	s0,0(sp)
 2fc:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 2fe:	4585                	li	a1,1
 300:	0b2000ef          	jal	3b2 <sys_sbrk>
}
 304:	60a2                	ld	ra,8(sp)
 306:	6402                	ld	s0,0(sp)
 308:	0141                	addi	sp,sp,16
 30a:	8082                	ret

000000000000030c <sbrklazy>:

char *
sbrklazy(int n)
{
 30c:	1141                	addi	sp,sp,-16
 30e:	e406                	sd	ra,8(sp)
 310:	e022                	sd	s0,0(sp)
 312:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 314:	4589                	li	a1,2
 316:	09c000ef          	jal	3b2 <sys_sbrk>
}
 31a:	60a2                	ld	ra,8(sp)
 31c:	6402                	ld	s0,0(sp)
 31e:	0141                	addi	sp,sp,16
 320:	8082                	ret

0000000000000322 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 322:	4885                	li	a7,1
 ecall
 324:	00000073          	ecall
 ret
 328:	8082                	ret

000000000000032a <exit>:
.global exit
exit:
 li a7, SYS_exit
 32a:	4889                	li	a7,2
 ecall
 32c:	00000073          	ecall
 ret
 330:	8082                	ret

0000000000000332 <wait>:
.global wait
wait:
 li a7, SYS_wait
 332:	488d                	li	a7,3
 ecall
 334:	00000073          	ecall
 ret
 338:	8082                	ret

000000000000033a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 33a:	4891                	li	a7,4
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <read>:
.global read
read:
 li a7, SYS_read
 342:	4895                	li	a7,5
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <write>:
.global write
write:
 li a7, SYS_write
 34a:	48c1                	li	a7,16
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <close>:
.global close
close:
 li a7, SYS_close
 352:	48d5                	li	a7,21
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <kill>:
.global kill
kill:
 li a7, SYS_kill
 35a:	4899                	li	a7,6
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <exec>:
.global exec
exec:
 li a7, SYS_exec
 362:	489d                	li	a7,7
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <open>:
.global open
open:
 li a7, SYS_open
 36a:	48bd                	li	a7,15
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 372:	48c5                	li	a7,17
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 37a:	48c9                	li	a7,18
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 382:	48a1                	li	a7,8
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <link>:
.global link
link:
 li a7, SYS_link
 38a:	48cd                	li	a7,19
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 392:	48d1                	li	a7,20
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 39a:	48a5                	li	a7,9
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3a2:	48a9                	li	a7,10
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3aa:	48ad                	li	a7,11
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 3b2:	48b1                	li	a7,12
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <pause>:
.global pause
pause:
 li a7, SYS_pause
 3ba:	48b5                	li	a7,13
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3c2:	48b9                	li	a7,14
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <sync>:
.global sync
sync:
 li a7, SYS_sync
 3ca:	48d9                	li	a7,22
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <wait2>:
.global wait2
wait2:
 li a7, SYS_wait2
 3d2:	48dd                	li	a7,23
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3da:	1101                	addi	sp,sp,-32
 3dc:	ec06                	sd	ra,24(sp)
 3de:	e822                	sd	s0,16(sp)
 3e0:	1000                	addi	s0,sp,32
 3e2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3e6:	4605                	li	a2,1
 3e8:	fef40593          	addi	a1,s0,-17
 3ec:	f5fff0ef          	jal	34a <write>
}
 3f0:	60e2                	ld	ra,24(sp)
 3f2:	6442                	ld	s0,16(sp)
 3f4:	6105                	addi	sp,sp,32
 3f6:	8082                	ret

00000000000003f8 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 3f8:	715d                	addi	sp,sp,-80
 3fa:	e486                	sd	ra,72(sp)
 3fc:	e0a2                	sd	s0,64(sp)
 3fe:	f84a                	sd	s2,48(sp)
 400:	f44e                	sd	s3,40(sp)
 402:	0880                	addi	s0,sp,80
 404:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
 406:	00d036b3          	snez	a3,a3
 40a:	03f5d793          	srli	a5,a1,0x3f
 40e:	8efd                	and	a3,a3,a5
  neg = 0;
 410:	4301                	li	t1,0
  if (sgn && xx < 0) {
 412:	c681                	beqz	a3,41a <printint+0x22>
    neg = 1;
    x = -xx;
 414:	40b005b3          	neg	a1,a1
    neg = 1;
 418:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 41a:	fb840993          	addi	s3,s0,-72
  neg = 0;
 41e:	86ce                	mv	a3,s3
  i = 0;
 420:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
 422:	00000817          	auipc	a6,0x0
 426:	53680813          	addi	a6,a6,1334 # 958 <digits>
 42a:	88ba                	mv	a7,a4
 42c:	0017051b          	addiw	a0,a4,1
 430:	872a                	mv	a4,a0
 432:	02c5f7b3          	remu	a5,a1,a2
 436:	97c2                	add	a5,a5,a6
 438:	0007c783          	lbu	a5,0(a5)
 43c:	00f68023          	sb	a5,0(a3)
  } while ((x /= base) != 0);
 440:	87ae                	mv	a5,a1
 442:	02c5d5b3          	divu	a1,a1,a2
 446:	0685                	addi	a3,a3,1
 448:	fec7f1e3          	bgeu	a5,a2,42a <printint+0x32>
  if (neg)
 44c:	00030b63          	beqz	t1,462 <printint+0x6a>
    buf[i++] = '-';
 450:	fd040793          	addi	a5,s0,-48
 454:	953e                	add	a0,a0,a5
 456:	02d00793          	li	a5,45
 45a:	fef50423          	sb	a5,-24(a0)
 45e:	0028871b          	addiw	a4,a7,2

  while (--i >= 0)
 462:	02e05563          	blez	a4,48c <printint+0x94>
 466:	fc26                	sd	s1,56(sp)
 468:	377d                	addiw	a4,a4,-1
 46a:	00e984b3          	add	s1,s3,a4
 46e:	19fd                	addi	s3,s3,-1
 470:	99ba                	add	s3,s3,a4
 472:	1702                	slli	a4,a4,0x20
 474:	9301                	srli	a4,a4,0x20
 476:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 47a:	0004c583          	lbu	a1,0(s1)
 47e:	854a                	mv	a0,s2
 480:	f5bff0ef          	jal	3da <putc>
  while (--i >= 0)
 484:	14fd                	addi	s1,s1,-1
 486:	ff349ae3          	bne	s1,s3,47a <printint+0x82>
 48a:	74e2                	ld	s1,56(sp)
}
 48c:	60a6                	ld	ra,72(sp)
 48e:	6406                	ld	s0,64(sp)
 490:	7942                	ld	s2,48(sp)
 492:	79a2                	ld	s3,40(sp)
 494:	6161                	addi	sp,sp,80
 496:	8082                	ret

0000000000000498 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 498:	711d                	addi	sp,sp,-96
 49a:	ec86                	sd	ra,88(sp)
 49c:	e8a2                	sd	s0,80(sp)
 49e:	e4a6                	sd	s1,72(sp)
 4a0:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 4a2:	0005c483          	lbu	s1,0(a1)
 4a6:	2a048063          	beqz	s1,746 <vprintf+0x2ae>
 4aa:	e0ca                	sd	s2,64(sp)
 4ac:	fc4e                	sd	s3,56(sp)
 4ae:	f852                	sd	s4,48(sp)
 4b0:	f456                	sd	s5,40(sp)
 4b2:	f05a                	sd	s6,32(sp)
 4b4:	ec5e                	sd	s7,24(sp)
 4b6:	e862                	sd	s8,16(sp)
 4b8:	8b2a                	mv	s6,a0
 4ba:	8a2e                	mv	s4,a1
 4bc:	8bb2                	mv	s7,a2
  state = 0;
 4be:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
 4c0:	4901                	li	s2,0
 4c2:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
 4c4:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
 4c8:	06400c13          	li	s8,100
 4cc:	a00d                	j	4ee <vprintf+0x56>
        putc(fd, c0);
 4ce:	85a6                	mv	a1,s1
 4d0:	855a                	mv	a0,s6
 4d2:	f09ff0ef          	jal	3da <putc>
 4d6:	a019                	j	4dc <vprintf+0x44>
    } else if (state == '%') {
 4d8:	03598363          	beq	s3,s5,4fe <vprintf+0x66>
  for (i = 0; fmt[i]; i++) {
 4dc:	0019079b          	addiw	a5,s2,1
 4e0:	893e                	mv	s2,a5
 4e2:	873e                	mv	a4,a5
 4e4:	97d2                	add	a5,a5,s4
 4e6:	0007c483          	lbu	s1,0(a5)
 4ea:	24048763          	beqz	s1,738 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 4ee:	0004879b          	sext.w	a5,s1
    if (state == 0) {
 4f2:	fe0993e3          	bnez	s3,4d8 <vprintf+0x40>
      if (c0 == '%') {
 4f6:	fd579ce3          	bne	a5,s5,4ce <vprintf+0x36>
        state = '%';
 4fa:	89be                	mv	s3,a5
 4fc:	b7c5                	j	4dc <vprintf+0x44>
        c1 = fmt[i + 1] & 0xff;
 4fe:	00ea06b3          	add	a3,s4,a4
 502:	0016c603          	lbu	a2,1(a3)
      if (c1)
 506:	24060563          	beqz	a2,750 <vprintf+0x2b8>
      if (c0 == 'd') {
 50a:	0b878763          	beq	a5,s8,5b8 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
 50e:	f9478693          	addi	a3,a5,-108
 512:	0016b693          	seqz	a3,a3
 516:	f9c60593          	addi	a1,a2,-100
 51a:	0015b593          	seqz	a1,a1
 51e:	8df5                	and	a1,a1,a3
 520:	e9c5                	bnez	a1,5d0 <vprintf+0x138>
        c2 = fmt[i + 2] & 0xff;
 522:	9752                	add	a4,a4,s4
 524:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 528:	f9460713          	addi	a4,a2,-108
 52c:	00173713          	seqz	a4,a4
 530:	8f75                	and	a4,a4,a3
 532:	f9c50593          	addi	a1,a0,-100
 536:	0015b593          	seqz	a1,a1
 53a:	8df9                	and	a1,a1,a4
 53c:	e5dd                	bnez	a1,5ea <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
 53e:	07500593          	li	a1,117
 542:	0cb78163          	beq	a5,a1,604 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if (c0 == 'l' && c1 == 'u') {
 546:	f8b60593          	addi	a1,a2,-117
 54a:	0015b593          	seqz	a1,a1
 54e:	8df5                	and	a1,a1,a3
 550:	e5f1                	bnez	a1,61c <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
 552:	f8b50593          	addi	a1,a0,-117
 556:	0015b593          	seqz	a1,a1
 55a:	8df9                	and	a1,a1,a4
 55c:	ede9                	bnez	a1,636 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
 55e:	07800593          	li	a1,120
 562:	0eb78763          	beq	a5,a1,650 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if (c0 == 'l' && c1 == 'x') {
 566:	f8860613          	addi	a2,a2,-120
 56a:	00163613          	seqz	a2,a2
 56e:	8ef1                	and	a3,a3,a2
 570:	0e069c63          	bnez	a3,668 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
 574:	f8850513          	addi	a0,a0,-120
 578:	00153513          	seqz	a0,a0
 57c:	8f69                	and	a4,a4,a0
 57e:	10071263          	bnez	a4,682 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
 582:	07000713          	li	a4,112
 586:	10e78a63          	beq	a5,a4,69a <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
 58a:	06300713          	li	a4,99
 58e:	14e78a63          	beq	a5,a4,6e2 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
 592:	07300713          	li	a4,115
 596:	16e78063          	beq	a5,a4,6f6 <vprintf+0x25e>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
 59a:	02500713          	li	a4,37
 59e:	18e78863          	beq	a5,a4,72e <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5a2:	02500593          	li	a1,37
 5a6:	855a                	mv	a0,s6
 5a8:	e33ff0ef          	jal	3da <putc>
        putc(fd, c0);
 5ac:	85a6                	mv	a1,s1
 5ae:	855a                	mv	a0,s6
 5b0:	e2bff0ef          	jal	3da <putc>
      }

      state = 0;
 5b4:	4981                	li	s3,0
 5b6:	b71d                	j	4dc <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 5b8:	008b8493          	addi	s1,s7,8
 5bc:	4685                	li	a3,1
 5be:	4629                	li	a2,10
 5c0:	000ba583          	lw	a1,0(s7)
 5c4:	855a                	mv	a0,s6
 5c6:	e33ff0ef          	jal	3f8 <printint>
 5ca:	8ba6                	mv	s7,s1
      state = 0;
 5cc:	4981                	li	s3,0
 5ce:	b739                	j	4dc <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5d0:	008b8493          	addi	s1,s7,8
 5d4:	4685                	li	a3,1
 5d6:	4629                	li	a2,10
 5d8:	000bb583          	ld	a1,0(s7)
 5dc:	855a                	mv	a0,s6
 5de:	e1bff0ef          	jal	3f8 <printint>
        i += 1;
 5e2:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 5e4:	8ba6                	mv	s7,s1
      state = 0;
 5e6:	4981                	li	s3,0
 5e8:	bdd5                	j	4dc <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5ea:	008b8493          	addi	s1,s7,8
 5ee:	4685                	li	a3,1
 5f0:	4629                	li	a2,10
 5f2:	000bb583          	ld	a1,0(s7)
 5f6:	855a                	mv	a0,s6
 5f8:	e01ff0ef          	jal	3f8 <printint>
        i += 2;
 5fc:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 5fe:	8ba6                	mv	s7,s1
      state = 0;
 600:	4981                	li	s3,0
        i += 2;
 602:	bde9                	j	4dc <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 604:	008b8493          	addi	s1,s7,8
 608:	4681                	li	a3,0
 60a:	4629                	li	a2,10
 60c:	000be583          	lwu	a1,0(s7)
 610:	855a                	mv	a0,s6
 612:	de7ff0ef          	jal	3f8 <printint>
 616:	8ba6                	mv	s7,s1
      state = 0;
 618:	4981                	li	s3,0
 61a:	b5c9                	j	4dc <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 61c:	008b8493          	addi	s1,s7,8
 620:	4681                	li	a3,0
 622:	4629                	li	a2,10
 624:	000bb583          	ld	a1,0(s7)
 628:	855a                	mv	a0,s6
 62a:	dcfff0ef          	jal	3f8 <printint>
        i += 1;
 62e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 630:	8ba6                	mv	s7,s1
      state = 0;
 632:	4981                	li	s3,0
 634:	b565                	j	4dc <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 636:	008b8493          	addi	s1,s7,8
 63a:	4681                	li	a3,0
 63c:	4629                	li	a2,10
 63e:	000bb583          	ld	a1,0(s7)
 642:	855a                	mv	a0,s6
 644:	db5ff0ef          	jal	3f8 <printint>
        i += 2;
 648:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 64a:	8ba6                	mv	s7,s1
      state = 0;
 64c:	4981                	li	s3,0
        i += 2;
 64e:	b579                	j	4dc <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 650:	008b8493          	addi	s1,s7,8
 654:	4681                	li	a3,0
 656:	4641                	li	a2,16
 658:	000be583          	lwu	a1,0(s7)
 65c:	855a                	mv	a0,s6
 65e:	d9bff0ef          	jal	3f8 <printint>
 662:	8ba6                	mv	s7,s1
      state = 0;
 664:	4981                	li	s3,0
 666:	bd9d                	j	4dc <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 668:	008b8493          	addi	s1,s7,8
 66c:	4681                	li	a3,0
 66e:	4641                	li	a2,16
 670:	000bb583          	ld	a1,0(s7)
 674:	855a                	mv	a0,s6
 676:	d83ff0ef          	jal	3f8 <printint>
        i += 1;
 67a:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 67c:	8ba6                	mv	s7,s1
      state = 0;
 67e:	4981                	li	s3,0
 680:	bdb1                	j	4dc <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 682:	008b8493          	addi	s1,s7,8
 686:	4641                	li	a2,16
 688:	000bb583          	ld	a1,0(s7)
 68c:	855a                	mv	a0,s6
 68e:	d6bff0ef          	jal	3f8 <printint>
        i += 2;
 692:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 694:	8ba6                	mv	s7,s1
      state = 0;
 696:	4981                	li	s3,0
        i += 2;
 698:	b591                	j	4dc <vprintf+0x44>
 69a:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 69c:	008b8793          	addi	a5,s7,8
 6a0:	8cbe                	mv	s9,a5
 6a2:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6a6:	03000593          	li	a1,48
 6aa:	855a                	mv	a0,s6
 6ac:	d2fff0ef          	jal	3da <putc>
  putc(fd, 'x');
 6b0:	07800593          	li	a1,120
 6b4:	855a                	mv	a0,s6
 6b6:	d25ff0ef          	jal	3da <putc>
 6ba:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6bc:	00000b97          	auipc	s7,0x0
 6c0:	29cb8b93          	addi	s7,s7,668 # 958 <digits>
 6c4:	03c9d793          	srli	a5,s3,0x3c
 6c8:	97de                	add	a5,a5,s7
 6ca:	0007c583          	lbu	a1,0(a5)
 6ce:	855a                	mv	a0,s6
 6d0:	d0bff0ef          	jal	3da <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6d4:	0992                	slli	s3,s3,0x4
 6d6:	34fd                	addiw	s1,s1,-1
 6d8:	f4f5                	bnez	s1,6c4 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 6da:	8be6                	mv	s7,s9
      state = 0;
 6dc:	4981                	li	s3,0
 6de:	6ca2                	ld	s9,8(sp)
 6e0:	bbf5                	j	4dc <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 6e2:	008b8493          	addi	s1,s7,8
 6e6:	000bc583          	lbu	a1,0(s7)
 6ea:	855a                	mv	a0,s6
 6ec:	cefff0ef          	jal	3da <putc>
 6f0:	8ba6                	mv	s7,s1
      state = 0;
 6f2:	4981                	li	s3,0
 6f4:	b3e5                	j	4dc <vprintf+0x44>
        if ((s = va_arg(ap, char *)) == 0)
 6f6:	008b8993          	addi	s3,s7,8
 6fa:	000bb483          	ld	s1,0(s7)
 6fe:	cc91                	beqz	s1,71a <vprintf+0x282>
        for (; *s; s++)
 700:	0004c583          	lbu	a1,0(s1)
 704:	c195                	beqz	a1,728 <vprintf+0x290>
          putc(fd, *s);
 706:	855a                	mv	a0,s6
 708:	cd3ff0ef          	jal	3da <putc>
        for (; *s; s++)
 70c:	0485                	addi	s1,s1,1
 70e:	0004c583          	lbu	a1,0(s1)
 712:	f9f5                	bnez	a1,706 <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 714:	8bce                	mv	s7,s3
      state = 0;
 716:	4981                	li	s3,0
 718:	b3d1                	j	4dc <vprintf+0x44>
          s = "(null)";
 71a:	00000497          	auipc	s1,0x0
 71e:	23648493          	addi	s1,s1,566 # 950 <malloc+0x104>
        for (; *s; s++)
 722:	02800593          	li	a1,40
 726:	b7c5                	j	706 <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 728:	8bce                	mv	s7,s3
      state = 0;
 72a:	4981                	li	s3,0
 72c:	bb45                	j	4dc <vprintf+0x44>
        putc(fd, '%');
 72e:	85be                	mv	a1,a5
 730:	855a                	mv	a0,s6
 732:	ca9ff0ef          	jal	3da <putc>
 736:	bdbd                	j	5b4 <vprintf+0x11c>
 738:	6906                	ld	s2,64(sp)
 73a:	79e2                	ld	s3,56(sp)
 73c:	7a42                	ld	s4,48(sp)
 73e:	7aa2                	ld	s5,40(sp)
 740:	7b02                	ld	s6,32(sp)
 742:	6be2                	ld	s7,24(sp)
 744:	6c42                	ld	s8,16(sp)
    }
  }
}
 746:	60e6                	ld	ra,88(sp)
 748:	6446                	ld	s0,80(sp)
 74a:	64a6                	ld	s1,72(sp)
 74c:	6125                	addi	sp,sp,96
 74e:	8082                	ret
      if (c0 == 'd') {
 750:	06400713          	li	a4,100
 754:	e6e782e3          	beq	a5,a4,5b8 <vprintf+0x120>
      } else if (c0 == 'l' && c1 == 'd') {
 758:	f9478693          	addi	a3,a5,-108
 75c:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 760:	8532                	mv	a0,a2
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 762:	4701                	li	a4,0
 764:	bbe9                	j	53e <vprintf+0xa6>

0000000000000766 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 766:	715d                	addi	sp,sp,-80
 768:	ec06                	sd	ra,24(sp)
 76a:	e822                	sd	s0,16(sp)
 76c:	1000                	addi	s0,sp,32
 76e:	e010                	sd	a2,0(s0)
 770:	e414                	sd	a3,8(s0)
 772:	e818                	sd	a4,16(s0)
 774:	ec1c                	sd	a5,24(s0)
 776:	03043023          	sd	a6,32(s0)
 77a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 77e:	8622                	mv	a2,s0
 780:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 784:	d15ff0ef          	jal	498 <vprintf>
}
 788:	60e2                	ld	ra,24(sp)
 78a:	6442                	ld	s0,16(sp)
 78c:	6161                	addi	sp,sp,80
 78e:	8082                	ret

0000000000000790 <printf>:

void
printf(const char *fmt, ...)
{
 790:	711d                	addi	sp,sp,-96
 792:	ec06                	sd	ra,24(sp)
 794:	e822                	sd	s0,16(sp)
 796:	1000                	addi	s0,sp,32
 798:	e40c                	sd	a1,8(s0)
 79a:	e810                	sd	a2,16(s0)
 79c:	ec14                	sd	a3,24(s0)
 79e:	f018                	sd	a4,32(s0)
 7a0:	f41c                	sd	a5,40(s0)
 7a2:	03043823          	sd	a6,48(s0)
 7a6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7aa:	00840613          	addi	a2,s0,8
 7ae:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7b2:	85aa                	mv	a1,a0
 7b4:	4505                	li	a0,1
 7b6:	ce3ff0ef          	jal	498 <vprintf>
}
 7ba:	60e2                	ld	ra,24(sp)
 7bc:	6442                	ld	s0,16(sp)
 7be:	6125                	addi	sp,sp,96
 7c0:	8082                	ret

00000000000007c2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7c2:	1141                	addi	sp,sp,-16
 7c4:	e406                	sd	ra,8(sp)
 7c6:	e022                	sd	s0,0(sp)
 7c8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 7ca:	ff050713          	addi	a4,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ce:	00001797          	auipc	a5,0x1
 7d2:	8327b783          	ld	a5,-1998(a5) # 1000 <freep>
 7d6:	a095                	j	83a <free+0x78>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if (bp + bp->s.size == p->s.ptr) {
 7d8:	ff852583          	lw	a1,-8(a0)
 7dc:	6390                	ld	a2,0(a5)
 7de:	02059813          	slli	a6,a1,0x20
 7e2:	01c85693          	srli	a3,a6,0x1c
 7e6:	96ba                	add	a3,a3,a4
 7e8:	02d60563          	beq	a2,a3,812 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 7ec:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
 7f0:	4790                	lw	a2,8(a5)
 7f2:	02061593          	slli	a1,a2,0x20
 7f6:	01c5d693          	srli	a3,a1,0x1c
 7fa:	96be                	add	a3,a3,a5
 7fc:	02d70263          	beq	a4,a3,820 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 800:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 802:	00000717          	auipc	a4,0x0
 806:	7ef73f23          	sd	a5,2046(a4) # 1000 <freep>
}
 80a:	60a2                	ld	ra,8(sp)
 80c:	6402                	ld	s0,0(sp)
 80e:	0141                	addi	sp,sp,16
 810:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 812:	4614                	lw	a3,8(a2)
 814:	9ead                	addw	a3,a3,a1
 816:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 81a:	6394                	ld	a3,0(a5)
 81c:	6290                	ld	a2,0(a3)
 81e:	b7f9                	j	7ec <free+0x2a>
    p->s.size += bp->s.size;
 820:	ff852703          	lw	a4,-8(a0)
 824:	9f31                	addw	a4,a4,a2
 826:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 828:	ff053703          	ld	a4,-16(a0)
 82c:	bfd1                	j	800 <free+0x3e>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 82e:	6394                	ld	a3,0(a5)
 830:	00d7e463          	bltu	a5,a3,838 <free+0x76>
 834:	fad762e3          	bltu	a4,a3,7d8 <free+0x16>
 838:	87b6                	mv	a5,a3
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 83a:	fee7fae3          	bgeu	a5,a4,82e <free+0x6c>
 83e:	6394                	ld	a3,0(a5)
 840:	f8d76ce3          	bltu	a4,a3,7d8 <free+0x16>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 844:	f8d7fae3          	bgeu	a5,a3,7d8 <free+0x16>
 848:	87b6                	mv	a5,a3
 84a:	bfc5                	j	83a <free+0x78>

000000000000084c <malloc>:
  return freep;
}

void *
malloc(uint nbytes)
{
 84c:	7139                	addi	sp,sp,-64
 84e:	fc06                	sd	ra,56(sp)
 850:	f822                	sd	s0,48(sp)
 852:	f04a                	sd	s2,32(sp)
 854:	ec4e                	sd	s3,24(sp)
 856:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 858:	02051993          	slli	s3,a0,0x20
 85c:	0209d993          	srli	s3,s3,0x20
 860:	09bd                	addi	s3,s3,15
 862:	0049d993          	srli	s3,s3,0x4
 866:	2985                	addiw	s3,s3,1
 868:	894e                	mv	s2,s3
  if ((prevp = freep) == 0) {
 86a:	00000517          	auipc	a0,0x0
 86e:	79653503          	ld	a0,1942(a0) # 1000 <freep>
 872:	c905                	beqz	a0,8a2 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 874:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 876:	4798                	lw	a4,8(a5)
 878:	09377663          	bgeu	a4,s3,904 <malloc+0xb8>
 87c:	f426                	sd	s1,40(sp)
 87e:	e852                	sd	s4,16(sp)
 880:	e456                	sd	s5,8(sp)
 882:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 884:	8a4e                	mv	s4,s3
 886:	6705                	lui	a4,0x1
 888:	00e9f363          	bgeu	s3,a4,88e <malloc+0x42>
 88c:	6a05                	lui	s4,0x1
 88e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 892:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
 896:	00000497          	auipc	s1,0x0
 89a:	76a48493          	addi	s1,s1,1898 # 1000 <freep>
  if (p == SBRK_ERROR)
 89e:	5afd                	li	s5,-1
 8a0:	a83d                	j	8de <malloc+0x92>
 8a2:	f426                	sd	s1,40(sp)
 8a4:	e852                	sd	s4,16(sp)
 8a6:	e456                	sd	s5,8(sp)
 8a8:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8aa:	00000797          	auipc	a5,0x0
 8ae:	76678793          	addi	a5,a5,1894 # 1010 <base>
 8b2:	00000717          	auipc	a4,0x0
 8b6:	74f73723          	sd	a5,1870(a4) # 1000 <freep>
 8ba:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8bc:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
 8c0:	b7d1                	j	884 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 8c2:	6398                	ld	a4,0(a5)
 8c4:	e118                	sd	a4,0(a0)
 8c6:	a899                	j	91c <malloc+0xd0>
  hp->s.size = nu;
 8c8:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
 8cc:	0541                	addi	a0,a0,16
 8ce:	ef5ff0ef          	jal	7c2 <free>
  return freep;
 8d2:	6088                	ld	a0,0(s1)
      if ((p = morecore(nunits)) == 0)
 8d4:	c125                	beqz	a0,934 <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 8d6:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 8d8:	4798                	lw	a4,8(a5)
 8da:	03277163          	bgeu	a4,s2,8fc <malloc+0xb0>
    if (p == freep)
 8de:	6098                	ld	a4,0(s1)
 8e0:	853e                	mv	a0,a5
 8e2:	fef71ae3          	bne	a4,a5,8d6 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 8e6:	8552                	mv	a0,s4
 8e8:	a0fff0ef          	jal	2f6 <sbrk>
  if (p == SBRK_ERROR)
 8ec:	fd551ee3          	bne	a0,s5,8c8 <malloc+0x7c>
        return 0;
 8f0:	4501                	li	a0,0
 8f2:	74a2                	ld	s1,40(sp)
 8f4:	6a42                	ld	s4,16(sp)
 8f6:	6aa2                	ld	s5,8(sp)
 8f8:	6b02                	ld	s6,0(sp)
 8fa:	a03d                	j	928 <malloc+0xdc>
 8fc:	74a2                	ld	s1,40(sp)
 8fe:	6a42                	ld	s4,16(sp)
 900:	6aa2                	ld	s5,8(sp)
 902:	6b02                	ld	s6,0(sp)
      if (p->s.size == nunits)
 904:	fae90fe3          	beq	s2,a4,8c2 <malloc+0x76>
        p->s.size -= nunits;
 908:	4137073b          	subw	a4,a4,s3
 90c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 90e:	02071693          	slli	a3,a4,0x20
 912:	01c6d713          	srli	a4,a3,0x1c
 916:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 918:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 91c:	00000717          	auipc	a4,0x0
 920:	6ea73223          	sd	a0,1764(a4) # 1000 <freep>
      return (void *)(p + 1);
 924:	01078513          	addi	a0,a5,16
  }
}
 928:	70e2                	ld	ra,56(sp)
 92a:	7442                	ld	s0,48(sp)
 92c:	7902                	ld	s2,32(sp)
 92e:	69e2                	ld	s3,24(sp)
 930:	6121                	addi	sp,sp,64
 932:	8082                	ret
 934:	74a2                	ld	s1,40(sp)
 936:	6a42                	ld	s4,16(sp)
 938:	6aa2                	ld	s5,8(sp)
 93a:	6b02                	ld	s6,0(sp)
 93c:	b7f5                	j	928 <malloc+0xdc>
