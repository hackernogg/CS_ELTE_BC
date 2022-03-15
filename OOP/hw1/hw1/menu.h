#ifndef MENU_H_INCLUDED
#define MENU_H_INCLUDED
#include "bagqueue.h"

class Menu
{
    public:
        Menu(){};
        void Run();
    private:
        int MenuPrint();
        void inserting();
        void removing();
        void findFre();
        void getMaxElement();
        void print();
        void loadTest();
        BagQueue Q;

};

#endif // MENU_H_INCLUDED
