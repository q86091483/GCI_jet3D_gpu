source load_gpu.sh
export HIP_PLATFORM=amd


export FI_PROVIDER=cxi
export FI_CXI_PORTS=0
export FI_CXI_DISABLE_HMEM=1
export FI_HMEM_DISABLE=1
export MPICH_GPU_SUPPORT_ENABLED=0
export MPICH_OFI_SKIP_NIC_SYMMETRY_TEST=1
export OMP_NUM_THREADS=1
echo "ENV_CHECK: $(date)"
env | egrep 'FI_|MPICH_|HIP_PLATFORM|SLURM_NNODES|SLURM_NTASKS_PER_NODE' | sort

srun -N ${SLURM_NNODES} \
     --ntasks-per-node=8  \
     --gpus-per-task=1 \
     --cpus-per-task=1 \
     --export=ALL \
     ./PeleLMeX3d.hip.x86-milan.MPI.HIP.ex input.3d 
