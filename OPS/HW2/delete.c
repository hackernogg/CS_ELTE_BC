#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h> 
#include <sys/types.h> 
#include <sys/stat.h>
#include <errno.h>
#include "Functions.h"
 
int dele(int argc, char **argv)
{
    FILE *fileptr1, *fileptr2;
    char ch;
    int delete_line, temp = 1;
 
    //open file in read mode
    fileptr1 = fopen(argv, "r");
    ch = getc(fileptr1);
     while (ch != EOF)
    {
        printf("%c", ch);
        ch = getc(fileptr1);
    }
    fseek(fileptr1, 0L, SEEK_SET);
    printf(" \n Enter line number of the line to be deleted:");
    scanf("%d", &delete_line);
    //open new file in write mode
    fileptr2 = fopen("vac2.txt", "w");
    ch = getc(fileptr1);
    fseek(fileptr1, 0L, SEEK_SET);
    while (ch != EOF)
    {
        ch = getc(fileptr1);
        if (ch == '\n')
            temp++;
            //skip the delete line
            if (temp != delete_line)
            {
                //copy all other line
                putc(ch, fileptr2);
            }
    }
    fclose(fileptr1);
    fclose(fileptr2);
    remove(argv);
    //rename the file vac2.txt to original name
    rename("vac2.txt", argv);
    printf("\n The contents of file after being modified are as follows:\n");
    return 0;
}
/*    fileptr1 = fopen(argv, "r");
    ch = getc(fileptr1);
    while (ch != EOF)
    {
        printf("%c", ch);
        ch = getc(fileptr1);
    }
    fclose(fileptr1);
    return 0;
    */
