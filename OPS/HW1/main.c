#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h> 
#include <sys/types.h> 
#include <sys/stat.h>
#include <errno.h>
#include "Functions.h"

int main()
{
    printf("\n\n\t\tCOVID Vaccine Register System\n\n\n");
    int choice, num, i;
    unsigned long int fact;

    while(1)
    {
        printf("\n1. add \n");
        printf("2. change\n");
        printf("3. delete\n");
        printf("4. total\n");
        printf("5. Exit\n\n\n");
        printf("Enter your choice :  ");
        scanf("%d",&choice);
        getchar();
        
        switch(choice)
        {
            case 1:
                add( 2 ,"vac.txt");
                total(2 ,"vac.txt");
                break;
        
            case 2:
                change(2 ,"vac.txt");
                total(2 ,"vac.txt");
                break;
        
            case 3:
                dele(2 ,"vac.txt");
                total(2 ,"vac.txt");
                break;
            case 4:
                total(2 ,"vac.txt");
                count(2 ,"vac.txt");
                break;
        
            case 5:
                printf("\n\n\t\t\tSystem goes off!\n\n\n");
                exit(0);    // terminates the complete program execution
        }
    }
    printf("\n\n\t\t\tSystem goes off!\n\n\n");
    return 0;
}
