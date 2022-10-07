# -*- coding: utf-8 -*-
'''
E3SM CLUBB Diagnostics package 

Main code to make 1) 2D plots,2) profiles, 3) budgets on selected stations, 
         and then build up  webpages  etc
    zhunguo : guozhun@lasg.iap.ac.cn 
    Kate
'''

## ==========================================================
# Begin User Defined Settings
# User defined name used for this comparison, this will be the name 
#   given the directory for these diagnostics
case='paper4' # A general case name
outdir='/lcrc/group/acme/zhun/plots/' # Location of plots

case='sens919_5' # A general case name
outdir='/lcrc/group/acme/public_html/diagnostic_output/ac.zguo/'

filepath=[ \
'/lcrc/group/acme/ac.zguo/E3SM_simulations/',\
'/lcrc/group/acme/ac.zguo/E3SM_simulations/',\
'/lcrc/group/acme/ac.zguo/E3SM_simulations/',\
'/lcrc/group/acme/ac.zguo/E3SM_simulations/',\
'/lcrc/group/acme/ac.zguo/E3SM_simulations/',\
          ]
cases=[ \
'chrysalis.bmg20220630.sens915_18.ne30pg2_r05_oECv3',\
'chrysalis.bmg20220630.sens915_19.ne30pg2_r05_oECv3',\
'chrysalis.bmg20220630.sens915_20.ne30pg2_r05_oECv3',\
'chrysalis.bmg20220630.sens915_21.ne30pg2_r05_oECv3',\
'chrysalis.bmg20220630.sens915_22.ne30pg2_r05_oECv3',\
]

# Give a short name for your experiment which will appears on plots

casenames=[ \
'sens919_18',\
'sens919_19',\
'sens919_20',\
'sens919_21',\
'sens919_22_tuner',\
]


years=[\
        1979, 1979, 1979,1979,1979,2010, 2010, 2010,2010,2010,2010]
nyear=[\
        1, 1, 1, 1,1,1,1, 1, 1,1,1,1]

dpsc=[\
      'none','none','none','none','none','none','none','none','none','none','none','none','none','none','none','none','none','none','none']
# NOTE, dpsc,deep scheme, has to be 'none', if silhs is turned on. 

# Observation Data
filepathobs='/blues/gpfs/home/ac.zguo/amwg_diag_20140804/obs_data_20140804/'
#------------------------------------------------------------------------
# Setting of plots.
ptype         ='png'   # eps, pdf, ps, png, x11, ... are supported by this package
cseason       ='ANN' # Seasons, or others
casename      =case+'_'+cseason

#------------------------------------------------------------------------
calfvsite        = True       # Calculate site indexes for FV files
calmean          = True       # make mean states
findout          = True       # pick out the locations of your sites
draw2d           = True       # 2D plots, SWCF etc.
drawlarge        = True       # profiles for large-scale variable on your sites 
drawclubb        = True       # profiles for standard clubb output
drawskw          = True       # profiles for skewness functions
drawrain         = True       # profiles for SNOW, Rain etc.
drawbgt          = True       # budgets of CLUBB prognostic Eqs 
drawe3smbgt      = False      # budgets of e3sm tendency
drawmicrobgt     = False       # budgets of MG2
drawaero         = False      # AERO for cloud brone
# ONLY for SILHS
drawhf           = False      # Tendency of holl filler 
drawsilhs        = False      # profiles for silhs variables
domatrix         = False
makeweb          =True        # Make a webpage?
maketar          =True        # Tar them?

clevel = 500
area  = 1.
# Note, this para helps to find out the 'ncol' within
# lats - area < lat(ncol) < lons + area .and. lons- area < lon(ncol) < lons + area
#------------------------------------------------------------------------
# Please give the lat and lon of sites here.
# sites    1    2    3    4    5    6    7    8    9    10   11   12   13   14   15   16   17   18   19   20   21   23   24   25   26   27   28   29   30  31  32 33
lats = [  20,  27, -20, -20,  -5,  -1,  60,   2,   9,   56,  45,   0,  10,  20,   0,   5,   9, -60,   0,   0, -45, -75,  30,  25 , 70 , 15,  17,  13,  36, 28, 29, 30, 27 , 30, 27]
lons = [ 190, 240, 275, 285, 355, 259,  180, 140, 229, 311, 180, 295,  90, 205, 325, 280, 170, 340, 305,  25,  90,  90,  90, 105 , 90, 300, 300, 300, 263, 240,240, 240 , 242, 238, 238 ]


