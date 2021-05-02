#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h> 
#include <sys/types.h> 
#include <sys/stat.h>
#include <errno.h>
#include "Functions.h"

int wc(char* file_path, char* word){
    FILE *fp;
    int count = 0;
    int ch, len;

    if(NULL==(fp=fopen(file_path, "r")))
        return -1;
    len = strlen(word);
    for(;;){
        int i;
        if(EOF==(ch=fgetc(fp))) break;
        if((char)ch != *word) continue;
        for(i=1;i<len;++i){
            if(EOF==(ch = fgetc(fp))) goto end;
            if((char)ch != word[i]){
                fseek(fp, 1-i, SEEK_CUR);
                goto next;
            }
        }
        ++count;
        next: ;
    }
end:
    fclose(fp);
    return count;
}

int count(int argc, char **argv){
    char Yes[] = "Yes";// Search Yes
    char No[] = "No"; // Search No
    char VACCINATED[] = "VACCINATED";
    int YesCount = 0;
    int NoCount = 0;
    int VacCount = 0;
    int unVacCount = 0;
    int TotalPaple = 0;
    YesCount = wc(argv, Yes);
    NoCount = wc(argv, No);
    VacCount = wc(argv,VACCINATED);
    TotalPaple = YesCount + NoCount;
    unVacCount = TotalPaple - VacCount;
    printf("\nThere are %d people in the register system \n",TotalPaple);
    printf("There are %d peopele agree to pay for the vaccine\n",YesCount);
    printf("There are %d peopele do NOT agree to pay for the vaccine\n",NoCount);
    printf("There are %d peopele are VACCINATED !!\n",VacCount);
    printf("There are %d peopele are still NOT VACCINATED !!!\n",unVacCount);

    return 0;
}
