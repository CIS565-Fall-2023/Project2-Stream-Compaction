#pragma once

#include "common.h"

namespace StreamCompaction {
    namespace Naive {
        StreamCompaction::Common::PerformanceTimer& timer();

        void scan(int n, int *odata, const int *idata);
        __global__ void kernScan(int n, int offset, int* odata1, int* odata2);

    }
}
