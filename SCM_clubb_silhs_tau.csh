#!/bin/csh

#######################################################################
#######################################################################
#######  Script to run E3SM in SCM for
#######  REPLAY 
#######  REPLAY an E3SM column
#######  
#######  Script Author: P. Bogenschutz (bogenschutz1@llnl.gov)
#######                 Zhun Guo       (guozhun@lasg.iap.ac.cn, guozhun@uwm.edu) 

set clubb_vars_zt_list = "'thlm', 'thvm', 'rtm', 'rcm', 'rvm', 'um', 'vm', 'um_ref','vm_ref','ug', 'vg', 'cloud_frac', 'cloud_cover', 'rcm_in_layer', 'rcm_in_cloud', 'p_in_Pa', 'exner', 'rho_ds_zt', 'thv_ds_zt', 'Lscale', 'Lscale_pert_1', 'Lscale_pert_2', 'T_in_K', 'rel_humidity', 'wp3', 'wpthlp2', 'wp2thlp', 'wprtp2','wp2rtp', 'Lscale_up', 'Lscale_down', 'Kh_zt', 'wp2thvp', 'wp2rcp', 'wprtpthlp', 'sigma_sqd_w_zt', 'rho', 'radht', 'radht_LW', 'radht_SW', 'Ncm', 'Nc_in_cloud', 'Nc_activated', 'snowslope', 'sed_rcm', 'rsat', 'rsati', 'diam', 'mass_ice_cryst', 'rcm_icedfs', 'u_T_cm', 'rtm_bt', 'rtm_ma', 'rtm_ta', 'rtm_mfl', 'rtm_tacl', 'rtm_cl', 'rtm_forcing', 'rtm_sdmp','rtm_mc', 'rtm_pd', 'rvm_mc', 'rcm_mc', 'rcm_sd_mg_morr', 'thlm_bt', 'thlm_ma', 'thlm_ta', 'thlm_mfl', 'thlm_tacl', 'thlm_cl', 'thlm_forcing', 'thlm_sdmp','thlm_mc', 'thlm_old', 'thlm_without_ta', 'thlm_mfl_min', 'thlm_mfl_max', 'thlm_enter_mfl', 'thlm_exit_mfl', 'rtm_old', 'rtm_without_ta', 'rtm_mfl_min', 'rtm_mfl_max', 'rtm_enter_mfl', 'rtm_exit_mfl', 'um_bt', 'um_ma', 'um_gf', 'um_cf', 'um_ta', 'um_f', 'um_sdmp', 'um_ndg', 'vm_bt', 'vm_ma', 'vm_gf', 'vm_cf', 'vm_ta', 'vm_f', 'vm_sdmp', 'vm_ndg', 'wp3_bt', 'wp3_ma', 'wp3_ta', 'wp3_tp', 'wp3_ac', 'wp3_bp1', 'wp3_bp2', 'wp3_pr1', 'wp3_pr2', 'wp3_dp1', 'wp3_cl', 'mixt_frac', 'w_1', 'w_2', 'varnce_w_1', 'varnce_w_2', 'thl_1', 'thl_2', 'varnce_thl_1', 'varnce_thl_2', 'rt_1', 'rt_2', 'varnce_rt_1', 'varnce_rt_2', 'rc_1', 'rc_2', 'rsatl_1', 'rsatl_2', 'cloud_frac_1', 'cloud_frac_2', 'a3_coef_zt', 'wp3_on_wp2_zt', 'chi_1', 'chi_2', 'stdev_chi_1', 'stdev_chi_2', 'stdev_eta_1', 'stdev_eta_2', 'covar_chi_eta_1', 'covar_chi_eta_2', 'corr_chi_eta_1', 'corr_chi_eta_2', 'corr_rt_thl_1', 'crt_1', 'crt_2', 'cthl_1', 'cthl_2', 'precip_frac', 'precip_frac_1', 'precip_frac_2', 'Ncnm', 'wp2_zt', 'thlp2_zt', 'wpthlp_zt', 'wprtp_zt', 'rtp2_zt', 'rtpthlp_zt', 'up2_zt', 'vp2_zt', 'upwp_zt', 'vpwp_zt', 'C11_Skw_fnc'"
set clubb_vars_zm_list = "'wp2', 'rtp2', 'thlp2', 'rtpthlp', 'wprtp', 'wpthlp', 'wp4', 'up2', 'vp2', 'wpthvp', 'rtpthvp', 'thlpthvp', 'bv_freq_sqd', 'tau_zm','invrs_tau_shear','invrs_tau_sfc','invrs_tau_bkgnd','tau_no_N2_zm','tau_wp2_zm','tau_wp3_zm','tau_xp2_zm','tau_wpxp_zm','Kh_zm', 'wprcp', 'wm_zm', 'thlprcp', 'rtprcp', 'rcp2', 'upwp', 'vpwp', 'rho_zm', 'sigma_sqd_w', 'Skw_velocity', 'gamma_Skw_fnc', 'C6rt_Skw_fnc', 'C6thl_Skw_fnc', 'C7_Skw_fnc', 'C1_Skw_fnc', 'a3_coef', 'wp3_on_wp2', 'rcm_zm', 'rtm_zm', 'thlm_zm', 'rho_ds_zm', 'thv_ds_zm', 'em', 'mean_w_up', 'mean_w_down', 'shear', 'wp3_zm', 'Frad', 'Frad_LW', 'Frad_SW', 'Frad_LW_up', 'Frad_SW_up', 'Frad_LW_down', 'Frad_SW_down', 'Fprec', 'Fcsed', 'wp2_bt', 'wp2_ma', 'wp2_ta', 'wp2_ac', 'wp2_bp', 'wp2_pr1', 'wp2_pr2', 'wp2_pr3', 'wp2_dp1', 'wp2_dp2', 'wp2_cl', 'wp2_pd', 'wp2_sf', 'vp2_bt', 'vp2_ma', 'vp2_ta', 'vp2_tp', 'vp2_dp1', 'vp2_dp2', 'vp2_pr1', 'vp2_pr2', 'vp2_cl', 'vp2_pd', 'vp2_sf', 'up2_bt', 'up2_ma', 'up2_ta', 'up2_tp', 'up2_dp1', 'up2_dp2', 'up2_pr1', 'up2_pr2', 'up2_cl', 'up2_pd', 'up2_sf', 'wprtp_bt', 'wprtp_ma', 'wprtp_ta', 'wprtp_tp', 'wprtp_ac', 'wprtp_bp', 'wprtp_pr1', 'wprtp_pr2', 'wprtp_pr3', 'wprtp_dp1', 'wprtp_mfl', 'wprtp_cl', 'wprtp_sicl', 'wprtp_pd', 'wprtp_forcing', 'wprtp_mc', 'wpthlp_bt', 'wpthlp_ma', 'wpthlp_ta', 'wpthlp_tp', 'wpthlp_ac', 'wpthlp_bp', 'wpthlp_pr1', 'wpthlp_pr2', 'wpthlp_pr3', 'wpthlp_dp1', 'wpthlp_mfl', 'wpthlp_cl', 'wpthlp_sicl', 'wpthlp_forcing', 'wpthlp_mc', 'rtp2_bt', 'rtp2_ma', 'rtp2_ta', 'rtp2_tp', 'rtp2_dp1', 'rtp2_dp2', 'rtp2_cl', 'rtp2_pd', 'rtp2_sf', 'rtp2_forcing', 'rtp2_mc', 'thlp2_bt', 'thlp2_ma', 'thlp2_ta', 'thlp2_tp', 'thlp2_dp1', 'thlp2_dp2', 'thlp2_cl', 'thlp2_pd', 'thlp2_sf', 'thlp2_forcing', 'thlp2_mc', 'rtpthlp_bt', 'rtpthlp_ma', 'rtpthlp_ta', 'rtpthlp_tp1', 'rtpthlp_tp2', 'rtpthlp_dp1', 'rtpthlp_dp2', 'rtpthlp_cl', 'rtpthlp_sf', 'rtpthlp_forcing', 'rtpthlp_mc', 'wpthlp_entermfl', 'wpthlp_exit_mfl','upwp_bp','upwp_ta', 'upwp_tp','upwp_dp1','upwp_pr1','upwp_pr2','upwp_pr3','upwp_pr4','wprtp_enter_mfl', 'wprtp_exit_mfl', 'wpthlp_mfl_min', 'wpthlp_mfl_max', 'wprtp_mfl_min', 'wprtp_mfl_max', 'Ri_zm', 'Richardson_num', 'shear_sqd'"

