/*
 * Examples of a race condition using threads.
 * All threads try to modify a single shared variable
 *
 * Gilberto Echeverria
 * 07/05/2020
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

#define MAX_COUNT 10000000

// Declare a structure to send data to the threads
typedef struct {
    int index;
    unsigned long * counter_ptr;
} thread_data_t;

// Declare functions
void * threadFunction (void * data);

int main(int argc, char * argv[])
{
    int num_threads = 3;
    int status;

    // Global variable (don't do this at home)
    unsigned long counter = 0;

    // Get the number of threads as an argument
    if (argc == 2)
    {
        num_threads = atoi(argv[1]);
    }

    // Create the array of thread id's
    pthread_t tid[num_threads];
    thread_data_t data[num_threads];

    printf("Launching threads\n");

    // Start all the threads
    for (long i=0; i<num_threads; i++)
    {
        data[i].index = i;
        data[i].counter_ptr = &counter;
        status = pthread_create(&tid[i], NULL, threadFunction, &data[i]);
        printf("Created thread: %ld\n", i);
        if (status == -1)
        {
            perror("ERROR: pthread_create");
        }
    }

    printf("Going to pthread_join\n");

    // Wait for the threads to finish
    for (int i=0; i<num_threads; i++)
    {
        // The return value must be a double pointer (a pointer to an address variable)
        status = pthread_join(tid[i], NULL);
        if (status == -1)
        {
            perror("ERROR: pthread_join");
        }
    }

    printf("The final value of counter is: %lu / %d\n", counter, num_threads * MAX_COUNT);

    printf("Going to pthread_exit\n");

    // Finish this thread, and wait for any child threads
    pthread_exit(NULL);
}

void * threadFunction (void * data)
{
    thread_data_t * info = data;
    printf("\tRunning thread with id: %d\n", info->index);

    for (int i=0; i<MAX_COUNT; i++)
    {
        // Dereference the pointer to the counter
        (*info->counter_ptr)++;
    }
    
    // Return the address in heap
    pthread_exit(NULL);
}
