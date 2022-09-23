
'''
    Draw 2D plots
    Zhun Guo 
'''
import Ngl
from netCDF4 import Dataset
import matplotlib.pyplot as plt
import numpy as np
import scipy as sp
import pylab
import math
import os
import Common_functions
from subprocess import call

def get_varible_name(var_org):
    for item in sys._getframe().f_locals.items():
        print(item[0],item[1])
    for item in sys._getframe(1).f_locals.items():
        print(item[0],item[1])
    for item in sys._getframe(2).f_locals.items():
        if (var_org is item[1]):
            return item[0]
def get_name(number):
    print("{} = {}".format(get_varible_name(number),number))

def draw_2D_plot (ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs,casedir):

# ncases, the number of models
# cases, the name of models
# casename, the name of cases
# filepath, model output filepath
# filepathobs, filepath for observational data
# inptrs = [ncases]
 if not os.path.exists(casedir):
        os.mkdir(casedir)

 if not os.path.exists(casedir+'/2D'):
        os.mkdir(casedir+'/2D') 

 _Font   = 25
 interp = 2
 extrap = False
 infiles  = ['' for x in range(ncases)] 
 infiles2 = ['' for x in range(ncases)]
 ncdfs    = ['' for x in range(ncases)] 
 alpha    = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N']
 cunits = ['']
 varis    = ['SWCF','LWCF', 'PRECT','LHFLX','SHFLX',   'TMQ','PSL','TS', 'U10', 'CLDTOT'    , 'CLDLOW'   ,    'CLDHGH']
 varisobs = ['toa_cre_sw_mon','toa_cre_lw_mon', 'PRECT','hfls','hfss','prw','psl','tas', 'uas', 'CLDTOT_CAL','CLDLOW_CAL','CLDHGH_CAL']
 nvaris = len(varis)
 cscale   = [     1,     1,86400000,      1,      1,    1,    1,   1,     1,          100,         100,         100,       1000,1,1,1]
 cscaleobs =  [1,1,1,1,1,1,1,1,1,1,1,1,1,1]
# cntrs = [[0 for col in range(11)] for row in range(nvaris)]
 cntrs = np.zeros((nvaris,11),np.float32)

 obsdataset=['ceres_ebaf_toa_v4.0','ceres_ebaf_toa_v4.0','GPCP_v2.3',  'ERA-Interim',       'ERA-Interim', 'ERA-Interim','MERRA2', 'ERA-Interim','ERA-Interim','CALIPSOCOSP', 'CALIPSOCOSP','CALIPSOCOSP']
 rangeyr   =[      '200101_201512',      '200101_201512',         '','197901_201612', '197901_201612','197901_201612','198001_201612','197901_201612','197901_201612','','','',''  ]

 ncea_str='/blues/gpfs/home/software/spack-0.10.1/opt/spack/linux-centos7-x86_64/intel-17.0.4/nco-4.7.4-x4y66ep2ydoyegnckicvv5ljwrheniun/bin/ncea '
 ncwa_str='/blues/gpfs/home/software/spack-0.10.1/opt/spack/linux-centos7-x86_64/intel-17.0.4/nco-4.7.4-x4y66ep2ydoyegnckicvv5ljwrheniun/bin/ncwa  '
 ncks_str='/blues/gpfs/home/software/spack-0.10.1/opt/spack/linux-centos7-x86_64/intel-17.0.4/nco-4.7.4-x4y66ep2ydoyegnckicvv5ljwrheniun/bin/ncks '
 ncap2_str='/blues/gpfs/home/software/spack-0.10.1/opt/spack/linux-centos7-x86_64/intel-17.0.4/nco-4.7.4-x4y66ep2ydoyegnckicvv5ljwrheniun/bin/ncap2 '
 ncrcat_str='/blues/gpfs/home/software/spack-0.10.1/opt/spack/linux-centos7-x86_64/intel-17.0.4/nco-4.7.4-x4y66ep2ydoyegnckicvv5ljwrheniun/bin/ncrcat '
 ncrename_str='/blues/gpfs/home/software/spack-0.10.1/opt/spack/linux-centos7-x86_64/intel-17.0.4/nco-4.7.4-x4y66ep2ydoyegnckicvv5ljwrheniun/bin/ncrename ' 
 plot2d=['' for x in range(nvaris)]
 for iv in range(0, nvaris):
# make plot for each field 
   if(varis[iv] == 'CLDTOT' or varis[iv] == 'CLDLOW' or varis[iv] == 'CLDHGH'):
       cntrs[iv,:] = [ 2, 5, 10, 20, 30, 40, 50, 60, 70,80, 90]
   if(varis[iv] == 'LWCF'):
       cntrs[iv,:] = [1, 2,5, 10, 15, 20, 25, 30, 35, 40, 45] 
   if(varis[iv] =='SWCF' or varis[iv] =='FLUT'):
       cntrs[iv,:] = [-40, -50, -60, -70, -80, -90, -100, -110, -120, -130,-140]
   if(varis[iv]=='PRECT' or varis[iv]=='QFLX'):
       cntrs[iv,:] = [0.5, 1.5, 3, 4.5, 6, 7.5, 9, 10.5, 12,13.5,15]
   if(varis[iv] == 'LHFLX'):
       cntrs[iv,:] = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110]
   if(varis[iv] == 'SHFLX'):
       cntrs[iv,:] = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110]
   if(varis[iv] == 'U10'):
       cntrs[iv,:] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
   if(varis[iv] == 'TMQ'):
       cntrs[iv,:] = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
   if(varis[iv] == 'TGCLDLWP'):
       cntrs[iv,:] = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110]


#  Observational data
   if(obsdataset[iv] =='CCCM'):
       if(cseason == 'ANN'):
           fileobs = '/Users/guoz/databank/CLD/CCCm/cccm_cloudfraction_2007-'+cseason+'.nc'
       else:
           fileobs = '/Users/guoz/databank/CLD/CCCm/cccm_cloudfraction_2007-2010-'+cseason+'.nc'
   else:
       if (varisobs[iv] =='PRECT' or varis[iv] == 'CLDTOT' or varis[iv] == 'CLDLOW' or varis[iv] == 'CLDHGH'):
           fileobs = filepathobs+'/'+obsdataset[iv]+'/'+obsdataset[iv]+'_'+cseason+'_climo.nc'
       else:
           fileobs = filepathobs + '/'+obsdataset[iv]+'/'+obsdataset[iv]+'_'+cseason+'_'+rangeyr[iv] +'_climo.nc'

