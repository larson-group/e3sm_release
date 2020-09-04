#!/bin/csh
#PBS  -V 
#PBS  -N make_climo
#PBS  -r n 
#PBS  -j oe 
#PBS  -m ae 
#PBS  -S /bin/bash 
#PBS -q acme
#PBS -l nodes=1:ppn=16
#PBS -l walltime=01:59:00

set echo

setenv projectdir /home
setenv modeloutdir /lcrc/group/acme

setenv start_year 0001
setenv last_year 0001

setenv case anvil.default.clubb_silhs_test.ne30_ne30
setenv W1 $projectdir/$user/amwg/mapping
setenv P1 $modeloutdir/$user/E3SM_simulations/${case}/run
setenv P2 $modeloutdir/$user/E3SM_simulations/${case}/run/regridded_climo

#setenv M1 ${W1}/map_ne30np4_to_fv129x256_aave.20150901.nc
setenv M1 ${W1}/map_ne30np4_to_fv129x256_aave.150418.nc

sh climo_nco.sh -c ${case} -s ${start_year} -e ${last_year} -r ${M1} -i ${P1} -o ${P2}
