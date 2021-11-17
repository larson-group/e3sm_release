### and incorporates some features originally from Hui Wan, Kai Zhang, and Balwinder Singh.
### Significant improvements from Michael Deakin and Chris Golaz.
### Zhun Guo modified for clubb-tau. 

###===================================================================
### THINGS USERS USUALLY CHANGE (SEE END OF SECTION FOR GUIDANCE)
###===================================================================



### BASIC INFO ABOUT RUN
set job_name       = mg2_def 
set compset        = FC5AV1C-L 
set resolution     = ne4_ne4
set machine        = nelson
setenv NUMSC 4
setenv MGVER 2

set input_data_dir = /home/pub/cam_inputdata

set walltime       = 18:00:00
setenv project condo      
setenv ntasks 1
setenv nthrds 1

setenv init_aero_type none # keep this as none for REPLAY option 

### SOURCE CODE OPTIONS
set fetch_code     = false       # flag to toggle cloning source code
set e3sm_tag       = maint-1.0   # github tag or hash
set tag_name       = "" #default

# A list of CLUBB variables
set clubb_vars_zt_list = "'thlm', 'thvm', 'rtm', 'rcm', 'rvm', 'um', 'vm', 'um_ref','vm_ref','ug', 'vg', 'cloud_frac', 'cloud_cover', 'rcm_in_layer', 'rcm_in_cloud', 'p_in_Pa', 'exner', 'rho_ds_zt', 'thv_ds_zt', 'Lscale', 'Lscale_pert_1', 'Lscale_pert_2', 'T_in_K', 'rel_humidity', 'wp3', 'wpthlp2', 'wp2thlp', 'wprtp2', 'wp2rtp', 'Lscale_up', 'Lscale_down', 'tau_zt', 'Kh_zt', 'wp2thvp', 'wp2rcp', 'wprtpthlp', 'sigma_sqd_w_zt', 'rho', 'radht', 'radht_LW', 'radht_SW', 'Ncm', 'Nc_in_cloud', 'Nc_activated', 'snowslope', 'sed_rcm', 'rsat', 'rsati', 'diam', 'mass_ice_cryst', 'rcm_icedfs', 'u_T_cm', 'rtm_bt', 'rtm_ma', 'rtm_ta', 'rtm_mfl', 'rtm_tacl', 'rtm_cl', 'rtm_forcing', 'rtm_sdmp','rtm_mc', 'rtm_pd', 'rvm_mc', 'rcm_mc', 'rcm_sd_mg_morr', 'thlm_bt', 'thlm_ma', 'thlm_ta', 'thlm_mfl', 'thlm_tacl', 'thlm_cl', 'thlm_forcing', 'thlm_sdmp','thlm_mc', 'thlm_old', 'thlm_without_ta', 'thlm_mfl_min', 'thlm_mfl_max', 'thlm_enter_mfl', 'thlm_exit_mfl', 'rtm_old', 'rtm_without_ta', 'rtm_mfl_min', 'rtm_mfl_max', 'rtm_enter_mfl', 'rtm_exit_mfl', 'um_bt', 'um_ma', 'um_gf', 'um_cf', 'um_ta', 'um_f', 'um_sdmp', 'um_ndg', 'vm_bt', 'vm_ma', 'vm_gf', 'vm_cf', 'vm_ta', 'vm_f', 'vm_sdmp', 'vm_ndg', 'wp3_bt', 'wp3_ma', 'wp3_ta', 'wp3_tp', 'wp3_ac', 'wp3_bp1', 'wp3_pr_turb', 'wp3_pr_dfsn', 'wp3_pr1', 'wp3_pr2', 'wp3_dp1', 'wp3_cl', 'mixt_frac', 'w_1', 'w_2', 'varnce_w_1', 'varnce_w_2', 'thl_1', 'thl_2', 'varnce_thl_1', 'varnce_thl_2', 'rt_1', 'rt_2', 'varnce_rt_1', 'varnce_rt_2', 'rc_1', 'rc_2', 'rsatl_1', 'rsatl_2', 'cloud_frac_1', 'cloud_frac_2', 'a3_coef_zt', 'wp3_on_wp2_zt', 'chi_1', 'chi_2', 'stdev_chi_1', 'stdev_chi_2', 'stdev_eta_1', 'stdev_eta_2', 'covar_chi_eta_1', 'covar_chi_eta_2', 'corr_chi_eta_1', 'corr_chi_eta_2', 'corr_rt_thl_1', 'crt_1', 'crt_2', 'cthl_1', 'cthl_2', 'precip_frac', 'precip_frac_1', 'precip_frac_2', 'Ncnm', 'wp2_zt', 'thlp2_zt', 'wpthlp_zt', 'wprtp_zt', 'rtp2_zt', 'rtpthlp_zt', 'up2_zt', 'vp2_zt', 'upwp_zt', 'vpwp_zt', 'C11_Skw_fnc'"
set clubb_vars_zm_list = "'wp2', 'rtp2', 'thlp2', 'rtpthlp', 'wprtp', 'wpthlp', 'wp4', 'up2', 'vp2', 'wpthvp', 'rtpthvp', 'thlpthvp', 'tau_zm', 'Kh_zm', 'wprcp', 'wm_zm', 'thlprcp', 'rtprcp', 'rcp2', 'upwp', 'vpwp', 'rho_zm', 'sigma_sqd_w', 'Skw_velocity', 'gamma_Skw_fnc', 'C6rt_Skw_fnc', 'C6thl_Skw_fnc', 'C7_Skw_fnc', 'C1_Skw_fnc', 'a3_coef', 'wp3_on_wp2', 'rcm_zm', 'rtm_zm', 'thlm_zm', 'cloud_frac_zm', 'rho_ds_zm', 'thv_ds_zm', 'em', 'mean_w_up', 'mean_w_down', 'shear', 'wp3_zm', 'Frad', 'Frad_LW', 'Frad_SW', 'Frad_LW_up', 'Frad_SW_up', 'Frad_LW_down', 'Frad_SW_down', 'Fprec', 'Fcsed', 'wp2_bt', 'wp2_ma', 'wp2_ta', 'wp2_ac', 'wp2_bp', 'wp2_pr1', 'wp2_pr2', 'wp2_pr3', 'wp2_dp1', 'wp2_dp2', 'wp2_cl', 'wp2_pd', 'wp2_sf', 'vp2_bt', 'vp2_ma', 'vp2_ta', 'vp2_tp', 'vp2_dp1', 'vp2_dp2', 'vp2_pr1', 'vp2_pr2', 'vp2_cl', 'vp2_pd', 'vp2_sf', 'up2_bt', 'up2_ma', 'up2_ta', 'up2_tp', 'up2_dp1', 'up2_dp2', 'up2_pr1', 'up2_pr2', 'up2_cl', 'up2_pd', 'up2_sf', 'wprtp_bt', 'wprtp_ma', 'wprtp_ta', 'wprtp_tp', 'wprtp_ac', 'wprtp_bp', 'wprtp_pr1', 'wprtp_pr2', 'wprtp_pr3', 'wprtp_dp1', 'wprtp_mfl', 'wprtp_cl', 'wprtp_sicl', 'wprtp_pd', 'wprtp_forcing', 'wprtp_mc', 'wpthlp_bt', 'wpthlp_ma', 'wpthlp_ta', 'wpthlp_tp', 'wpthlp_ac', 'wpthlp_bp', 'wpthlp_pr1', 'wpthlp_pr2', 'wpthlp_pr3', 'wpthlp_dp1', 'wpthlp_mfl', 'wpthlp_cl', 'wpthlp_sicl', 'wpthlp_forcing', 'wpthlp_mc', 'rtp2_bt', 'rtp2_ma', 'rtp2_ta', 'rtp2_tp', 'rtp2_dp1', 'rtp2_dp2', 'rtp2_cl', 'rtp2_pd', 'rtp2_sf', 'rtp2_forcing', 'rtp2_mc', 'thlp2_bt', 'thlp2_ma', 'thlp2_ta', 'thlp2_tp', 'thlp2_dp1', 'thlp2_dp2', 'thlp2_cl', 'thlp2_pd', 'thlp2_sf', 'thlp2_forcing', 'thlp2_mc', 'rtpthlp_bt', 'rtpthlp_ma', 'rtpthlp_ta', 'rtpthlp_tp1', 'rtpthlp_tp2', 'rtpthlp_dp1', 'rtpthlp_dp2', 'rtpthlp_cl', 'rtpthlp_sf', 'rtpthlp_forcing', 'rtpthlp_mc', 'wpthlp_entermfl', 'wpthlp_exit_mfl', 'wprtp_enter_mfl', 'wprtp_exit_mfl', 'wpthlp_mfl_min', 'wpthlp_mfl_max', 'wprtp_mfl_min', 'wprtp_mfl_max', 'Richardson_num', 'shear_sqd'"

### CUSTOM CASE_NAME
set case_name = ${machine}.${job_name}.${resolution}

### BUILD OPTIONS
set debug_compile  = false
set old_executable = false

### AUTOMATIC DELETION OPTIONS
set seconds_before_delete_source_dir = -1
set seconds_before_delete_case_dir   = 10
set seconds_before_delete_bld_dir    = -1
set seconds_before_delete_run_dir    = -1

### SUBMIT OPTIONS
set submit_run       = True
set debug_queue      = False

