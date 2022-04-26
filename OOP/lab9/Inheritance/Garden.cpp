#include "Garden.h"

Garden::Garden(int n)
{
    if (n < 0)
        throw NUM_ERROR;
    _parcels.resize(n);
    for (int i = 0; i< n; ++i)
    {
        _parcels[i] = new Parcel();
    }
}

Parcel* Garden::getParcel(int i) const
{
    if (i < 0 || i > _parcels.size()) return nullptr;
    return _parcels[i];
}

void Garden::plant(int i, Plant* p, int date)
{
    if (i < 1 || i > _parcels.size())
        throw PARCEL_ERROR;
    getParcel(i-1)->plant(p, date);
}

std::vector<int> Garden::canHarvest(int date)
{
    std::vector<int> result;

    for (int i = 0; i<_parcels.size() ; ++i)
    {
        Parcel* p = _parcels[i];

        if (p->getPlant() != nullptr && p->getPlant()->isVegetable() &&
            date - p->getPlantingDate() == p->getPlant()->getRipeningTime()
            )
            {
                result.push_back(i+1);
            }
    }
    return result;

}
