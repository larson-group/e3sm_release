set(ALBANY_PATH "/projects/install/rhel7-x86_64/ACME/AlbanyTrilinos/Albany/build/install")
if (COMP_NAME STREQUAL gptl)
  string(APPEND CPPDEFS " -DHAVE_SLASHPROC")
endif()
string(APPEND CXX_LIBS " -lstdc++ -lmpi_cxx")
set(NETCDF_PATH "$ENV{NETCDFROOT}")
set(PNETCDF_PATH "$ENV{PNETCDFROOT}")
execute_process(COMMAND ${NETCDF_PATH}/bin/nf-config --flibs OUTPUT_VARIABLE SHELL_CMD_OUTPUT_BUILD_INTERNAL_IGNORE0 OUTPUT_STRIP_TRAILING_WHITESPACE)
string(APPEND SLIBS " ${SHELL_CMD_OUTPUT_BUILD_INTERNAL_IGNORE0} -lblas -llapack")