### PROCESSOR CONFIGURATION
set processor_config = 1

### STARTUP TYPE
set model_start_type = initial
set restart_files_dir = none

### DIRECTORIES
set code_root_dir               = default
set e3sm_simulations_dir        = /home/$USER/E3SM_simulations
set case_build_dir              = ${e3sm_simulations_dir}/${case_name}/build
set case_run_dir                = ${e3sm_simulations_dir}/${case_name}/run
set short_term_archive_root_dir = ${e3sm_simulations_dir}/${case_name}/archive

### LENGTH OF SIMULATION, RESTARTS, AND ARCHIVING
set stop_units                  = ndays
set stop_num                    = 1
set restart_units               = $stop_units
set restart_num                 = 6 #$stop_num
set num_resubmits               = 0
set do_short_term_archiving     = false

### SIMULATION OPTIONS
set atm_output_freq             = 0
set records_per_atm_output_file = 1
set start_date                  = default

### COUPLER HISTORY FILES
set do_cpl_hist    = false
set cpl_hist_units = nmonths
set cpl_hist_num   = 1

### Flag options
set do_turnoff_swrad = .false. # Turn off SW calculation
set do_turnoff_lwrad = .false. # Turn off LW calculation
set do_turnoff_precip = .false. # Turn off precipitation
set micro_nccons_val = 55.0D6 # cons_droplet value for liquid
set micro_nicons_val = 0.0001D6 # cons_droplet value for ice
set presc_aero_path = atm/cam/chem/trop_mam/aero
set presc_aero_file = mam4_0.9x1.2_L72_2000clim_c170323.nc

#==============================
#EXPLANATION FOR OPTIONS ABOVE:
#==============================

### BASIC INFO ABOUT RUN (1)

#job_name: This is only used to name the job in the batch system. The problem is that batch systems often only
#    provide the first few letters of the job name when reporting on jobs in the queue, which may not be enough
#    to distinguish simultaneous jobs.
#compset: indicates which model components and forcings to use. List choices by typing `create_newcase -list compsets`.
#    An (outdated?) list of options is available at http://www.cesm.ucar.edu/models/cesm1.0/cesm/cesm_doc_1_0_4/a3170.html
#resolution: Model resolution to use. Type `create_newcase -list grids` for a list of options or see
#    http://www.cesm.ucar.edu/models/cesm1.0/cesm/cesm_doc_1_0_4/a3714.htm. Note that E3SM always uses ne30 or ne120 in the atmosphere.
#machine: what machine you are going to run on. This should be 'default' for most machines, and only changed for machines with multiple queues, such as cori.
#    Valid machine names can also be listed via `create_newcase -list machines`
#walltime: How long to reserve the nodes for. The format is HH:MM(:SS); ie 00:10 -> 10 minutes.
#    Setting this to 'default' has the script determine a reasonable value for most runs.
#project: what bank to charge for your run time. May not be needed on some machines.
#    Setting this to 'default' has CIME determine what project to use
#    NOTE: project must be an *environment* variable on some systems.

### SOURCE CODE OPTIONS (2)

#fetch_code: If True, downloads code from github. If False, code is assumed to exist already.
#    NOTE: it is assumed that you have access to the E3SM git repository.  To get access, see:
#    https://acme-climate.atlassian.net/wiki/display/Docs/Installing+the+ACME+Model
#e3sm_tag: E3SM tagname in github. Can be 'master', a git hash, a tag, or a branch name. Only used if fetch_code=True.
#    NOTE: If e3sm_tag=master or master_detached, then this script will provide the latest master version, but detach from the head,
#          to minimize the risk of a user pushing something to master.
#tag_name: Short name for the E3SM branch used. If fetch_code=True, this is a shorter replacement for e3sm_tag
#    (which could be a very long hash!). Otherwise, this is a short name for the branch used. You can
#    choose TAG_NAME to be whatever you want.

### BUILD OPTIONS (3)

#debug_compile: If TRUE, then compile with debug flags
#    Compiling in debug mode will stop the run at the actual location an error occurs, and provide more helpful output.
#    However, it runs about 10 times slower, and is not bit-for-bit the same because some optimizations make tiny change to the
#    numerics.
#old_executable: If this is a path to an executable, then it is used instead of recompiling (it is copied across).
#    If TRUE then skip the build step entirely.
#    If FALSE then build a new executable (using any already compiled files). If you want a clean build then
#    set seconds_before_delete_bld_dir>=0.
#    NOTE: The executable that will be copied should be the same as would be created by compiling (for provenance).
#    NOTE: The path should either be an absolute path, or a path relative to the case_scripts directory.
#    NOTE: old_executable=true is a risk to provenance, so this feature may be removed in the future.
#          However the build system currently rebuilds a few files every time which takes several minutes.
#          When this gets fixed the cost of deleting this feature will be minor.


### AUTOMATIC DELETION OPTIONS (4)

#seconds_before_delete_source_dir : If seconds_before_delete_source_dir>=0 and fetch_code=true, this script automatically deletes
#    the old source code directory after waiting seconds_before_delete_source_dir seconds (to give you the opportunity to cancel
#    by pressing ctrl-C). To turn off the deletion (default behavior), set $num_seconds_before_deleting_source_dir to be negative.
#seconds_before_delete_case_dir : Similar to above, but remove the old case_scripts directory. Since create_newcase dies whenever
#    the case_scripts directory exists, it only makes sense to use $seconds_before_delete_case_dir<0 if you want to be extra careful and
#    only delete the case_scripts directory manually.
#seconds_before_delete_bld_dir : As above, but the old bld directory will be deleted.  This makes for a clean start.
#seconds_before_delete_run_dir : As above, but the old run directory will be deleted.  This makes for a clean start.

### SUBMIT OPTIONS (5)

#submit_run:  If True, then submit the batch job to start the simulation.
#debug_queue: If True, then use the debug queue, otherwise use the queue specified in the section on QUEUE OPTIONS.

### PROCESSOR CONFIGURATION (6)

#processor_config: Indicates what processor configuration to use.
#    1=single processor, S=small, M=medium, L=large, X1=very large, X2=very very large, CUSTOM=defined below.
#    The actual configurations for S,M,L,X1,X2 are dependent on the machine.

### STARTUP TYPE (7)

#model_start_type:  Specify how this script should initialize the model:  initial, continue, branch.
#    These options are not necessarily related to the CESM run_type options.
#    'initial' means the intial files will be copied into the run directory,
#    and the E3SM run_type can be 'initial', 'hybrid', or 'restart', as specified by this script below.
#    'continue' will do a standard restart, and assumes the restart files are already in the run directory.
#    'branch' is almost the same, but will set RUN_TYPE='branch', and other options as specified by this script below.
#    NOTE: To continue an existing simulation, it may be easier to edit env_run and [case].run manually in the
#    case_scripts directory.  The biggest difference is that doing it with this script
#    may delete the previous case_scripts directory, and will provide a way to pass a simulation to someone else.

### DIRECTORIES (8)

#code_root_dir: The directory that contains (or will contain) the source code and other code files. (formerly $CCSMROOT)
#     If fetch_code=false, this is the location where the code already resides.
#     If fetch_code=true, this is where to put the code.

### LENGTH OF SIMULATION, RESTARTS, AND ARCHIVING (9)

#stop_units: The units for the length of run, eg nhours, ndays, nmonths, nyears.
#stop_num: The simulation length for each batch submission, in units of $stop_units.
#restart_units: The units for how often restart files are written, eg nhours, ndays, nmonths, nyears.
#restart_num: How often restart files are written, in units of $restart_units.
#num_resubmits: After a batch job finishes successfully, a new batch job will automatically be submitted to
#    continue the simulation.  num_resubmits is the number of times to submit after initial completion.
#    After the first submission, the CONTINUE_RUN flage in env_run.xml will be changed to TRUE.
#do_short_term_archiving: If TRUE, then move simulation output to the archive directory in your scratch directory.

### SIMULATION OPTIONS (10)

#atm_output_freq (the namelist variable is nhtfrq) : The frequency with which the atmosphere writes its output.
#    0=monthly, +N=every N timesteps,  -N=every N hours
#    For more information:   http://www.cesm.ucar.edu/models/atm-cam/docs/usersguide/node45.html
#records_per_atm_output_file (the namelist variable is mfilt):  The number of time records in each netCDF output file
#    from the atmosphere model. If atm_output_freq=0, then there will only be one time record per file.
#NOTE: If there will be more than one 'history tape' defined in the atm namelist, then
#    atm_output_freq and records_per_atm_output_file should be a comma-separated list of numbers
#    (specifying the option for each history tape).
#start_date: The day that the simulation starts

### GENERAL NOTES:

# 1. capitalization doesn't matter on most of the variables above because we lowercase variables before using them.
# 2. most of the code below does things you probably never want to change. However, users will often make settings
#    in the "USER_NL" and "RUN CONFIGURATION OPTIONS" sections below.

### PROGRAMMING GUIDELINES
#
# +) The exit error numbers are sequential through the code:
#        0-099 are before create_newcase
#      100-199 are between create_newcase and cesm_setup
#      200-299 are between cesm_setup and case_scripts.build
#      300-399 are between case_scripts.build and case_scripts.submit
#      400-499 are after case_scripts.submit
#    If this script dies, then print out the exit code.
#    (in csh: use 'echo $status' immediatedly after the script exits)

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#  END OF COMMON OPTIONS - you may need to change things below here to access advanced
#  capabilities, but if you do you should know what you're doing.
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

