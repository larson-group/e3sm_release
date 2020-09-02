set case = anvil-centos7.NGD.ZM_n2p3_c151 
set aff = ("00000" "10800" "21600" "32400" "43200" "54000" "64800" "75600")

 
set nmember = 512
cd /lcrc/group/acme/ac.zguo/E3SM_simulations/$case.ne16_ne16/run/
mkdir climo
set j = 1
while ( $j <= 1 )
set yrs = `printf "%04d\n" $j`
  set i = 1
  while ( $i <= 1 )
    set day = 1
    while ( $day <= 1 )

set foo = `printf "%02d\n" $i`
set fdy = `printf "%02d\n" $day`

set k = 1
while ( $k <= 8 )
echo ${foo}
rm -f climo/$case.ne16_ne16.cam.h0.${yrs}-${foo}-${fdy}-${aff[$k]}.nc
ncks --map=/home/ac.zguo/amwg_diag_20140804/mapping/map_ne16np4_to_ne30np4_aave.20160601.nc $case.ne16_ne16.cam.h0.${yrs}-${foo}-${fdy}-${aff[$k]}.nc $case.tmp.nc
ncks --map=/home/ac.zguo/amwg_diag_20140804/mapping/map_ne30np4_to_fv129x256_aave.150418.nc $case.tmp.nc climo/$case.ne16_ne16.cam.h0.${yrs}-${foo}-${fdy}-${aff[$k]}.nc
rm $case.tmp.nc
@ k++
end

@ day++
end
@ i++
end
@ j++
end
