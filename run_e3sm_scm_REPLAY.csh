#!/bin/csh

#######################################################################
#######################################################################
#######  Script to run E3SM in SCM for
#######  REPLAY 
#######  REPLAY an E3SM column
#######  
#######  Script Author: P. Bogenschutz (bogenschutz1@llnl.gov)

#######################################################
#######  BEGIN USER DEFINED SETTINGS

  # Set the name of your case here

  setenv casename clbzm_REPLAY_285E_-20N_gust4

  # Set the case directory here
  setenv casedirectory /lcrc/group/acme/$USER/SCM_runs
 
  # Directory where code lives
  setenv code_dir $HOME/E3SM_code

  # Code tag name 
  setenv code_tag base2 #master_20191113 

  # Name of machine you are running on (i.e. cori, anvil, etc)                                                    
  setenv machine anvil-centos7

  # Name of project to run on, if submitting to queue
  setenv projectname condo 

set clubb_vars_zt_list = "'thlm', 'thvm', 'rtm', 'rcm', 'rvm', 'um', 'vm', 'um_ref','vm_ref','ug', 'vg', 'cloud_frac', 'cloud_cover', 'rcm_in_layer', 'rcm_in_cloud', 'p_in_Pa', 'exner', 'rho_ds_zt', 'thv_ds_zt', 'Lscale', 'Lscale_pert_1', 'Lscale_pert_2', 'T_in_K', 'rel_humidity', 'wp3', 'wpthlp2', 'wp2thlp', 'wprtp2', 'wp2rtp', 'Lscale_up', 'Lscale_down', 'tau_zt', 'Kh_zt', 'wp2thvp', 'wp2rcp', 'wprtpthlp', 'sigma_sqd_w_zt', 'rho', 'radht', 'radht_LW', 'radht_SW', 'Ncm', 'Nc_in_cloud', 'Nc_activated', 'snowslope', 'sed_rcm', 'rsat', 'rsati', 'diam', 'mass_ice_cryst', 'rcm_icedfs', 'u_T_cm', 'rtm_bt', 'rtm_ma', 'rtm_ta', 'rtm_mfl', 'rtm_tacl', 'rtm_cl', 'rtm_forcing', 'rtm_sdmp','rtm_mc', 'rtm_pd', 'rvm_mc', 'rcm_mc', 'rcm_sd_mg_morr', 'thlm_bt', 'thlm_ma', 'thlm_ta', 'thlm_mfl', 'thlm_tacl', 'thlm_cl', 'thlm_forcing', 'thlm_sdmp','thlm_mc', 'thlm_old', 'thlm_without_ta', 'thlm_mfl_min', 'thlm_mfl_max', 'thlm_enter_mfl', 'thlm_exit_mfl', 'rtm_old', 'rtm_without_ta', 'rtm_mfl_min', 'rtm_mfl_max', 'rtm_enter_mfl', 'rtm_exit_mfl', 'um_bt', 'um_ma', 'um_gf', 'um_cf', 'um_ta', 'um_f', 'um_sdmp', 'um_ndg', 'vm_bt', 'vm_ma', 'vm_gf', 'vm_cf', 'vm_ta', 'vm_f', 'vm_sdmp', 'vm_ndg', 'wp3_bt', 'wp3_ma', 'wp3_ta', 'wp3_tp', 'wp3_ac', 'wp3_bp1', 'wp3_bp2', 'wp3_pr1', 'wp3_pr2', 'wp3_dp1', 'wp3_cl', 'mixt_frac', 'w_1', 'w_2', 'varnce_w_1', 'varnce_w_2', 'thl_1', 'thl_2', 'varnce_thl_1', 'varnce_thl_2', 'rt_1', 'rt_2', 'varnce_rt_1', 'varnce_rt_2', 'rc_1', 'rc_2', 'rsatl_1', 'rsatl_2', 'cloud_frac_1', 'cloud_frac_2', 'a3_coef_zt', 'wp3_on_wp2_zt', 'chi_1', 'chi_2', 'stdev_chi_1', 'stdev_chi_2', 'stdev_eta_1', 'stdev_eta_2', 'covar_chi_eta_1', 'covar_chi_eta_2', 'corr_chi_eta_1', 'corr_chi_eta_2', 'corr_rt_thl_1', 'crt_1', 'crt_2', 'cthl_1', 'cthl_2', 'precip_frac', 'precip_frac_1', 'precip_frac_2', 'Ncnm', 'wp2_zt', 'thlp2_zt', 'wpthlp_zt', 'wprtp_zt', 'rtp2_zt', 'rtpthlp_zt', 'up2_zt', 'vp2_zt', 'upwp_zt', 'vpwp_zt', 'C11_Skw_fnc'"