#===========================================
# VERSION OF THIS SCRIPT
#===========================================
set script_ver = 3.0.22

#===========================================
# DEFINE ALIASES
#===========================================

alias lowercase "echo \!:1 | tr '[A-Z]' '[a-z]'"  #make function which lowercases any strings passed to it.
alias uppercase "echo \!:1 | tr '[a-z]' '[A-Z]'"  #make function which uppercases any strings passed to it.

alias e3sm_print 'echo run_e3sm: \!*'
alias e3sm_newline "echo ''"

#===========================================
# ALERT THE USER IF THEY TRY TO PASS ARGUMENTS
#===========================================
set first_argument = $1
if ( $first_argument != '' ) then
 echo 'This script does everything needed to configure/compile/run a case. As such, it'
 echo 'provides complete provenance for each run and makes sharing simulation configurations easy.'
 echo 'Users should make sure that everything required for a run is in this script, the E3SM'
 echo 'git repo, and/or the inputdata svn repo.'
 echo '** This script accepts no arguments. Please edit the script as needed and resubmit without arguments. **'
 exit 5
endif

e3sm_newline
e3sm_print '++++++++ run_e3sm starting ('`date`'), version '$script_ver' ++++++++'
e3sm_newline

#===========================================
# DETERMINE THE LOCATION AND NAME OF THE SCRIPT
#===========================================

# NOTE: CIME 5 and git commands are not cwd agnostic, so compute the absolute paths, then cd to the directories as needed
set this_script_name = `basename $0`
set relative_dir = `dirname $0`
set this_script_dir = `cd $relative_dir ; pwd -P`
set this_script_path = $this_script_dir/$this_script_name

#===========================================
# SETUP DEFAULTS
#===========================================

if ( `lowercase $code_root_dir` == default ) then
  set code_root_dir = `cd $this_script_dir/..; pwd -P`
endif

if ( `lowercase $tag_name` == default ) then
  set pwd_temp       = `pwd`
  set tag_name       = ${pwd_temp:t}
  e3sm_print '$tag_name = '$tag_name
endif

#===========================================
# BASIC ERROR CHECKING
#===========================================

set seconds_after_warning = 10

if ( `lowercase $old_executable` == true ) then
  if ( $seconds_before_delete_source_dir >= 0 ) then
    e3sm_newline
    e3sm_print 'ERROR: It is unlikely that you want to delete the source code and then use the existing compiled executable.'
    e3sm_print '       Hence, this script will abort to avoid making a mistake.'
    e3sm_print '       $seconds_before_delete_source_dir = '$seconds_before_delete_source_dir'      $old_executable = '$old_executable
    exit 11
  endif

  if ( $seconds_before_delete_bld_dir >= 0 ) then
    e3sm_newline
    e3sm_print 'ERROR: It makes no sense to delete the source-compiled code and then use the existing compiled executable.'
    e3sm_print '       Hence, this script will abort to avoid making a mistake.'
    e3sm_print '       $seconds_before_delete_bld_dir = '$seconds_before_delete_bld_dir'      $old_executable = '$old_executable
    exit 12
  endif
endif

if ( `lowercase $case_build_dir` == default && $seconds_before_delete_bld_dir >= 0 ) then
  e3sm_print 'ERROR: run_e3sm cannot delete the build directory when CIME chooses it'
  e3sm_print '       To remedy this, either set $case_build_dir to the path of the executables or disable deleting the directory'
  exit 14
endif

if ( `lowercase $case_run_dir` == default && $seconds_before_delete_run_dir >= 0 ) then
  e3sm_print 'ERROR: run_e3sm cannot delete the run directory when CIME chooses it'
  e3sm_print '       To remedy this, either set $case_run_dir to the path of the executables or disable deleting the directory'
  exit 15
endif

if ( `lowercase $debug_queue` == true && ( $num_resubmits >= 1 || `lowercase $do_short_term_archiving` == true ) ) then
  e3sm_print 'ERROR: Supercomputer centers generally do not allow job chaining in debug queues'
  e3sm_print '       You should either use a different queue, or submit a single job without archiving.'
  e3sm_print '       $debug_queue             = '$debug_queue
  e3sm_print '       $num_resubmits           = '$num_resubmits
  e3sm_print '       $do_short_term_archiving = '$do_short_term_archiving
  exit 16
endif

if ( $restart_num != 0 ) then
  @ remaining_periods = $stop_num - ( $stop_num / $restart_num ) * $restart_num
  if ( $num_resubmits >= 1 && ( $stop_units != $restart_units || $remaining_periods != 0 ) ) then
    e3sm_print 'WARNING: run length is not divisible by the restart write frequency, or the units differ.'
    e3sm_print 'If restart write frequency doesnt evenly divide the run length, restarts will simulate the same time period multiple times.'
    e3sm_print '         $stop_units        = '$stop_units
    e3sm_print '         $stop_num          = '$stop_num
    e3sm_print '         $restart_units     = '$restart_units
    e3sm_print '         $restart_num       = '$restart_num
    e3sm_print '         $remaining_periods = '$remaining_periods
    e3sm_print '         $num_resubmits     = '$num_resubmits
    sleep $seconds_after_warning
  endif
endif

#===========================================
# DOWNLOAD SOURCE CODE IF NEEDED:
#===========================================

### NOTE: you must be setup with access to the E3SM repository before you can clone the repository. For access, see
###       https://acme-climate.atlassian.net/wiki/display/Docs/Installing+the+ACME+Model

if ( `lowercase $fetch_code` == true ) then
  e3sm_print 'Downloading code from the E3SM git repository.'
  if ( -d $code_root_dir/$tag_name ) then
    if ( $seconds_before_delete_source_dir >= 0 ) then
      set num_seconds_until_delete = $seconds_before_delete_source_dir
      e3sm_print 'Removing old code directory '$code_root_dir/$tag_name' in '$num_seconds_until_delete' seconds.'
      e3sm_print 'To abort, press ctrl-C'
      while ( ${num_seconds_until_delete} > 0 )
         e3sm_print ' '${num_seconds_until_delete}'  seconds until deletion.'
         sleep 1
         @ num_seconds_until_delete = ${num_seconds_until_delete} - 1
      end
      rm -fr $code_root_dir/$tag_name
      e3sm_print 'Deleted '$code_root_dir/$tag_name
    else
      e3sm_print 'ERROR: Your branch tag already exists, so dying instead of overwriting.'
      e3sm_print '          You likely want to either set fetch_code=false, change $tag_name, or'
      e3sm_print '          change seconds_before_delete_source_dir.'
      e3sm_print '          Note: $fetch_code = '$fetch_code
      e3sm_print '                $code_root_dir/$tag_name = '$code_root_dir/$tag_name
      e3sm_print '                $seconds_before_delete_source_dir = '$seconds_before_delete_source_dir
      exit 20
    endif #$seconds_before_delete_source_dir >=0
  endif #$code_root_dir exists

  e3sm_print 'Cloning repository into $tag_name = '$tag_name'  under $code_root_dir = '$code_root_dir
  mkdir -p $code_root_dir
  git clone git@github.com:ACME-Climate/ACME.git $code_root_dir/$tag_name     # This will put repository, with all code, in directory $tag_name
  ## Setup git hooks
  rm -rf $code_root_dir/$tag_name/.git/hooks
  git clone git@github.com:ACME-Climate/ACME-Hooks.git $code_root_dir/$tag_name/.git/hooks         # checkout with write permission.
#  git clone git://github.com/ACME-Climate/ACME-Hooks.git .git/hooks      # checkout read-only.
  cd $code_root_dir/$tag_name
  git config commit.template $code_root_dir/$tag_name/.git/hooks/commit.template
  ## Bring in MPAS ocean/ice repo
  git submodule update --init

  if ( `lowercase $e3sm_tag` == master ) then
    e3sm_newline
    ##e3sm_print 'Detaching from the master branch to avoid accidental changes to master by user.'
    ##git checkout --detach
    echo 'KLUDGE: git version on anvil (1.7.1) is too old to be able to detach'
    echo 'edison uses git version 1.8.5.6 and it can git checkout --detach'
  else
    e3sm_newline
    e3sm_print 'Checking out branch ${e3sm_tag} = '${e3sm_tag}
    git checkout ${e3sm_tag}
  endif

endif

e3sm_newline
e3sm_print '$case_name        = '$case_name

#============================================
# DETERMINE THE SCRATCH DIRECTORY TO USE
#============================================

if ( $e3sm_simulations_dir == default ) then
  ### NOTE: csh doesn't short-circuit; so we can't check whether $SCRATCH exists or whether it's empty in the same condition
  if ( ! $?SCRATCH ) then
    e3sm_newline
    e3sm_print 'WARNING: Performing science runs while storing run output in your home directory is likely to exceed your quota'
    e3sm_print '         To avoid any issues, set $e3sm_simulations_dir to a scratch filesystem'
    set e3sm_simulations_dir = ${HOME}/E3SM_simulations
  else
    ### Verify that $SCRATCH is not an empty string
    if ( "${SCRATCH}" == "" ) then
      set e3sm_simulations_dir = ${HOME}/E3SM_simulations
      e3sm_newline
      e3sm_print 'WARNING: Performing science runs while storing run output in your home directory is likely to exceed your quota'
      e3sm_print '         To avoid any issues, set $e3sm_simulations_dir to a scratch filesystem'
    else
      set e3sm_simulations_dir = ${SCRATCH}/E3SM_simulations
    endif
  endif
