#include <iostream>
#include "matrix.h"


using namespace std;

int main()
{
    matrix a;
    matrix b;
    matrix c(2);
    cout << "a:\n"<<a<<endl<<endl;
    cout << "b:\n"<<b<<endl;
    cout <<"a[2,3]="<<a.getElement(2,3) <<endl;
    cout <<"a[3,2]="<<a.getElement(3,2) <<endl <<endl;
    cout <<"a+b:\n"<<matrix::add(a,b)<<endl<<endl;
    cout <<"a*b:\n"<<matrix::multiply(a,b)<<endl<<endl;
    return 0;
}
