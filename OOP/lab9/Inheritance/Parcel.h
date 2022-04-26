#ifndef PARCEL_H
#define PARCEL_H
#include "Plant.h"

class Parcel
{
    public:
        enum Exceptions { DATE_ERROR};
        Parcel() : _plant(nullptr), _plantingDate(1) {}
        plant(Plant *p, int date)
        {
            if (date < 1 || date > 12)
            {
                throw DATE_ERROR;
            }
            _plant = p;
            _plantingDate = date;
        }

        Plant* getPlant() const { return _plant;}
        int getPlantingDate() const { return _plantingDate;}

    private:
        int _plantingDate;
        Plant* _plant;
};

#endif // PARCEL_H
