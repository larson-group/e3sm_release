set case =  anvil.default.NGD_clubb_silhs_P3_1deg

set nmember = 512
cd /lcrc/group/acme/ac.griffin/E3SM_simulations/$case.ne30pg2_r05_oECv3/run/
mkdir climo
set endyear = 2014
set j = 2010
while ( $j <= $endyear )
set yrs = `printf "%04d\n" $j`
set i = 1
while ( $i <= 12 )
set foo = `printf "%02d\n" $i`
echo ${foo}
rm -f climo/$case.ne30pg2_r05_oECv3.eam.h0.${yrs}-${foo}.nc
ncks --map=/home/ac.griffin/amwg/mapping/map_ne30pg2_to_cmip6_180x360_aave.20200201.nc $case.ne30pg2_r05_oECv3.eam.h0.${yrs}-${foo}.nc climo/$case.ne30pg2_r05_oECv3.eam.h0.${yrs}-${foo}.nc
@ i++
end
@ j++
end
