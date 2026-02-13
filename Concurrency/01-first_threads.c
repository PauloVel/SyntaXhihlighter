/*
    Very simple example of using pthreads

    Gilberto Echeverria
    gilecheverria@yahoo.com
    15/03/2017
*/

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

// Function declarations
void * threadStart(void * arg);

int main(int argc, char * argv[])
{
    int num_threads = 5;
    int thread_status;
    long i;
    //void * result;

    // Change the number of threads if provided as an argument
    if (argc == 2)
        num_threads = atoi(argv[1]);

    // Create an array for the thread ID's
    // Should only work with more recent compilers
    pthread_t tid[num_threads];

    // Create the threads
    for(i=0; i<num_threads; i++)
    {
        thread_status = pthread_create(&tid[i], NULL, &threadStart, (void *)i);
        // Check for errors
        if (thread_status)
        {
            fprintf(stderr, "ERROR: pthread_create %d\n", thread_status);
            exit(EXIT_FAILURE);
        }

        printf("Created thread %ld with ID %lu\n", i, tid[i]);
    }

    // Finish the threads
    for(i=0; i<num_threads; i++)
    {
        //pthread_join(tid, &result);
        //printf("Thread %d finished with return value: %d\n", i, *(int *)result);
        pthread_join(tid[i], NULL);
        printf("Thread %ld finished\n", i);
    }

    printf("All threads have finished\n");

    // Call this function to wait for the other threads to finish
    pthread_exit(NULL);

    return 0;
}

void * threadStart(void * arg)
{
    long received = (long) arg;
    printf("\tInside of thread %ld\n", received);
    // Explicitly finish this thread
    pthread_exit(NULL);
}