#       infiles[im]=filepath[im]+cases[im]+'/run/'+cases[im]+'_'+cseason+'_climo.nc'


   inptrobs = Dataset(fileobs,'r') 
   latobs=inptrobs.variables['lat'][:]
   lonobs=inptrobs.variables['lon'][:]
   if (varisobs[iv] =='U10'):
      B0=inptrobs.variables[varisobs[iv]][0,:,:] 
      B1=inptrobs.variables['V10'][0,:,:]
      B=(B0*B0+B1*B1)
      B=B * cscaleobs[iv]
      B=np.sqrt(B)
   else:
      B=inptrobs.variables[varisobs[iv]][0,:,:]
      B=B * cscaleobs[iv]



   os.system(ncwa_str+' -O -a lat,lon  -d lat,20.,35. -d lon,226.0,241.0 ' + fileobs + ' tmp.nc')
   os.system('echo DYCOMS'+varisobs[iv]+'=`ncks -H -s "%15.15f\n" -v '+varisobs[iv] + ' tmp.nc`') 
   os.system('rm -f tmp.nc')

   os.system(ncwa_str+' -O -a lat,lon  -d lat,10.,30. -d lon,200.0,220.0 ' + fileobs + ' tmp.nc')
   os.system('echo HAWAII'+varisobs[iv]+'=`ncks -H -s "%6.20f\n" -v '+varisobs[iv] + ' tmp.nc`')
   os.system('rm -f tmp.nc')
   os.system(ncwa_str+' -O -a lat,lon  -d lat,-25.,-15. -d lon,275.0,285.0 ' + fileobs + ' tmp.nc')
   os.system('echo VOCAL'+varisobs[iv]+'=`ncks -H -s "%6.20f\n" -v '+varisobs[iv] + ' tmp.nc`')
   os.system('rm -f tmp.nc')

   os.system(ncwa_str+' -O -a lat,lon  -d lat,-35.,-25. -d lon,282.0,288.0 ' + fileobs + ' tmp.nc')
   os.system('echo VOCAL near'+varisobs[iv]+'=`ncks -H -s "%6.20f\n" -v '+varisobs[iv] + ' tmp.nc`')
   os.system('rm -f tmp.nc')

   os.system(ncwa_str+' -O -a lat,lon  -d lat,-30.,-20. -d lon,5.0,15.0 ' + fileobs + ' tmp.nc')
   os.system('echo Nambian near'+varisobs[iv]+'=`ncks -H -s "%6.20f\n" -v '+varisobs[iv] + ' tmp.nc`')
   os.system('rm -f tmp.nc')

   os.system(ncwa_str+' -O -a lat,lon  -d lat,-20.,-10. -d lon,-5.0,5.0 ' + fileobs + ' tmp.nc')
   os.system('echo Nambian far'+varisobs[iv]+'=`ncks -H -s "%6.20f\n" -v '+varisobs[iv] + ' tmp.nc`')
   os.system('rm -f tmp.nc')

   os.system(ncwa_str+' -O -a lat,lon  -d lat,-15.,5. -d lon,290.0,320.0 ' + fileobs + ' tmp.nc')
   os.system('echo LBA'+varisobs[iv]+'=`ncks -H -s "%6.20f\n" -v '+varisobs[iv] + ' tmp.nc`')
   os.system('rm -f tmp.nc')
   os.system(ncwa_str+' -O -a lat,lon  -d lat,-10.,10. -d lon,110.,180. ' + fileobs + ' tmp.nc')
   os.system('echo WP'+varisobs[iv]+'=`ncks -H -s "%6.20f\n" -v '+varisobs[iv] + ' tmp.nc`')
   os.system('rm -f tmp.nc')
   os.system(ncwa_str+' -O -a lat,lon  -d lat,0.,15. -d lon,180.,270. ' + fileobs + ' tmp.nc')
   os.system('echo EP'+varisobs[iv]+'=`ncks -H -s "%6.20f\n" -v '+varisobs[iv] + ' tmp.nc`')
   os.system('rm -f tmp.nc')
   os.system(ncwa_str+' -O -a lat,lon  -d lat,-60.,-45. -d lon,0.1,360. ' + fileobs + ' tmp.nc')
   os.system('echo SP'+varisobs[iv]+'=`ncks -H -s "%6.20f\n" -v '+varisobs[iv] + ' tmp.nc`')
   os.system('rm -f tmp.nc')

   os.system(ncwa_str+' -O -a lat,lon  -d lat,45.,60. -d lon,0.1,360. ' + fileobs + ' tmp.nc')
   os.system('echo NP'+varisobs[iv]+'=`ncks -H -s "%6.20f\n" -v '+varisobs[iv] + ' tmp.nc`')
   os.system('rm -f tmp.nc')

   os.system(ncwa_str+' -O -a lat,lon  -d lat,0.1,10. -d lon,270.,290. ' + fileobs + ' tmp.nc')
   os.system('echo PA'+varisobs[iv]+'=`ncks -H -s "%6.20f\n" -v '+varisobs[iv] + ' tmp.nc`')
   os.system('rm -f tmp.nc')

   os.system(ncwa_str+' -O -a lat,lon  -d lat,-10.,10. -d lon,10.,40. ' + fileobs + ' tmp.nc')
   os.system('echo CAF'+varisobs[iv]+'=`ncks -H -s "%6.20f\n" -v '+varisobs[iv] + ' tmp.nc`')
   os.system('rm -f tmp.nc')
   #************************************************
   # create plot
   #************************************************
   plotname = casedir+'/2D/Horizontal_'+varis[iv]+'_'+cseason
   plot2d[iv] = 'Horizontal_'+varis[iv]+'_'+cseason
   wks= Ngl.open_wks(ptype,plotname)
   Ngl.define_colormap(wks,'cmocean_thermal')
#   Ngl.define_colormap(wks,'MPL_coolwarm')
 
#   ngl_define_colormap(wks,'prcp_1')
   plot = []

   textres               = Ngl.Resources()
   textres.txFontHeightF = 0.02   # Size of title.
   textres.txFont        = _Font
   Ngl.text_ndc(wks,varis[iv],0.1,.97,textres)

   pres            = Ngl.Resources()
   pres.nglMaximize = True
   pres.nglPanelYWhiteSpacePercent = 5
   pres.nglPanelXWhiteSpacePercent = 5
   pres.nglPanelBottom = 0.20
   pres.nglPanelTop = 0.9
   pres.pmLabelBarWidthF        = 0.8
   pres.nglFrame         = False
   pres.nglPanelLabelBar                 = True     # Turn on panel labelbar
   pres.nglPanelLabelBarLabelFontHeightF = 0.015    # Labelbar font height
   pres.nglPanelLabelBarHeightF          = 0.0750   # Height of labelbar
   pres.nglPanelLabelBarWidthF           = 0.700    # Width of labelbar
   pres.lbLabelFont                      = 'helvetica-bold' # Labelbar font
   pres.nglPanelTop                      = 0.935
   pres.nglPanelFigureStrings            = alpha
   pres.nglPanelFigureStringsJust        = 'BottomRight'


   res = Ngl.Resources()
   res.nglDraw         =  False            #-- don't draw plots
   res.nglFrame        =  False  
   res.cnFillOn     = True
   res.cnFillMode   = 'RasterFill'
   res.cnLinesOn    = False
   res.nglMaximize = True
   res.mpFillOn     = True
   res.mpCenterLonF = 180
   res.tiMainFont                     = _Font
   res.tiMainFontHeightF              = 0.025
   res.tiXAxisString                  = ''
   res.tiXAxisFont                    = _Font
   res.tiXAxisFontHeightF             = 0.025
   res.tiYAxisString                  = ''
   res.tiYAxisFont                    = _Font
   res.tiYAxisOffsetXF                = 0.0
   res.tiYAxisFontHeightF             = 0.025       
   res.tmXBLabelFont = _Font
   res.tmYLLabelFont = _Font
   res.tiYAxisFont   = _Font
   res.vpWidthF         = 0.80                      # set width and height
   res.vpHeightF        = 0.40
   res.vpXF             = 0.04
   res.vpYF             = 0.30

   res.cnInfoLabelOn                  = False  
   res.cnFillOn                       = True
   res.cnLinesOn                      = False
   res.cnLineLabelsOn                 = False
   res.lbLabelBarOn                   = False
 
