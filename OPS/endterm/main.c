#include <sys/types.h>
#include <stdio.h>
#include <sys/ipc.h> 
#include <sys/msg.h> 
#include <sys/stat.h>
#include <sys/wait.h>
#include <sys/time.h>
#include <wait.h> 
#include <unistd.h>
#include <mqueue.h>
#include <stdlib.h>
#include <ctype.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>
#include <time.h>
#include <sched.h>
#include <signal.h>
#include <bits/siginfo.h>

void handler(int signumber){
  printf("vaccination \n",signumber);
}

struct messg { 
     long mtype;//this is a free value e.g for the address of the message
     int sick; //this is the message itself
};
 

int main(int argc, char *argv[])
{
    int messg, status; 
     key_t key; 
     
     // msgget needs a key, created by  ftok  
     //. 
     key = ftok(argv[0],1); 
     printf ("The key: %d\n",key);
     messg = msgget( key, 0600 | IPC_CREAT ); 
     if ( messg < 0 ) { 
          perror("msgget error"); 
          return 1; 
     } 

    signal(SIGSEGV,handler);
    signal(SIGINT,handler);

    int allAnimal =  atoi(argv[1]);
    int AnimalA = 0;
    int AnimalB = 0;
    printf("Number of  animal  %i\n",allAnimal);
    if(allAnimal % 2 == 0){
        printf("Number of animal is even\n");
        AnimalA = allAnimal/2;
        AnimalB = allAnimal/2;
    }else{
        printf("Number of animal is odd\n");
        AnimalA = (allAnimal -1)/2;
        AnimalB = ((allAnimal -1)/2) + 1;
    }

    int fd,fd2;
    int fid=mkfifo("/tmp/sunJerry", S_IRUSR|S_IWUSR );
    int fid2=mkfifo("/tmp/sunJerry2", S_IRUSR|S_IWUSR );

    srand(time(NULL));

    pid_t child_a, child_b;
	child_a = fork();
	if (child_a == 0) 
	{
		/* Child A code */
        printf("Ursula start \n");
        printf("Waits 1 seconds, then send a vaccination signal\n");
        sleep(1);
        kill(getppid(),SIGSEGV); 
        //----------------------
        char s[1024]="Nothing";
        int a;
        fd=open("/tmp/sunJerry",O_RDONLY);
	    read(fd,&a,sizeof(a));
	    printf("Thanks Ursula for take care of %i animals \n",a);
	    close(fd);
	    // remove fifo.ftc
	    unlink("/tmp/sunJerry");
        //------------------------
        int i;
        int sickA=0;
        for(i=1;i<=a;i++){
            int r=rand()%100;
            if(r<=50){
                sickA++;
            }

        }
        printf("Number of sick in Ursula: %i \n",sickA);
        int status;
        const struct messg A = { 4, sickA };
        status = msgsnd( messg, &A,  sizeof(int) , 0 ); 
         //childAFunction( messg ,sickA);
        //printf("Child 1 process ended\n"); 
	} 
	else 
	{
		child_b = fork();

		if (child_b == 0) 
		{
			/* Child B code */
            printf("Beakmaster start \n");
            printf("Waits 2 seconds, then send a vaccination signal\n");
            sleep(2);
            kill(getppid(),SIGINT); 
            //---------------------
            char s[1024]="Nothing";
            int b;
            fd2=open("/tmp/sunJerry2",O_RDONLY);
	        read(fd2,&b,sizeof(b));
	        printf("Thanks Beakmaster for take care of %i animals \n",b);
	        close(fd2);
	        // remove fifo.ftc
	        unlink("/tmp/sunJerry2");
            //printf("Child 2 process ended\n"); 
            //-----------------------
            int i;
            int sickB=0;
            for(i=1;i<=b;i++){
                int r=rand()%100;
                if(r<=50){
                sickB++;
                }

            }
            printf("Number of sick in Beakmaster: %i \n",sickB);
            int status;
            const struct messg B = { 5, sickB };
            status = msgsnd( messg, &B, sizeof(int) , 0 ); 
		} 
		else 
		{
			/* Parent Code */
            pause();
            printf("Get signal from Ursula with pid:%i\n",SIGSEGV);
            pause();
            printf("Get signal from Beakmaster with pid:%i\n",SIGINT);
            //---------------------
            fd=open("/tmp/sunJerry",O_WRONLY);
            write(fd,&AnimalA,sizeof(AnimalA));
            close(fd);

            fd2=open("/tmp/sunJerry2",O_WRONLY);
            write(fd2,&AnimalB,sizeof(AnimalB));
            close(fd2);
            // parentsFunction( messg );
            int status;
            struct messg FromA; 
            struct messg FromB; 
            status = msgrcv(messg, &FromA, sizeof(int), 4, 0 ); 
            status = msgrcv(messg, &FromB, sizeof(int), 5, 0 );
            int sumSick = FromA.sick + FromB.sick;
            if ( status < 0 ) 
            perror("msgsnd error"); 
            else
            printf( "The total number of sick is :  %i\n", sumSick ); 
            

            wait(NULL);
            sleep(2);
            printf("waited for the assistants to leave\n");
            printf("doctor and assistants finished activity\n");
		}
	}
	
	
}
