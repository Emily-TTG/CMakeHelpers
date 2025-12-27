# SPDX-License-Identifier: X11
# Copyright (C) 2025 Emily "TTG" Banerjee <prs.ttg+cmh@pm.me>

### `$<CONFIG:...>`: 3.19

include(${CMAKE_CURRENT_LIST_DIR}/Utilities.cmake)

function(_c_flag_conditional_target TARGET FLAG)
	c_flag_test(FLAG _HAVE_FLAG)
	if(${_HAVE_FLAG})
		string(APPEND ${TARGET} " ${FLAG}")
	endif()
endfunction()

function(_global_c_flag_release_conditional FLAG)
	_c_flag_conditional_target(CMAKE_C_FLAGS_RELEASE ${FLAG})
	_c_flag_conditional_target(CMAKE_C_FLAGS_RELWITHDEBINFO ${FLAG})
endfunction()

function(_global_c_flag_conditional FLAG)
	_c_flag_conditional_target(CMAKE_C_FLAGS ${FLAG})
endfunction()

### Globally enables FastMath in release builds.
function(enable_fast_math)
	# Adapted from https://github.com/CelestiaProject/Celestia/blob/master/cmake/FastMath.cmake
	# Which is licenced under the GNU GPLv2.

	_global_c_flag_release_conditional(/fp:fast)
	_global_c_flag_release_conditional(-ffast-math)
	_global_c_flag_release_conditional(-fno-finite-math-only)
	_global_c_flag_release_conditional(-fsigned-zeros)
	_global_c_flag_release_conditional(-fno-associative-math)
endfunction()

### Globally enables host-native CPU tuning.
function(enable_host_tuning)
	_global_c_flag_conditional(-march=native)
	_global_c_flag_conditional(-mtune=native)
endfunction()
