#include <iostream>
#include "menu.h"
#include "read.hpp"
#include <sstream>
#define menuCount 6 ///number of menu items

using namespace std;

///Check if the given menuitem number exists
bool check(int a){return a>=0 && a<=menuCount;}
bool validate(int a){return true;}

void Menu::Run()
{
    int v;
    do{
        v=MenuPrint();
        switch(v)
        {
            case 1:
                putIn();
                print();
                break;
            case 2:
                takeOut();
                print();
                break;
            case 3:
                count();
                print();
                break;
            case 4:
                isIn();
                print();
                break;
            case 5:
                print();
                break;
            case 6:
                loadTest();
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
    cout<<"1. Put in\n";
    cout<<"2. Take out\n";
    cout<<"3. Count the elements\n";
    cout<<"4. IsIn\n";
    cout<<"5. Print\n";
    cout<<"6. Load test (how many items we can put in)\n";
    cout<<"****************************************\n";
    ///flexible error msg
    ostringstream s;
    s<<"choose a number between 0 and "<<menuCount<<"!";
    string errmsg=s.str();
    ///read with read.hpp
    choice = read<int>("Choose a menuitem: ",errmsg,check);

    return choice;
}

void Menu::putIn()
{
    try{
        Item e;
        cin >> e;
        M.insert(e);
        cout<<"Success!\n"<<endl;
    }
    catch(Map::ExistingKeyException err)
    {
        cerr<<"Insert is unsuccessful. The key already exists!\n";
    }

}

void Menu::takeOut()
{
    int key = read<int>("Key: ","I need an integer!",validate);
    try{
        M.erase(key);
        cout<<"Success!\n"<<endl;
    }
    catch(Map::NonExistingKeyException err)
    {
        cerr<<"Take out is unsuccessful, the key does not exist!\n";
    }
}

void Menu::isIn()
{
    int key = read<int>("Key: ","I need an integer!",validate);
    if (M.isIn(key)) { cout<<"It is in!\n"<<endl; }
    else { cout<<"It is NOT in!\n"<<endl; }
}

void Menu::count()
{
    cout<<"There are "<<M.count()<< " items in the map.\n";
}

void Menu::print()
{
    cout<<M;
}



void Menu::loadTest()
{
    const int size=1000000000;
    Map M;
    cout<<"Follow the current size of the map:\n";
    try{
        for(int i=1; i<size; ++i)
        {
            if(i%1000000==0) cout<<i<<endl;
            M.insert(Item(i,"a"));
        }
    }catch(...)
    {
        cout<<"The size of the map: "<<M.count()<<endl;
    }
}


