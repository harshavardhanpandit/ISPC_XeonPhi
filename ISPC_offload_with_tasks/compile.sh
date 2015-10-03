# ISPC generates the intermediate .cpp and .h files
ispc -O2 --target=avx --arch=x86-64 --pic offload.ispc  -o offload_ispc.o
ispc -O3 -D__MIC__ --emit-c++ --target=generic-16 --c++-include-file=knc.h --pic offload.ispc  -o offload_ispcMIC.cpp -h offload_ispc.h

# parse the .h file to add pragmas to the generated .h file
./parse_header.py

# continue with icc compilation (should not generate any warning)
icc -mmic -fPIC -c offload_ispcMIC.cpp -o offload_ispcMIC.o
icc -openmp offload_ispc.o omp_tasksys.cpp ispc_malloc.cpp dispatch.cpp offload.cpp -o offload
