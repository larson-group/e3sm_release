set case = anvil.default.NGD_clubb_silhs_P3_std_fallspeed
 
set nmember = 512
cd /lcrc/group/acme/ac.griffin/E3SM_simulations/$case.ne30_ne30/run/
mkdir climo
#set endyear = 2015
#set j = 2010
set endyear = 2
set j = 1
while ( $j <= $endyear )
set yrs = `printf "%04d\n" $j`
set i = 1
while ( $i <= 12 )
set foo = `printf "%02d\n" $i`
echo ${foo}
rm -f climo/$case.ne30_ne30.eam.h0.${yrs}-${foo}.nc
ncks --map=/home/ac.griffin/amwg/mapping/map_ne30np4_to_fv129x256_aave.150418.nc $case.ne30_ne30.eam.h0.${yrs}-${foo}.nc climo/$case.ne30_ne30.eam.h0.${yrs}-${foo}.nc
@ i++
end
@ j++
end