#   res.vcRefMagnitudeF = 5.
#   res.vcMinMagnitudeF = 1.
#   res.vcRefLengthF    = 0.04
#   res.vcRefAnnoOn     = True#False
#   res.vcRefAnnoZone   = 3
#   res.vcRefAnnoFontHeightF = 0.02
#   res.vcRefAnnoString2 =''
#   res.vcRefAnnoOrthogonalPosF   = -1.0   
#  res.vcRefAnnoArrowLineColor   = 'blue'         # change ref vector color
#  res.vcRefAnnoArrowUseVecColor = False
#   res.vcMinDistanceF  = .05
#   res.vcMinFracLengthF         = .
#   res.vcRefAnnoParallelPosF    =  0.997
#   res.vcFillArrowsOn           = True
#   res.vcLineArrowThicknessF    =  3.0
#   res.vcLineArrowHeadMinSizeF   = 0.01
#   res.vcLineArrowHeadMaxSizeF   = 0.03
#   res.vcGlyphStyle              = 'CurlyVector'     # turn on curley vectors 
#  res@vcGlyphStyle              ='Fillarrow'
#   res.vcMonoFillArrowFillColor = True
#   res.vcMonoLineArrowColor     = True
#   res.vcLineArrowColor          = 'green'           # change vector color
#   res.vcFillArrowEdgeColor      ='white'
#   res.vcPositionMode            ='ArrowTail'
#   res.vcFillArrowHeadInteriorXF =0.1
#   res.vcFillArrowWidthF         =0.05           #default
#   res.vcFillArrowMinFracWidthF  =.5
#   res.vcFillArrowHeadMinFracXF  =.5
#   res.vcFillArrowHeadMinFracYF  =.5
#   res.vcFillArrowEdgeThicknessF = 2.0
   res.mpFillOn                   = False
   
   res.cnLevelSelectionMode = 'ExplicitLevels'

   res.cnLevels      = cntrs[iv][:]

   for im in range(0, ncases):
       ncdfs[im]  = './data/'+cases[im]+'_site_location.nc' 
       infiles[im] = filepath[im]+cases[im]+'/'+cases[im]+'_'+cseason+'_climo.nc'
       
       inptrs  = Dataset(infiles[im],'r')       # pointer to file1
       lat=inptrs.variables['lat'][:]
       nlat=len(lat)
       lon=inptrs.variables['lon'][:]
       nlon=len(lon)
       area=inptrs.variables['area'][:]

       area_wgt = np.zeros(nlat)

       sits=np.linspace(0,nsite-1,nsite)
       ncdf= Dataset(ncdfs[im],'r')
       n   =ncdf.variables['n'][:]
       idx_cols=ncdf.variables['idx_cols'][:]

       if (varis[iv] != 'PRECT' and varis[iv] != 'FLUT' and varis[iv] != 'U10'):
           A  = inptrs.variables[varis[iv]][0,:]
       elif (varis[iv] == 'PRECT'):
           A  = inptrs.variables['PRECC'][0,:]+inptrs.variables['PRECL'][0,:]
       elif (varis[iv] == 'U10'):
           A  = inptrs.variables['U10'][0,:]*inptrs.variables['U10'][0,:]
           A  = np.sqrt(A)

       elif (varis[iv] == 'FLUT'):
           A  = inptrs.variables['FLUT'][0,:]-inptrs.variables['FLNS'][0,:]


       A_xy = A
       A_xy = A_xy * cscale[iv]
       if (varis[iv] == 'SWCF'):
          with open(filepath[im]+cases[im]+'/run/atm_in') as inf:
              clubb_c_invrs_tau_n2 = 0
              for line in inf:
                  line = line.split('=')
                  line[0] = line[0].strip()
                  if line[0] == 'clubb_c_invrs_tau_n2':
                      clubb_c_invrs_tau_n2 = float(line[1])
                  elif line[0] == 'clubb_c_invrs_tau_n2_clear_wp3':
                      clubb_c_invrs_tau_n2_clear_wp3 = float(line[1])
                  elif line[0] == 'clubb_c_invrs_tau_n2_wpxp':
                      clubb_c_invrs_tau_n2_wpxp = float(line[1])
                  elif line[0] == 'clubb_c_invrs_tau_n2_xp2':
                      clubb_c_invrs_tau_n2_xp2 = float(line[1])
                  elif line[0] == 'clubb_c_invrs_tau_n2_wp2':
                      clubb_c_invrs_tau_n2_wp2 = float(line[1])
                  elif line[0] == 'clubb_c_k10h':
                      clubb_c_k10h = float(line[1])
                  elif line[0] == 'clubb_c_k10':
                      clubb_c_k10 = float(line[1])
                  elif line[0] == 'clubb_gamma_coef':
                      clubb_gamma_coef = float(line[1])
                  elif line[0] == 'clubb_c7':
                      clubb_c7 = float(line[1])
                  elif line[0] == 'clubb_c8':
                      clubb_c8 = float(line[1])
                  elif line[0] == 'clubb_c11':
                      clubb_c11 = float(line[1])
                  elif line[0] == 'clubb_c_invrs_tau_wpxp_ri':
                      clubb_c_invrs_tau_wpxp_ri = float(line[1])
                  elif line[0] == 'clubb_c_invrs_tau_wpxp_n2_thresh':
                      clubb_c_invrs_tau_wpxp_n2_thresh = float(line[1])
                  elif line[0] == 'clubb_altitude_threshold':
                      clubb_altitude_threshold = float(line[1])
                  elif line[0] == 'clubb_c_invrs_tau_bkgnd': 
                      clubb_c_invrs_tau_bkgnd = float(line[1])
                  elif line[0] == 'clubb_c_invrs_tau_sfc': 
                      clubb_c_invrs_tau_sfc = float(line[1])
                  elif line[0] == 'clubb_c_invrs_tau_n2_wp2':
                      clubb_c_invrs_tau_n2_wp2 = float(line[1])
                  elif line[0] == 'clubb_C_invrs_tau_wpxp_Ri':
                      clubb_C_invrs_tau_wpxp_Ri = float(line[1])

          SWCF = inptrs.variables['SWCF'][0,:]
          LWCF = inptrs.variables['LWCF'][0,:]
          TMQ = inptrs.variables['TMQ'][0,:]
          CLDTOT = inptrs.variables['CLDTOT'][0,:]
          PRECT = inptrs.variables['PRECC'][0,:]+inptrs.variables['PRECL'][0,:]

          numb_DYCOMS=0
          SWCF_DYCOMS=0
          LWCF_DYCOMS=0
          CLDTOT_DYCOMS=0
          TMQ_DYCOMS=0
          PRECT_DYCOMS=0

          numb_WP=0
          SWCF_WP=0
          LWCF_WP=0
          CLDTOT_WP=0
          TMQ_WP=0
          PRECT_WP=0

          numb_HAWAII=0
          SWCF_HAWAII=0
          LWCF_HAWAII=0
          CLDTOT_HAWAII=0
          TMQ_HAWAII=0
          PRECT_HAWAII=0

          numb_LBA=0
          SWCF_LBA=0
          LWCF_LBA=0
          CLDTOT_LBA=0
          TMQ_LBA=0
          PRECT_LBA=0

          numb_VOCAL=0
          SWCF_VOCAL=0
          LWCF_VOCAL=0
          CLDTOT_VOCAL=0
          TMQ_VOCAL=0
          PRECT_VOCAL=0


          numb_VOCAL_near=0
          SWCF_VOCAL_near=0
          LWCF_VOCAL_near=0
          CLDTOT_VOCAL_near=0
          TMQ_VOCAL_near=0
          PRECT_VOCAL_near=0


          numb_Nambian_near=0
          SWCF_Nambian_near=0
          LWCF_Nambian_near=0
          CLDTOT_Nambian_near=0
          TMQ_Nambian_near=0
          PRECT_Nambian_near=0

          numb_Nambian=0
          SWCF_Nambian=0
          LWCF_Nambian=0
          CLDTOT_Nambian=0
          TMQ_Nambian=0
          PRECT_Nambian=0

          numb_EP=0
          SWCF_EP=0
          LWCF_EP=0
          CLDTOT_EP=0
          TMQ_EP=0
          PRECT_EP=0

          numb_NP=0
          SWCF_NP=0
          LWCF_NP=0
          CLDTOT_NP=0
          TMQ_NP=0
          PRECT_NP=0


          numb_SP=0
          SWCF_SP=0
          LWCF_SP=0
          CLDTOT_SP=0
          TMQ_SP=0
          PRECT_SP=0

          numb_PA=0
          SWCF_PA=0
          LWCF_PA=0
          CLDTOT_PA=0
          TMQ_PA=0
          PRECT_PA=0

          numb_CAF=0
          SWCF_CAF=0
          LWCF_CAF=0
          CLDTOT_CAF=0
          TMQ_CAF=0
          PRECT_CAF=0
