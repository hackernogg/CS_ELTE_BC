#include <iostream>
#include <fstream>
#include <vector>
#include "plants.h"
#include "earth.h"
using namespace std;

int plantsToInt(string str)
{
    if(str=="wom") return 1;
    if(str=="wit") return 2;
    if(str=="wor") return 3;
}
void create(const string &str,vector<plants*> &plantsList)
{
    ifstream f(str);
    if(f.fail()) { cout << "Wrong file name!\n"; exit(1);}
    int pNum;
    f >> pNum;

    plantsList.resize(pNum);
    for(int i =0; i<pNum;++i)
    {
        string name;
        string type;
        int level;
        f >> name >> type >> level;
        switch(plantsToInt(type)){
            case 1 : plantsList[i] = new Womroot(name,level); break;
            case 2 : plantsList[i] = new Witroot(name,level); break;
            case 3 : plantsList[i] = new Worroot(name,level); break;
        }
    }
}
string intToRad(int i)
{
    string rad;
    switch(i)
    {
        case 1: rad = "Alpha"; break;
        case 2: rad ="Delta"; break;
        case 0: rad ="Non-Radiation"; break;
    }
    return rad;
}

void simTill2NonRad(vector<plants*> &plantsList)
{
    bool NonRadOne = false;
    bool NonRadTwo = false;
    cout <<"Start Simulate : D "<<endl;
    earth ThisEarth = nonRad();

    int day = 0;
    for(;NonRadOne == false || NonRadTwo == false;)
    {
        cout << endl;
        cout << "day : "<<day<<" Earth Rad type: "<<intToRad(ThisEarth.getEarthType())<<endl;
        cout << endl;
        int a = 0;
        int d = 0;
        NonRadOne = ThisEarth.isnonRad();
        for(int i =0; i<plantsList.size();++i)
        {

            if(plantsList[i]->isAlive())
            {

                plantsList[i]->changeNeedRad();
                tuple<int,int> hereNeed = plantsList[i]->getNeedRad();
                cout <<plantsList[i]->getName()<<" ";
                cout <<plantsList[i]->getLevel()<<" ";
                cout <<"need Alpha: "<<get<0>(hereNeed)<<" "<<"need Delta: "<<get<1>(hereNeed);
                a = a+get<0>(hereNeed);
                d = d+get<1>(hereNeed);
                plantsList[i]->changeLevel(ThisEarth);

            }
            else
            {
                cout <<plantsList[i]->getName()<<" ";
                cout <<plantsList[i]->getLevel()<<" ";
                cout << "dead";
            }
                cout << endl;

        }
        cout<< "Total need Alpha :" << a <<" Total need Delta :" << d <<endl;
        cout <<"______________________________________" <<endl;


        ThisEarth=ThisEarth.changeType(ThisEarth,a,d);
        NonRadTwo = ThisEarth.isnonRad();
        day++;
    }

}

int main()
{


    vector <plants*> plantsList;
    create("input.txt",plantsList);

    simTill2NonRad(plantsList);


    return 0;
}
