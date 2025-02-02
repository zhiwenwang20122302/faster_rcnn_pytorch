#!/usr/bin/env bash

CUDA_PATH=/usr/local/cuda
export CUDAHOME=/usr/local/cuda
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/v-zhiwwa/work/iCAN/cudnn5

python setup.py build_ext --inplace
rm -rf build
cd roi_pooling/src/cuda

echo "Compiling roi pooling kernels by nvcc..."
nvcc -c -o roi_pooling.cu.o roi_pooling_kernel.cu \
	 -D GOOGLE_CUDA=1 -x cu -Xcompiler -fPIC -arch=sm_52

#g++ -std=c++11 -shared -o roi_pooliving.so roi_pooling_op.cc \
#	roi_pooling_op.cu.o -I $TF_INC -fPIC -lcudart -L $CUDA_PATH/lib64
cd ../../
python build.py
