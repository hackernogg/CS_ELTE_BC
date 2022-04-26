#include <iostream>
#include "Gardener.h"
using namespace std;


int main()
{
    Garden* garden = new Garden(5);
    Gardener* gardener = new Gardener(garden);

    gardener->garden->plant(2, Potatoe::getInstance(), 3);
    gardener->garden->plant(3, Rose::getInstance(), 4);

    cout << "IDs of parcels, where vegies are ready to harvest:\n";

    vector<int> result = gardener->garden->canHarvest(7);

    for (int i : result)
    {
        cout << i << " ";
    }
    Potatoe::destroy();
    Rose::destroy();
	return 0;
}