set clubb_vars_zm_list = "'wp2', 'rtp2', 'thlp2', 'rtpthlp', 'wprtp', 'wpthlp', 'wp4', 'up2', 'vp2', 'wpthvp', 'rtpthvp', 'thlpthvp', 'tau_zm', 'Kh_zm', 'wprcp', 'wm_zm', 'thlprcp', 'rtprcp', 'rcp2', 'upwp', 'vpwp', 'rho_zm', 'sigma_sqd_w', 'Skw_velocity', 'gamma_Skw_fnc', 'C6rt_Skw_fnc', 'C6thl_Skw_fnc', 'C7_Skw_fnc', 'C1_Skw_fnc', 'a3_coef', 'wp3_on_wp2', 'rcm_zm', 'rtm_zm', 'thlm_zm', 'cloud_frac_zm', 'rho_ds_zm', 'thv_ds_zm', 'em', 'mean_w_up', 'mean_w_down', 'shear', 'wp3_zm', 'Frad', 'Frad_LW', 'Frad_SW', 'Frad_LW_up', 'Frad_SW_up', 'Frad_LW_down', 'Frad_SW_down', 'Fprec', 'Fcsed', 'wp2_bt', 'wp2_ma', 'wp2_ta', 'wp2_ac', 'wp2_bp', 'wp2_pr1', 'wp2_pr2', 'wp2_pr3', 'wp2_dp1', 'wp2_dp2', 'wp2_cl', 'wp2_pd', 'wp2_sf', 'vp2_bt', 'vp2_ma', 'vp2_ta', 'vp2_tp', 'vp2_dp1', 'vp2_dp2', 'vp2_pr1', 'vp2_pr2', 'vp2_cl', 'vp2_pd', 'vp2_sf', 'up2_bt', 'up2_ma', 'up2_ta', 'up2_tp', 'up2_dp1', 'up2_dp2', 'up2_pr1', 'up2_pr2', 'up2_cl', 'up2_pd', 'up2_sf', 'wprtp_bt', 'wprtp_ma', 'wprtp_ta', 'wprtp_tp', 'wprtp_ac', 'wprtp_bp', 'wprtp_pr1', 'wprtp_pr2', 'wprtp_pr3', 'wprtp_dp1', 'wprtp_mfl', 'wprtp_cl', 'wprtp_sicl', 'wprtp_pd', 'wprtp_forcing', 'wprtp_mc', 'wpthlp_bt', 'wpthlp_ma', 'wpthlp_ta', 'wpthlp_tp', 'wpthlp_ac', 'wpthlp_bp', 'wpthlp_pr1', 'wpthlp_pr2', 'wpthlp_pr3', 'wpthlp_dp1', 'wpthlp_mfl', 'wpthlp_cl', 'wpthlp_sicl', 'wpthlp_forcing', 'wpthlp_mc', 'rtp2_bt', 'rtp2_ma', 'rtp2_ta', 'rtp2_tp', 'rtp2_dp1', 'rtp2_dp2', 'rtp2_cl', 'rtp2_pd', 'rtp2_sf', 'rtp2_forcing', 'rtp2_mc', 'thlp2_bt', 'thlp2_ma', 'thlp2_ta', 'thlp2_tp', 'thlp2_dp1', 'thlp2_dp2', 'thlp2_cl', 'thlp2_pd', 'thlp2_sf', 'thlp2_forcing', 'thlp2_mc', 'rtpthlp_bt', 'rtpthlp_ma', 'rtpthlp_ta', 'rtpthlp_tp1', 'rtpthlp_tp2', 'rtpthlp_dp1', 'rtpthlp_dp2', 'rtpthlp_cl', 'rtpthlp_sf', 'rtpthlp_forcing', 'rtpthlp_mc', 'wpthlp_entermfl', 'wpthlp_exit_mfl', 'wprtp_enter_mfl', 'wprtp_exit_mfl', 'wpthlp_mfl_min', 'wpthlp_mfl_max', 'wprtp_mfl_min', 'wprtp_mfl_max', 'Ri', 'Richardson_num', 'shear_sqd'"

  # Aerosol specification
  # Options include:
  #  1) cons_droplet (sets cloud liquid and ice concentration
  #                   to a constant)
  #  2) prescribed (uses climatologically prescribed aerosol 
  #                 concentration)
  setenv init_aero_type  none  # keep this as none for REPLAY option 
  setenv NUMSC 4
  setenv MGVER 2

  set startdate = 0001-06-01 # set desired start date
  set stop_option = nhours # set desired stop option
  set stop_n = 72 # set desired stop n
  set start_in_sec = 0 # set start time in seconds
  set iop_file = e3sm_gust_forcing_285E_20S.nc 
  set lat = -20 # set desired latitude
  set lon = 285  # set desired longitude
  
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
#######	   namelist (user_nl_eam) should be modified below to accomodate for this
###########################################################################
###########################################################################
###########################################################################

