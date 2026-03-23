#.rst:
# FindTaglib
# -------
# Finds the Taglib library
#
# This will will define the following variables::
#
# TAGLIB_FOUND - system has libnfs
# TAGLIB_INCLUDE_DIRS - the libnfs include directory
# TAGLIB_LIBRARIES - the libnfs libraries
#

include(FindPackageHandleStandardArgs)

set(TAGLIB_FOUND FALSE)

find_path( TAGLIB_INCLUDE_DIR
		NAMES "taglib.h"
		PATHS "/usr/include/taglib/"
			  "/opt/local/include/taglib/"
			  "/usr/local/include/taglib"
			  "/usr/mysql/include/taglib" 
)

find_package_handle_standard_args(Taglib  
	REQUIRED_VARS 
		TAGLIB_INCLUDE_DIR 
)