#'time|1 lat|-30:30 lon|-120:120'
          for ilat in range(0,nlat):
              if (lon[ilat] >= 226) & (lon[ilat] < 241) & (lat[ilat]>=20) & (lat[ilat] < 35):
                 numb_DYCOMS=numb_DYCOMS+1
                 SWCF_DYCOMS=SWCF_DYCOMS+SWCF[ilat]
                 LWCF_DYCOMS=LWCF_DYCOMS+LWCF[ilat]
                 CLDTOT_DYCOMS=CLDTOT_DYCOMS+CLDTOT[ilat]
                 PRECT_DYCOMS=PRECT_DYCOMS+PRECT[ilat]
                 TMQ_DYCOMS=TMQ_DYCOMS+TMQ[ilat]
              if (lon[ilat] >= 195) & (lon[ilat] < 215) & (lat[ilat]>=10) & (lat[ilat] < 30):
                 numb_HAWAII=numb_HAWAII+1
                 SWCF_HAWAII=SWCF_HAWAII+SWCF[ilat]
                 LWCF_HAWAII=LWCF_HAWAII+LWCF[ilat]
                 CLDTOT_HAWAII=CLDTOT_HAWAII+CLDTOT[ilat]
                 PRECT_HAWAII=PRECT_HAWAII+PRECT[ilat]
                 TMQ_HAWAII=TMQ_HAWAII+TMQ[ilat]
              if (lon[ilat] >= 265) & (lon[ilat] < 285) & (lat[ilat]>=-30) & (lat[ilat] < -10):
                 numb_VOCAL=numb_VOCAL+1
                 SWCF_VOCAL=SWCF_VOCAL+SWCF[ilat]
                 LWCF_VOCAL=LWCF_VOCAL+LWCF[ilat]
                 CLDTOT_VOCAL=CLDTOT_VOCAL+CLDTOT[ilat]
                 PRECT_VOCAL=PRECT_VOCAL+PRECT[ilat]
                 TMQ_VOCAL=TMQ_VOCAL+TMQ[ilat]

              if (lon[ilat] >= 282) & (lon[ilat] < 288) & (lat[ilat]>=-35) & (lat[ilat] < -25):
                 numb_VOCAL_near=numb_VOCAL_near+1
                 SWCF_VOCAL_near=SWCF_VOCAL_near+SWCF[ilat]
                 LWCF_VOCAL_near=LWCF_VOCAL_near+LWCF[ilat]
                 CLDTOT_VOCAL_near=CLDTOT_VOCAL_near+CLDTOT[ilat]
                 PRECT_VOCAL_near=PRECT_VOCAL_near+PRECT[ilat]
                 TMQ_VOCAL_near=TMQ_VOCAL_near+TMQ[ilat]

              if (lon[ilat] >= 10) & (lon[ilat] < 15) & (lat[ilat]>=-30) & (lat[ilat] < -20):
                 numb_Nambian_near=numb_Nambian_near+1
                 SWCF_Nambian_near=SWCF_Nambian_near+SWCF[ilat]
                 LWCF_Nambian_near=LWCF_Nambian_near+LWCF[ilat]
                 CLDTOT_Nambian_near=CLDTOT_Nambian_near+CLDTOT[ilat]
                 PRECT_Nambian_near=PRECT_Nambian_near+PRECT[ilat]
                 TMQ_Nambian_near=TMQ_Nambian_near+TMQ[ilat]

              if (lon[ilat] >= -5) & (lon[ilat] < 5) & (lat[ilat]>=-20) & (lat[ilat] < -10):
                 numb_Nambian=numb_Nambian+1
                 SWCF_Nambian=SWCF_Nambian+SWCF[ilat]
                 LWCF_Nambian=LWCF_Nambian+LWCF[ilat]
                 CLDTOT_Nambian=CLDTOT_Nambian+CLDTOT[ilat]
                 PRECT_Nambian=PRECT_Nambian+PRECT[ilat]
                 TMQ_Nambian=TMQ_Nambian+TMQ[ilat]

              if (lon[ilat] >= 290) & (lon[ilat] < 320) & (lat[ilat]>=-15) & (lat[ilat] < 5):
                 numb_LBA=numb_LBA+1
                 SWCF_LBA=SWCF_LBA+SWCF[ilat]
                 LWCF_LBA=LWCF_LBA+LWCF[ilat]
                 CLDTOT_LBA=CLDTOT_LBA+CLDTOT[ilat]
                 PRECT_LBA=PRECT_LBA+PRECT[ilat]
                 TMQ_LBA=TMQ_LBA+TMQ[ilat]
              if (lon[ilat] >= 110) & (lon[ilat] < 180) & (lat[ilat]>=-10) & (lat[ilat] < 10):
                 numb_WP=numb_WP+1
                 SWCF_WP=SWCF_WP+SWCF[ilat]
                 LWCF_WP=LWCF_WP+LWCF[ilat]
                 CLDTOT_WP=CLDTOT_WP+CLDTOT[ilat]
                 PRECT_WP=PRECT_WP+PRECT[ilat]
                 TMQ_WP=TMQ_WP+TMQ[ilat]
              if (lon[ilat] >= 180) & (lon[ilat] < 270) & (lat[ilat]>=0) & (lat[ilat] < 15):
                 numb_EP=numb_EP+1
                 SWCF_EP=SWCF_EP+SWCF[ilat]
                 LWCF_EP=LWCF_EP+LWCF[ilat]
                 CLDTOT_EP=CLDTOT_EP+CLDTOT[ilat]
                 PRECT_EP=PRECT_EP+PRECT[ilat]
                 TMQ_EP=TMQ_EP+TMQ[ilat]
              if (lon[ilat] >= 0) & (lon[ilat] < 360) & (lat[ilat]>=-60) & (lat[ilat] < -45):
                 numb_SP=numb_SP+1
                 SWCF_SP=SWCF_SP+SWCF[ilat]
                 LWCF_SP=LWCF_SP+LWCF[ilat]
                 CLDTOT_SP=CLDTOT_SP+CLDTOT[ilat]
                 PRECT_SP=PRECT_SP+PRECT[ilat]
                 TMQ_SP=TMQ_SP+TMQ[ilat]
              if (lon[ilat] >= 0) & (lon[ilat] < 360) & (lat[ilat]>=45) & (lat[ilat] < 60):
                 numb_NP=numb_NP+1
                 SWCF_NP=SWCF_NP+SWCF[ilat]
                 LWCF_NP=LWCF_NP+LWCF[ilat]
                 CLDTOT_NP=CLDTOT_NP+CLDTOT[ilat]
                 PRECT_NP=PRECT_NP+PRECT[ilat]
                 TMQ_NP=TMQ_NP+TMQ[ilat]
              if (lon[ilat] >= 270) & (lon[ilat] < 290) & (lat[ilat]>=0) & (lat[ilat] < 10):
                 numb_PA=numb_PA+1
                 SWCF_PA=SWCF_PA+SWCF[ilat]
                 LWCF_PA=LWCF_PA+LWCF[ilat]
                 CLDTOT_PA=CLDTOT_PA+CLDTOT[ilat]
                 PRECT_PA=PRECT_PA+PRECT[ilat]
                 TMQ_PA=TMQ_PA+TMQ[ilat]
              if (lon[ilat] >= 10) & (lon[ilat] < 40) & (lat[ilat]>=-10) & (lat[ilat] < 10):
                 numb_CAF=numb_CAF+1
                 SWCF_CAF=SWCF_CAF+SWCF[ilat]
                 LWCF_CAF=LWCF_CAF+LWCF[ilat]
                 CLDTOT_CAF=CLDTOT_CAF+CLDTOT[ilat]
                 PRECT_CAF=PRECT_CAF+PRECT[ilat]
                 TMQ_CAF=TMQ_CAF+TMQ[ilat]

          if (os.path.exists('./data/'+cases[im]+'_Regional.nc')):
             os.system('/bin/rm -f '+'./data/'+cases[im]+'_Regional.nc')

          outf =Dataset('./data/'+cases[im]+'_Regional.nc','w')
          outf.createDimension("col",1)
          outf.createVariable('clubb_c8','f4',('col'))
          outf.variables['clubb_c8'][:]=0
          outf.variables['clubb_c8'][0]=clubb_c8
          outf.createVariable('clubb_c7','f4',('col'))
          outf.variables['clubb_c7'][:]=0
          outf.variables['clubb_c7'][0]=clubb_c7
          outf.createVariable('clubb_c11','f4',('col'))
          outf.variables['clubb_c11'][:]=0
          outf.variables['clubb_c11'][0]=clubb_c11
          outf.createVariable('clubb_gamma_coef','f4',('col'))
          outf.variables['clubb_gamma_coef'][:]=0
          outf.variables['clubb_gamma_coef'][0]=clubb_gamma_coef
          outf.createVariable('clubb_c_k10','f4',('col'))
          outf.variables['clubb_c_k10'][:]=0
          outf.variables['clubb_c_k10'][0]=clubb_c_k10
          outf.createVariable('clubb_c_k10h','f4',('col'))
          outf.variables['clubb_c_k10h'][:]=0
          outf.variables['clubb_c_k10h'][0]=clubb_c_k10h
          outf.createVariable('clubb_c_invrs_tau_n2','f4',('col'))
          outf.variables['clubb_c_invrs_tau_n2'][:]=0
          outf.variables['clubb_c_invrs_tau_n2'][0]=clubb_c_invrs_tau_n2
          outf.createVariable('clubb_c_invrs_tau_n2_clear_wp3','f4',('col'))
          outf.variables['clubb_c_invrs_tau_n2_clear_wp3'][:]=0
          outf.variables['clubb_c_invrs_tau_n2_clear_wp3'][0]=clubb_c_invrs_tau_n2_clear_wp3
          outf.createVariable('clubb_c_invrs_tau_n2_wpxp','f4',('col'))
          outf.variables['clubb_c_invrs_tau_n2_wpxp'][:]=0
          outf.variables['clubb_c_invrs_tau_n2_wpxp'][0]=clubb_c_invrs_tau_n2_wpxp
          outf.createVariable('clubb_c_invrs_tau_n2_xp2','f4',('col'))
          outf.variables['clubb_c_invrs_tau_n2_xp2'][:]=0
          outf.variables['clubb_c_invrs_tau_n2_xp2'][0]=clubb_c_invrs_tau_n2_xp2
          outf.createVariable('clubb_c_invrs_tau_n2_wp2','f4',('col'))
          outf.variables['clubb_c_invrs_tau_n2_wp2'][:]=0
          outf.variables['clubb_c_invrs_tau_n2_wp2'][0]=clubb_c_invrs_tau_n2_wp2
          outf.createVariable('clubb_c_invrs_tau_wpxp_n2_thresh','f4',('col'))
          outf.variables['clubb_c_invrs_tau_wpxp_n2_thresh'][:]=0
          outf.variables['clubb_c_invrs_tau_wpxp_n2_thresh'][0]=clubb_c_invrs_tau_wpxp_n2_thresh
          outf.createVariable('clubb_c_invrs_tau_wpxp_ri','f4',('col'))
          outf.variables['clubb_c_invrs_tau_wpxp_ri'][:]=0
          outf.variables['clubb_c_invrs_tau_wpxp_ri'][0]=clubb_c_invrs_tau_wpxp_ri
          outf.createVariable('clubb_altitude_threshold','f4',('col'))
          outf.variables['clubb_altitude_threshold'][:]=0
          outf.variables['clubb_altitude_threshold'][0]=clubb_altitude_threshold

          outf.createVariable('clubb_c_invrs_tau_bkgnd','f4',('col'))
          outf.variables['clubb_c_invrs_tau_bkgnd'][:]=0
          outf.variables['clubb_c_invrs_tau_bkgnd'][0]=clubb_c_invrs_tau_bkgnd

          outf.createVariable('clubb_c_invrs_tau_sfc','f4',('col'))
          outf.variables['clubb_c_invrs_tau_sfc'][:]=0
          outf.variables['clubb_c_invrs_tau_sfc'][0]=clubb_c_invrs_tau_sfc

