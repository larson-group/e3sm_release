'''
    CLUBB budgets
    zhunguo : guozhun@lasg.iap.ac.cn ; guozhun@uwm.edu
'''
  

import Ngl
from netCDF4 import Dataset
import matplotlib.pyplot as plt
import numpy as np
import scipy as sp
import pylab
import os
from subprocess import call

 
def draw_clubb_bgt (ptype,cseason, ncases, cases, casenames, nsite, lats, lons, filepath, filepathobs):

# ncases, the number of models
# cases, the name of models
# casename, the name of cases
# filepath, model output filepath
# filepathobs, filepath for observational data
# inptrs = [ncases]
 if not os.path.exists("pic"):
        os.mkdir("pic")


 _Font   = 25
 interp = 2
 extrap = False
 mkres = Ngl.Resources()
 mkres.gsMarkerIndex = 2
 mkres.gsMarkerColor = "Red"
 mkres.gsMarkerSizeF = 15.   
 infiles  = ["" for x in range(ncases)]
 ncdfs    = ["" for x in range(ncases)]
 nregions = nsite

 varis = [ "wp2","wp3","wprtp","wpthlp","rtp2","thlp2","up2","vp2","rtpthlp"]
 varisobs = [ "CLOUD", "OMEGA","SHUM","CLWC_ISBL", "THATA","RELHUM"]
 nvaris = len(varis)
 cunits = ["%", "mba/day","g/kg","g/kg","K", "%", "mba/day", "K", "g/kg", "m/s", "m/s","K","m"]
 cscale = [1, 1, 1E3, 1, 1E6, 1, 1,1,1E3,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
 cscaleobs = [100., 100/86400., 1., 1000, 1., 1., 1, 1,1,1]
 obsdataset =["CCCM", "ERAI", "ERAI", "ERAI", "ERAI", "ERAI", "ERAI", "ERAI","ERAI","ERAI"]

 plotbgt=["" for x in range(nsite*ncases)] 

 for ire in range (0, nsite):
     for im in range (0,ncases):
         if not os.path.exists('pic/'+str(lons[ire])+'E_'+str(lats[ire])+'N'):
             os.mkdir('pic/'+str(lons[ire])+'E_'+str(lats[ire])+'N')

         plotname = './pic/'+str(lons[ire])+'E_'+str(lats[ire])+'N/Budgets_'+casenames[im]+"_"+str(lons[ire])+"E_"+str(lats[ire])+"N_"+cseason
         plotbgt[im+ncases*ire] = 'Budgets_'+casenames[im]+"_"+str(lons[ire])+"E_"+str(lats[ire])+"N_"+cseason

         wks= Ngl.open_wks(ptype,plotname)

         Ngl.define_colormap(wks,"radar_1")
         plot = []
         res     = Ngl.Resources()  
         res.nglDraw              = False
         res.nglFrame             = False
         res.lgLabelFontHeightF     = .012                   # change font height
         res.lgPerimOn              = False                 # no box around
         res.vpWidthF         = 0.30                      # set width and height
         res.vpHeightF        = 0.30
#         res.txFontHeightF   = .01
         #  res.vpXF             = 0.04
         # res.vpYF             = 0.30
         res.tmYLLabelFont  = 12
         res.tmXBLabelFont  = 12
         res.tmXBLabelFontHeightF = 0.005
         res.tmXBLabelFontThicknessF = 1.0
         res.tmXBLabelAngleF = 45
         res.xyMarkLineMode      = "MarkLines"
         res.xyLineThicknesses = [2.0, 2.0, 2.0, 2.0, 2.0, 2.0,2.,2.,2.,2.,2,2,2,2,2,2,2]
         res.xyLineColors      = np.arange(2,25,2)
         res.xyDashPatterns    = np.arange(0,24,1)
         res.xyMarkers         = np.arange(16,40,1)
         res.xyMarkerSizeF       = 0.005
         res.xyMarkerColors      = np.arange(2,25,2)
         res.pmLegendDisplayMode    = "ALWAYS"
         res.pmLegendSide           = "top"                 # Change location of
         res.pmLegendParallelPosF   = 0.75                  # move units right
         res.pmLegendOrthogonalPosF = -0.65                  # more neg = down
         res.pmLegendWidthF         = 0.10                 # Change width and
         res.pmLegendHeightF        = 0.15                  # height of legend.
         res.lgLabelFontHeightF     = .01                   # change font height
         res.lgLabelFontThicknessF  = 1.
         res.lgPerimOn              = True
         res.tiYAxisString   = "Height  (unit: KM)"
     
#         res.nglLeftString     = varis[iv]
#         res.nglRightString    = cunits[iv]
         res.trYReverse        = True

         pres            = Ngl.Resources() 
#         pres.nglMaximize = True
         pres.nglFrame = False
         pres.txFont = 12
         pres.nglPanelYWhiteSpacePercent = 5
         pres.nglPanelXWhiteSpacePercent = 5
         pres.nglPanelTop = 0.93

         txres               = Ngl.Resources()
#         txres.txFontHeightF = 0.01

         for iv in range (0, nvaris):

             if (varis[iv] == "rtp2" or varis[iv] == "thlp2"):
                 budget_ends = ["_bt", "_ma", "_ta", "_tp", "_dp1", "_dp2", "_cl", "_pd", "_sf", "_forcing"]
                 nterms = len (budget_ends)
             if (varis[iv] == "wprtp") :
                 budget_ends = ["_bt", "_ma", "_ta", "_tp", "_ac","_bp","_pr1","_pr2", "_pr3","_dp1","_mfl", "_cl", "_sicl","_pd", "_forcing"]
                 nterms = len (budget_ends)
             if (varis[iv] == "wpthlp") :
                 budget_ends = ["_bt", "_ma", "_ta", "_tp", "_ac","_bp","_pr1","_pr2", "_pr3","_dp1","_mfl", "_cl", "_sicl", "_forcing"]
                 nterms = len (budget_ends)

             if (varis[iv] == "rtpthlp") :
                 budget_ends = ["_bt", "_ma", "_ta", "_tp1","_tp2","_dp1","_dp2", "_cl", "_sf", "_forcing"]
                 nterms = len (budget_ends)
             if (varis[iv] == "wp2") :
                 budget_ends = ["_bt", "_ma", "_ta", "_ac","_bp","_pr1","_pr2", "_pr3","_dp1","_dp2", "_cl", "_pd", "_sf"]
                 nterms = len (budget_ends)

             if (varis[iv] == "wp3") :
                 budget_ends = ["_bt", "_ma", "_ta", "_tp", "_ac","_bp1","_pr1","_pr2","_dp1", "_cl"]
                 nterms = len (budget_ends)

             if (varis[iv] == "up2" or varis[iv] == "vp2") :
                 budget_ends = ["_bt", "_ma", "_ta", "_tp", "_dp1", "_dp2","_pr1","_pr2" ,"_cl", "_pd", "_sf"]
                 nterms = len (budget_ends)

             ncdfs[im]  = './data/'+cases[im]+'_site_location.nc'
             infiles[im]= filepath[im]+cases[im]+'/'+cases[im]+'_'+cseason+'_climo.nc'
             inptrs = Dataset(infiles[im],'r')       # pointer to file1
             lat=inptrs.variables['lat'][:]
             nlat=len(lat)
             lon=inptrs.variables['lon'][:]
             nlon=len(lon)
             ilev=inptrs.variables['ilev'][:]
             nilev=len(ilev)
             ncdf= Dataset(ncdfs[im],'r')
             n   =ncdf.variables['n'][:]
             idx_cols=ncdf.variables['idx_cols'][:,:]
             ncdf.close()
             A_field = np.zeros((nterms,nilev),np.float32)
             theunits=str(cscale[iv])+"x"+inptrs.variables[varis[iv]+'_bt'].units
             res.tiMainString    =  varis[iv]+"  "+theunits 


             for it in range(0, nterms):
                 for subc in range( 0, n[ire]):
                     varis_bgt= varis[iv]+budget_ends[it]
                     npoint=idx_cols[ire,n[subc]-1]-1
                     tmp=inptrs.variables[varis_bgt][0,:,npoint] #/n[ire]
                     tmp=tmp*cscale[iv]
                     A_field[it,:] = (A_field[it,:]+tmp[:]/n[ire]).astype(np.float32 )

             inptrs.close()
             res.xyExplicitLegendLabels =  budget_ends[:]
             p = Ngl.xy(wks,A_field,ilev,res)
             plot.append(p)

             xp=np.mod(iv,3)
             yp=int(iv/3)

         pres.txFontHeightF = 0.02
         pres.txString   = casenames[im]+"  BUDGET at" +str(lons[ire])+"E,"+str(lats[ire])+"N"

         Ngl.panel(wks,plot[:],[nvaris/3,3],pres)
         txres = Ngl.Resources()
         txres.txFontHeightF = 0.020
         Ngl.text_ndc(wks,casenames[im]+"  BUDGET at" +str(lons[ire])+"E,"+str(lats[ire])+"N",0.5,0.95,txres)

         Ngl.frame(wks)
         Ngl.destroy(wks) 

 return (plotbgt)

