/*
    First exercises with threads
*/

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

#define NUM_THREADS 5

// Global variables
char ** shared_strings;

// Function declarations
void * threadStart(void * arg);

int main()
{
    long i;
    pthread_t tid[NUM_THREADS];
    int counter[NUM_THREADS];
    int status;
    
    char * greetings[] = {"Hello", "Hola", "Salut", "Ciao", "Aloha"};
    shared_strings = greetings;
    
    for (i=0; i<NUM_THREADS; i++)
    {
        // Create new threads
        counter[i] = i;
        status = pthread_create(&tid[i], NULL, &threadStart, &counter[i]);
        if (status)
        {
            fprintf(stderr, "ERROR: pthread_create %d\n", status);
            exit(EXIT_FAILURE);
        }
        printf("Created new thread %ld with tid %lu\n", i, (long unsigned)tid[i]);
    }
    
    // Wait for all other threads to finish
    pthread_exit(NULL);
    
    return 0;
}

void * threadStart(void * arg)
{
    int index = *((int *) arg);
    printf("Thread %d says: %s\n", index, shared_strings[index]);
    
    return NULL;
}