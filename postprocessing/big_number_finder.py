# big_number_finder.py
#
# Finds big numbers in E3SM output files.
#
# This script loops over each variable in the E3SM output file.  For numerical
# variables, it prints the variable name, the absolute maximum value, and the
# location(s) of the absolute maximum value.  For variables that have negative
# values, it also prints the absolute minimum value (in other words, the
# largest magnitude negative value) and the location(s) of the absolute minimum
# value.
#
# To find instances of unreasonably huge magnitude values, simply search the
# output of the script for the string "e+". 
#
# To obtain the environment on Anvil, if you have the E3SM-CLUBB stats
# installed:
#
# source /lcrc/soft/climate/e3sm-unified/base/etc/profile.d/conda.sh
# conda activate <USERNAME>
# python big_number_finder.py

from netCDF4 import Dataset
import numpy as np

E3SM_filename='/lcrc/group/acme/ac.griffin/E3SM_simulations/anvil.default.clubb_silhs_upgrade_Sept2020.ne30_ne30/run/anvil.default.clubb_silhs_upgrade_Sept2020.ne30_ne30.cam.h0.0001-01.nc'

# Extract data from E3SM NetCDF output file.
dataset = Dataset(E3SM_filename)

# Loop over all variables
for varname in dataset.variables:
   print('################################################')
   if ( dataset.variables[varname].name == 'cosp_ht_bnds' ) :
      continue
   if ( dataset.variables[varname].name == 'cosp_dbze_bnds' ) :
      continue
   if ( len(dataset.variables[varname].dimensions[:]) == 0 ):
      var = dataset.variables[varname][:]
      if ( dataset.variables[varname].datatype == 'float64' or \
           dataset.variables[varname].datatype == 'float32' or \
           dataset.variables[varname].datatype == 'int32' ):
         print( 'Variable:', dataset.variables[varname].name )
         print( 'Value = ', var )
   elif ( len(dataset.variables[varname].dimensions[:]) == 1 ):
      var = dataset.variables[varname][:]
      if ( dataset.variables[varname].datatype == 'float64' or \
           dataset.variables[varname].datatype == 'float32' or \
           dataset.variables[varname].datatype == 'int32' ):
         print( 'Variable:', dataset.variables[varname].name )
         print( 'Abs. max = ', np.amax(var), \
                'at ', np.where(var == np.amax(var)) )
         if ( np.any( var < 0 ) ):
            print( 'Abs. min = ', np.amin(var), \
                   'at ', np.where(var == np.amin(var)) )
   elif ( len(dataset.variables[varname].dimensions[:]) == 2 ):
      var = dataset.variables[varname][:,:]
      if ( dataset.variables[varname].datatype == 'float64' or \
           dataset.variables[varname].datatype == 'float32' or \
           dataset.variables[varname].datatype == 'int32' ):
         print( 'Variable:', dataset.variables[varname].name )
         print( 'Abs. max = ', np.amax(var), \
                'at ', np.where(var == np.amax(var)) )
         if ( np.any( var < 0 ) ):
            print( 'Abs. min = ', np.amin(var), \
                   'at ', np.where(var == np.amin(var)) )
   elif ( len(dataset.variables[varname].dimensions[:]) == 3 ):
      var = dataset.variables[varname][:,:,:]
      if ( dataset.variables[varname].datatype == 'float64' or \
           dataset.variables[varname].datatype == 'float32' or \
           dataset.variables[varname].datatype == 'int32' ):
         print( 'Variable:', dataset.variables[varname].name )
         print( 'Abs. max = ', np.amax(var), \
                'at ', np.where(var == np.amax(var)) )
         if ( np.any( var < 0 ) ):
            print( 'Abs. min = ', np.amin(var), \
                   'at ', np.where(var == np.amin(var)) )
   else:
      print('Variable has more than 3 dimensions')
      print(dataset.variables[varname])

