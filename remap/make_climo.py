# -*- coding: utf-8 -*-
'''
E3SM CLUBB Diagnostics package 
    zhunguo : guozhun@lasg.iap.ac.cn ; guozhun@uwm.edu
'''

## ==========================================================
# Begin User Defined Settings
# User defined name used for this comparison, this will be the name 
#   given the directory for these diagnostics

filepath=[ \
'/lcrc/group/acme/ac.griffin/E3SM_simulations/',\
          ]
cases=[ \
'anvil.default.clubb_silhs_test.ne16_ne16',\
]

years=[\
        1]
nyear=[\
        1]

import os
import function_cal_mean

ncases =len(cases)

print('Getting climatological mean')
function_cal_mean.cal_mean(ncases, cases, years,nyear, filepath)

