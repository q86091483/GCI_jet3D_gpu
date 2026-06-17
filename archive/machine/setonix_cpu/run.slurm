#!/bin/bash
#SBATCH --job-name=GCI3D
#SBATCH --account=w47
#SBATCH --partition=work

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1

#SBATCH --mem-per-cpu=1840M

#SBATCH --time=24:00:00
#SBATCH --output=mpi_output_%j.txt
#SBATCH --mail-type=FAIL

cd $SLURM_SUBMIT_DIR
export MPICH_OFI_STARTUP_CONNECT=1
export MPICH_OFI_VERBOSE=1

module load gcc 

srun -N 20 -n 1280 --mem-per-cpu=1840M PeleLMeX3d.gnu.x86-milan.MPI.ex input.3d

#rsync -avzPh zl5403@gadi-dm.nci.org.au:/scratch/w47/zl5403/scopingRuns/Ujet30_Re8000_rd53/chk_05000 ./chk_05000

echo ">>ending:  " `date`
