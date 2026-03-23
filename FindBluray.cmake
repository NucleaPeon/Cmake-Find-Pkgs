#.rst:
# FindBluray
# -------
# Finds the Bluray library
#
# This will will define the following variables::
#
# BLURAY_FOUND - system has libnfs
# BLURAY_INCLUDE_DIRS - the libnfs include directory
# BLURAY_LIBRARIES - the libnfs libraries
#

include(FindPackageHandleStandardArgs)

find_path( BLURAY_INCLUDE_DIR
		NAMES "bluray.h"
		PATHS "/usr/include/libbluray"
			  "/opt/local/include/libbluray"
			  "/usr/local/include/libbluray"
			  "/usr/mysql/include/libbluray" 
)

find_library( BLURAY_LIB_DIR
	NAMES "bluray" "libbluray"
	PATHS "/lib"
			"/lib64"
			"/usr/lib"
			"/usr/lib64"
			"/usr/local/lib"
			"/usr/local/lib64"
			"/opt/local/lib"
			"/opt/local/lib64"
)

find_package_handle_standard_args(Bluray  
	REQUIRED_VARS  
		BLURAY_INCLUDE_DIR BLURAY_LIB_DIR
)

