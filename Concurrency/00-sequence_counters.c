/*
 * Simple program to increment a variable multiple times
 *
 * Gilberto Echeverria
 * 2025-05-22
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

#define MAX_COUNT 10000000
#define DEFAULT_THREADS 5

// Declare a structure to send data to the threads
typedef struct {
    int index;
    unsigned long * counter_ptr;
} thread_data_t;

// Declare functions
void incrementGlobal (int index, unsigned long * counter_ptr);

int main(int argc, char * argv[])
{
    int num_threads = DEFAULT_THREADS;

    // Global variable (don't do this at home)
    unsigned long counter = 0;

    // Get the number of threads as an argument
    if (argc == 2)
    {
        num_threads = atoi(argv[1]);
    }

    printf("Launching threads\n");

    // Start all the threads
    for (long i=0; i<num_threads; i++)
    {
        incrementGlobal(i, &counter);
    }

    printf("The final value of counter is: %lu / %d\n", counter, num_threads * MAX_COUNT);

    return 0;
}

void incrementGlobal (int index, unsigned long * counter_ptr)
{
    printf("\tRunning call with id: %d\n", index);

    for (int i=0; i<MAX_COUNT; i++)
    {
        // Dereference the pointer to the counter
        (*counter_ptr)++;
    }
}
