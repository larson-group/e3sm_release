set case = anvil.default.clubb_silhs_upgrade_Sept2020
 
cd /lcrc/group/acme/ac.griffin/E3SM_simulations/$case.ne30_ne30/run/
ncks --map=/home/ac.griffin/amwg/mapping/map_ne30np4_to_fv129x256_aave.150418.nc $case.ne30_ne30.cam.h1.0001-01-01-00000.nc climo/$case.cam.h3.0001-01-01-00000.nc
