#include <iostream>
#include "menu.h"
#include "read.hpp"
#include <sstream>
#define menuCount 5 ///number of menu items

using namespace std;

///Check if the given menuitem number exists
bool check(int a){return a>=0 && a<=menuCount;}

void Menu::Run()
{
    int v;
    do{
        v=MenuPrint();
        switch(v)
        {
            case 1:
                inserting();
                print();
                break;
            case 2:
                removing();
                print();
                break;
            case 3:
                findFre();
                print();
                break;
            case 4:
                getMaxElement();
                print();
                break;
            case 5:
                print();
                break;
            default:
                cout<<"\nGoodbye!\n";
                break;

        }
    }while(v!=0);
}

int Menu::MenuPrint()
{
    int choice;
    cout<<"\n****************************************\n";
    cout<<"0. Exit\n";
    cout<<"1. Inserting\n";
    cout<<"2. Removing\n";
    cout<<"3. Get frequency\n";
    cout<<"4. Largest element\n";
    cout<<"5. Print\n";
    cout<<"****************************************\n";
    ///flexible error message
    ostringstream s;
    s<<"choose a number between 0 and "<<menuCount<<"!";
    string errmsg=s.str();
    ///read choice with read.hpp
    choice = read<int>("Choose a menuitem: ",errmsg,check);

    return choice;
}

void Menu::inserting()
{
    Bag e;
    cout<<"Bag:\n";
    cin >> e;
    Q.add(e);
}
void Menu::print()
{
    cout<<Q;
}
void Menu::removing()
{
    Q.rem();
}
void Menu::getMaxElement()
{
    Bag m;
    if(Q.isEmpty()==false)
    {
        m=Q.MaxEle();
        cout << "Largest element: "<<m;
    }
    else
    {
        cout<<"The Queue is empty!";
    }
}
void Menu::findFre()
{
    Bag b;
    int i;
    if(Q.isEmpty()==false){
        cout << "Enter the element: "<<endl;
        cin >>i;
        b=Q.GetFre(i);
        if(i==b.element){
            cout << "The frequency: " << b;
        }
        else
        {
            cout << "Can not find it :C!";
        }

    }
    else
    {
        cout<<"The Queue is empty!";
    }

}