#          outf.createVariable('micro_mg_dcs','f4',('col'))
#          outf.variables['micro_mg_dcs'][:]=0
#          outf.variables['micro_mg_dcs'][0]=micro_mg_dcs
#          outf.createVariable('micro_mg_berg_eff_factor','f4',('col'))
#          outf.variables['micro_mg_berg_eff_factor'][:]=0
#          outf.variables['micro_mg_berg_eff_factor'][0]=micro_mg_berg_eff_factor

#          outf.createVariable('prc_exp','f4',('col'))
#          outf.variables['prc_exp'][:]=0
#          outf.variables['prc_exp'][0]=prc_exp
#          outf.createVariable('prc_exp1','f4',('col'))
#          outf.variables['prc_exp1'][:]=0
#          outf.variables['prc_exp1'][0]=prc_exp1
          #outf.createVariable('micro_vqit','f4',('col'))
          #outf.variables['micro_vqit'][:]=0
          #outf.variables['micro_vqit'][0]=micro_vqit

          outf.createVariable('SWCF_GLB','f4',('col'))
          outf.variables['SWCF_GLB'][:]=0
          outf.variables['SWCF_GLB'][0]=np.sum(SWCF[:]*area[:]/np.sum(area))
          outf.createVariable('LWCF_GLB','f4',('col'))
          outf.variables['LWCF_GLB'][:]=0
          outf.variables['LWCF_GLB'][0]=np.sum(LWCF[:]*area[:]/np.sum(area))
          outf.createVariable('CLDTOT_GLB','f4',('col'))
          outf.variables['CLDTOT_GLB'][:]=0
          outf.variables['CLDTOT_GLB'][0]=np.sum(CLDTOT[:]*area[:]/np.sum(area))
          outf.createVariable('PRECT_GLB','f4',('col'))
          outf.variables['PRECT_GLB'][:]=0
          outf.variables['PRECT_GLB'][0]=np.sum(PRECT[:]*area[:]/np.sum(area))
          outf.createVariable('TMQ_GLB','f4',('col'))
          outf.variables['TMQ_GLB'][:]=0
          outf.variables['TMQ_GLB'][0]=np.sum(TMQ[:]*area[:]/np.sum(area))

          outf.createVariable('SWCF_DYCOMS','f4',('col'))
          outf.variables['SWCF_DYCOMS'][:]=0
          outf.variables['SWCF_DYCOMS'][0]=SWCF_DYCOMS/numb_DYCOMS
          outf.createVariable('LWCF_DYCOMS','f4',('col'))
          outf.variables['LWCF_DYCOMS'][:]=0
          outf.variables['LWCF_DYCOMS'][0]=LWCF_DYCOMS/numb_DYCOMS
          outf.createVariable('CLDTOT_DYCOMS','f4',('col'))
          outf.variables['CLDTOT_DYCOMS'][:]=0
          outf.variables['CLDTOT_DYCOMS'][0]=CLDTOT_DYCOMS/numb_DYCOMS
          outf.createVariable('PRECT_DYCOMS','f4',('col'))
          outf.variables['PRECT_DYCOMS'][:]=0
          outf.variables['PRECT_DYCOMS'][0]=PRECT_DYCOMS/numb_DYCOMS
          outf.createVariable('TMQ_DYCOMS','f4',('col'))
          outf.variables['TMQ_DYCOMS'][:]=0
          outf.variables['TMQ_DYCOMS'][0]=TMQ_DYCOMS/numb_DYCOMS

          outf.createVariable('SWCF_HAWAII','f4',('col'))
          outf.variables['SWCF_HAWAII'][:]=0
          outf.variables['SWCF_HAWAII'][0]=SWCF_HAWAII/numb_HAWAII
          outf.createVariable('LWCF_HAWAII','f4',('col'))
          outf.variables['LWCF_HAWAII'][:]=0
          outf.variables['LWCF_HAWAII'][0]=LWCF_HAWAII/numb_HAWAII
          outf.createVariable('CLDTOT_HAWAII','f4',('col'))
          outf.variables['CLDTOT_HAWAII'][:]=0
          outf.variables['CLDTOT_HAWAII'][0]=CLDTOT_HAWAII/numb_HAWAII
          outf.createVariable('PRECT_HAWAII','f4',('col'))
          outf.variables['PRECT_HAWAII'][:]=0
          outf.variables['PRECT_HAWAII'][0]=PRECT_HAWAII/numb_HAWAII
          outf.createVariable('TMQ_HAWAII','f4',('col'))
          outf.variables['TMQ_HAWAII'][:]=0
          outf.variables['TMQ_HAWAII'][0]=TMQ_HAWAII/numb_HAWAII

          outf.createVariable('SWCF_VOCAL','f4',('col'))
          outf.variables['SWCF_VOCAL'][:]=0
          outf.variables['SWCF_VOCAL'][0]=SWCF_VOCAL/numb_VOCAL
          outf.createVariable('LWCF_VOCAL','f4',('col'))
          outf.variables['LWCF_VOCAL'][:]=0
          outf.variables['LWCF_VOCAL'][0]=LWCF_VOCAL/numb_VOCAL
          outf.createVariable('CLDTOT_VOCAL','f4',('col'))
          outf.variables['CLDTOT_VOCAL'][:]=0
          outf.variables['CLDTOT_VOCAL'][0]=CLDTOT_VOCAL/numb_VOCAL
          outf.createVariable('PRECT_VOCAL','f4',('col'))
          outf.variables['PRECT_VOCAL'][:]=0
          outf.variables['PRECT_VOCAL'][0]=PRECT_VOCAL/numb_VOCAL
          outf.createVariable('TMQ_VOCAL','f4',('col'))
          outf.variables['TMQ_VOCAL'][:]=0
          outf.variables['TMQ_VOCAL'][0]=TMQ_VOCAL/numb_VOCAL

          outf.createVariable('SWCF_VOCAL_near','f4',('col'))
          outf.variables['SWCF_VOCAL_near'][:]=0
          outf.variables['SWCF_VOCAL_near'][0]=SWCF_VOCAL_near/numb_VOCAL_near
          outf.createVariable('LWCF_VOCAL_near','f4',('col'))
          outf.variables['LWCF_VOCAL_near'][:]=0
          outf.variables['LWCF_VOCAL_near'][0]=LWCF_VOCAL_near/numb_VOCAL_near
          outf.createVariable('CLDTOT_VOCAL_near','f4',('col'))
          outf.variables['CLDTOT_VOCAL_near'][:]=0
          outf.variables['CLDTOT_VOCAL_near'][0]=CLDTOT_VOCAL_near/numb_VOCAL_near
          outf.createVariable('PRECT_VOCAL_near','f4',('col'))
          outf.variables['PRECT_VOCAL_near'][:]=0
          outf.variables['PRECT_VOCAL_near'][0]=PRECT_VOCAL_near/numb_VOCAL_near
          outf.createVariable('TMQ_VOCAL_near','f4',('col'))
          outf.variables['TMQ_VOCAL_near'][:]=0
          outf.variables['TMQ_VOCAL_near'][0]=TMQ_VOCAL_near/numb_VOCAL_near


          outf.createVariable('SWCF_Nambian_near','f4',('col'))
          outf.variables['SWCF_Nambian_near'][:]=0
          outf.variables['SWCF_Nambian_near'][0]=SWCF_Nambian_near/numb_Nambian_near
          outf.createVariable('LWCF_Nambian_near','f4',('col'))
          outf.variables['LWCF_Nambian_near'][:]=0
          outf.variables['LWCF_Nambian_near'][0]=LWCF_Nambian_near/numb_Nambian_near
          outf.createVariable('CLDTOT_Nambian_near','f4',('col'))
          outf.variables['CLDTOT_Nambian_near'][:]=0
          outf.variables['CLDTOT_Nambian_near'][0]=CLDTOT_Nambian_near/numb_Nambian_near
          outf.createVariable('PRECT_Nambian_near','f4',('col'))
          outf.variables['PRECT_Nambian_near'][:]=0
          outf.variables['PRECT_Nambian_near'][0]=PRECT_Nambian_near/numb_Nambian_near
          outf.createVariable('TMQ_Nambian_near','f4',('col'))
          outf.variables['TMQ_Nambian_near'][:]=0
          outf.variables['TMQ_Nambian_near'][0]=TMQ_Nambian_near/numb_Nambian_near


          outf.createVariable('SWCF_Nambian','f4',('col'))
          outf.variables['SWCF_Nambian'][:]=0
          outf.variables['SWCF_Nambian'][0]=SWCF_Nambian/numb_Nambian
          outf.createVariable('LWCF_Nambian','f4',('col'))
          outf.variables['LWCF_Nambian'][:]=0
          outf.variables['LWCF_Nambian'][0]=LWCF_Nambian/numb_Nambian
          outf.createVariable('CLDTOT_Nambian','f4',('col'))
          outf.variables['CLDTOT_Nambian'][:]=0
          outf.variables['CLDTOT_Nambian'][0]=CLDTOT_Nambian/numb_Nambian
          outf.createVariable('PRECT_Nambian','f4',('col'))
          outf.variables['PRECT_Nambian'][:]=0
          outf.variables['PRECT_Nambian'][0]=PRECT_Nambian/numb_Nambian
          outf.createVariable('TMQ_Nambian','f4',('col'))
          outf.variables['TMQ_Nambian'][:]=0
          outf.variables['TMQ_Nambian'][0]=TMQ_Nambian/numb_Nambian

          outf.createVariable('SWCF_LBA','f4',('col'))
          outf.variables['SWCF_LBA'][:]=0
          outf.variables['SWCF_LBA'][0]=SWCF_LBA/numb_LBA
          outf.createVariable('LWCF_LBA','f4',('col'))
          outf.variables['LWCF_LBA'][:]=0
          outf.variables['LWCF_LBA'][0]=LWCF_LBA/numb_LBA
          outf.createVariable('CLDTOT_LBA','f4',('col'))
          outf.variables['CLDTOT_LBA'][:]=0
          outf.variables['CLDTOT_LBA'][0]=CLDTOT_LBA/numb_LBA
          outf.createVariable('PRECT_LBA','f4',('col'))
          outf.variables['PRECT_LBA'][:]=0
          outf.variables['PRECT_LBA'][0]=PRECT_LBA/numb_LBA
          outf.createVariable('TMQ_LBA','f4',('col'))
          outf.variables['TMQ_LBA'][:]=0
          outf.variables['TMQ_LBA'][0]=TMQ_LBA/numb_LBA

          outf.createVariable('SWCF_WP','f4',('col'))
          outf.variables['SWCF_WP'][:]=0
          outf.variables['SWCF_WP'][0]=SWCF_WP/numb_WP
          outf.createVariable('LWCF_WP','f4',('col'))
          outf.variables['LWCF_WP'][:]=0
          outf.variables['LWCF_WP'][0]=LWCF_WP/numb_WP
          outf.createVariable('CLDTOT_WP','f4',('col'))
          outf.variables['CLDTOT_WP'][:]=0
          outf.variables['CLDTOT_WP'][0]=CLDTOT_WP/numb_WP
          outf.createVariable('PRECT_WP','f4',('col'))
          outf.variables['PRECT_WP'][:]=0
          outf.variables['PRECT_WP'][0]=PRECT_WP/numb_WP
          outf.createVariable('TMQ_WP','f4',('col'))
          outf.variables['TMQ_WP'][:]=0
          outf.variables['TMQ_WP'][0]=TMQ_WP/numb_WP

          outf.createVariable('SWCF_EP','f4',('col'))
          outf.variables['SWCF_EP'][:]=0
          outf.variables['SWCF_EP'][0]=SWCF_EP/numb_EP
          outf.createVariable('LWCF_EP','f4',('col'))
          outf.variables['LWCF_EP'][:]=0
          outf.variables['LWCF_EP'][0]=LWCF_EP/numb_EP
          outf.createVariable('CLDTOT_EP','f4',('col'))
          outf.variables['CLDTOT_EP'][:]=0
          outf.variables['CLDTOT_EP'][0]=CLDTOT_EP/numb_EP
          outf.createVariable('PRECT_EP','f4',('col'))
          outf.variables['PRECT_EP'][:]=0
          outf.variables['PRECT_EP'][0]=PRECT_EP/numb_EP
          outf.createVariable('TMQ_EP','f4',('col'))
          outf.variables['TMQ_EP'][:]=0
          outf.variables['TMQ_EP'][0]=TMQ_EP/numb_EP

          outf.createVariable('SWCF_NP','f4',('col'))
          outf.variables['SWCF_NP'][:]=0
          outf.variables['SWCF_NP'][0]=SWCF_NP/numb_NP
          outf.createVariable('LWCF_NP','f4',('col'))
          outf.variables['LWCF_NP'][:]=0
          outf.variables['LWCF_NP'][0]=LWCF_NP/numb_NP
          outf.createVariable('CLDTOT_NP','f4',('col'))
          outf.variables['CLDTOT_NP'][:]=0
          outf.variables['CLDTOT_NP'][0]=CLDTOT_NP/numb_NP
          outf.createVariable('PRECT_NP','f4',('col'))
          outf.variables['PRECT_NP'][:]=0
          outf.variables['PRECT_NP'][0]=PRECT_NP/numb_NP
          outf.createVariable('TMQ_NP','f4',('col'))
          outf.variables['TMQ_NP'][:]=0
          outf.variables['TMQ_NP'][0]=TMQ_NP/numb_NP

          outf.createVariable('SWCF_SP','f4',('col'))
          outf.variables['SWCF_SP'][:]=0
          outf.variables['SWCF_SP'][0]=SWCF_SP/numb_SP
          outf.createVariable('LWCF_SP','f4',('col'))
          outf.variables['LWCF_SP'][:]=0
          outf.variables['LWCF_SP'][0]=LWCF_SP/numb_SP
          outf.createVariable('CLDTOT_SP','f4',('col'))
          outf.variables['CLDTOT_SP'][:]=0
          outf.variables['CLDTOT_SP'][0]=CLDTOT_SP/numb_SP
          outf.createVariable('PRECT_SP','f4',('col'))
          outf.variables['PRECT_SP'][:]=0
          outf.variables['PRECT_SP'][0]=PRECT_SP/numb_SP
          outf.createVariable('TMQ_SP','f4',('col'))
          outf.variables['TMQ_SP'][:]=0
          outf.variables['TMQ_SP'][0]=TMQ_SP/numb_SP

          outf.createVariable('SWCF_PA','f4',('col'))
          outf.variables['SWCF_PA'][:]=0
          outf.variables['SWCF_PA'][0]=SWCF_PA/numb_PA
          outf.createVariable('LWCF_PA','f4',('col'))
          outf.variables['LWCF_PA'][:]=0
          outf.variables['LWCF_PA'][0]=LWCF_PA/numb_PA
          outf.createVariable('CLDTOT_PA','f4',('col'))
          outf.variables['CLDTOT_PA'][:]=0
          outf.variables['CLDTOT_PA'][0]=CLDTOT_PA/numb_PA
          outf.createVariable('PRECT_PA','f4',('col'))
          outf.variables['PRECT_PA'][:]=0
          outf.variables['PRECT_PA'][0]=PRECT_PA/numb_PA
          outf.createVariable('TMQ_PA','f4',('col'))
          outf.variables['TMQ_PA'][:]=0
          outf.variables['TMQ_PA'][0]=TMQ_PA/numb_PA


          outf.createVariable('SWCF_CAF','f4',('col'))
          outf.variables['SWCF_CAF'][:]=0
          outf.variables['SWCF_CAF'][0]=SWCF_CAF/numb_CAF
          outf.createVariable('LWCF_CAF','f4',('col'))
          outf.variables['LWCF_CAF'][:]=0
          outf.variables['LWCF_CAF'][0]=LWCF_CAF/numb_CAF
          outf.createVariable('CLDTOT_CAF','f4',('col'))
          outf.variables['CLDTOT_CAF'][:]=0
          outf.variables['CLDTOT_CAF'][0]=CLDTOT_CAF/numb_CAF
          outf.createVariable('PRECT_CAF','f4',('col'))
          outf.variables['PRECT_CAF'][:]=0
          outf.variables['PRECT_CAF'][0]=PRECT_CAF/numb_CAF
          outf.createVariable('TMQ_CAF','f4',('col'))
          outf.variables['TMQ_CAF'][:]=0
          outf.variables['TMQ_CAF'][0]=TMQ_CAF/numb_CAF

          outf.close()
       ncdf.close()
       inptrs.close()
       if im == 0 :
           dsizes = len(A_xy)
           field_xy = [[0 for col in range(dsizes)] for row in range(ncases)] 
       
       field_xy[im][:] = A_xy
  
       res.lbLabelBarOn = False 
       if(np.mod(im,2)==0): 
           res.tiYAxisOn  = True
       else:
           res.tiYAxisOn  = False
  
       res.tiXAxisOn  = False 
       res.sfXArray     = lon
       res.sfYArray     = lat
       res.mpLimitMode  = 'LatLon'
       res.mpMaxLonF    = max(lon) 
       res.mpMinLonF    = min(lon) 
       res.mpMinLatF    = min(lat) 
       res.mpMaxLatF    = max(lat) 
       res.tiMainString    =  'GLB='+str(np.sum(A_xy[:]*area[:]/np.sum(area)))

       textres.txFontHeightF = 0.015
       Ngl.text_ndc(wks,alpha[im]+'  '+ casenames[im],0.3,.135-im*0.03,textres)


       p = Ngl.contour_map(wks,A_xy,res)
       plot.append(p)

