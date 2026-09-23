#include "kernel/types.h"
#include "user/user.h"
#include "kernel/pstat.h"

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(2, "Usage: time <command> [args...]\n");
        exit(1);
    }

    struct rusage ru;
    int status;
    int start = uptime();
    int pid = fork();

    if (pid == 0) {
        exec(argv[1], &argv[1]);
        exit(1);
    } else {
        wait2(&status, &ru);
        int elapsed = uptime() - start;
        int cpu_pct = elapsed > 0 ? (ru.cputime * 100) / elapsed : 0;

        printf("elapsed time: %d ticks, cpu time: %d ticks, %d%% CPU\n", 
               elapsed, ru.cputime, cpu_pct);
    }
    exit(0);
}