endif

#============================================
# DELETE PREVIOUS DIRECTORIES (IF REQUESTED)
#============================================
### Determine the case_scripts directory
### Remove existing case_scripts directory (so it doesn't have to be done manually every time)
### Note: This script causes create_newcase to generate a temporary directory (part of a workaround to put the case_name into the script names)
###       If something goes wrong, this temporary directory is sometimes left behind, so we need to delete it too.
### Note: To turn off the deletion, set $num_seconds_until_delete to be negative.
###       To delete immediately, set $num_seconds_until_delete to be zero.

set case_scripts_dir = ${e3sm_simulations_dir}/${case_name}/case_scripts

cd $code_root_dir/$tag_name 
set DATE = `date +%F | sed 's/-//g'``date +%T | sed 's/://g'`
git diff  components/ > diff.$job_name.$DATE.asc
git diff  *.csh > diff_script.$job_name.$DATE.asc
git log > log.$job_name.$DATE.asc
#cd components/clm/src/external_models/mpp
#git diff  > $code_root_dir/$tag_name/diff_clm.$job_name.$DATE.asc
#cd $code_root_dir/$tag_name

if ( -d $case_scripts_dir ) then
  if ( ${seconds_before_delete_case_dir} >= 0 ) then
    set num_seconds_until_delete = $seconds_before_delete_case_dir
    e3sm_newline
    e3sm_print 'Removing old $case_scripts_dir directory for '${case_name}' in '${num_seconds_until_delete}' seconds.'
    e3sm_print 'To abort, press ctrl-C'
    while ( ${num_seconds_until_delete} > 0 )
      e3sm_print ' '${num_seconds_until_delete}'  seconds until deletion.'
      sleep 1
      @ num_seconds_until_delete = ${num_seconds_until_delete} - 1
    end
    rm -fr $case_scripts_dir
    e3sm_print ' Deleted $case_scripts_dir directory for : '${case_name}
  else
    e3sm_print 'WARNING: $case_scripts_dir='$case_scripts_dir' exists '
    e3sm_print '         and is not being removed because seconds_before_delete_case_dir<0.'
    e3sm_print '         But create_newcase always fails when the case directory exists, so this script will now abort.'
    e3sm_print '         To fix this, either delete the case_scripts directory manually, or change seconds_before_delete_case_dir'
    exit 35
  endif
endif

### Remove existing build directory (to force a clean compile).  This is good for a new run, but not usually necessary while developing.

if ( `lowercase $case_build_dir` != default && -d $case_build_dir ) then
  if ( ${seconds_before_delete_bld_dir} >= 0 ) then
    set num_seconds_until_delete = $seconds_before_delete_bld_dir
    e3sm_newline
    e3sm_print 'Removing old $case_build_dir directory for '${case_name}' in '${num_seconds_until_delete}' seconds.'
    e3sm_print 'To abort, press ctrl-C'
    while ( ${num_seconds_until_delete} > 0 )
      e3sm_print ' '${num_seconds_until_delete}'  seconds until deletion.'
      sleep 1
      @ num_seconds_until_delete = ${num_seconds_until_delete} - 1
    end
    rm -fr $case_build_dir
    e3sm_print ' Deleted $case_build_dir directory for '${case_name}
  else
    e3sm_print 'NOTE: $case_build_dir='$case_build_dir' exists '
    e3sm_print '      and is not being removed because seconds_before_delete_bld_dir<0.'
  endif
endif

### Remove existing run directory (for a clean start).  This is good for a new run, but often not usually necessary while developing.

if ( `lowercase $case_run_dir` != default &&  -d $case_run_dir ) then
  if ( ${seconds_before_delete_run_dir} >= 0 ) then
    set num_seconds_until_delete = $seconds_before_delete_run_dir
    e3sm_newline
    e3sm_print 'Removing old $case_run_dir directory for '${case_name}' in '${num_seconds_until_delete}' seconds.'
    e3sm_print 'To abort, press ctrl-C'
    while ( ${num_seconds_until_delete} > 0 )
     e3sm_print ' '${num_seconds_until_delete}'  seconds until deletion.'
     sleep 1
     @ num_seconds_until_delete = ${num_seconds_until_delete} - 1
    end
    rm -fr $case_run_dir
    e3sm_print ' Deleted $case_run_dir directory for '${case_name}
  else
    e3sm_print 'NOTE: $case_run_dir='$case_run_dir' exists '
    e3sm_print '      and is not being removed because seconds_before_delete_run_dir<0.'
  endif
endif

#=============================================================
# HANDLE STANDARD PROCESSOR CONFIGURATIONS
#=============================================================
# NOTE: Some standard PE configurations are available (S,M,L,X1,X2).
#       If the requested configuration is 1 or CUSTOM, then set to M here, and handle later.

set lower_case = `lowercase $processor_config`
switch ( $lower_case )
  case 's':
    set std_proc_configuration = 'S'
    breaksw
  case 'm':
    set std_proc_configuration = 'M'
    breaksw
  case 'l':
    set std_proc_configuration = 'L'
    breaksw
  case 'x1':
    set std_proc_configuration = 'X1'
    breaksw
  case 'x2':
    set std_proc_configuration = 'X2'
    breaksw
  case '1':
    set std_proc_configuration = 'M'
    breaksw
  case 'custom*':
    # Note: this is just a placeholder so create_newcase will work.
    #       The actual configuration should be set under 'CUSTOMIZE PROCESSOR CONFIGURATION'
    set std_proc_configuration = 'M'
    breaksw
  default:
    e3sm_print 'ERROR: $processor_config='$processor_config' is not recognized'
    exit 40
    breaksw
endsw

#================================================================================
# MAKE FILES AND DIRECTORIES CREATED BY THIS SCRIPT READABLE BY EVERYONE IN GROUP
#================================================================================
# Note:  we also want to change the group id for the files.
#        But this can only be done once the run_root_dir has been created,
#        so it is done later.
umask 022

set cime_dir = ${code_root_dir}/${tag_name}/cime
set create_newcase_exe = $cime_dir/scripts/create_newcase
if ( -f ${create_newcase_exe} ) then
  set e3sm_exe = e3sm.exe
  set case_setup_exe = $case_scripts_dir/case.setup
  set case_build_exe = $case_scripts_dir/case.build
  set case_run_exe = $case_scripts_dir/.case.run
  set case_submit_exe = $case_scripts_dir/case.submit
  set xmlchange_exe = $case_scripts_dir/xmlchange
  set xmlquery_exe = $case_scripts_dir/xmlquery
  set shortterm_archive_script = $case_scripts_dir/case.st_archive
  set preview_namelists_exe = $case_scripts_dir/preview_namelists
else                                                                   # No version of create_newcase found
  e3sm_print 'ERROR: ${create_newcase_exe} not found'
  e3sm_print '       This is most likely because fetch_code should be true.'
  e3sm_print '       At the moment, $fetch_code = '$fetch_code
  exit 45
endif

#=============================================================
# DETERMINE THE OPTIONS FOR CREATE_NEWCASE
#=============================================================

set configure_options = "--case ${case_name} --compset ${compset} --script-root ${case_scripts_dir} --res ${resolution} --pecount ${std_proc_configuration} --handle-preexisting-dirs u"

if ( `lowercase $machine` != default ) then
  set configure_options = "${configure_options} --mach ${machine}"
endif

if ( `lowercase $case_build_dir` == default ) then
  set case_build_dir = ${e3sm_simulations_dir}/${case_name}/build
endif

if ( `lowercase $case_run_dir` == default ) then
  set case_run_dir = ${e3sm_simulations_dir}/${case_name}/run
endif

# Default group and permissions on NERSC can be a pain for sharing data
# within the project. This should take care of it. Create top level 
# directory and set the default group to 'acme', permissions for 
# group read access for top level and all files underneath (Chris Golaz).
if ( $machine == 'cori*' || $machine == 'edison' ) then
  mkdir -p ${e3sm_simulations_dir}/${case_name}
  cd ${e3sm_simulations_dir}
  chgrp acme ${case_name}
  chmod 750 ${case_name}
  chmod g+s ${case_name}
  setfacl -d -m g::rx ${case_name}
endif

mkdir -p ${case_build_dir}
set build_root = `cd ${case_build_dir}/..; pwd -P`
mkdir -p ${case_run_dir}
set run_root = `cd ${case_run_dir}/..; pwd -P`

if ( ${build_root} == ${run_root} ) then
  set configure_options = "${configure_options} --output-root ${build_root}"
endif

if ( `lowercase $project` == default ) then
  unsetenv project
else
  set configure_options = "${configure_options} --project ${project}"
endif

#=============================================================
# CREATE CASE_SCRIPTS DIRECTORY AND POPULATE WITH NEEDED FILES
#=============================================================

e3sm_newline
e3sm_print '-------- Starting create_newcase --------'
e3sm_newline

e3sm_print ${create_newcase_exe} ${configure_options}
${create_newcase_exe} ${configure_options}

cd ${case_scripts_dir}

e3sm_newline
e3sm_print '-------- Finished create_newcase --------'
e3sm_newline

