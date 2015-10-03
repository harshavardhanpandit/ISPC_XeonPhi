#include <cstdio>
#include <cstdlib>
#include <vector>


__declspec(target(mic)) void dispatch(const int n, float *data);


int main(int argc, char * argv[])
{
  const int n = argc > 1 ? atoi(argv[1]) : 1024;
  std::vector<float> data(n);

  float *data_ptr = &data[0];

  for (int i = 0; i < n; i++)
    data[i] = 0.0;

#pragma offload target(mic) inout(data_ptr:length(n))
  dispatch(n, data_ptr);

  for (int i = 0; i < n; i++)
    printf("i= %d : %g \n", i, data[i]);
  return 0;
}
