#include <iostream>
#include "InFile.h"
using namespace std;

int main()
{
    try
    {
        string filename;
        filename = "input.txt";

        InFile t(filename);
        bool isHe15 = false;
        int cnt = 0;

        for(t.first(); !t.end();t.next())
        {
            if(t.current().id=="gfhdjs" && t.current().hour > 15 && isHe15 == false)
            {
                isHe15 = true;
            }
            if(isHe15 == true && t.current().id=="gfhdjs" && t.current().hour < 12)
            {
                cnt = cnt + 1;
            }
        }
        cout << "after he teaching more than 15 hours   how many times has he (gfhdjs) taught less than 12 hours? "<< cnt <<endl;

    }catch (InFile::Errors err)
    {
        cerr << "Invlaid file!!!\n";
    }
    return 0;
}
