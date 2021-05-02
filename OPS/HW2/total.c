#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h> 
#include <sys/types.h> 
#include <sys/stat.h>
#include <errno.h>
#include "Functions.h"
  
int total(int argc, char **argv)
{
    FILE *fptr;
    char c;
    char filename[100];
  
    // Open file
    fptr = fopen(argv, "r");
    if (fptr == NULL)
    {
        printf("Cannot open file \n");
        printf("return file name %s \n",argv);
        exit(0);
    }
  
    // Read contents from file
    c = fgetc(fptr);
    while (c != EOF)
    {
        printf ("%c", c);
        c = fgetc(fptr);
    }
  
    fclose(fptr);
    return 0;
}
