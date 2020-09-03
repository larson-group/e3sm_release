set case = anvil.default.clubb_silhs_test
 
cd /lcrc/group/acme/ac.griffin/E3SM_simulations/$case.ne16_ne16/run/
mkdir climo
set endyear = 2
   set j = 1
   while ( $j <= $endyear )
   set yrs = `printf "%04d\n" $j`
       set i = 1
       while ( $i <= 12 )
       set foo = `printf "%02d\n" $i`
       echo ${foo}
          rm -f climo/$case.ne16_ne16.cam.h0.${yrs}-${foo}.nc
          ncks --map=/home/ac.griffin/amwg/mapping/map_ne16np4_to_ne30np4_aave.20160601.nc $case.ne16_ne16.cam.h0.${yrs}-${foo}.nc $case.tmp.nc
          ncks --map=/home/ac.griffin/amwg/mapping/map_ne30np4_to_fv129x256_aave.150418.nc $case.tmp.nc climo/$case.ne16_ne16.cam.h0.${yrs}-${foo}.nc
       rm $case.tmp.nc
       @ i++
       end
   @ j++
   end