#set clubb_vars_sfc_list = "'ustar', 'soil_heat_flux', 'veg_T_in_K', 'sfc_soil_T_in_K', 'deep_soil_T_in_K', 'lh', 'sh', 'cc','lwp', 'vwp', 'swp', 'iwp', 'rwp', 'z_cloudNGD', 'z_inversion', 'rain_rate_sfc','rain_flux_sfc', 'rrainm_sfc', 'wpthlp_sfc', 'wprtp_sfc', 'upwp_sfc', 'vpwp_sfc', 'morr_rain_rate', 'morr_snow_rate','thlm_vert_avg', 'rtm_vert_avg', 'um_vert_avg', 'vm_vert_avg', 'wp2_vert_avg', 'up2_vert_avg', 'vp2_vert_avg', 'rtp2_vert_avg',         'thlp2_vert_avg', 'T_sfc', 'rtm_spur_src', 'thlm_spur_src'"

#######################################################
#######  BEGIN USER DEFINED SETTINGS

  # Set the name of your case here

  # Set the case directory here
  setenv casedirectory /lcrc/group/acme/$USER/SCM_runs/test
 
  # Directory where code lives
  setenv code_dir $HOME/E3SM_code

  # Code tag name 
  setenv code_tag NGD_old  #newbase_noupwp_newbase

  # Name of machine you are running on (i.e. cori, anvil, etc)                                                    
  setenv machine anvil-centos7

  # Name of project to run on, if submitting to queue
  setenv projectname condo 

  # Aerosol specification
  # Options include:
  #  1) cons_droplet (sets cloud liquid and ice concentration
  #                   to a constant)
  #  2) prescribed (uses climatologically prescribed aerosol 
  #                 concentration)
  setenv init_aero_type prescribed # keep this as none for REPLAY option 
  setenv NUMSC 4
  setenv MGVER 2

  setenv CASEID rf01_NGD


  set start_in_sec = 0 # set start time in seconds

  if ($CASEID == bomex_NGD) then
  set lat = 15.0
  set lon = 300.0
  set startdate = 1969-06-25 # Start date in IOP file
  set stop_option = ndays
  set stop_n = 3
  set iop_file = BOMEX_iopfile_4scam.nc
  endif

  if ($CASEID == rf01_NGD) then
  set lat = 31.5 # latitude  
  set lon = 239.0 # longitude
  set startdate = 1999-07-10 # Start date in IOP file
  set stop_option = ndays
  set stop_n = 3
  set iop_file = DYCOMSrf01_iopfile_4scam.nc #IOP file name
  endif
  
  # Set the dynamical core
  #   1) Select "Eulerian" IF you are running E3SMv1 release code 
  #    
  #   2) Select "SE" IF you are running code from E3SM master branch that
  #     is AFTER March 10,2019
  setenv dycore SE
  setenv gust true
  #  WARNING:  EULERIAN DYCORE SCM IS NO LONGER SUPPORTED. You are only safe
  #  to use Eulerian dycore SCM if you are using E3SMv1 release code.  Else,
  #  user be(very)ware

