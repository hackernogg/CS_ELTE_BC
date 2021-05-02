#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h> 
#include <sys/types.h> 
#include <sys/stat.h>
#include <errno.h>
#include "Functions.h"
int add(int argc, char **argv)
{
    char name[50];
    char birthYear[50];
    char phoneNumber[50];
    char agreeToPay[50];
    char wholeInfo[200];
    printf("Enter Name: \n");
    fgets(name, sizeof(name), stdin);
    printf("Enter Birth Year: \n");
    fgets(birthYear, sizeof(birthYear), stdin);
    printf("Enter Phone Number: \n");
    fgets(phoneNumber, sizeof(phoneNumber), stdin);
    printf("Do u agree to pay for vaccine? Yes or No \n");
    fgets(agreeToPay, sizeof(agreeToPay), stdin);
    name[strcspn(name, "\n")] = 0;
    birthYear[strcspn(birthYear, "\n")] = 0;
    phoneNumber[strcspn(phoneNumber, "\n")] = 0;
    agreeToPay[strcspn(agreeToPay, "\n")] = 0;
    strcpy(wholeInfo, name);
    strcat(wholeInfo, ",");
    strcat(wholeInfo, birthYear);
    strcat(wholeInfo, ",");
    strcat(wholeInfo, phoneNumber);
    strcat(wholeInfo, ",");
    strcat(wholeInfo, agreeToPay);
    //puts(wholeInfo);

  if (argc != 2)
  {
    perror("You have to use program with two arguments, the file names copy_from copy_to");
    exit(1);
  }
  FILE *fptr;
  fptr = fopen(argv, "a");
  if (fptr == NULL) {
        printf("Error!");
        exit(1);
    }
  fprintf(fptr, "\n%s", wholeInfo);
  fclose(fptr);
  



  return 0;


}