#========================================================================

#------------------------------------------------------------------------
# Do not need to change
#------------------------------------------------------------------------

ncases =len(cases)
nsite  =len(lats)

casedir=outdir+casename
print(casedir)

import os
import function_cal_mean
import function_pick_out
import draw_plots_hoz_2D
import draw_plots_hoz_3D
import draw_large_scale
import draw_clubb_skew
import draw_silhs_standard 
import draw_clubb_standard
import draw_clubb_budget
import draw_hollfiller
import draw_rain 
import draw_micro_budget
import draw_e3sm_budget
import Common_functions
import Diagnostic_webpage

casedir=outdir+casename

if not os.path.exists(casedir):
    os.mkdir(casedir)

if calmean:
    print('Getting climatological mean')
    function_cal_mean.cal_mean(ncases, cases, years,nyear, nsite, lats, lons, area, filepath)

if findout:
    print('Find out the sites')
    function_pick_out.pick_out(ncases, cases, years, nsite, lats, lons, area, filepath,casedir,calfvsite)

if draw2d:
    print('Drawing 2d')
    plot2d=draw_plots_hoz_2D.draw_2D_plot(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir)
    clevel=500
    plot3d=draw_plots_hoz_3D.draw_3D_plot(ptype,clevel,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir)
    if domatrix:
       datain = np.empty(len(cases), dtype=object)
       for i in range(len(cases)):
             datain[i] = './data/' + cases[i]+'_Regional.nc'
	       print(datain)
       print(cases)
       defaultNcFilename=datain[0]
       sensNcFilenames=datain[2:len(cases)]

       obsMetricValsDict = { 'LWCF_GLB': 28.008, 'PRECT_GLB': 0.000000031134259, 'SWCF_GLB': -45.81, 'TMQ_GLB': 24.423, \
                             'LWCF_DYCOMS': 17.39229, 'PRECT_DYCOMS': 5.540433451401774e-09, 'SWCF_DYCOMS': -63.05767, 'TMQ_DYCOMS': 19.03481,\
                             'LWCF_LBA': 54.7332, 'PRECT_LBA': 7.86887e-08, 'SWCF_LBA': -62.0982, 'TMQ_LBA': 51.1303,\
                             'LWCF_HAWAII': 21.111, 'PRECT_HAWAII': 1.47959e-08, 'SWCF_HAWAII': -31.6793, 'TMQ_HAWAII': 30.7126,\
                             'LWCF_WP': 54.7332, 'PRECT_WP': 7.86887e-08, 'SWCF_WP': -62.0982, 'TMQ_WP':51.1303,\
                             'LWCF_EP': 32.724, 'PRECT_EP': 5.93702e-08, 'SWCF_EP': -54.0756, 'TMQ_EP':45.7974,\
                             'LWCF_NP': 26.2394, 'PRECT_NP': 2.85975e-08, 'SWCF_NP': -50.9236, 'TMQ_NP':12.7285,\
                             'LWCF_SP': 31.9614, 'PRECT_SP': 3.46254e-08, 'SWCF_SP': -70.2646, 'TMQ_SP':10.947,\
                             'LWCF_PA': 28.5308, 'PRECT_PA': 3.22142e-08, 'SWCF_PA': -73.4048, 'TMQ_PA':50.0178,\
                             'LWCF_CAF': 57.0782, 'PRECT_CAF': 5.71253e-08, 'SWCF_CAF': -60.8234, 'TMQ_CAF':41.1117,\
                             'LWCF_VOCAL': 16.2196, 'PRECT_VOCAL': 1.78555e-09, 'SWCF_VOCAL': -77.2623, 'TMQ_VOCAL':17.5992  }

       linSolnNcFilename = \
            './data/anvil.0703.lmm_1.ne30_ne30_Regional.nc'


       metricsNames = np.array(['PRECT_GLB','PRECT_LBA','PRECT_WP','PRECT_EP','PRECT_NP','PRECT_VOCAL','PRECT_DYCOMS','PRECT_HAWAII','PRECT_SP','PRECT_PA','PRECT_CAF'])#,'SWCF_GLB','SWCF_DYCOMS','SWCF_HAWAII','SWCF_VOCAL','SWCF_NP','SWCF_WP','SWCF_LBA','SWCF_EP','SWCF_SP','SWCF_PA','SWCF_CAF','LWCF_GLB','LWCF_LBA','LWCF_DYCOMS','LWCF_HAWAII','LWCF_WP','LWCF_EP','LWCF_NP','LWCF_VOCAL','LWCF_PA','LWCF_SP','LWCF_CAF'])
       paramsNames = np.array(['clubb_c8','clubb_c_k10','clubb_c_invrs_tau_N2','clubb_c_invrs_tau_wpxp_n2_thresh','micro_vqit'])
       transformedParamsNames = np.array(['clubb_c8','clubb_c_k10','clubb_c_invrs_tau_N2','clubb_c_invrs_tau_wpxp_n2_thresh','micro_vqit'])#'prc_exp','clubb_c_invrs_tau_n2','clubb_c_invrs_tau_n2_wp2','clubb_c_invrs_tau_n2_clear_wp3'])
       metricsWeights = np.array([[1.],[1.],[1.],[1.],[1.], [1.], [1.],[1.],[1.],[1.],[1.]])#
                                #,[1.],[1.],[1.],[1.],[1.], [1.], [1.],[1.],[1.],[1.],[1.],[1.],[1.],[1.],[1.],[1.], [1.], [1.],[1.],[1.],[1.],[1.]])

       sensMatrixOrig, sensMatrix, normlzdSensMatrix, svdInvrsNormlzdWeighted, \
            dparamsSoln, paramsSoln, defaultBiasesApprox = \
          analyze_sensitivity_matrix.analyzeSensMatrix(metricsNames, paramsNames, transformedParamsNames,
                      metricsWeights,
                      sensNcFilenames, defaultNcFilename,
                      obsMetricValsDict)
    # See if the solution based on a linear combination of the SVD-calculated parameter values
    #    matches what we expect.
       linSolnBias = \
          analyze_sensitivity_matrix.calcLinSolnBias(linSolnNcFilename, defaultNcFilename,
                                  metricsNames)

       metricsNames = np.array(['SWCF_GLB','SWCF_DYCOMS','SWCF_HAWAII','SWCF_VOCAL','SWCF_NP','SWCF_WP','SWCF_LBA','SWCF_EP','SWCF_SP','SWCF_PA','SWCF_CAF'])
       sensMatrixOrig, sensMatrix, normlzdSensMatrix, svdInvrsNormlzdWeighted, \
            dparamsSoln, paramsSoln, defaultBiasesApprox = \
          analyze_sensitivity_matrix.analyzeSensMatrix(metricsNames, paramsNames, transformedParamsNames,
                      metricsWeights,
                      sensNcFilenames, defaultNcFilename,
                      obsMetricValsDict)

    # See if the solution based on a linear combination of the SVD-calculated parameter values
    #    matches what we expect.
       linSolnBias = \
          analyze_sensitivity_matrix.calcLinSolnBias(linSolnNcFilename, defaultNcFilename,
                                  metricsNames)


       metricsNames = np.array(['LWCF_GLB','LWCF_LBA','LWCF_DYCOMS','LWCF_HAWAII','LWCF_WP','LWCF_EP','LWCF_NP','LWCF_VOCAL','LWCF_PA','LWCF_SP','LWCF_CAF'])
       sensMatrixOrig, sensMatrix, normlzdSensMatrix, svdInvrsNormlzdWeighted, \
            dparamsSoln, paramsSoln, defaultBiasesApprox = \
          analyze_sensitivity_matrix.analyzeSensMatrix(metricsNames, paramsNames, transformedParamsNames,
                      metricsWeights,
                      sensNcFilenames, defaultNcFilename,
                      obsMetricValsDict)

    # See if the solution based on a linear combination of the SVD-calculated parameter values
    #    matches what we expect.
       linSolnBias = \
          analyze_sensitivity_matrix.calcLinSolnBias(linSolnNcFilename, defaultNcFilename,
                                  metricsNames)
       metricsNames = np.array(['TMQ_GLB','TMQ_LBA','TMQ_DYCOMS','TMQ_HAWAII','TMQ_WP','TMQ_EP','TMQ_NP','TMQ_VOCAL','TMQ_PA','TMQ_SP','TMQ_CAF'])
       sensMatrixOrig, sensMatrix, normlzdSensMatrix, svdInvrsNormlzdWeighted, \
            dparamsSoln, paramsSoln, defaultBiasesApprox = \
          analyze_sensitivity_matrix.analyzeSensMatrix(metricsNames, paramsNames, transformedParamsNames,
                      metricsWeights,
                      sensNcFilenames, defaultNcFilename,
                      obsMetricValsDict)

    # See if the solution based on a linear combination of the SVD-calculated parameter values
    #    matches what we expect.
       linSolnBias = \
          analyze_sensitivity_matrix.calcLinSolnBias(linSolnNcFilename, defaultNcFilename,
                                  metricsNames)