# observation 
#   res.nglLeftString = obsdataset[iv]
#  res@lbLabelBarOn = True 
#  res@lbOrientation        = 'vertical'         # vertical label bars
   res.lbLabelFont          = _Font
   res.tiYAxisOn  = True
   res.tiXAxisOn  = True
   res.tiXAxisFont = _Font
   rad    = 4.0*np.arctan(1.0)/180.0
   re     = 6371220.0
   rr     = re*rad

   dlon   = abs(lonobs[2]-lonobs[1])*rr
   dx     = dlon* np.cos(latobs*rad)
   jlat   = len(latobs )
   dy     = np.zeros(jlat,dtype=float)
                                                            # close enough
   dy[0]  = abs(lat[2]-lat[1])*rr
   dy[1:jlat-2]  = abs(lat[2:jlat-1]-lat[0:jlat-3])*rr*0.5
   dy[jlat-1]    = abs(lat[jlat-1]-lat[jlat-2])*rr
   area_wgt   = dx*dy  # 
   is_SE= False

   sum1 = 0 
   sum2 = 0 

   for j in range(0, jlat-1):
      for i in range(0, len(lonobs)-1):
        if (np.isnan(B[j][i]) != '--'):
           sum1= sum1+area_wgt[j]*B[j][i]
           sum2= sum2+area_wgt[j]
   
   glb=sum1/sum2
   res.sfXArray     = lonobs
   res.sfYArray     = latobs
   res.mpLimitMode  = 'LatLon'
   res.mpMaxLonF    = max(lonobs)
   res.mpMinLonF    = min(lonobs)
   res.mpMinLatF    = min(latobs)
   res.mpMaxLatF    = max(latobs)
   res.tiMainString   =  'GLB='+str(glb)

   p =Ngl.contour_map(wks,B,res)
   if (iv == 0) :
      poly_res               = Ngl.Resources()
      poly_res.gsMarkerIndex = 16
      poly_res.gsMarkerSizeF = 0.005
      poly_res.gsMarkerColor = 'green'
      dum = Ngl.add_polymarker(wks,p,lons,lats,poly_res)
      gnres                = Ngl.Resources()
      gnres.gsFillOpacityF = 0.6          # mostly opaque
      gnres.gsFillColor    = "white"


      xx1= 0
      xx2=15
      yy1=180
      yy2=270
      lat_box = [ xx1,xx1, xx2,  xx2,xx1]
      lon_box = [ yy1,yy2,yy2,yy1,yy1]
      gsid = Ngl.add_polygon(wks,p,lon_box,lat_box,gnres)


      xx1= -10
      xx2= 10
      yy1=110
      yy2=180
      lat_box = [ xx1,xx1, xx2,  xx2,xx1]
      lon_box = [ yy1,yy2,yy2,yy1,yy1]
      gsid = Ngl.add_polygon(wks,p,lon_box,lat_box,gnres)


      xx1= 20
      xx2= 35
      yy1=226
      yy2=241
      lat_box = [ xx1,xx1, xx2,  xx2,xx1]
      lon_box = [ yy1,yy2,yy2,yy1,yy1]
      gsid = Ngl.add_polygon(wks,p,lon_box,lat_box,gnres)



      xx1= 10
      xx2= 30
      yy1=195
      yy2=215
      lat_box = [ xx1,xx1, xx2,  xx2,xx1]
      lon_box = [ yy1,yy2,yy2,yy1,yy1]
      gsid = Ngl.add_polygon(wks,p,lon_box,lat_box,gnres)

      xx1= -30
      xx2= -10
      yy1= 265
      yy2= 285
      lat_box = [ xx1,xx1, xx2,  xx2,xx1]
      lon_box = [ yy1,yy2,yy2,yy1,yy1]
      gsid = Ngl.add_polygon(wks,p,lon_box,lat_box,gnres)

      xx1= -35
      xx2= -25
      yy1=282
      yy2=288
      lat_box = [ xx1,xx1, xx2,  xx2,xx1]
      lon_box = [ yy1,yy2,yy2,yy1,yy1]
      gsid = Ngl.add_polygon(wks,p,lon_box,lat_box,gnres)

      xx1= -30
      xx2= -20
      yy1=10
      yy2=15
      lat_box = [ xx1,xx1, xx2,  xx2,xx1]
      lon_box = [ yy1,yy2,yy2,yy1,yy1]
      gsid = Ngl.add_polygon(wks,p,lon_box,lat_box,gnres)

      xx1= -20
      xx2= -10
      yy1= -5
      yy2=  5
      lat_box = [ xx1,xx1, xx2,  xx2,xx1]
      lon_box = [ yy1,yy2,yy2,yy1,yy1]
      gsid = Ngl.add_polygon(wks,p,lon_box,lat_box,gnres)

      xx1= -15
      xx2= 5
      yy1=290
      yy2=320
      lat_box = [ xx1,xx1, xx2,  xx2,xx1]
      lon_box = [ yy1,yy2,yy2,yy1,yy1]
      gsid = Ngl.add_polygon(wks,p,lon_box,lat_box,gnres)

      xx1= -60
      xx2= -45
      yy1= 0
      yy2= 360
      lat_box = [ xx1,xx1, xx2,  xx2,xx1]
      lon_box = [ yy1,yy2,yy2,yy1,yy1]
      gsid = Ngl.add_polygon(wks,p,lon_box,lat_box,gnres)

      xx1= 45
      xx2= 60
      yy1= 0
      yy2= 360
      lat_box = [ xx1,xx1, xx2,  xx2,xx1]
      lon_box = [ yy1,yy2,yy2,yy1,yy1]
      gsid = Ngl.add_polygon(wks,p,lon_box,lat_box,gnres)

      xx1= 0
      xx2= 5
      yy1= 270
      yy2= 280
      lat_box = [ xx1,xx1, xx2,  xx2,xx1]
      lon_box = [ yy1,yy2,yy2,yy1,yy1]
      gsid = Ngl.add_polygon(wks,p,lon_box,lat_box,gnres)

      xx1= -10
      xx2=  10
      yy1= 10
      yy2= 40
      lat_box = [ xx1,xx1, xx2,  xx2,xx1]
      lon_box = [ yy1,yy2,yy2,yy1,yy1]
      gsid = Ngl.add_polygon(wks,p,lon_box,lat_box,gnres)

   plot.append(p)


   if(np.mod(ncases+1,2)==1):
      Ngl.panel(wks,plot[:],[(ncases+1)/2+1,2],pres) 
   else:
      Ngl.panel(wks,plot[:],[(ncases+1)/2,2],pres)
   Ngl.frame(wks)
   Ngl.destroy(wks)

#   Ngl.end()
 return plot2d