#================================================
# UPDATE VARIABLES WHICH REQUIRE A CASE TO BE SET
#================================================

if ( `lowercase $machine` == default ) then
  set machine = `$xmlquery_exe MACH --value`
endif
# machine is a commonly used variable; so make certain it's lowercase
set machine = `lowercase $machine`

if ( `lowercase $case_build_dir` == default ) then
  set case_build_dir = ${e3sm_simulations_dir}/${case_name}/bld
endif
${xmlchange_exe} EXEROOT=${case_build_dir}

if ( `lowercase $case_run_dir` == default ) then
  set case_run_dir = ${case_scripts_dir}/${case_name}/run
endif
${xmlchange_exe} RUNDIR=${case_run_dir}

if ( ! $?project ) then
  setenv project `$xmlquery_exe PROJECT --subgroup case.run --value`
else
  if ( $project == "" ) then
    setenv project `$xmlquery_exe PROJECT --subgroup case.run --value`
  endif
endif

e3sm_print "Project used for submission: ${project}"

#================================
# SET WALLTIME FOR CREATE_NEWCASE
#================================

if ( `lowercase $walltime` == default ) then
  if ( `lowercase $debug_queue` == true ) then
    set walltime = '0:30:00'
  else
    if ( $machine == 'quartz' || $machine == 'syrah' ) then
      set walltime = '1:29:00'
    else
      set walltime = '2:00:00'
    endif
  endif
endif

# Allow the user to specify how long the job taks
$xmlchange_exe JOB_WALLCLOCK_TIME=$walltime
#$xmlchange_exe PROJECT="condo" ,CHARGE_ACCOUNT="condo"
#$xmlchange_exe -file env_run.xml -id SAVE_TIMING_DIR -val $HOME
#$xmlchange_exe -file env_workflow.xml -id JOB_QUEUE -val 'acme-medium'
#$xmlchange_exe -file env_workflow.xml -subgroup case.run 
#$xmlchange_exe SAVE_TIMING="FALSE"

#================================
# SET THE STARTDATE FOR THE SIMULATION
#================================

if ( `lowercase $start_date` != 'default' ) then
  $xmlchange_exe RUN_STARTDATE=$start_date
endif

#NOTE: Details of the configuration setup by create_newcase are in $case_scripts_dir/env_case.xml, which should NOT be edited.
#      It will be used by cesm_setup (formerly 'configure -case').
#NOTE: To get verbose output from create_newcase, add '-v' to the argument list.

#============================================================
#COPY STUFF TO SourceMods IF NEEDED:
#============================================================
#note: SourceMods is a horrible thing to do from a provenance perspective
#      it is much better to make changes to the code and to put those changes
#      into a git branch, which you then check out to do your run. Nonetheless,
#      it is useful for debugging so here's an example of how to use it...

#echo 'KLUDGE: Putting streams.ocean in SourceMods'
#cp /global/u1/p/petercal/junk/streams.ocean $case_scripts_dir/SourceMods/src.mpaso/

#============================================================
# COPY THIS SCRIPT TO THE CASE DIRECTORY TO ENSURE PROVENANCE
#============================================================

set script_provenance_dir  = $case_scripts_dir/run_script_provenance
set script_provenance_name = $this_script_name.`date +%F_%T_%Z`
mkdir -p $script_provenance_dir
cp -f $this_script_path $script_provenance_dir/$script_provenance_name
mv $code_root_dir/$tag_name/diff.$job_name.$DATE.asc $case_run_dir/.
mv $code_root_dir/$tag_name/diff_script.$job_name.$DATE.asc $case_run_dir/.
mv $code_root_dir/$tag_name/log.$job_name.$DATE.asc $case_run_dir/.


#=============================================
# CUSTOMIZE PROCESSOR CONFIGURATION
# ============================================
#NOTE: Changes to the processor configuration should be done by an expert.  \
#      Not all possible options will work.

if ( `lowercase $processor_config` == '1' ) then

  set ntasks = 1
  set nthrds = 1
  set sequential_or_concurrent = 'sequential'
  foreach ntasks_name ( NTASKS_ATM  NTASKS_LND  NTASKS_ICE  NTASKS_OCN  NTASKS_CPL  NTASKS_GLC  NTASKS_ROF  NTASKS_WAV )
    $xmlchange_exe --id $ntasks_name --val $ntasks
  end

  foreach nthrds_name ( NTHRDS_ATM  NTHRDS_LND  NTHRDS_ICE  NTHRDS_OCN  NTHRDS_CPL  NTHRDS_GLC  NTHRDS_ROF  NTHRDS_WAV )
    $xmlchange_exe --id $nthrds_name --val $nthrds
  end

  foreach rootpe_name ( ROOTPE_ATM  ROOTPE_LND  ROOTPE_ICE  ROOTPE_OCN  ROOTPE_CPL  ROOTPE_GLC  ROOTPE_ROF  ROOTPE_WAV )
    $xmlchange_exe --id $rootpe_name --val 0
  end

  foreach layout_name ( NINST_ATM_LAYOUT NINST_LND_LAYOUT NINST_ICE_LAYOUT NINST_OCN_LAYOUT NINST_GLC_LAYOUT NINST_ROF_LAYOUT NINST_WAV_LAYOUT )
    $xmlchange_exe --id $layout_name --val $sequential_or_concurrent
  end

else if ( `lowercase $processor_config` == 'customknl' ) then

  e3sm_print 'using custom layout for cori-knl because $processor_config = '$processor_config

  ${xmlchange_exe} MAX_TASKS_PER_NODE="64"
  ${xmlchange_exe} PES_PER_NODE="256"

  ${xmlchange_exe} NTASKS_ATM="5400"
  ${xmlchange_exe} ROOTPE_ATM="0"

  ${xmlchange_exe} NTASKS_LND="320"
  ${xmlchange_exe} ROOTPE_LND="5120"

  ${xmlchange_exe} NTASKS_ICE="5120"
  ${xmlchange_exe} ROOTPE_ICE="0"

  ${xmlchange_exe} NTASKS_OCN="3840"
  ${xmlchange_exe} ROOTPE_OCN="5440"

  ${xmlchange_exe} NTASKS_CPL="5120"
  ${xmlchange_exe} ROOTPE_CPL="0"

  ${xmlchange_exe} NTASKS_GLC="320"
  ${xmlchange_exe} ROOTPE_GLC="5120"

  ${xmlchange_exe} NTASKS_ROF="320"
  ${xmlchange_exe} ROOTPE_ROF="5120"

  ${xmlchange_exe} NTASKS_WAV="5120"
  ${xmlchange_exe} ROOTPE_WAV="0"

  ${xmlchange_exe} NTHRDS_ATM="1"
  ${xmlchange_exe} NTHRDS_LND="1"
  ${xmlchange_exe} NTHRDS_ICE="1"
  ${xmlchange_exe} NTHRDS_OCN="1"
  ${xmlchange_exe} NTHRDS_CPL="1"
  ${xmlchange_exe} NTHRDS_GLC="1"
  ${xmlchange_exe} NTHRDS_ROF="1"
  ${xmlchange_exe} NTHRDS_WAV="1"

endif

#============================================
# SET PARALLEL I/O (PIO) SETTINGS
#============================================
#Having bad PIO_NUMTASKS and PIO_STRIDE values can wreck performance
#See https://acme-climate.atlassian.net/wiki/display/ATM/How+to+Create+a+New+PE+Layout

#$xmlchange_exe -file env_run.xml -id PIO_NUMTASKS -val 128

#============================================
# COMPONENT CONFIGURATION OPTIONS
#============================================

#NOTE:  This section is for making specific component configuration selections.
#NOTE:  Setting CAM_CONFIG_OPTS will REPLACE anything set by the build system.
#       To add on instead, add '-append' to the xmlchange command.
#NOTE:  CAM_NAMELIST_OPTS should NOT be used.  Instead, use the user_nl section after case_scripts.build

#$xmlchange_exe --id CAM_CONFIG_OPTS --val "-phys cam5 -chem linoz_mam3"

## Chris Golaz: build with COSP
#NOTE: The xmlchange will fail if CAM is not active, so test whether a data atmosphere (datm) is used.

./xmlchange --id DIN_LOC_ROOT --val "${input_data_dir}"

if ( `$xmlquery_exe --value COMP_ATM` == 'datm'  ) then 
  e3sm_newline
  e3sm_print 'The specified configuration uses a data atmosphere, so cannot activate COSP simulator.'
  e3sm_newline
else
  e3sm_newline
  e3sm_print 'Configuring E3SM to use the COSP simulator.'
  e3sm_newline
#  $xmlchange_exe --id CAM_CONFIG_OPTS --append --val='-e3smreplay'
endif

# For e3smreplay, let init_aero_type be a configure option
if ($init_aero_type == cons_droplet || $init_aero_type == none) then
#    $xmlchange_exe --id CAM_CONFIG_OPTS --append --val='-chem linoz_mam4_resus_mom_soag -rain_evap_to_coarse_aero -bc_dep_to_snow_updates'
#$xmlchange_exe --id CAM_CONFIG_OPTS --append --val="-dyn se -phys cam5 -clubb_sgs -rad rrtmg -chem linoz_mam4_resus_mom_soag -rain_evap_to_coarse_aero -bc_dep_to_snow_updates -silent -nlev 72 -microphys mg$MGVER  -psubcols $NUMSC -cppdefs '-DUWM_MISC -DSILHS'"
#$xmlchange_exe --id CAM_CONFIG_OPTS --append --val="-dyn se -phys cam5 -nadv 29 -clubb_sgs -rad rrtmg -chem trop_mam3 -silent -nlev 72 -microphys mg$MGVER  -psubcols $NUMSC -cppdefs '-DUWM_MISC -DSILHS'"
endif

