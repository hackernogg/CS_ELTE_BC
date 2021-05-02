#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>  //fork
#include <sys/wait.h>
#include <sys/time.h>
#include <sys/stat.h> 
#include <fcntl.h>
#include <errno.h> 
#include <stdbool.h>
#include <string.h>
#include "Functions.h"
int numPeople(){
    FILE *fp;
    int count = 1;  // Line counter (result)
    char filename[100]="vac.txt";
    char c;  // To store a character read from file
  
    // Get file name from user. The file should be
    // either in current folder or complete path should be provided
  
    // Open the file
    fp = fopen(filename, "r");
    // Check if file exists
    if (fp == NULL)
    {
        printf("Could not open file %s", filename);
        return 0;
    }
  
    // Extract characters from file and store in character c
    for (c = getc(fp); c != EOF; c = getc(fp))
        if (c == '\n') // Increment count if this character is newline
            count = count + 1;
  
    // Close the file
    fclose(fp);
    
  
    return count;
}
//----------------------------------------------------------------------------------------------
int VacedPeople() {
    FILE *fp;
    char    filepath[100] = "vac.txt";
    char    vacCheck[100] = "VACCINATED";
    char    *line = NULL;
    size_t  len = 0;
    ssize_t read;
    int c = 0;
    fp = fopen(filepath, "r");

    if (!fp) {
        fprintf(stderr, "Failed to open %s\n", filepath);
        return 1;
    }

    while ((read = getline(&line, &len, fp)) != -1) {
        line[strcspn(line, "\n")] = 0;
        if (strstr(line, vacCheck) != NULL) {
            c++;
        }
    }
    fclose(fp);

    if (line)
        free(line);
    //printf("%i\n",c);
    return c;
}
//-------------------------------------------------------------------------------------------

void preList(char outList[100][100]) {
    FILE *fp;
    char    filepath[100] = "vac.txt";
    char    vacCheck[100] = "VACCINATED";
    bool    infile = false;
    char    *line = NULL;
    size_t  len = 0;
    ssize_t read;
    fp = fopen(filepath, "r");
    int c=0;

    if (!fp) {
        fprintf(stderr, "Failed to open %s\n", filepath);
        return 1;
    }
    
        while ((read = getline(&line, &len, fp)) != -1) {
            line[strcspn(line, "\n")] = 0;
            
                if (strstr(line, vacCheck) == NULL) {
                 //printf("%s\n",line);
                 c++;
                 strcpy(outList[c],line);
            
            }
            
        }
    

    
    fclose(fp);
    


    if (line){
            free(line);
    }
        
}
//----------------------------------------------------------------------------------
int addVacMark(int argc, char** argv)
{
    char buf[100];
    snprintf(buf,100,"sed '%ss/^/VACCINATED,/g' vac.txt > changed.txt && mv changed.txt vac.txt",argv);
    //printf("%s\n",buf);
    //"s/^/VACCINATED,/g' vac.txt"
    system(buf);
}

//------------------------------------------------------------------------------------

int getVacLine(int argc, char** argv) {
    FILE *fp;
    char    filepath[100] = "vac.txt";
    //char    vacCheck[100] = argv[1];
    char    *line = NULL;
    size_t  len = 0;
    ssize_t read;
    int c = 0;
    int a;
    fp = fopen(filepath, "r");

    if (!fp) {
        fprintf(stderr, "Failed to open %s\n", filepath);
        return 1;
    }

    while ((read = getline(&line, &len, fp)) != -1) {
        line[strcspn(line, "\n")] = 0;
        c++;
        if (strstr(line, argv) != NULL) {
            a = c;
        }
    }
    fclose(fp);

    if (line)
        free(line);
    //printf("%i\n",a);
    return a;
    
}

//-----------------------------------------------------------------------------------
void handler(int signumber){
  printf("FIGHT UP\n");
}
  