if drawclubb:
    print('Drawing CLUBB standard variables on selected sites')

    pname = 'std1'
    varis    = [ 'wp2','up2','vp2','rtp2','thlp2','wp3']
    cscale   = [     1,    1,    1,   1E6,      1,    1]
    chscale  = [   '1',  '1',  '1','1E-6',    '1',  '1']
    underlev = 0
    plotstd1=draw_clubb_standard.clubb_std_prf(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir,varis,cscale,chscale,pname,underlev)

    underlev = 750
    pname = 'std1_lev'
    plotstd1_lev=draw_clubb_standard.clubb_std_prf(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir,varis,cscale,chscale,pname,underlev)

    pname = 'std2'
    varis    = [ 'wprtp','wpthlp','wprcp','upwp','vpwp','rtpthlp']
    cscale   = [     1E3,       1,    1E3,     1,     1,     1E3]
    chscale  = [  '1E-3',     '1', '1E-3',   '1',    '1',    '1E-3']

    underlev = 0
    plotstd2=draw_clubb_standard.clubb_std_prf(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir,varis,cscale,chscale,pname,underlev)


    underlev = 750
    pname = 'std2_lev'
    plotstd2_lev=draw_clubb_standard.clubb_std_prf(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir,varis,cscale,chscale,pname,underlev)

    pname = 'std3'
    varis    = [ 'wp2thlp','wp2rtp','wpthlp2','wprtp2','rcp2', 'wp2rcp']
    cscale   = [         1,        1,       1,     1E6,   1E6,      1E3]
    chscale  = [       '1',      '1',     '1',  '1E-6','1E-6',   '1E-3']

    underlev = 0
    plotstd3=draw_clubb_standard.clubb_std_prf(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir,varis,cscale,chscale,pname,underlev)

    underlev = 750
    pname = 'std3_lev'
    plotstd3_lev=draw_clubb_standard.clubb_std_prf(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir,varis,cscale,chscale,pname,underlev)

    varis    = [ 'wpthvp','wp2thvp','rtpthvp','thlpthvp','wp4','wprtpthlp']
    cscale   = [        1,        1,      1E3,         1,    1,        1E3]
    chscale  = [      '1',      '1',   '1E-3',       '1',  '1',    '1-E-3']
    pname = 'std4'
    underlev = 0
    plotstd4=draw_clubb_standard.clubb_std_prf(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir,varis,cscale,chscale,pname,underlev)

    underlev = 750
    pname = 'std4_lev'
    plotstd4_lev=draw_clubb_standard.clubb_std_prf(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir,varis,cscale,chscale,pname,underlev)

