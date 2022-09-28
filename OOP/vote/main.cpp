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
        bool afterOrban = false;
        bool orban = false;
        bool other = false;

        for(t.first(); !t.end();t.next())
        {
            if(t.current().name == "Orban")
            {
                afterOrban = true;
                if(t.current().votes > 100000)
                {
                    orban = true;
                }
            }
            if(afterOrban == true && t.current().votes>100000)
            {
                other = true;
            }
        }
        if(orban == true || other == true)
        {
            cout << "Yes" <<endl;
        }
        else
        {
            cout << "No" << endl;
        }
    }catch (InFile::Errors err)
    {
        cerr << "Invlaid file!!!\n";
    }
    return 0;
}