# User enter any needed modules to load or use below
#  EXAMPLE:
  #module load python/2.7.15-7utbzum # python #/2.7.5
# module load python/intel-17.0.4

####### END USER DEFINED SETTINGS
####### Likely POSSIBLE EXCEPTION (not limited to):  
#######  - If the user wants to add addition output, for example, the CAM
#######	   namelist (user_nl_cam) should be modified below to accomodate for this
###########################################################################
###########################################################################
###########################################################################

# Case specific information kept here
  set do_iop_srf_prop = .true. # Use surface fluxes in IOP file?
  set do_scm_relaxation = .false. # Relax case to observations?
  set do_turnoff_swrad = .true. # Turn off SW calculation
  set do_turnoff_lwrad = .true. # Turn off LW calculation
  set do_turnoff_precip = .true. # Turn off precipitation
  set micro_nccons_val = 55.0D6 # cons_droplet value for liquid
  set micro_nicons_val = 0.0001D6 # cons_droplet value for ice
# End Case specific stuff here

  # Location of IOP file
  set iop_path =  atm/cam/scam/iop #~/myiops/ 

  # Prescribed aerosol file path and name
  set presc_aero_path = atm/cam/chem/trop_mam/aero
  set presc_aero_file = mam4_0.9x1.2_L72_2000clim_c170323.nc

  set PROJECT=$projectname
  set E3SMROOT=${code_dir}/${code_tag}
  cd $E3SMROOT/
  set DATE = `date +%F | sed 's/-//g'``date +%T | sed 's/://g'`
