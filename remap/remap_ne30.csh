set case = anvil-centos7.base2.n2p3_c151_pre1_fallp25 
 
set nmember = 512
cd /lcrc/group/acme/ac.zguo/E3SM_simulations/$case.ne30_ne30/run/
mkdir climo
set j = 1
while ( $j <= 5 )
set yrs = `printf "%04d\n" $j`
set i = 1
while ( $i <= 12 )
set foo = `printf "%02d\n" $i`
echo ${foo}
rm -f climo/$case.ne30_ne30.cam.h0.${yrs}-${foo}.nc
ncks --map=/home/ac.zguo/amwg_diag_20140804/mapping/map_ne30np4_to_fv129x256_aave.150418.nc $case.ne30_ne30.cam.h0.${yrs}-${foo}.nc climo/$case.ne30_ne30.cam.h0.${yrs}-${foo}.nc
@ i++
end
@ j++
end
