/*
 * First example of launching threads in C
 *
 * Gilberto Echeverria
 * 07/05/2020
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

// Declare functions
void * threadFunction (void * data);

int main(int argc, char * argv[])
{
    int num_threads = 3;
    int status;

    // Get the number of threads as an argument
    if (argc == 2)
    {
        num_threads = atoi(argv[1]);
    }

    // Create the array of thread id's
    pthread_t tid[num_threads];
    int index[num_threads];

    printf("Launching threads\n");

    // Start all the threads
    for (long i=0; i<num_threads; i++)
    {
        index[i] = i;
        status = pthread_create(&tid[i], NULL, threadFunction, &index[i]);
        printf("Created thread: %ld\n", i);
        if (status == -1)
        {
            perror("ERROR: pthread_create");
        }
    }

    printf("Going to pthread_join\n");

    // Pointer where the result of the thread will be received
    int * result = NULL;

    // Wait for the threads to finish
    for (int i=0; i<num_threads; i++)
    {
        // The return value must be a double pointer (a pointer to an address variable)
        status = pthread_join(tid[i], (void **)&result);
        if (status == -1)
        {
            perror("ERROR: pthread_join");
        }
        printf("New index of thread %d is %d\n", i, index[i]);
        printf("Result returned by thread %d is %d\n", i, *result);
        // Free the address allocated
        free(result);
    }

    printf("Going to pthread_exit\n");

    // Finish this thread, and wait for any child threads
    pthread_exit(NULL);
}

void * threadFunction (void * data)
{
    //int index = * (int *) data;
    int * index = data;
    printf("\tRunning thread with id: %d\n", *index);
    //sleep(2);
    *index *= -1;

    // Allocate a new variable in heap to place the results
    int * result = malloc(sizeof (int));
    if (!result)
    {
        perror("ERROR: malloc");
    }
    *result = *index * 10;

    printf("\tThread %d finishing\n", *index);

    // Return the address in heap
    pthread_exit(result);
}
