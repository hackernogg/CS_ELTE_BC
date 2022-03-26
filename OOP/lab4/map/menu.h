#ifndef MENU_H_INCLUDED
#define MENU_H_INCLUDED
#include "map.h"

class Menu
{
    public:
        Menu(){};
        void Run();
    private:
        int MenuPrint();
        void putIn();
        void takeOut();
        void isIn();
        void count();
        void print();
        void loadTest();

        Map M;

};

#endif // MENU_H_INCLUDED