# Case specific information kept here
  set do_iop_srf_prop = .true. # Use surface fluxes in IOP file?
  set do_scm_relaxation = .false. # Relax case to observations?
  set do_turnoff_swrad = .false. # Turn off SW calculation
  set do_turnoff_lwrad = .false. # Turn off LW calculation
  set do_turnoff_precip = .false. # Turn off precipitation
  set micro_nccons_val = 55.0D6 # cons_droplet value for liquid
  set micro_nicons_val = 0.0001D6 # cons_droplet value for ice
# End Case specific stuff here

  # Location of IOP file
  set iop_path = ~/myiops/ 

  # Prescribed aerosol file path and name
  set presc_aero_path = atm/cam/chem/trop_mam/aero
  set presc_aero_file = mam4_0.9x1.2_L72_2000clim_c170323.nc

  set PROJECT=$projectname
  set E3SMROOT=${code_dir}/${code_tag}
  
  cd $E3SMROOT/cime/scripts
  set compset=F_SCAM5
  
  if ($dycore == Eulerian) then
    set grid=T42_T42
  endif
  
  if ($dycore == SE) then
    set grid=ne16_ne16
  endif

  set CASEID=$casename   

  set CASEDIR=${casedirectory}/$CASEID
  
  set run_root_dir = $CASEDIR
  set temp_case_scripts_dir = $run_root_dir/case_scripts   

  set case_scripts_dir = $run_root_dir/case_scripts
  set case_build_dir   = $run_root_dir/build
  set case_run_dir     = $run_root_dir/run 

  set walltime = '00:10:00'

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
    set CAM_CONFIG_OPTS="$CAM_CONFIG_OPTS -chem linoz_mam4_resus_mom_soag -rain_evap_to_coarse_aero -bc_dep_to_snow_updates"
#    set CAM_CONFIG_OPTS="$CAM_CONFIG_OPTS -chem trop_mam3"
  endif

  if ($init_aero_type == prescribed || $init_aero_type == observed) then
    set CAM_CONFIG_OPTS="$CAM_CONFIG_OPTS -chem none"
  endif



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
cat <<EOF >> user_nl_eam
 cld_macmic_num_steps = $clubb_micro_steps
 cosp_lite = .true.
 use_gw_front = .true.
 iopfile = '$iop_path/$iop_file'
 mfilt = 10000
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

cat <<EOF >> user_nl_eam
   clubb_c1               = 2.4
   clubb_c11              = 0.70
   clubb_c11b             = 0.20
   clubb_c11c             = 0.85
   clubb_c14              = 2.0D0
   clubb_c1b              = 2.8
   clubb_c1c              = 0.75
   clubb_c2rt             =          1.75D0
   clubb_c6rtb            = 7.50
   clubb_c6rtc            = 0.50
   clubb_c6thlb           = 7.50
   clubb_c6thlc           = 0.50
   clubb_c8               =            5.2
   clubb_c_k10            =         0.35
   clubb_gamma_coef               =    0.12D0
   clubb_gamma_coefb              =    0.28D0
   clubb_gamma_coefc              = 1.2
   clubb_mu               = 0.0005
   clubb_wpxp_l_thresh            =  100.0D0