#  git diff  components/ > diff.$CASEID.$DATE.asc
#  git diff  *.csh > diff_script.$CASEID.$DATE.asc
#  cd components/clm/src/external_models/mpp
#  git diff   > $E3SMROOT/diff_clm.$CASEID.$DATE.asc


  cd $E3SMROOT/cime/scripts
  set compset=F_SCAM5
  
  if ($dycore == Eulerian) then
    set grid=T42_T42
  endif
  
  if ($dycore == SE) then
    set grid=ne16_oQU240 #ne16_ne16
  endif

  set CASEDIR=${casedirectory}/$CASEID
  
  set run_root_dir = $CASEDIR
  set temp_case_scripts_dir = $run_root_dir/case_scripts   

  set case_scripts_dir = $run_root_dir/case_scripts
  set case_build_dir   = $run_root_dir/build
  set case_run_dir     = $run_root_dir/run 

  set walltime = '00:40:00'

# COSP, set to false unless user really wants it
  setenv do_cosp  false

# Create new case
  ./create_newcase -case $temp_case_scripts_dir -mach $machine -project $PROJECT -compset $compset -res $grid --walltime $walltime  -q 'acme-small' # 
  cd $temp_case_scripts_dir


# SCM must run in serial mode
  if ($dycore == Eulerian) then
    ./xmlchange --id MPILIB --val mpi-serial
  endif
  
# Define executable and run directories
  ./xmlchange --id EXEROOT --val "${case_build_dir}"
  ./xmlchange --id RUNDIR --val "${case_run_dir}" 

# Set to debug, only on certain machines  
  if ($machine =~ 'cori*') then 
    ./xmlchange --id JOB_QUEUE --val 'debug'
  endif 
  
  if ($machine == 'quartz' || $machine == 'syrah') then
    ./xmlchange --id JOB_QUEUE --val 'pdebug'
  endif
# Get local input data directory path

  set input_data_dir = `./xmlquery DIN_LOC_ROOT -value`

# need to use single thread
  set npes = 1
  foreach component ( ATM LND ICE OCN CPL GLC ROF WAV )
    ./xmlchange  NTASKS_$component=$npes,NTHRDS_$component=1
  end

# CAM configure options.  By default set up with settings the same as E3SMv1
  set CAM_CONFIG_OPTS="-phys cam5 -scam -nlev 72 -clubb_sgs"
  if ($dycore == Eulerian) then
    set CAM_CONFIG_OPTS="$CAM_CONFIG_OPTS -nospmd -nosmp"
  endif
  
  if ( $do_cosp == true ) then
    set  CAM_CONFIG_OPTS="$CAM_CONFIG_OPTS -cosp -verbose" 
  endif

# CAM configure options dependant on what aerosol specification is used
  if ($init_aero_type == cons_droplet || $init_aero_type == none) then 
#    set CAM_CONFIG_OPTS="$CAM_CONFIG_OPTS -chem linoz_mam4_resus_mom_soag -rain_evap_to_coarse_aero -bc_dep_to_snow_updates" 
#    set CAM_CONFIG_OPTS="$CAM_CONFIG_OPTS -chem trop_mam3"
  endif

  if ($init_aero_type == prescribed || $init_aero_type == observed) then
    set CAM_CONFIG_OPTS="$CAM_CONFIG_OPTS -chem none"
  endif

#  set  CAM_CONFIG_OPTS="$CAM_CONFIG_OPTS -dyn se -phys cam5 -nadv 29 -clubb_sgs -rad rrtmg -chem trop_mam3 -silent -nlev 72 -microphys mg$MGVER  -psubcols $NUMSC -cppdefs '-DUWM_MISC -DSILHS'"
 set  CAM_CONFIG_OPTS="$CAM_CONFIG_OPTS -phys cam5 -scam -nlev 72 -clubb_sgs -rad rrtmg -microphys mg$MGVER  -psubcols $NUMSC -cppdefs '-DUWM_MISC -DSILHS'"

