#!/bin/bash -fl
#------------------------------------------------------------------------------
# Batch system directives
#------------------------------------------------------------------------------
#SBATCH  --job-name=SILHS-DIAG
#SBATCH  --nodes=1
#SBATCH  --ntasks-per-node=1
#SBATCH  --output=logs/SILHS.DIAG
#SBATCH  --time=12:15:00
#SBATCH  --partition=acme-centos6
#SBATCH  --account=condo
# #SBATCH  --qos=premium

module load nco
module load  netcdf/4.6.1-c2mecde
./diag140804.csh