#    pname = 'Tau'
#    varis   = [ 'invrs_tau_bkgnd','invrs_tau_shear','invrs_tau_sfc','tau_no_N2_zm','tau_zm','tau_wp2_zm','tau_xp2_zm','tau_wp3_zm',  'bv_freq_sqd']
#    cscale  = [               1E3,              1E3,            1E3,           1E3,     1E3,         1E3,         1E3,         1E3,            1E3]
#    chscale = [            '1E-3',           '1E-3',         '1E-3',        '1E-3',  '1E-3',      '1E-3',      '1E-3',      '1E-3',         '1E-3']
#    plottau=draw_clubb_standard.clubb_std_prf(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir,varis,cscale,chscale,pname)


if drawskw:
    print('Drawing CLUBB skewness functions on selected sites')
    plotskw=draw_clubb_skew.clubb_skw_prf(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir)

if drawsilhs:
    print('CLUBB standard variables on selected sites')
    plotsilhs=draw_silhs_standard.silhs_prf(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir)

if drawhf:
    print('Holl filler')
    plothf=draw_hollfiller.hollfiller_prf(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir)

if drawrain:
    print('Drawing Rain and Snow properties')

    pname = 'Rain'
    varis   = [ 'AQRAIN','ANRAIN','ADRAIN','FREQR']
    cscale  = [      1E6,     1,       1E4,      1]
    chscale = [   '1E-6',  '1',    '1E-4',     '1']
    plotrain=draw_rain.rain_prf(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir,varis,cscale,chscale,pname)

    pname = 'Snow'
    varis   = [ 'AQSNOW','ANSNOW','ADSNOW','FREQS']
    cscale  = [      1E6,     1,       1E4,      1]
    chscale = [   '1E-6',  '1',    '1E-4',     '1']
    plotsnow=draw_rain.rain_prf(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir,varis,cscale,chscale,pname)

    pname = 'NUM'
    varis   = [ 'AWNC','AWNI','AREL','AREI']
    cscale  = [     1E-7,    1E-3,        1,         1]
    chscale = [    '1E7',   '1E3',      '1',       '1']
    plotsnum=draw_rain.rain_prf(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir,varis,cscale,chscale,pname)

    pname = 'RAINQM'
    varis   = [ 'RAINQM','NUMRAI']
    cscale  = [     1E-12,    1E-3]
    chscale = [    '1E12',   '1E3']
    plotsqm=draw_rain.rain_prf(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir,varis,cscale,chscale,pname)