# set  CAM_CONFIG_OPTS="$CAM_CONFIG_OPTS -dyn se -phys cam5 -chem linoz_mam4_resus_mom_soag -rain_evap_to_coarse_aero -bc_dep_to_snow_updates -microphys mg$MGVER  -cppdefs '-DUWM_MISC '"

  ./xmlchange CAM_CONFIG_OPTS="$CAM_CONFIG_OPTS" 
  set clubb_micro_steps = 8
# If SE dycore is used then we need to change the timestep 
# to be consistent with ne30 timestep.  Also change the 
# cld_macmic_num_steps to be consistent
  if ($dycore == SE) then
    ./xmlchange ATM_NCPL='48'
    set clubb_micro_steps = 6
  endif

# User enter CAM namelist options
#  Add additional output here for example
cat <<EOF >> user_nl_cam
 cld_macmic_num_steps = $clubb_micro_steps
 cosp_lite = .false.
 iopfile = '$input_data_dir/$iop_path/$iop_file'
 mfilt = 1000
 nhtfrq = 1
 scm_iop_srf_prop = $do_iop_srf_prop 
 scm_relaxation = $do_scm_relaxation
 iradlw = 1
 iradsw = 1
 swrad_off = $do_turnoff_swrad 
 lwrad_off = $do_turnoff_lwrad
 precip_off = $do_turnoff_precip
 scmlat = $lat 
 scmlon = $lon
EOF

# CAM namelist options to match E3SMv1 settings
#  Future implementations this block will not be needed
#  Match settings in compset 2000_cam5_av1c-04p2

cat <<EOF >> user_nl_cam

 state_debug_checks=.true.

 clubb_beta             = 2.
 clubb_c1               = 1.0
 clubb_c11              = .5
 clubb_c11b             = .5
 clubb_c11c             = 0.85
 clubb_c14              = 1.0
 clubb_c15              = 0.
 clubb_c1b              = 1.0
 clubb_c1c              = 0.75
 clubb_c2rt             = 1
 clubb_c2rtthl          = 1
 clubb_c2thl            = 1
 clubb_c4               = 1
 clubb_c5               = 0
 clubb_c6rt             = 1
 clubb_c6rtb            = 1
 clubb_c6rtc            = 0.50
 clubb_c6thlb           = 1
 clubb_c6thlc           = 0.50
 clubb_c7               = 0.7
 clubb_c7b              = 0.7
 clubb_c8               = 0.5

 clubb_c_invrs_tau_bkgnd                = 1.5
 clubb_c_invrs_tau_n2                   = 0.3!65
 clubb_c_invrs_tau_n2_clear_wp3         = 2.0
 clubb_c_invrs_tau_n2_wp2               = 0.2
 clubb_c_invrs_tau_n2_wpxp              = 2.
 clubb_c_invrs_tau_n2_xp2               = 0.0  
 clubb_c_invrs_tau_sfc                  = 0.1
 clubb_c_invrs_tau_shear                = 0.15
 clubb_c_k1             = 1
 clubb_c_k10            = 0.5
 clubb_c_k2             = 0.1
 clubb_c_k8             = 10
 clubb_c_wp2_splat              = 0.
 clubb_gamma_coef               = 0.3
 clubb_gamma_coefb              = 0.3
 clubb_gamma_coefc              = 1.2
 clubb_mu               = 0.0005
 clubb_nu1              = 10
 clubb_nu2              = 1
 clubb_nu8              = 60
 clubb_wpxp_l_thresh            = 100.0D0
 clubb_alt_thresh       = 300.

 history_amwg = .true.
 history_budget = .true.
 clubb_history = .true.
 clubb_rad_history = .false.

 clubb_vars_zt = $clubb_vars_zt_list
 clubb_vars_zm = $clubb_vars_zm_list
 
