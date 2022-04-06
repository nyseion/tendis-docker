
#! /bin/bash

git clone https://github.com/Tencent/tendis.git --recursive
cd tendis 
git checkout $TENDIS_VERSION
git submodule update --init --recursive
mkdir build
cd src/thirdparty/rocksdb/rocksdb/
git checkout $ROCKSDB_VERSION && cd /tendis
git apply --verbose /rocks7.diff
git apply --verbose /cmake.diff
cd /tendis/build
cmake .. && make -j8 tendisplus
