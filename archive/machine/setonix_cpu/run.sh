export MPICH_OFI_STARTUP_CONNECT=1
export MPICH_OFI_VERBOSE=1
source load_env.sh

srun -N 75 --mem-per-cpu=1840M PeleLMeX3d.gnu.x86-milan.MPI.ex input.3d
