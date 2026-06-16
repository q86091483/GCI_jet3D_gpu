TOP = /scratch/w47/q86091483/code/exascale_eb
PELELMEX_HOME      ?= ${TOP}/PeleLMeX
PELE_HOME 		     ?= ${TOP}/PeleLMeX
AMREX_HOME         ?= ${TOP}/amrex
PELE_PHYSICS_HOME  ?= ${TOP}/PelePhysics
AMREX_HYDRO_HOME   ?= ${TOP}/AMReX-Hydro
PELEMP_HOME        ?= ${TOP}/PeleMP
SUNDIALS_HOME      ?= ${TOP}/sundials-7.4.0
#SUNDIALS_HOME      ?= ${TOP}/PelePhysics/ThirdParty/INSTALL/gnu

#HYPRE_DIR ?= /home/zisen347/opt/hypre-2.28.0

# Augxiliary fields
USE_AUX = TRUE
USE_MIXF = TRUE
USE_AGE = TRUE
USE_AGEPV = FALSE

# AMReX
DIM = 3
COMP = gnu
PRECISION = DOUBLE
USE_EB = FALSE
USE_HYPRE = FALSE

# Profiling
PROFILE = FALSE
TINY_PROFILE = FALSE
COMM_PROFILE = FALSE
TRACE_PROFILE = FALSE
MEM_PROFILE = FALSE
USE_GPROF = FALSE

# Performance
USE_MPI = TRUE
USE_OMP = FALSE
USE_CUDA = FALSE
USE_SYCL = FALSE

USE_HIP = FALSE
USE_MAGMA = FALSE
PELE_USE_MAGMA = FALSE

# Debugging
DEBUG = FALSE
FSANITIZER = FALSE
THREAD_SANITIZER = FALSE

# PelePhysics
Chemistry_Model = prf_rd53_new #heptane_4sp
Eos_Model = Fuego
Transport_Model = Simple

include $(PELELMEX_HOME)/Exec/Make.PeleLMeX
