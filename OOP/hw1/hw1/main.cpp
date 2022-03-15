#include <iostream>
#include <vector>
//#include "prqueue.h"
#include "menu.h"

using namespace std;

/// Change between manual mode and unit test mode
//#define NORMAL_MODE
//#ifdef NORMAL_MODE

int main()
{
    cout << "Priority queue" << endl;

    Menu menu;
    menu.Run();

    return 0;
}
