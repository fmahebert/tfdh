
#ifndef TFDH_RADIAL_INTEGRAL_H
#define TFDH_RADIAL_INTEGRAL_H

#include "RadialFunction.h"

#include <vector>


double integrateOverRadius(const RadialFunction& data);

RadialFunction accumulateOverRadius(const RadialFunction& data);


#endif // TFDH_RADIAL_INTEGRAL_H

