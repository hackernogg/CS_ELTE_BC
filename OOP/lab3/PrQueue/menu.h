#ifndef MENU_H_INCLUDED
#define MENU_H_INCLUDED
#include "prqueue.h"

class Menu
{
    public:
        Menu(){};
        void Run();
    private:
        int MenuPrint();
        void putIn();
        void takeOut();
        void max();
        void isEmpty();
        void print();
        void loadTest();
        PrQueue Q;

};

#endif // MENU_H_INCLUDED
