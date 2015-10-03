#include "offload_ispc.h"

__declspec(target(mic))
void dispatch(int n, float *data)
{
  ispc::foo(n, data);
}

