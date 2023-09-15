#include <cuda.h>
#include <cuda_runtime.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <thrust/scan.h>
#include <vector>
#include "common.h"
#include "thrust.h"

namespace StreamCompaction {
    namespace Thrust {
        using StreamCompaction::Common::PerformanceTimer;
        PerformanceTimer& timer()
        {
            static PerformanceTimer timer;
            return timer;
        }
        /**
         * Performs prefix-sum (aka scan) on idata, storing the result into odata.
         */
        void scan(int n, int *odata, const int *idata) {
            // TODO use `thrust::exclusive_scan`
            // example: for device_vectors dv_in and dv_out:
            // thrust::exclusive_scan(dv_in.begin(), dv_in.end(), dv_out.begin());
            thrust::device_vector<int> in_vec(idata, idata + n);
            thrust::device_vector<int> out_vec(n);
            cudaDeviceSynchronize();
            timer().startGpuTimer();
            thrust::exclusive_scan(in_vec.begin(), in_vec.end(), out_vec.begin());
            timer().endGpuTimer();
            thrust::copy(out_vec.begin(), out_vec.end(), odata);
        }
    }
}
