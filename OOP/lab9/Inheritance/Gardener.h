#ifndef GARDENER_H
#define GARDENER_H
#include "Garden.h"

class Gardener
{
    public:
        Gardener(Garden* g) : garden(g) { }
        Garden* garden;
};

#endif // GARDENER_H
