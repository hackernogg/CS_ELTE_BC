#include <iostream>
#include <cmath>
using namespace std;
 
//task1
 /*
int main()
{
  int a = 10;
  int b = 20;
  int c = a * b;
  int d = ( a + b ) * 2;
  cout << " The area of rectangle is ";
  cout << c ;
  cout << " The perimeter of rectangle is ";
  cout << d ;
   return 0;
}
*/
//task2
/*
int main()
{
  int a = 3;
  int b = 4;
  int c = a + b;
  
  int d = c*c;
 
  cout << d ;
   return 0;
}
*/
//task3
/*
int a;
int b;
int c;

int main(){
  cout << "Enter Length for Side 1: ";
	cin >> a;
  cout << "Enter Length for Side 2: ";
	cin >> b;
  cout << "Enter Length for Side 3: ";
	cin >> c;
  if((a*a + b*b)==c*c){
    cout << "The given triangle is a right angled triangle.";
    return 0;
  }else if ((b*b + c*c)==a*a){
    cout << "The given triangle is a right angled triangle.";
    return 0;
  }
  else if ((a*a + c*c)==b*b){
    cout << "The given triangle is a right angled triangle.";
    return 0;
  }
  else{
    cout << "The given triangle is not a right angled triangle.";
    return 0;
  }


}
*/
//task4
/*
int a;
int b;
int main()
{
  cout << "Amount of petrol consumed (liters) ";
	cin >> a;
  cout << " Length of the trip (km) ";
	cin >> b;
double c = b/100.0;
double d = a/c;
cout << d;
return 0;
}
*/
//task5
/*
int a;
int b;
int main()
{
  cout << " Number of kids " ;
  cin >> a;
  cout << " Number of apples " ;
  cin >> b;
  int c = b/a;
  int d = b%a;
  cout <<"Every kid gets "<< c <<" apples and there are " << d << " apples left." ;
  return 0;



}
*/
//task6
/*
int a;
int b;
int main(){
  cout << "Enter two integers";
  cin >> a >> b;
if ( b < a ){
  cout << "The smaller number is " << b; 
  return 0;
}else if (a < b){
  cout << "The smaller number is " << a; 
  return 0;
}else {
  cout << a << " = "<< b ; 
  return 0;
}

}
*/
//task7
/*
int a;
int main(){
  cout << " enter a Natural number";
  cin >> a;
  if ( (a > 99) && a < (1000)){
  cout <<a << " is a 3-digit number";
  return 0;
  }else {
  cout <<a << " is not a 3-digit natural number";
  return 0;
  }
}
*/
//task8
/*
int a ;
int b ;
int main(){
  cout << "enter two number :";
  cin >> a >> b;
  if (((a%2)==0) && ((b%2)==0)){
    cout << "None of them is odd";
    return 0;
  }
  else {
    cout << "Yes, there is an odd one";
    return 0;
  }
}
*/
//task9
/*
string a, b, c;
int main(){
  cout << "enter 3 words :";
  cin >> a >> b >> c;
int al = a.length();
int bl = b.length();
int cl = c.length();

if (al >= bl && al >= cl){
  cout << " The longest word is"<<a;
  return 0;
}
if (bl >= al && bl >= cl){
  cout << " The longest word is"<<b;
  return 0;
}
if (cl >= al && cl >= bl){
  cout << " The longest word is"<<c;
  return 0;
}


}
*/
//task10
double a,b,c,x;
bool exists;
int main(){
  cout << "the value of a:";
  cin >> a;
  cout << "the value of b:";
  cin >> b;
  cout << "the value of c:";
  cin >> c;
double d = b*b-4*a*c;
if(d >= 0.0){
  exists = true;
  x = ((-b) + sqrt(d))/(2*a);
  cout <<"The equation has a solution, x =" << x;
  return 0;
} else{
  cout <<"The equation has no solution";
  return 0;
}
}