! clubb_beta             = 2.
! clubb_c1               = 3.
! clubb_c11              = .6
! clubb_c11b             = .6
! clubb_c14              = 3.
! clubb_c15              = 0.85
! clubb_c1b              = 3.
! clubb_c2rt             = 2.
! clubb_c2rtthl          = 2.
! clubb_c2thl            = 2.  
! clubb_c4               = 8.
! clubb_c5               = .9
! clubb_c6rt             = 6.
! clubb_c6rtb            = 6.
! clubb_c6thlb           = 6.
! clubb_c8               = .4
! clubb_c_k10            = .3
! clubb_c_k2             = .01
! clubb_gamma_coef               = .22
! clubb_gamma_coefb              = .22
! clubb_nu2              = 10
! clubb_wpxp_l_thresh            =  100.0D0
! clubb_C_invrs_tau_bkgnd = 1.1D0
! clubb_C_invrs_tau_sfc = 0.1D0
! clubb_C_invrs_tau_shear = 0.02D0
! clubb_C_invrs_tau_N2 = 0.4D0
! clubb_C_invrs_tau_N2_wp2 = 0.1D0
! clubb_C_invrs_tau_N2_xp2 = 0.05D0
! clubb_C_invrs_tau_N2_wpxp= 0.0D0
! clubb_C_invrs_tau_N2_clear_wp3 = 1.0D0
! clubb_c_wp2_splat  = 0.0D0
 clubb_ice_deep = 14.e-6
 clubb_ice_sh = 50.e-6
 clubb_liq_deep = 8.e-6
 clubb_liq_sh = 10.e-6
 history_amwg = .true.
 history_budget = .true.
 clubb_history = .true.
 clubb_rad_history = .false.
 macrop_scheme = 'CLUBB_SGS'
 eddy_scheme = 'CLUBB_SGS'
 shallow_scheme = 'CLUBB_SGS'
 clubb_do_adv = .false.
 clubb_expldiff = .false.
 clubb_rainevap_turb = .false.
 clubb_cloudtop_cooling = .false.
 clubb_vars_zt = $clubb_vars_zt_list
 clubb_vars_zm = $clubb_vars_zm_list
fincl1 = $clubb_vars_zt_list,$clubb_vars_zm_list,
'U:A','PS:A','T:A','V:A','OMEGA:A','Z3:A','PRECT:A',
'CLDLIQ:A', 'CLDICE:A', 'LWCF:A', 'SWCF:A', 'FLUT:A',
'TMQ:A', 'PRECC:A', 'PRECL:A', 'CME:A', 'PRODPREC:A',
'EVAPPREC:A','EVAPSNOW:A','ICWMRST:A','ICIMRST:A','PRAO:A',
'PRCO:A','QCSEVAP:A','QISEVAP:A','QVRES:A','CMEIOUT:A','VTRMI:A',
'VTRMC:A','QCSEDTEN:A','QISEDTEN:A','MNUCCCO:A','MNUCCTO:A',
'MNUCCDO:A','MNUCCDOhet:A','MSACWIO:A','PSACWSO:A','BERGSO:A',
'BERGO:A','MELTO:A','HOMOO:A','QCRESO:A','PRCIO:A','PRAIO:A',
'MELTSDT:A','FRZRDT:A','ADRAIN:A','ADSNOW:A','FREQR:A','FREQS:A',
'PE:A','APRL:A','PEFRAC:A','VPRCO:A','VPRAO:A','RACAU:A',
'QIRESO:A','QCRESO:A','PRACSO:A','MPDT:A','MPDQ:A','MPDLIQ:A',
'MPDICE:A'!
!,'INEGCLPTEND', 'LNEGCLPTEND', 'VNEGCLPTEND',
!'QCRAT:A'
! 'QVHFTEN', 'QCHFTEN', 'QRHFTEN', 'QIHFTEN', 'QSHFTEN', 'THFTEN',
!'SL', 'Q', 'RHW', 'QRS', 'QRL', 'HR', 'FDL', 'SILHS_CLUBB_PRECIP_FRAC',
!'SILHS_CLUBB_ICE_SS_FRAC', 'T_ADJ_CLUBB'
 ncdata         = '/home/ccsm-data/inputdata/atm/cam/inic/homme/cami_mam3_Linoz_ne16np4_L72_c160614.nc'
 relvar_fix = .true. 
 mg_prc_coeff_fix = .true.
 rrtmg_temp_fix = .true.
 microp_scheme = 'MG'
 micro_mg_version = 2
 micro_mg_sub_version = 0
 micro_mg_num_steps = 1
 micro_mg_dcs = 195e-6
 micro_mg_berg_eff_factor =0.7D0
 cldfrc2m_rhmini = 0.8
 cldfrc2m_rhmaxi = 1.05