if ($init_aero_type == prescribed || $init_aero_type == observed) then
    $xmlchange_exe --id CAM_CONFIG_OPTS --append --val='$CAM_CONFIG_OPTS -chem none'
endif

#set  CAM_CONFIG_OPTS="-dyn se -phys cam5 -silent "
set  CAM_CONFIG_OPTS=" -silent "

#$xmlchange_exe --id CAM_CONFIG_OPTS --append --val="-nadv 40  -clubb_sgs -rad rrtmg -chem linoz_mam4_resus_mom_soag -rain_evap_to_coarse_aero -bc_dep_to_snow_updates -microphys mg$MGVER  -psubcols $NUMSC -cppdefs '-DUWM_MISC -DSILHS'"

$xmlchange_exe --id CAM_CONFIG_OPTS --append --val="-nadv 40  -clubb_sgs -rad rrtmg -chem linoz_mam4_resus_mom_soag -rain_evap_to_coarse_aero -microphys mg$MGVER  -psubcols $NUMSC -cppdefs '-DUWM_MISC -DSILHS'"

#$xmlchange_exe --id CAM_CONFIG_OPTS --append --val="-nadv 40  -psubcols $NUMSC -cppdefs '-DUWM_MISC -DSILHS'"

#$xmlchange_exe --id CAM_CONFIG_OPTS --append --val="-nadv 40  -clubb_sgs -rad rrtmg -chem linoz_mam4_resus_mom_soag -rain_evap_to_coarse_aero -microphys mg$MGVER  -cppdefs '-DUWM_MISC'"  

#===========================
# SET THE PARTITION OF NODES
#===========================

if ( `lowercase $debug_queue` == true ) then
  if ( $machine == quartz || $machine == syrah ) then
    $xmlchange_exe --id JOB_QUEUE --val 'pdebug'
  else if ($machine != sandiatoss3 && $machine != bebop && $machine != blues) then
    $xmlchange_exe --id JOB_QUEUE --val 'debug'
  endif
endif

#============================================
# CONFIGURE
#============================================

#note configure -case turned into cesm_setup in cam5.2

e3sm_newline
e3sm_print '-------- Starting case.setup --------'
e3sm_newline

e3sm_print ${case_setup_exe}

${case_setup_exe} --reset

e3sm_newline
e3sm_print '-------- Finished case.setup  --------'
e3sm_newline

#============================================================
#MAKE GROUP PERMISSIONS to $PROJECT FOR THIS DIRECTORY
#============================================================
#this stuff, combined with the umask command above, makes
#stuff in $run_root_dir readable by everyone in e3sm group.

set run_root_dir = `cd $case_run_dir/..; pwd -P`

#both run_root_dir and case_scripts_dir are created by create_newcase,
#so run_root_dir group isn't inherited for case_scripts_dir

#========================================================
# CREATE LOGICAL LINKS BETWEEN RUN_ROOT & THIS_SCRIPT_DIR
#========================================================

#NOTE: This is to make it easy for the user to cd to the case directory
#NOTE: Starting the suffix wit 'a' helps to keep this near the script in ls
#      (but in practice the behavior depends on the LC_COLLATE system variable).

e3sm_print 'Creating logical links to make navigating easier.'
e3sm_print 'Note: Beware of using ".." with the links, since the behavior of shell commands can vary.'

# Customizations from Chris Golaz
# Link in this_script_dir case_dir
set run_dir_link = $this_script_dir/$this_script_name=a_run_link

e3sm_print ${run_dir_link}

if ( -l $run_dir_link ) then
  rm -f $run_dir_link
endif
e3sm_print "run_root ${run_root_dir}"
e3sm_print "run_dir ${run_dir_link}"

ln -s $run_root_dir $run_dir_link

#============================================
# SET BUILD OPTIONS
#============================================

if ( `uppercase $debug_compile` != 'TRUE' && `uppercase $debug_compile` != 'FALSE' ) then
  e3sm_print 'ERROR: $debug_compile can be true or false but is instead '$debug_compile
  exit 220
endif

if ( $machine == 'edison' && `uppercase $debug_compile` == 'TRUE' ) then
  e3sm_print 'ERROR: Edison currently has a compiler bug and crashes when compiling in debug mode (Nov 2015)'
  exit 222
endif

$xmlchange_exe --id DEBUG --val `uppercase $debug_compile`

#Modify/uncomment the next line to change the number of processors used to compile.
#$xmlchange_exe --id GMAKE_J --val 4

#=============================================
# CREATE NAMELIST MODIFICATION FILES (USER_NL)
#=============================================

# Append desired changes to the default namelists generated by the build process.
#
# NOTE: It doesn't matter which namelist an option is in for any given component, the system will sort it out.
# NOTE: The user_nl files need to be set before the build, because case_scripts.build checks whether input files exist.
# NOTE: $atm_output_freq and $records_per_atm_output_file are so commonly used, that they are set in the options at the top of this script.

$xmlchange_exe  -file env_run.xml -id  CAM_NML_USE_CASE -val '2000_cam5_av1c-04p2_gust'
#$xmlchange_exe  ATM_NCPL='96'

cat <<EOF >> user_nl_elm
! finidat=''
EOF

cat <<EOF >> user_nl_docn
! finidat=''
EOF

cat <<EOF >> user_nl_cpl
! finidat=''
EOF

cat <<EOF >> user_nl_cam 
! clubb_ice_deep = 25.e-7 ! -6
! clubb_ice_sh = 50.e-7
! clubb_liq_deep = 8.e-7
! clubb_liq_sh = 10.e-7
!clubb_l_trapezoidal_rule_zm = .false.
!clubb_l_trapezoidal_rule_zt = .false.
!clubb_l_call_pdf_closure_twice = .true.
state_debug_checks=.true.
clubb_do_icesuper= .false.
clubb_beta             = 2.
clubb_c1               = 1.0
clubb_c11              = .5
clubb_c11b             = .5
clubb_c11c             = 0.85
clubb_c14              = 1.0
clubb_c_wp3_pr_turb    = 1
clubb_c1b              = 1.0
clubb_c1c              = 0.75
clubb_c2rt             = 1
clubb_c2rtthl          = 1
clubb_c2thl            = 1
clubb_c4               = 1
clubb_c_uu_shr         = 0
clubb_c_uu_buoy        = 0
clubb_c6rt             = 1
clubb_c6rtb            = 1
clubb_c6rtc            = 0.50
clubb_c6thlb           = 1
clubb_c6thlc           = 0.50
clubb_c7               = 0.7
clubb_c7b              = 0.7
clubb_c8               = 0.5
history_amwg = .true.
history_budget = .true.
clubb_history = .true.
clubb_rad_history = .false.
clubb_vars_zt = $clubb_vars_zt_list
clubb_vars_zm = $clubb_vars_zm_list
nhtfrq = $atm_output_freq, -3,-3,-3,-3,-3,-3
mfilt  = $records_per_atm_output_file, 5000, 5000, 5000,5000,5000,5000
avgflag_pertape = 'A','A','A','A','A','A','A'

fincl1 = 'U:A','PS:A','T:A','V:A','OMEGA:A','Z3:A','PRECT:A',
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
'MPDICE:A','INEGCLPTEND', 'LNEGCLPTEND', 'VNEGCLPTEND',
'QCRAT:A', $clubb_vars_zt_list,$clubb_vars_zm_list,
'SL', 'Q', 'RHW', 'QRS', 'QRL', 'HR', 'FDL', 'SILHS_CLUBB_PRECIP_FRAC',
'SILHS_CLUBB_ICE_SS_FRAC'
fincl2 = 'CLDTOT', 'CLDST','CDNUMC','CLDLIQ','CLDICE','FLUT',
'LWCF','SWCF','PRECT'

