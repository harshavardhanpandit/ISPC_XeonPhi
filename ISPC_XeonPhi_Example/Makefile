CC=icc
LD=icc
AR=xiar
ISPC=ispc

MIC_FLAGS=-mmic -fPIC
CPU_FLAGS=-mavx -fPIC
ISPC_CPU_FLAGS=-O2 --target=avx --arch=x86-64 --pic
ISPC_MIC_FLAGS=-O3 -D__MIC__ --emit-c++ --target=generic-16 --c++-include-file=knc.h --pic

all: offload

offload: offload_ispc.o offload_ispcMIC.o dispatch.cpp offload.cpp
	$(LD) offload_ispc.o  dispatch.cpp offload.cpp -o $@ 	-offload=optional

offload_ispc.o: offload.ispc
	$(ISPC) $(ISPC_CPU_FLAGS) $^  -o $@

offload_ispcMIC.cpp: offload.ispc
	$(ISPC) $(ISPC_MIC_FLAGS) $^  -o offload_ispcMIC.cpp -h offload_ispc.h

offload_ispcMIC.o: offload_ispcMIC.cpp
	$(CC) $(MIC_FLAGS) -c $< -o $@


clean:
	/bin/rm -f *.o offload offload_ispc.h offload_ispcMIC.cpp