! ice_sed_ai= 1200.0
EOF

# if constant droplet was selected then modify name list to reflect this
if ($init_aero_type == cons_droplet) then
cat <<EOF >> user_nl_eam
  micro_do_nccons = .true.
  micro_do_nicons = .true.
  micro_nccons = $micro_nccons_val 
  micro_nicons = $micro_nicons_val
EOF
endif

# if prescribed or observed aerosols set then need to put in settings for prescribed aerosol model

if ($init_aero_type == prescribed ||$init_aero_type == observed) then
cat <<EOF >> user_nl_eam
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

cat <<EOF >> user_nl_eam
  scm_observed_aero = .true.
EOF

endif

if ($init_aero_type == none) then
cat <<EOF >> user_nl_eam
!  ice_supersat = .true.
!  micro_do_icesupersat  =  .true.
  macrop_scheme = 'CLUBB_SGS'
  eddy_scheme = 'CLUBB_SGS'
  shallow_scheme = 'CLUBB_SGS'
  deep_scheme = 'ZM'
  subcol_scheme = 'off'
  use_subcol_microp = .false.
  microp_uniform = .false.
  clubb_do_adv = .false.
  clubb_expldiff = .false.
  clubb_rainevap_turb = .false.
  clubb_cloudtop_cooling = .false.
  sol_facti_cloud_borne = 1.0D0
  dust_emis_fact = 0.3D0
  nucleate_ice_subgrid = 1.2
  seasalt_emis_scale = 0.6
   clubb_use_sgv          = .true.
 se_ftype               = 2
 dust_emis_fact         =      2.8D0
 ice_sed_ai             =          1200.0
 effgw_beres            =         0.4
 effgw_oro              =           0.25
   zmconv_alfa            =         0.14D0 
   zmconv_c0_lnd          =       0.0020  
   zmconv_c0_ocn          =       0.0020  
   zmconv_cape_cin                = 1
   zmconv_dmpdz           =       -1.2e-3
   zmconv_ke              =           5.0E-6 
   zmconv_mx_bot_lyr_adj          = 1
   zmconv_tau             =  3600
   zmconv_tiedke_add              = 0.8D0
   zmconv_tp_fac          =       2.0D0
EOF

endif

if ($gust == true) then
cat <<EOF >> user_nl_eam
  cld_macmic_num_steps           =  6 
  cld_sed                        =  1.8D0 
  conv_water_in_rad              =  1                                                                   
  convproc_do_aer                = .true.
  convproc_do_gas                = .false.                                                              
  convproc_method_activate       = 2                                                            
  demott_ice_nuc                 = .true.
  do_aerocom_ind3                =  .false.                                                             
  do_tms                 =              .false.
  fix_g1_err_ndrop               = .true.
  history_aero_optics            = .true.
  history_aerosol                = .true.
  history_eddy           =                  .false.                                                     
  history_vdiag          =                 .false.                                                      
  history_verbose                =               .false.                                                
  history_waccm          =                 .false.                                                      
  liqcf_fix              = .true.
  mam_amicphys_optaa             = 1
  micro_mg_accre_enhan_fac               = 1.75D0
  n_so4_monolayers_pcage         = 8.0D0 
  prc_coef1              = 30500.0D0
  prc_exp                = 3.19D0
  prc_exp1               = -1.40D0
  radiation_scheme               = 'rrtmg'                                                              
  regen_fix              = .true.
  resus_fix              = .true.
  rrtmg_temp_fix         = .true.                                                                       
  srf_flux_avg           = 0                                                                            
  ssalt_tuning           = .true.
  use_gw_convect         = .true.                                                                       
  use_gw_front           = .true.                                                                       
  use_gw_oro             = .true.                                                                       
  use_hetfrz_classnuc    = .true.
  waccmx_opt             = 'off'
  nucleate_ice_subgrid           = 1.2D0 
  so4_sz_thresh_icenuc           = 0.080e-6
  use_preexisting_ice            = .false.
  taubgnd                = 2.5D-3
EOF
endif
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
  ./case.build
# ./xmlchange BUILD_COMPLETE="TRUE"
#  ln -sf /lcrc/group/acme/zhun/SCM_runs/clbsilh_REPLAY_285E_-20N_gust1/build/e3sm.exe  $run_root_dir/build/e3sm.exe

  ./case.submit
  
  exit