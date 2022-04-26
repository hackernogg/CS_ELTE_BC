#ifndef GARDEN_H
#define GARDEN_H

#include "Parcel.h"

class Garden
{
    public:
        enum ERRORS { NUM_ERROR, PARCEL_ERROR};
        Garden(int n);
        Parcel* getParcel(int i) const;
        void plant(int i, Plant *p, int date);
        std::vector<int> canHarvest(int date);

    private:
        std::vector<Parcel*> _parcels;
};

#endif // GARDEN_H