if drawaero:
    print('Drawing  aerosol related vars')

    pname = 'FREZ'
    varis   = [ 'DSTFREZIMM','BCFREZIMM','DSTFREZCNT','BCFREZCNT','DSTFREZDEP','BCFREZDEP']
    cscale  = [            1,          1,        1E12,       1E3 ,         1E8,        1E3]
    chscale = [          '1',        '1',     '1E-12',     '1E-3',      '1E-8',     '1E-3']
    plotsaero1=draw_rain.rain_prf(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir,varis,cscale,chscale,pname)

    pname = 'FREQAERO'
    varis   = ['FREQIMM','FREQCNT','FREQDEP','FREQMIX']
    cscale  = [      1,     1,       1E3,      1]
    chscale = [    '1',   '1',    '1E-3',     '1']
    plotsaero2=draw_rain.rain_prf(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir,varis,cscale,chscale,pname)

    pname = 'ACN'
    varis   = [ 'bc_a1_num','bc_c1_num','dst_a1_num','dst_a3_num','dst_c1_num','dst_c3_num']
    cscale  = [            1,         1,           1,         1E3,          1,        1E3]
    chscale = [          '1',       '1',         '1',      '1E-3',         '1',     '1E-3']
    plotsaero3=draw_rain.rain_prf(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir,varis,cscale,chscale,pname)


if drawe3smbgt:
    print('Drawing e3sm standard budgets')
    plote3smbgt=draw_e3sm_budget.draw_e3sm_bgt(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir,dpsc)

