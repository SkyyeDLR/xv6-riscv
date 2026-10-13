#include "kernel/param.h"
#include "kernel/types.h"
#include "kernel/pstat.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
  struct pstat uproc[NPROC];
  int nprocs;
  int i;
  char *state;
  static char *states[] = {
    [UNUSED]    = "unused",
    [USED]      = "used",
    [SLEEPING]  = "sleeping",
    [RUNNABLE]  = "runnable",
    [RUNNING]   = "running ",
    [ZOMBIE]    = "zombie  "
  };

  nprocs = getprocs(uproc);
  printf("nprocs = %d\n", nprocs);
  if (nprocs < 0)
    exit(-1);

  printf("pid\tstate\t\tsize\tage\tpriority\tcputime\tppid\tname\n");  

  for (i = 0; i < nprocs; i++) {
    if (uproc[i].state == UNUSED)
      continue;

    state = states[uproc[i].state];
    uint64 age = 0;
    if (uproc[i].state == RUNNABLE) {
      age = uptime() - uproc[i].readytime;
    }

    printf("%d\t%s\t%ld\t%ld\t%d\t\t%d\t\t%d\t%s\n",        
        uproc[i].pid, 
        state,
        uproc[i].size, 
        age, 
        uproc[i].priority,
        uproc[i].cputime,
        uproc[i].ppid, 
        uproc[i].name);
  }
  exit(0);
}