set case = anvil.default.clubb_silhs_test
set aff = ("00000" "10800" "21600" "32400" "43200" "54000" "64800" "75600")

 
set nmember = 512
cd /lcrc/group/acme/ac.griffin/E3SM_simulations/$case.ne30_ne30/run/
mkdir climo
set j = 1
while ( $j <= 1 )
set yrs = `printf "%04d\n" $j`
set i = 1
while ( $i <= 1 )
set day = 5
while ( $day <= 5 )

set foo = `printf "%02d\n" $i`
set fdy = `printf "%02d\n" $day`

set k = 1
while ( $k <= 8 )
echo ${foo}
rm -f climo/$case.ne30_ne30.eam.h0.${yrs}-${foo}-${fdy}-${aff[$k]}.nc
ncks --map=/home/ac.griffin/amwg/mapping/map_ne30np4_to_fv129x256_aave.150418.nc $case.ne30_ne30.eam.h0.${yrs}-${foo}-${fdy}-${aff[$k]}.nc climo/$case.ne30_ne30.eam.h0.${yrs}-${foo}-${fdy}-${aff[$k]}.nc
rm $case.tmp.nc
@ k++
end

@ day++
end
@ i++
end
@ j++
end
