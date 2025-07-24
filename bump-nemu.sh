ready_to_run_home=$(pwd)
tmp_dir=$(mktemp -d -t NEMU-XXXXXX)
git clone https://github.com/OpenXiangShan-Nanhu/NEMU.git --depth=1 $tmp_dir

pushd $tmp_dir
export NEMU_HOME=$(pwd)
make riscv64-nhv5-ref_defconfig
make -j
cp build/riscv64-nemu-interpreter-so $ready_to_run_home
make clean

sed -i '/CONFIG_MULTICORE_DIFF/a CONFIG_MULTICORE_DIFF=y' .config
make -j
cp build/riscv64-nemu-interpreter-so $ready_to_run_home/riscv64-nemu-interpreter-multicore-so
popd

