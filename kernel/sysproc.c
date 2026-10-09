#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"
#include "vm.h"
#include "pstat.h"

uint64
sys_exit(void)
{
  int n;
  argint(0, &n);
  kexit(n);
  return 0; // not reached
}

uint64
sys_getpid(void)
{
  return myproc()->pid;
}

uint64
sys_fork(void)
{
  return kfork();
}

uint64
sys_wait(void)
{
  uint64 p;
  argaddr(0, &p);
  return kwait(p);
}

uint64
sys_sbrk(void)
{
  uint64 addr;
  int t;
  int n;

  argint(0, &n);
  argint(1, &t);
  addr = myproc()->sz;

  if (t == SBRK_EAGER || n < 0) {
    if (growproc(n) < 0) {
      return -1;
    }
  } else {
    // Lazily allocate memory for this process: increase its memory
    // size but don't allocate memory. If the processes uses the
    // memory, vmfault() will allocate it.
    if (addr + n < addr)
      return -1;
    if (addr + n > TRAPFRAME)
      return -1;
    myproc()->sz += n;
  }
  return addr;
}

uint64
sys_pause(void)
{
  int n;
  uint ticks0;

  argint(0, &n);
  if (n < 0)
    n = 0;
  acquire(&tickslock);
  ticks0 = ticks;
  while (ticks - ticks0 < n) {
    if (killed(myproc())) {
      release(&tickslock);
      return -1;
    }
    sleep_prepare(&ticks);
    release(&tickslock);
    sleep();
    acquire(&tickslock);
  }
  release(&tickslock);
  return 0;
}

uint64
sys_kill(void)
{
  int pid;

  argint(0, &pid);
  return kkill(pid);
}

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

uint64 
sys_wait2(void) {
  uint64 addr, rusage_addr;
  argaddr(0, &addr);
  argaddr(1, &rusage_addr);
  return kwait2(addr, rusage_addr);
}

extern struct proc proc[];

uint64
sys_getprocs(void)
{
  uint64 st_addr;
  argaddr(0, &st_addr);

  struct proc *p;
  struct pstat st;
  int count = 0;

  for(p = proc; p < &proc[NPROC]; p++){
    acquire(&p->lock);
    if(p->state != UNUSED){
      st.pid = p->pid;
      st.state = p->state;
      st.size = p->sz;
      st.ppid = p->parent ? p->parent->pid : 0;
      safestrcpy(st.name, p->name, sizeof(p->name));

      uint64 dst = st_addr + count * sizeof(struct pstat);

      st.priority = p->priority;

      // Pass myproc()->sz as the 2nd parameter
      if(copyout(myproc()->pagetable, myproc()->sz, dst, (char *)&st, sizeof(struct pstat)) < 0){
        release(&p->lock);
        return -1;
      }
      count++;
    }
    release(&p->lock);
  }
  return count;
}

uint64
sys_getpriority(void)
{
  return myproc()->priority;
}

uint64
sys_setpriority(void)
{
  int new_pri;
  argint(0, &new_pri);

  // Validate range (0 to 49)
  if (new_pri < 0 || new_pri > 49)
    return -1;

  struct proc *p = myproc();
  acquire(&p->lock);
  p->priority = new_pri;
  release(&p->lock);

  return 0;
}