fincl1 = $clubb_vars_zt_list,$clubb_vars_zm_list,
'U','PS','T','V','OMEGA','Z3','PRECT',
'CLDLIQ', 'CLDICE', 'LWCF', 'SWCF', 'FLUT',
'TMQ', 'PRECC', 'PRECL', 'CME', 'PRODPREC',
'EVAPPREC','EVAPSNOW','ICWMRST','ICIMRST','PRAO',
'PRCO','QCSEVAP','QISEVAP','QVRES','CMEIOUT','VTRMI',
'VTRMC','QCSEDTEN','QISEDTEN','MNUCCCO','MNUCCTO',
'MNUCCDO','MNUCCDOhet','MSACWIO','PSACWSO','BERGSO',
'BERGO','MELTO','HOMOO','QCRESO','PRCIO','PRAIO',
'MELTSDT','FRZRDT','ADRAIN','ADSNOW','FREQR','FREQS',
'PE','APRL','PEFRAC','VPRCO','VPRAO','RACAU',
'QIRESO','QCRESO','PRACSO','MPDT','MPDQ','MPDLIQ',
'MPDICE','INEGCLPTEND', 'LNEGCLPTEND', 'VNEGCLPTEND',
'QCRAT'

 ncdata         = '/home/ccsm-data/inputdata/atm/cam/inic/homme/cami_mam3_Linoz_ne16np4_L72_c160614.nc'

 use_gw_front = .false.
 use_hetfrz_classnuc = .true.
 micro_mg_dcs_tdep = .true.
 microp_aero_wsub_scheme = 1
 sscav_tuning = .true.
 convproc_do_aer = .true.
 demott_ice_nuc = .true.
 liqcf_fix = .true.
 regen_fix = .true.
 resus_fix = .false.
 mam_amicphys_optaa = 1
 fix_g1_err_ndrop = .true.
 ssalt_tuning = .true.
 use_rad_dt_cosz = .true.
 ice_sed_ai = 500.0
 cldfrc_dp1 = 0.045D0
 clubb_ice_deep = 16.e-6
 clubb_ice_sh = 50.e-6
 clubb_liq_deep = 8.e-6
 clubb_liq_sh = 10.e-6
 effgw_oro = 0.25
 seasalt_emis_scale = 0.85
 dust_emis_fact = 2.05D0
 cldfrc2m_rhmaxi = 1.05D0
 effgw_beres = 0.4
 do_tms = .false.
 so4_sz_thresh_icenuc = 0.075e-6
 n_so4_monolayers_pcage = 8.0D0
 micro_mg_accre_enhan_fac = 1.5D0
 zmconv_tiedke_add = 0.8D0
 zmconv_cape_cin = 1
 zmconv_mx_bot_lyr_adj = 2
 taubgnd = 2.5D-3
 raytau0 = 5.0D0
 prc_coef1 = 30500.0D0
 prc_exp = 3.D0 
 prc_exp1 = -1.2D0
 se_ftype = 2
 relvar_fix = .true. 
 mg_prc_coeff_fix = .true.
 rrtmg_temp_fix = .true.

EOF

# if constant droplet was selected then modify name list to reflect this
if ($init_aero_type == cons_droplet) then
cat <<EOF >> user_nl_cam
  micro_do_nccons = .true.
  micro_do_nicons = .true.
  micro_nccons = $micro_nccons_val 
  micro_nicons = $micro_nicons_val
EOF
endif

# if prescribed or observed aerosols set then need to put in settings for prescribed aerosol model

if ($init_aero_type == prescribed ||$init_aero_type == observed) then
cat <<EOF >> user_nl_cam
  use_hetfrz_classnuc = .false.
  aerodep_flx_type = 'CYCLICAL'
  aerodep_flx_datapath = '$input_data_dir/$presc_aero_path' 
  aerodep_flx_file = '$presc_aero_file'
  aerodep_flx_cycle_yr = 01
  prescribed_aero_type = 'CYCLICAL'
  prescribed_aero_datapath='$input_data_dir/$presc_aero_path'
  prescribed_aero_file='$presc_aero_file'
  prescribed_aero_cycle_yr = 01
EOF
  
endif

# if observed aerosols then set flag
if ($init_aero_type == observed) then

cat <<EOF >> user_nl_cam
  scm_observed_aero = .true.
EOF

endif