relvar_fix = .true. 
mg_prc_coeff_fix = .true.
rrtmg_temp_fix = .true.
microp_scheme = 'MG'
micro_mg_version = 2
micro_mg_sub_version = 0
micro_mg_num_steps = 1
micro_mg_dcs = 300e-6 
micro_mg_berg_eff_factor =1.0D0
cldfrc2m_rhmini = 0.9
cldfrc2m_rhmaxi = 1.05
cld_macmic_num_steps           =  6 
cld_sed                        =  1.8D0 
conv_water_in_rad              =  1                                                                   
convproc_do_aer                = .true.
convproc_do_gas                = .false.                                                              
convproc_method_activate       = 2                                                            
demott_ice_nuc                 = .true.
do_aerocom_ind3                =  .false.                                                             
do_tms                         =  .false.
fix_g1_err_ndrop               = .true.
history_aero_optics            = .true.
history_aerosol                = .false.
history_eddy                   = .false.                                                     
history_vdiag                  = .false.                                                      
history_verbose                = .false.                                                
history_waccm          =                 .false.                                                      
liqcf_fix              = .true.
mam_amicphys_optaa             = 1
micro_mg_accre_enhan_fac               = 1.75D0
n_so4_monolayers_pcage         = 8.0D0 
prc_coef1 = 30500.0D0
prc_exp = 3.D0
prc_exp1 = -1.2D0
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
co2vmr         = 367.000000e-6 
waccmx_opt             = 'off'
nucleate_ice_subgrid           = 1.2D0 
so4_sz_thresh_icenuc           = 0.080e-6
use_preexisting_ice            = .false.
taubgnd                = 2.5D-3
ice_sed_ai= 1200.0
effgw_beres            =         0.4
effgw_oro              =           0.25
dust_emis_fact         =      2.8D0
clubb_use_sgv          =.false. 
micro_mg_dcs_tdep              = .false.
mam_mom_mixing_state           = 3
se_ftype               = 2
use_rad_dt_cosz                = .true.
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
! How to turn on SILHS? deep_scheme='off', subcol_scheme = 'SILHS',use_subcol_microp = .true.,microp_uniform = .true. 
macrop_scheme = 'CLUBB_SGS'
eddy_scheme = 'CLUBB_SGS'
shallow_scheme = 'CLUBB_SGS'
deep_scheme = 'off'         ! off
subcol_scheme = 'SILHS'     ! SILHS
use_subcol_microp = .true.  ! true
microp_uniform = .true.     ! true
clubb_do_adv = .false.
clubb_expldiff = .false.
clubb_rainevap_turb = .false.
clubb_cloudtop_cooling = .false.
subcol_SILHS_weight = .true.
subcol_SILHS_numsubcol =  4 
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
  
### NOTES ON COMMON NAMELIST OPTIONS ###

### ATMOSPHERE NAMELIST ###

#NHTFRQ : The frequency with which the atmosphere writes its output.
#    0=monthly, +N=every N timesteps,  -N=every N hours
#    For more information:   http://www.cesm.ucar.edu/models/atm-cam/docs/usersguide/node45.html
#MFILT : The number of time records in each netCDF output file from the atmosphere model.
#    If mfilt is 0, then there will only be one time record per file.
#NOTE:  nhtfrq and mfilt can be a comma-separated list of numbers, corresponding to the 'history tapes' defined in the namelist.

#============================================
# BUILD CODE
#============================================

#NOTE: This will either build the code (if needed and $old_executable=false) or copy an existing executable.

if ( `lowercase $old_executable` == false ) then
  e3sm_newline
  e3sm_print '-------- Starting Build --------'
  e3sm_newline

  e3sm_print 'WARNING: Make sure there are no double-slashes (//) in the build command below: => Will cause a build error'
  e3sm_print ${case_build_exe}
  ${case_build_exe}
  
  if ($status > 0) then 
    echo "The case.build step failed."
    exit 1
  endif

  e3sm_newline
  e3sm_print '-------- Finished Build --------'
  e3sm_newline
else if ( `lowercase $old_executable` == true ) then
  if ( -x $case_build_dir/$e3sm_exe ) then       #use executable previously generated for this case_name.
    e3sm_print 'Skipping build because $old_executable='$old_executable
    e3sm_newline
    #create_newcase sets BUILD_COMPLETE to FALSE. By using an old executable you're certifying
    #that you're sure the old executable is consistent with the new case... so be sure you're right!
    #NOTE: This is a risk to provenance, so this feature may be removed in the future [PJC].
    #      However the build system currently rebuilds several files every time which takes many minutes.
    #      When this gets fixed the cost of deleting this feature will be minor.
    #      (Also see comments for user options at top of this file.)
    e3sm_print 'WARNING: Setting BUILD_COMPLETE = TRUE.  This is a little risky, but trusting the user.'
    $xmlchange_exe --id BUILD_COMPLETE --val TRUE
  else
    e3sm_print 'ERROR: $old_executable='$old_executable' but no executable exists for this case.'
    e3sm_print '                Expected to find executable = '$case_build_dir/$e3sm_exe
    exit 297
  endif
else
  if ( -x $old_executable ) then #if absolute pathname exists and is executable.
    #create_newcase sets BUILD_COMPLETE to FALSE. By copying in an old executable you're certifying
    #that you're sure the old executable is consistent with the new case... so be sure you're right!
    #NOTE: This is a risk to provenance, so this feature may be removed in the future [PJC].
    #      However the build system currently rebuilds several files every time which takes many minutes.
    #      When this gets fixed the cost of deleting this feature will be minor.
    #      (Also see comments for user options at top of this file.)
    #
    #NOTE: The alternative solution is to set EXEROOT in env_build.xml.
    #      That is cleaner and quicker, but it means that the executable is outside this directory,
    #      which weakens provenance if this directory is captured for provenance.
    e3sm_print 'WARNING: Setting BUILD_COMPLETE = TRUE.  This is a little risky, but trusting the user.'
    $xmlchange_exe --id BUILD_COMPLETE --val TRUE
    cp -fp $old_executable $case_build_dir/
  else
    e3sm_print 'ERROR: $old_executable='$old_executable' does not exist or is not an executable file.'
    exit 297
  endif
endif

# Some user_nl settings won't be updated to *_in files under the run directory
# until namelists are built again.
# Call preview_namelists to make sure *_in and user_nl files are consistent.
$preview_namelists_exe

#============================================
# BATCH JOB OPTIONS
#============================================

# Set options for batch scripts (see above for queue and batch time, which are handled separately)

# NOTE: This also modifies the short-term archiving script.
# NOTE: We want the batch job log to go into a sub-directory of case_scripts (to avoid it getting clogged up)

# NOTE: we are currently not modifying the archiving scripts to run in debug queue when $debug_queue=true
#       under the assumption that if you're debugging you shouldn't be archiving.

# NOTE: there was 1 space between MSUB or PBS and the commands before cime and there are 2 spaces
#       in post-cime versions. This is fixed by " \( \)*" in the lines below. The "*" here means
#       "match zero or more of the expression before". The expression before is a single whitespace.
#       The "\(" and "\)" bit indicate to sed that the whitespace in between is the expression we
#       care about. The space before "\(" makes sure there is at least one whitespace after #MSUB.
#       Taken all together, this stuff matches lines of the form #MSUB<one or more whitespaces>-<stuff>.

mkdir -p batch_output      ### Make directory that stdout and stderr will go into.

if ( $machine =~ 'cori*' || $machine == edison ) then
    $xmlchange_exe --subgroup case.run BATCH_COMMAND_FLAGS="--job-name=${job_name} --output=batch_output/${case_name}.o%j"
    $xmlchange_exe --subgroup case.st_archive BATCH_COMMAND_FLAGS="--job-name=ST+${job_name} --output=batch_output/ST+${case_name}.o%j --account=${project}"
else if ( $machine == titan || $machine == eos ) then
    $xmlchange_exe --subgroup case.run BATCH_COMMAND_FLAGS="-N ${job_name} -A ${project} -o batch_output/${case_name}.o%j"
    $xmlchange_exe --subgroup case.st_archive BATCH_COMMAND_FLAGS="-N ST+${job_name} -o batch_output/ST+${case_name}.o%j"

else if ( $machine == anvil ) then
# Priority for Anvil
# For more information, see
# https://acme-climate.atlassian.net/wiki/pages/viewpage.action?pageId=98992379#Anvil:ACME'sdedicatednodeshostedonBlues.-Settingthejobpriority
# If default; use the default priority of qsub.py. Otherwise, should be from 0-5, where 0 is the highest priority
# Note that only one user at a time is allowed to use the highest (0) priority
# env_batch.xml must be modified by hand, as it doesn't conform to the entry-id format
# ${xmlchange_exe} batch_submit="qsub.py "
    set anvil_priority   = default
    if ( `lowercase ${anvil_priority}` != default ) then
	sed -i 's:qsub:qsub.py:g' env_batch.xml
	$xmlchange_exe BATCH_COMMAND_FLAGS="-W x=QOS:pri${anvil_priority}"
    endif

else
    e3sm_print 'WARNING: This script does not have batch directives for $machine='$machine
    e3sm_print '         Assuming default E3SM values.'
endif

#============================================
# QUEUE OPTIONS
#============================================
# Edit the default queue and batch job lengths.

# HINT: To change queue after run submitted, the following works on most machines:
#       qalter -lwalltime=00:29:00 <run_descriptor>
#       qalter -W queue=debug <run_descriptor>

### Only specially authorized people can use the special_e3sm qos on Cori or Edison. Don't uncomment unless you're one.
#if ( `lowercase $debug_queue` == false && $machine == edison ) then
#  set batch_options = `$xmlquery_exe BATCH_COMMAND_FLAGS --value`
#  $xmlchange_exe BATCH_COMMAND_FLAGS="${batch_options} --qos=special_e3sm"
#endif

#============================================
# SETUP SHORT TERM ARCHIVING
#============================================

$xmlchange_exe --id DOUT_S --val `uppercase $do_short_term_archiving`
if ( `lowercase $short_term_archive_root_dir` != default ) then
  $xmlchange_exe --id DOUT_S_ROOT --val $short_term_archive_root_dir
endif

set short_term_archive_root_dir = `$xmlquery_exe DOUT_S_ROOT --value`

#==============================
# SETUP PERMISSIONS FOR SHARING
#==============================

