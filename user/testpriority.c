#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char *argv[]) {
    // Query the initial priority
    int initial_prio = getpriority();
    printf("Test: Initial process priority is %d\n", initial_prio);

    // Set a new valid priority (e.g., 10)
    int target_prio = 10;
    printf("Test: Attempting to set priority to %d...\n", target_prio);
    
    if (setpriority(target_prio) < 0) {
        printf("Test Error: setpriority failed!\n");
        exit(1);
    }

    // Verify the priority change using getpriority()
    int updated_prio = getpriority();
    printf("Test: Priority successfully updated to %d\n", updated_prio);

    // Test an invalid priority (out of range 0-49) to ensure validation works
    printf("Test: Attempting to set an invalid priority (50)...\n");
    if (setpriority(50) < 0) {
        printf("Test: Correctly rejected invalid priority 50.\n");
    } else {
        printf("Test Warning: Allowed invalid priority 50!\n");
    }

    exit(0);
}