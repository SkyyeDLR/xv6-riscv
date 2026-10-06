#ifndef PSTAT_H
#define PSTAT_H

struct rusage {
  uint cputime;
};

struct pstat {
  int pid;
  enum procstate state;
  uint64 size;
  int ppid;
  char name[16];
};

#endif
