#!/bin/bash -l
#SBATCH --account=w47-gpu
#SBATCH --partition=gpu
#SBATCH --time=8:00:00

#SBATCH --nodes=15
#SBATCH --exclusive
#SBATCH --ntasks-per-node=8
#SBATCH --gres=gpu:8

##SBATCH --export=ALL

#SBATCH --job-name=AmoH2gpu
#SBATCH --output=outputfile_%j.log
#SBATCH --error=errorfile_%j.log

##SBATCH --gpus-per-task=1
##SBATCH --exclusive
##SBATCH --gpu-bind=closest
##SBATCH --exclude=nid002950,nid002984,nid002986,nid002988

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

#echo "=== batch LD_LIBRARY_PATH ==="
#echo "$LD_LIBRARY_PATH" | tr ':' '\n' | grep -i magma || true
#echo "=== task LD_LIBRARY_PATH (srun -n1) ==="
#srun -n1 --export=ALL bash -lc 'echo "$LD_LIBRARY_PATH" | tr ":" "\n" | grep -i magma || echo "NO_MAGMA_IN_TASK"'
#echo "=== task ldd ==="
#srun -n1 --export=ALL bash -lc 'ldd ./PeleLMeX3d.hip.x86-milan.MPI.HIP.ex | grep -i magma || echo "ldd: no magma"'

#srun -N 30 --ntasks-per-node=8 --gpus-per-task=1 \
#     ./PeleLMeX3d.hip.x86-milan.MPI.HIP.ex input.3d

srun -N ${SLURM_NNODES} \
     --ntasks-per-node=8  \
     --gpus-per-task=1 \
     --cpus-per-task=1 \
     --export=ALL \
     ./PeleLMeX3d.hip.x86-milan.MPI.HIP.ex input.3d > run.log.gpu.0 2>&1

echo ">>ending:  " `date`
