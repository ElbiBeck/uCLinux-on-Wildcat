#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>

int main() {
    pid_t pid;

    printf("This is the parent (PID: %d) before vfork\n", getpid());

    pid = vfork();

    if (pid < 0) {
        perror("parent vfork failed");
        exit(1);
    } 
    else if (pid == 0) {
        // Parent fork success
        printf("This is the child process (PID: %d)\n", getpid());

        pid_t pid2 = vfork();

        if (pid2 < 0) {
            perror("child vfork failed");
            exit(1);
        }
        else if(pid2 == 0) {
            // Child fork success
            printf("This is the grandchild process (PID: %d)\n", getpid());
            _exit(1);
        }
        else {
            printf("This is the child process (PID: %d) after resuming from grand-child process\n", getpid());
        }

        _exit(1);
    } 
    else {
        printf("This is the parent process (PID: %d) after resuming from child process\n", getpid());
    }

    return 0;
}