cat <<EOF >> user_nl_cam
  ice_supersat = .true.
  clubb_do_icesuper  =  .false.
  macrop_scheme = 'CLUBB_SGS'
  eddy_scheme = 'CLUBB_SGS'
  shallow_scheme = 'CLUBB_SGS'
  deep_scheme = 'off'
  subcol_scheme = 'SILHS'
  use_subcol_microp = .true.
  microp_uniform = .true.
  clubb_do_adv = .false.
  clubb_expldiff = .false.
  clubb_rainevap_turb = .false.
  clubb_cloudtop_cooling = .false.
  subcol_SILHS_weight = .true.
  subcol_SILHS_numsubcol =  $NUMSC 
  subcol_SILHS_corr_file_name = 'arm_97'
  subcol_silhs_q_to_micro = .true. ! if .false. gridbox means are used instead of sample points
  subcol_silhs_n_to_micro = .true. ! if .false. gridbox means are used instead of sample points
  subcol_silhs_use_clear_col = .false.
  subcol_SILHS_constrainmn = .false.
  subcol_silhs_ncnp2_on_ncnm2 = 0.05,
  hmp2_ip_on_hmm2_ip_slope%rr = 0.0,
  hmp2_ip_on_hmm2_ip_slope%Nr = 0.0,
  hmp2_ip_on_hmm2_ip_slope%rs = 0.0,
  hmp2_ip_on_hmm2_ip_slope%Ns = 0.0,
  hmp2_ip_on_hmm2_ip_slope%ri = 0.0,
  hmp2_ip_on_hmm2_ip_slope%Ni = 0.0,
  hmp2_ip_on_hmm2_ip_intrcpt%rr = 1.0,
  hmp2_ip_on_hmm2_ip_intrcpt%Nr = 1.0,
  hmp2_ip_on_hmm2_ip_intrcpt%rs = 1.0,
  hmp2_ip_on_hmm2_ip_intrcpt%Ns = 1.0,
  hmp2_ip_on_hmm2_ip_intrcpt%ri = 1.0,
  hmp2_ip_on_hmm2_ip_intrcpt%Ni = 1.0
EOF


# avoid the monthly cice file from writing as this 
#   appears to be currently broken for SCM
cat <<EOF >> user_nl_cice
  histfreq='y','x','x','x','x'
EOF

# Use CLM4.5.  Currently need to point to the correct file for Eulerian 
#  dy-core (this will be fixed in upcoming PR)
set CLM_CONFIG_OPTS="-phys clm4_5"
./xmlchange CLM_CONFIG_OPTS="$CLM_CONFIG_OPTS"

# Modify the run start and duration parameters for the desired case
  ./xmlchange RUN_STARTDATE="$startdate",START_TOD="$start_in_sec",STOP_OPTION="$stop_option",STOP_N="$stop_n"

# Modify the latitude and longitude for the particular case
  ./xmlchange PTS_MODE="TRUE",PTS_LAT="$lat",PTS_LON="$lon"
  ./xmlchange MASK_GRID="USGS"

  ./case.setup 

# Don't want to write restarts as this appears to be broken for 
#  CICE model in SCM.  For now set this to a high value to avoid
  ./xmlchange PIO_TYPENAME="netcdf"
  ./xmlchange REST_N=30000

# Modify some parameters for CICE to make it SCM compatible 
  ./xmlchange CICE_AUTO_DECOMP="FALSE"
  ./xmlchange CICE_DECOMPTYPE="blkrobin"
  ./xmlchange --id CICE_BLCKX --val 1
  ./xmlchange --id CICE_BLCKY --val 1
  ./xmlchange --id CICE_MXBLCKS --val 1
  ./xmlchange CICE_CONFIG_OPTS="-nodecomp -maxblocks 1 -nx 1 -ny 1"

# Build the case 
#  ./xmlchange DEBUG="True"
  mv $E3SMROOT/diff.$CASEID.$DATE.asc $run_root_dir/run/.
  mv $E3SMROOT/diff_clm.$CASEID.$DATE.asc $run_root_dir/run/.
  mv $E3SMROOT/diff_script.$CASEID.$DATE.asc $run_root_dir/run/.

 ./case.build

#  ./xmlchange BUILD_COMPLETE="TRUE"
#  ln -sf /lcrc/group/acme/ac.zguo/SCM_runs/sample102_clean/hawaii_NGD_v4/build/e3sm.exe $run_root_dir/build/e3sm.exe

#  ln -sf /lcrc/group/acme/zhun/E3SM_simulations/anvil-centos7.newbase_noupwp.newbase_noupwp_L72_repeat.ne16_ne16/build/e3sm.exe $run_root_dir/build/e3sm.exe

  ./case.submit

  exit