int vac()
{
    int unVacPeople = (numPeople()-VacedPeople());
    printf("unVacPeople: %i\n",unVacPeople);
    char getList[100][100];
    preList(getList);

    signal(SIGTERM,handler);

    if(unVacPeople < 5){
        perror("Sorry we need at least 5 people to start the bus!\n");
        return 0;
    }
    int fid=mkfifo("/tmp/sunJerry", S_IRUSR|S_IWUSR );
    int fid2=mkfifo("/tmp/sunJerry2", S_IRUSR|S_IWUSR );
    int fid3=mkfifo("/tmp/sunJerry3", S_IRUSR|S_IWUSR );
    int fid4=mkfifo("/tmp/sunJerry4", S_IRUSR|S_IWUSR );
    int fd,fd2,fd3,fd4;
    int pipeCB1[2];
    int pipeCB2[2];
    int pipeBC1[2];
    int pipeBC2[2];
    
    pid_t child_a, child_b;
    int nbytes;
        child_a = fork();

    if(child_a == 0 && unVacPeople >=5 ){
        //child 1
        char s[1024];
        char bus1List[100][100];
        int bus1Count = 0;
        printf("Bus 1st will start!\n");
        printf("Waits 1 seconds, then send a FIGHT UP signal\n");
        sleep(1);
        kill(getppid(),SIGTERM); 
        sleep(1);
        wait(NULL);
        fd=open("/tmp/sunJerry",O_RDONLY);
        sleep(1);
	    read(fd,s,sizeof(s));
	    //printf("I read from the pipe:  %s \n",s);
        char * people = strtok(s,";");
        while(people != NULL){
            bus1Count ++;
            printf("Bus 1 : patient %s got in to the Bus 1st\n",people);
            strcpy(bus1List[bus1Count],people);
            people = strtok(NULL,";");
        }


	    close(fd);
        unlink("/tmp/sunJerry");
        
        sleep(2);
        srand(time(NULL));
        fd2=open("/tmp/sunJerry2",O_WRONLY);
        for(int i = 1; i <= 5 ; i++){
             //the starting value of random number generation
            int r=rand()%100;
            if(r <90){
                printf("BUS 1 : Vaccination SUCCESS for %s :%i\n",bus1List[i],r);
                strcat(bus1List[i],";");
                write(fd2,bus1List[i],strlen(bus1List[i]));

            }else{
                printf("BUS 1 : Vaccination FAIL for %s :%i\n",bus1List[i],r);
            }


        }
        
        close(fd2);

    }else{
        if(unVacPeople >= 10){
            child_b = fork();
        }
        
        if(child_b == 0 && unVacPeople >=10 && child_a>0){
        //child 2
        char s2[1024];
        char bus2List[100][100];
        int bus2Count = 0;
        printf("Bus 2nd will start!\n");
        sleep(1);
        fd3=open("/tmp/sunJerry3",O_RDONLY);
        sleep(1);
        wait(NULL);
	    read(fd3,s2,sizeof(s2));
	    //printf("I read from the pipe:  %s \n",s2);
        sleep(1);
        char * people2 = strtok(s2,";");
        while(people2 != NULL){
            bus2Count ++;
            printf(" Bus 2 : patient %s got in to the Bus 2nd\n",people2);
            strcpy(bus2List[bus2Count],people2);
            people2 = strtok(NULL,";");
        }


	    close(fd3);
        unlink("/tmp/sunJerry3");
        //printf("child 2\n");
        sleep(1);
        fd4=open("/tmp/sunJerry4",O_WRONLY);
        for(int i = 1; i <= 5 ; i++){
             //the starting value of random number generation
            int r2=rand()%100;
            if(r2 <90){
                printf("BUS 2 : Vaccination SUCCESS for %s :%i\n",bus2List[i],r2);
                strcat(bus2List[i],";");
                write(fd4,bus2List[i],strlen(bus2List[i]));

            }else{
                printf("BUS 2 : Vaccination FAIL for %s :%i\n",bus2List[i],r2);
            }


        }
        
        close(fd4);
         
    }else{
        int bus1BackCount=0;
        int bus2BackCount=0;
        char BackCenter[1024];
        char Back2Center[1024];
        char center1List[100][100];
        char center2List[100][100];
        //parent
        pause(); //waits till a signal arrive 
        printf("FIGHT UP signal arrived\n");
        if(unVacPeople>=5){
            printf("For Bus 1 :\n");
            for(int i = 1 ; i <=5;i++){
                printf(" Sending vac info to %s \n", getList[i]);
            }
        }
        if(unVacPeople >=10){
            printf("For Bus 2 :\n");
            for(int i = 6;i<=10;i++){
                printf(" Sending vac info to %s \n",getList[i]);
            }
        }
        
        
        if(unVacPeople>=5){
            fd=open("/tmp/sunJerry",O_WRONLY);
            for(int i = 1; i <=5;i++){
                write(fd,getList[i],strlen(getList[i])-1);
            }
        }
        if(unVacPeople >=10){
            fd3=open("/tmp/sunJerry3",O_WRONLY);
            for(int i = 6;i<=10;i++){
                write(fd3,getList[i],strlen(getList[i])-1);
            }
        }
        
        
        close(fd);
        close(fd3);
        fd2=open("/tmp/sunJerry2",O_RDONLY);
        sleep(1);
	    read(fd2,BackCenter,sizeof(BackCenter));
        char * peopleB = strtok(BackCenter,";");
        while(peopleB != NULL){
            bus1BackCount ++;
            printf(" BUS 1 : patient %s is VACED and got back into the Bus 1st\n",peopleB);
            int num = (getVacLine(2,peopleB));
            char snum[5];
            snprintf(snum,100,"%i",num);
            addVacMark(2,snum);
            printf("Add VACED marke for line %i in OG txt File\n",(getVacLine(2,peopleB)));
            strcpy(center1List[bus1BackCount],peopleB);
            peopleB = strtok(NULL,";");
        }
        close(fd2);
        if(unVacPeople >= 10){

        
        fd4=open("/tmp/sunJerry4",O_RDONLY);
        sleep(1);
	    read(fd4,Back2Center,sizeof(Back2Center));
        char * peopleB2 = strtok(Back2Center,";");
        while(peopleB2 != NULL){
            bus2BackCount ++;
            printf(" BUS 2 : patient %s is VACED and got back into the Bus 2st\n",peopleB2);
            int num = (getVacLine(2,peopleB2));
            char snum[5];
            snprintf(snum,100,"%i",num);
            addVacMark(2,snum);
            printf("Add VACED marke for line %i in OG txt File\n",(getVacLine(2,peopleB2)));
            strcpy(center2List[bus2BackCount],peopleB2);
            peopleB2 = strtok(NULL,";");
        }
        close(fd4);
        unlink("/tmp/sunJerry2");
        }
        wait(NULL);
        

    }



    }
    
    
    sleep(2);
    return 0;
}
