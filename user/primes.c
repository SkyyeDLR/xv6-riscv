#include "kernel/types.h" 
#include "user/user.h"

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Winfinite-recursion"

void
primes(int in_fd) {
int p; 
  if (read(in_fd, &p, sizeof(p)) == 0) { 
    // TODO: this stage has nothing left to filter. Clean up 
    // this stage's own end of its input pipe before exiting. 
    exit(0); 
  } 
  printf("prime %d\n", p);
}
