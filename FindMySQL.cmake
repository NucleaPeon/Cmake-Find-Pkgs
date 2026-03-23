# FindMySQL.cmake
#
# Minimal Find module to locate MySQL client headers and library on Snow Leopard
#
# Variables set:
#   MYSQL_FOUND          - TRUE if both include dir and lib were found
#   MYSQL_INCLUDE_DIR    - Path to MySQL headers (directory containing mysql.h)
#   MYSQL_LIBRARIES      - Full path to the MySQL client library (or list)
#
# Usage:
#   find_package(MySQL QUIET)
#   if(MYSQL_FOUND)
#       include_directories(${MYSQL_INCLUDE_DIR})
#       target_link_libraries(<target> ${MYSQL_LIBRARIES})
#   endif()

include(FindPackageHandleStandardArgs)

set(MYSQL_FOUND FALSE)
set(MYSQL_INCLUDE_DIR "")
set(MYSQL_LIBRARIES "")

# Common candidate base directories for Snow Leopard era environments
set(_MYSQL_INCLUDE_HINTS
  /usr/include
  /usr/local/include
  /usr/local/mysql/include
  /opt/local/include
  /sw/include
  /usr/include/mysql
  ${CMAKE_INSTALL_PREFIX}/include
)

set(_MYSQL_LIB_HINTS
  /usr/lib
  /usr/local/lib
  /opt/local/lib
  /sw/lib
  /usr/local/mysql/lib
  /usr/lib/mysql
  ${CMAKE_INSTALL_PREFIX}/lib
)

# Helper to check for header
function(_try_mysql_header_dir dir out_var)
  if(EXISTS "${dir}/mysql.h")
    set(${out_var} "${dir}" PARENT_SCOPE)
  endif()
endfunction()

# Helper to check for library
function(_try_mysql_lib_dir dir out_var)
  if(EXISTS "${dir}/libmysqlclient.dylib")
    set(${out_var} "${dir}/libmysqlclient.dylib" PARENT_SCOPE)
  elseif(EXISTS "${dir}/libmysqlclient.dylib")
    set(${out_var} "${dir}/libmysqlclient.dylib" PARENT_SCOPE)
  elseif(EXISTS "${dir}/libmysqlclient.dylib.a")
    set(${out_var} "${dir}/libmysqlclient.dylib.a" PARENT_SCOPE)
  endif()
endfunction()

# Try common locations
set(_FOUND FALSE)
foreach(_inc_dir ${_MYSQL_INCLUDE_HINTS})
  if(NOT MYSQL_INCLUDE_DIR)
    _try_mysql_header_dir("${_inc_dir}" _tmp_inc)
    if(_tmp_inc)
      set(MYSQL_INCLUDE_DIR "${_tmp_inc}")
    endif()
  endif()
endforeach()

# If still not found, try a few more Mac-centric patterns (Snow Leopard era)
if(NOT MYSQL_FOUND)
  # MacPorts layout
  if(EXISTS "/opt/local/include/mysql/mysql.h")
    set(MYSQL_INCLUDE_DIR "/opt/local/include/mysql")
    if(EXISTS "/opt/local/lib/libmysqlclient.dylib")
      set(MYSQL_LIBRARIES "/opt/local/lib/libmysqlclient.dylib")
    endif()
  endif()
endif()

foreach(_lib_dir ${_MYSQL_LIB_HINTS})
  if(NOT MYSQL_LIBRARIES)
    _try_mysql_lib_dir("${_lib_dir}" _tmp_lib)
    if(_tmp_lib)
      set(MYSQL_LIBRARIES "${_tmp_lib}")
    endif()
  endif()
endforeach()

# If both present, declare found
if(MYSQL_INCLUDE_DIR AND MYSQL_LIBRARIES)
  set(MYSQL_FOUND TRUE)
endif()


# Final message & handling
if(MYSQL_FOUND)
  set(_MYSQL_HINTS ${MYSQL_INCLUDE_DIR} ${MYSQL_LIBRARIES})
  find_package_handle_standard_args(MySQL  REQUIRED_VARS MYSQL_INCLUDE_DIR MYSQL_LIBRARIES)
else()
  set(MYSQL_LIBRARIES "")
  set(MYSQL_INCLUDE_DIR "")
  set(MYSQL_FOUND FALSE)
  set(_MYSQL_HINTS "")
  if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU|Apple")
    # Do not fail hard here, Snow Leopard users may still install via local paths
    message(STATUS "FindMySQL: Could not locate MySQL headers and libraries on this system.")
  endif()
endif()
