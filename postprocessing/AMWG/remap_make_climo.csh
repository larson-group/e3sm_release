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

setenv case anvil.default.clubb_silhs_test.ne16_ne16
setenv W1 $projectdir/$user/amwg/mapping
setenv P1 $modeloutdir/$user/E3SM_simulations/${case}/run/climo_files
setenv P2 $modeloutdir/$user/E3SM_simulations/${case}/run/regridded_climo

#setenv M1 ${W1}/map_ne30np4_to_fv129x256_aave.20150901.nc
setenv M1 ${W1}/map_ne30np4_to_fv129x256_aave.150418.nc

setenv start_dir $PWD

cd $modeloutdir/$user/E3SM_simulations/$case/run/
mkdir climo_files

set j = 1
while ( $j <= $last_year )
set yrs = `printf "%04d\n" $j`
set i = 1
while ( $i <= 12 )
set mths = `printf "%02d\n" $i`
echo ${mths}
rm -f climo_files/$case.cam.h0.${yrs}-${mths}.nc
ncks --map=${W1}/map_ne16np4_to_ne30np4_aave.20160601.nc $case.cam.h0.${yrs}-${mths}.nc climo_files/$case.cam.h0.${yrs}-${mths}.nc
#ncks --map=${W1}/map_ne16np4_to_ne30np4_aave.20160601.nc $case.cam.h0.${yrs}-${mths}.nc $case.tmp.nc
#ncks --map=/home/ac.griffin/amwg/mapping/map_ne30np4_to_fv129x256_aave.150418.nc $case.tmp.nc climo_files_2/$case.ne16_ne16.cam.h0.${yrs}-${foo}.nc
#rm $case.tmp.nc
@ i++
end
@ j++
end

cd $start_dir

sh climo_nco.sh -c ${case} -s ${start_year} -e ${last_year} -r ${M1} -i ${P1} -o ${P2}

