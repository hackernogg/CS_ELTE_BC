#include <iostream>
#include "menu.h"
#include "read.hpp"
#include <sstream>
#define menuCount 6 ///number of menu items

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
                putIn();
                print();
                break;
            case 2:
                takeOut();
                print();
                break;
            case 3:
                max();
                print();
                break;
            case 4:
                isEmpty();
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
    cout<<"3. Query the maximum\n";
    cout<<"4. Is empty\n";
    cout<<"5. Print\n";
    cout<<"6. Load test (how many items we can put in)\n";
    cout<<"****************************************\n";
    ///flexible error message
    ostringstream s;
    s<<"choose a number between 0 and "<<menuCount<<"!";
    string errmsg=s.str();
    ///read choice with read.hpp
    choice = read<int>("Choose a menuitem: ",errmsg,check);

    return choice;
}

void Menu::putIn()
{
    Item e;
    cout<<"Item:\n";
    cin >> e;
    Q.add(e);
}

void Menu::takeOut()
{
    Item e;
    bool error=false;
    try{
        e=Q.remMax();
    }catch(PrQueue::PrQueueError err)
    {
        error=true;
        if(err==PrQueue::EMPTY_PRQUEUE)
            cerr<<"Take out is unsuccessful, the queue is empty!\n";
        else
            cerr<<"Unknown error.\n";
    }
    if(!error) cout<<"Got item:\n"<<e<<endl;
}

void Menu::max()
{
    Item e;
    bool error=false;
    try{
        e=Q.max();
    }catch(PrQueue::PrQueueError err)
    {
        error=true;
        if(err==PrQueue::EMPTY_PRQUEUE)
            cerr<<"Maximum cannot be checked as the queue is empty.\n";
        else
            cerr<<"Unknown error.\n";
    }
    if (!error) cout<<"Maximal element is:\n"<<e<<endl;
}

void Menu::isEmpty()
{
    if(Q.isEmpty())
        cout<<"The queue is empty.\n";
    else
        cout<<"The queue is not empty.\n";
}

void Menu::print()
{
    cout<<Q;
}



void Menu::loadTest()
{
    const int size=1000000000;
    PrQueue Q;
    cout<<"Follow the current size of the queue:\n";
    try{
        for(int i=1; i<size; ++i)
        {
            if(i%1000000==0) cout<<i<<endl;
            Q.add(Item(i,"a"));
        }
    }catch(...)
    {
        cerr<<"Run out of memory!\n";
        cerr<<"The size of the vector: "<<Q.getLength()<<endl;
    }
}
