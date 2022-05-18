#include "plants.h"
#include "earth.h"


void Womroot::changeLevel(earth theEarth)
{
    if(theEarth.getEarthType()==1){
        _level = _level+2;
    }
    if(theEarth.getEarthType()==2){
        _level = _level-2;
    }
    if(theEarth.getEarthType()==0){
        _level = _level-1;
    }
}

void Witroot::changeLevel(earth theEarth)
{
    if(theEarth.getEarthType()==1){
        _level = _level-3;
    }
    if(theEarth.getEarthType()==2){
        _level = _level+4;
    }
    if(theEarth.getEarthType()==0){
        _level = _level-1;
    }
}

void Worroot::changeLevel(earth theEarth)
{
    if(theEarth.getEarthType()==1){
        _level = _level+1;
    }
    if(theEarth.getEarthType()==2){
        _level = _level+1;
    }
    if(theEarth.getEarthType()==0){
        _level = _level-1;
    }
}

//-------------------------------------
void Womroot::changeNeedRad()
{
    _needRad = make_tuple(10,0);
}

void Witroot::changeNeedRad()
{
    if(_level < 5)
    {
        _needRad = make_tuple(0,4);
    }
        if(_level >=5 && _level <=10 )
    {
        _needRad = make_tuple(0,1);
    }
           if(_level >10 )
    {
        _needRad = make_tuple(0,0);
    }
}

void Worroot::changeNeedRad()
{
    _needRad = make_tuple(0,0);
}

//--------------------------------