set group_list = `groups`
if ( "$group_list" =~ "*${project}*" ) then
  # Determine what command to use to setup permissions
  where setfacl > /dev/null
  if ( $? == 0 ) then
    # setfacl exists, but may not work depending on kernel configuration
    # So, verify it works, and if not, just use chgrp
    set group_perms = "setfacl -Rdm g:${project}:r-x"
    e3sm_print ${group_perms} ${case_run_dir}
    ${group_perms} ${case_run_dir}
    if ( $? != 0 ) then
      set group_perms = "chgrp ${project}"
    endif
    ${group_perms} ${case_run_dir}
    # Ensure chgrp works also, in case there's something we didn't anticipate
    if ( $? != 0 ) then
      unset group_perms
      e3sm_print "Could not make results accessible to the group, results must be shared manually"
    endif
  endif

  if ( $?group_perms ) then
    # Make results which have been archived accessible to other project members
    if (! -d ${short_term_archive_root_dir} )then
      mkdir -p ${short_term_archive_root_dir}
    endif
    e3sm_print ${group_perms} ${short_term_archive_root_dir}
    ${group_perms} ${short_term_archive_root_dir}

    e3sm_print "All project members have been given access to the results of this simulation"
  endif
else
  e3sm_print "${project} not recognized as a group, results must be shared manually"
endif

#============================================
# COUPLER HISTORY OUTPUT
#============================================

#$xmlchange_exe --id HIST_OPTION --val ndays
#$xmlchange_exe --id HIST_N      --val 1

#=======================================================
# SETUP SIMULATION LENGTH AND FREQUENCY OF RESTART FILES
#=======================================================

#SIMULATION LENGTH
$xmlchange_exe --id STOP_OPTION --val `lowercase $stop_units`
$xmlchange_exe --id STOP_N      --val $stop_num

#RESTART FREQUENCY
$xmlchange_exe --id REST_OPTION --val `lowercase $restart_units`
$xmlchange_exe --id REST_N      --val $restart_num

#COUPLER BUDGETS
$xmlchange_exe --id BUDGETS     --val `uppercase $do_cpl_hist`

#COUPLER HISTORY FILES
$xmlchange_exe --id HIST_OPTION --val `lowercase $cpl_hist_units`
$xmlchange_exe --id HIST_N      --val $cpl_hist_num

#============================================
# SETUP SIMULATION INITIALIZATION
#============================================

e3sm_newline
e3sm_print '$model_start_type = '${model_start_type}'  (This is NOT necessarily related to RUN_TYPE)'

set model_start_type = `lowercase $model_start_type`
#-----------------------------------------------------------------------------------------------
# start_type = initial means start a new run from default or user-specified initial conditions
#-----------------------------------------------------------------------------------------------
if ( $model_start_type == 'initial' ) then
  ### 'initial' run: cobble together files, with RUN_TYPE= 'startup' or 'hybrid'.
  $xmlchange_exe --id RUN_TYPE --val "startup"
  $xmlchange_exe --id CONTINUE_RUN --val "FALSE"

  # if you want to use your own initial conditions, uncomment and fix up the lines below:
#  set initial_files_dir = $PROJWORK/cli107/sulfur_DOE_restarts/2deg_1850_0011-01-01-00000
#  cp -fpu $initial_files_dir/* ${case_run_dir}

#-----------------------------------------------------------------------------------------------
# start_type = continue means you've already run long enough to produce restart files and want to
# continue the run
#-----------------------------------------------------------------------------------------------
else if ( $model_start_type == 'continue' ) then

  ### This is a standard restart.

  $xmlchange_exe --id CONTINUE_RUN --val "TRUE"

#-----------------------------------------------------------------------------------------------
# start_type = branch means you want to continue a run, but in a new run directory and/or with
# recompiled code
#-----------------------------------------------------------------------------------------------
else if ( $model_start_type == 'branch' ) then

  ### Branch runs are the same as restarts, except that the history output can be changed
  ### (eg to add new variables or change output frequency).

  ### Branch runs are often used when trying to handle a complicated situation.
  ### Hence, it is likely that the user will need to customize this section.

  ### the next lines attempt to automatically extract all needed info for setting up the branch run.
  set rpointer_filename = "${restart_files_dir}/rpointer.drv"
  if ( ! -f $rpointer_filename ) then
    e3sm_print 'ERROR: ${rpointer_filename} does not exist. It is needed to extract RUN_REFDATE.'
    e3sm_print "       This may be because you should set model_start_type to 'initial' or 'continue' rather than 'branch'."
    e3sm_print '       ${rpointer_filename} = '{rpointer_filename}
    exit 370
  endif
  set restart_coupler_filename = `cat $rpointer_filename`
  set restart_case_name = ${restart_coupler_filename:r:r:r:r}         # Extract out the case name for the restart files.
  set restart_filedate = ${restart_coupler_filename:r:e:s/-00000//}   # Extract out the date (yyyy-mm-dd).
  e3sm_print '$restart_case_name = '$restart_case_name
  e3sm_print '$restart_filedate  = '$restart_filedate

  ### the next line gets the YYYY-MM of the month before the restart time. Needed for staging history files.
  ### NOTE: This is broken for cases that have run for less than a month
  set restart_prevdate = `date -d "${restart_filedate} - 1 month" +%Y-%m`

  e3sm_print '$restart_prevdate  = '$restart_prevdate

  e3sm_print 'Copying stuff for branch run'
  cp -s ${restart_files_dir}/${restart_case_name}.cam.r.${restart_filedate}-00000.nc $case_run_dir
  cp -s ${restart_files_dir}/${restart_case_name}.cam.rs.${restart_filedate}-00000.nc $case_run_dir
  cp -s ${restart_files_dir}/${restart_case_name}.clm2.r.${restart_filedate}-00000.nc $case_run_dir
  cp -s ${restart_files_dir}/${restart_case_name}.clm2.rh0.${restart_filedate}-00000.nc $case_run_dir
  cp -s ${restart_files_dir}/${restart_case_name}.cpl.r.${restart_filedate}-00000.nc $case_run_dir
  cp -s ${restart_files_dir}/${restart_case_name}.mosart.r.${restart_filedate}-00000.nc $case_run_dir
  cp -s ${restart_files_dir}/${restart_case_name}.mosart.rh0.${restart_filedate}-00000.nc $case_run_dir
  cp -s ${restart_files_dir}/mpassi.rst.${restart_filedate}_00000.nc $case_run_dir
  cp -s ${restart_files_dir}/mpaso.rst.${restart_filedate}_00000.nc $case_run_dir
  cp -s ${restart_files_dir}/../../atm/hist/${restart_case_name}.cam.h0.${restart_prevdate}.nc $case_run_dir
  cp -s ${restart_files_dir}/../../rof/hist/${restart_case_name}.mosart.h0.${restart_prevdate}.nc $case_run_dir
  cp -s ${restart_files_dir}/../../lnd/hist/${restart_case_name}.clm2.h0.${restart_prevdate}.nc $case_run_dir
  cp ${restart_files_dir}/rpointer* $case_run_dir

  $xmlchange_exe --id RUN_TYPE --val "branch"
  $xmlchange_exe --id RUN_REFCASE --val $restart_case_name
  $xmlchange_exe --id RUN_REFDATE --val $restart_filedate    # Model date of restart file
  $xmlchange_exe --id CONTINUE_RUN --val "FALSE"
  # Currently broken in CIME
  # Only uncomment this if you want to continue the run with the same name (risky)!!
  # $xmlchange_exe --id BRNCH_RETAIN_CASENAME --val "TRUE"

else

  e3sm_print 'ERROR: $model_start_type = '${model_start_type}' is unrecognized.   Exiting.'
  exit 380

endif

#============================================
# RUN CONFIGURATION OPTIONS
#============================================

#NOTE:  This section is for making specific changes to the run options (ie env_run.xml).

#if ( $machine == 'cori*' ) then      ### fix pnetcdf problem on Cori. (github #593)
#  $xmlchange_exe --id PIO_TYPENAME  --val "netcdf"
#endif

#=================================================
# SUBMIT THE SIMULATION TO THE RUN QUEUE
#=================================================
#note: to run the model in the totalview debugger,
# cd $case_run_dir
# totalview srun -a -n <number of procs> -p <name of debug queue> ../bld/$e3sm_exe
# where you may need to change srun to the appropriate submit command for your system, etc.


e3sm_newline
e3sm_print '-------- Starting Submission to Run Queue --------'
e3sm_newline

if ( ${num_resubmits} > 0 ) then
  ${xmlchange_exe} --id RESUBMIT --val ${num_resubmits}
  e3sm_print 'Setting number of resubmits to be '${num_resubmits}
  @ total_submits = ${num_resubmits} + 1
  e3sm_print 'This job will submit '${total_submits}' times after completion'
endif

if ( `lowercase $submit_run` == 'true' ) then
  e3sm_print '         SUBMITTING JOB:'
  e3sm_print ${case_submit_exe}
  ${case_submit_exe}
else
    e3sm_print 'Run NOT submitted because $submit_run = '$submit_run
endif

if ($status > 0) then
  echo "The case.submit step failed."
  exit 1
endif

e3sm_newline
e3sm_print '-------- Finished Submission to Run Queue --------'
e3sm_newline

#=================================================
# DO POST-SUBMISSION THINGS (IF ANY)
#=================================================

# Actions after the run submission go here.

e3sm_newline
e3sm_print '++++++++ run_e3sm Completed ('`date`') ++++++++'
e3sm_newline
