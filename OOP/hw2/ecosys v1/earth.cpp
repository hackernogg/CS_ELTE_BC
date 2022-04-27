#include "earth.h"
#include <cstdlib>

using namespace std;
earth earth::changeType(earth theEarth,int a, int b)
{
    if(a-b>=3)
    {
        theEarth = Alpha();
        return theEarth;
    }
    if(b-a>=3)
    {
        theEarth = Delta();
        return theEarth;
    }
        if(abs(a-b)<3)
    {
        theEarth = nonRad();
        return theEarth;
    }
}