if drawmicrobgt:
    print('Drawing MG budget')
    pname = 'mirco1'
    vname   = [ 'Liquid','Ice','Rain','Snow']
    varis   = [ 'MPDLIQ','MPDICE','QRSEDTEN','QSSEDTEN'] # We just need a unit
    cscale  = [      1E9,     1E9,       1E9,       1E9]
    chscale = [   '1E-9',  '1E-9',    '1E-9',    '1E-9']
    plotmicrobgt1=draw_micro_budget.draw_micro_bgt(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir,varis,vname,cscale,chscale,pname)

    pname = 'micro2'
    vname   = [ 'Vapor','NUMCLDLIQ','NUMCLDICE']
    varis   = [ 'QISEVAP','nnuccco',  'nnuccdo']  # We just need a unit
    cscale  = [      1E9,     1E-3,      1E-1]
    chscale = [   '1E-9',    '1E3',     '1E1']
    plotmicrobgt2=draw_micro_budget.draw_micro_bgt(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir,varis,vname,cscale,chscale,pname)

if drawbgt:
    print('Drawing CLUBB BUDGET')
    varis   = [ 'wp2','wp3','up2','vp2']
    cscale  = [     1,    1,    1,    1]
    chscale = [   '1',  '1',  '1',  '1']
    pname = 'Budget1'
    plotbgt1=draw_clubb_budget.draw_clubb_bgt(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir,varis,cscale,chscale,pname)

    varis    = [ 'wprtp','wpthlp',  'rtp2', 'thlp2']
    cscale   = [     1E7,     1E4,    1E11,     1E4]
    chscale  = [  '1E-7',  '1E-4', '1E-11',  '1E-4']
    pname = 'Budget2'
    plotbgt2=draw_clubb_budget.draw_clubb_bgt(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir,varis,cscale,chscale,pname)   

    varis   = [  'um',   'rtpthlp',  'thlm',   'rtm']
    cscale  = [   1E4,    1E4,     1E5,     1E8]
    chscale = ['1E-4', '1E-4',  '1E-5',  '1E-8']
    pname = 'Budget3'
    plotbgt3=draw_clubb_budget.draw_clubb_bgt(ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir,varis,cscale,chscale,pname)  

if makeweb:
    print('Making webpages')
    Diagnostic_webpage.main_web(casename,casedir)

    Diagnostic_webpage.sets_web(casename,casedir,'diff.*.asc','txt',\
                                'Gitdiff','1000','1000')

    if (draw2d):
        plot2d.extend(plot3d[:])

        Diagnostic_webpage.sets_web(casename,casedir,plot2d,'2D',\
				'Horizontal Plots','1000','1000')



    for ire in range (0, nsite):
        plotclb=[]
        if (drawlarge):
           plotclb.append(plotlgs[ire])
        if (drawclubb):  
           plotclb.append(plotstd1[ire])
           plotclb.append(plotstd2[ire])
           plotclb.append(plotstd3[ire])
           plotclb.append(plotstd4[ire])
#           plotclb.append(plottau[ire])

        if (drawskw):
           plotclb.append(plotskw[ire])
        if (drawhf):
           plotclb.append(plothf[ire])
        if (drawrain):
           plotclb.append(plotrain[ire])
           plotclb.append(plotsnow[ire])
           plotclb.append(plotsnum[ire])
           plotclb.append(plotsqm[ire])

        if (drawaero):
           plotclb.append(plotsaero1[ire])
           plotclb.append(plotsaero2[ire])
           plotclb.append(plotsaero3[ire])


        if (drawmicrobgt):
           for im in range (0, ncases ):
               plotclb.append(plotmicrobgt1[ire*ncases+im])
#               plotclb.append(plotmicrobgt2[ire*ncases+im])

        if (drawe3smbgt):
           for im in range (0, ncases ):
               plotclb.append(plote3smbgt[ire*ncases+im])

        if (drawbgt):
           for im in range (0, ncases ):
               plotclb.append(plotbgt1[ire*ncases+im])
           for im in range (0, ncases ):
               plotclb.append(plotbgt2[ire*ncases+im])
           for im in range (0, ncases ):
               plotclb.append(plotbgt3[ire*ncases+im])

        Diagnostic_webpage.sets_web(casename,casedir,plotclb,str(lons[ire])+'E_'+str(lats[ire])+'N',\
                                  'Profiles on '+str(lons[ire])+'E_'+str(lats[ire])+'N','908','636')

if maketar:
    print('Making tar file of case')
    Common_functions.make_tarfile(outdir+casename+'.tar',outdir+casename)
    
