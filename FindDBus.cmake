#.rst:
# FindDBus
# -------
# Finds the DBus library
#
# This will will define the following variables::
#
# DBUS_FOUND - system has libnfs
# DBUS_INCLUDE_DIRS - the libnfs include directory
# DBUS_LIBRARIES - the libnfs libraries
#

include(FindPackageHandleStandardArgs)

find_path( DBUS_INCLUDE_DIR
		NAMES "dbus.h"
		PATHS "/usr/include/dbus"
			  "/opt/local/include/dbus"
			  "/usr/local/include/dbus"
			  "/usr/mysql/include/dbus" 
			  "/opt/local/include/dbus-1.0"
			  "/usr/local/include/dbus-1.0"
			  "/usr/mysql/include/dbus-1.0" 
			  "/opt/local/include/dbus-1.0/dbus"
			  "/usr/local/include/dbus-1.0/dbus"
			  "/usr/mysql/include/dbus-1.0/dbus" 
)

find_library( DBUS_LIB_DIR
	NAMES "libdbus-1" "libdbus-glib" "dbus-1" "dbus-glib"
	PATHS "/lib"
			"/lib64"
			"/usr/lib"
			"/usr/lib64"
			"/usr/local/lib"
			"/usr/local/lib64"
			"/opt/local/lib"
			"/opt/local/lib64"
)

find_package_handle_standard_args(DBus  
	REQUIRED_VARS  
		DBUS_INCLUDE_DIR DBUS_LIB_DIR
)

