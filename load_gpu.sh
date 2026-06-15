module purge
module load pawseyenv/2025.08
module load PrgEnv-gnu/8.6.0
module load gcc-native/14.2
module load craype-x86-milan

module load cray-libsci/25.03.0
module load cray-libsci_acc/25.03.0

module load rocm/6.3.0
module load craype-accel-amd-gfx90a
module load cmake/3.30.5
module load magma-amd-gfx90a/2.8.0
module load cray-mpich

#export LD_LIBRARY_PATH=/opt/cray/pe/lib64:${MPICH_DIR:+$MPICH_DIR/lib}:$LD_LIBRARY_PATH
#export LD_PRELOAD=/opt/cray/pe/lib64/libmpi_gtl_hsa.so.0${LD_PRELOAD:+:$LD_PRELOAD}

#export PAWSEY_MAGMA_HOME=/software/setonix/2025.08/software/linux-sles15-zen3/gcc-14.2.0/magma-2.8.0-hncqpjzs2d6ytkx6boiv2a4bbxm2uwjf
export PAWSEY_MAGMA_HOME=/software/setonix/2025.08/software/linux-sles15-zen3/gcc-14.2.0/magma-2.8.0-nrznu7ireffg4dnrkj2gszwnnlbibmpy

# Tell Pele/SUNDIALS where MAGMA lives
export PELE_MAGMA_HOME="$PAWSEY_MAGMA_HOME"

# Pick lib dir (lib vs lib64) and expose to runtime linker & CMake
export LM="$PELE_MAGMA_HOME/lib"; [ -d "$LM" ] || LM="$PELE_MAGMA_HOME/lib64"
#export LD_LIBRARY_PATH="$LM:$LD_LIBRARY_PATH"
export CMAKE_PREFIX_PATH="$PELE_MAGMA_HOME:$CMAKE_PREFIX_PATH"

# make sure ROCm is loaded (example)
export AMDGPU_TARGETS=gfx90a
export CMAKE_HIP_ARCHITECTURES=gfx90a
export AMD_ARCH=gfx90a

#export MPICH_OFI_SKIP_NIC_SYMMETRY_TEST=1

export MPICH_GPU_SUPPORT_ENABLED=1    # Enable GPU support with MPI
export MPIR_CVAR_GPU_IPC=0            # common
export MPICH_GPU_IPC_ENABLED=0        # some builds use this


#module load libfabric/1.22.0
#export LD_LIBRARY_PATH=/opt/rocm-6.3.0/llvm/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}

echo "[Modules]"
module -t list
echo "[MAGMA picked]"
echo "$LD_LIBRARY_PATH" | tr ':' '\n' | grep magma || echo "  (no magma in LD_LIBRARY_PATH)"
echo "[PELE_MAGMA_HOME]"
echo "$PELE_MAGMA_HOME"

