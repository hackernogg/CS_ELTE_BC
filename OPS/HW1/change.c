#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h> 
#include <sys/types.h> 
#include <sys/stat.h>
#include <errno.h>
#include "Functions.h"
int change(int argc, char **argv)
{
    FILE *fileptr1, *fileptr2;
    char ch;
    int delete_line, temp = 1;
    int i = 0;
    char name[50];
    char birthYear[50];
    char phoneNumber[50];
    char agreeToPay[50];
    char wholeInfo[200];
    //open file in read mode
    fileptr1 = fopen(argv, "r");
    ch = getc(fileptr1);
     while (ch != EOF)
    {
        printf("%c", ch);
        ch = getc(fileptr1);
    }
    fseek(fileptr1, 0L, SEEK_SET);
    printf(" \n Enter line number of the line to be change:");
    scanf("%d", &delete_line);
    
    getchar();

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

    //open new file in write mode
    fileptr2 = fopen("vac2.txt", "w");
    ch = getc(fileptr1);
    fseek(fileptr1, 0L, SEEK_SET);
    while (ch != EOF)
    {
        ch = getc(fileptr1);
        if (ch == '\n')
            temp++;
            //skip the change line
            if (temp != delete_line)
            {
                
                putc(ch, fileptr2);
            }
            // when is the change line put the change txt by if loop
            if (temp == delete_line && i < 1)
            {
                
                fprintf(fileptr2,"\n%s",wholeInfo);
                i++;
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
/*
int main(char argc,char* argv[])
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
 
    int cnt;
 int line;            
 int c,c1;
 FILE *fp;
 int i=1;
 char ch;
    printf("chose the line to change");
    scanf("%d",&line);
 fp=fopen("vac.txt","r+");
 if(fp<0)
 {
  printf("can not open\n");
  exit(1);
 }

 
    //检测行数，如遇到回车'/n'，意味着一行的结束，i++
 while(i!=line)
 {
  ch=fgetc(fp);
  if(ch=='\n')
  {
   i++;
  }
 }
 
//检测到指定行开头的指针位置，将其赋值给c
 c=ftell(fp);
//遍历一遍目标行，确定该行长度，同时for循环结束时c1为该行末尾的指针位置
 while(fgetc(fp)!='\n')
 {
  c1=ftell(fp);
 }
//将文件指针移到目标行的行首
 fseek(fp,c,SEEK_SET);
//得到目标行的长度
 cnt=c1-c;
 
//for循环插入想要修改的内容
for(i=0;i<cnt;i++)
 {
  fputc((char) 0,fp);
 }
fprintf(fp, "%s", wholeInfo);
 
 
 if(fclose(fp)==0)
  printf("file closed!\n");
 else
  printf("file can not closed!\n");
 return 0;
 
}*/
