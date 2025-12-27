# SPDX-License-Identifier: X11
# Copyright (C) 2025 Emily "TTG" Banerjee <prs.ttg+cmh@pm.me>

### `string(PREPEND)`: 3.10
### `cmake_language()`: 3.18

include(CheckCCompilerFlag)
include(CMakeParseArguments)

### Convert compile flag to variable-appropriate string.
### e.g. "-Wall" -> "<prefix>_WALL<suffix>".
function(_flag_string_variable FLAG OUT_VAR PREFIX SUFFIX)
	string(SUBSTRING ${FLAG} 0 1 _FLAG_START)
	string(SUBSTRING ${FLAG} 1 -1 _FLAG_NAME)

	# MS to GNU style CLI.
	if(${_FLAG_START} STREQUAL "/")
		string(PREPEND _FLAG_NAME "_MS_")
	else()
		string(PREPEND _FLAG_NAME "_")
	endif()

	string(MAKE_C_IDENTIFIER ${_FLAG_NAME} _FLAG_NAME)

	string(TOUPPER "${_FLAG_NAME}" _FLAG_NAME)

	set(${OUT_VAR} "${PREFIX}${_FLAG_NAME}${SUFFIX}" PARENT_SCOPE)
endfunction()

function(c_flag_test FLAG OUT_VAR)
	_flag_string_variable(${FLAG} _FLAG_NAME "C_FLAG" "")
	check_c_compiler_flag(${FLAG} ${_FLAG_NAME})
	set(${OUT_VAR} ${_FLAG_NAME} PARENT_SCOPE)
endfunction()

### Add compile flag if it exists.
function(c_options_conditional)
	cmake_parse_arguments(
			C_OPTIONS_CONDITIONAL
			"REQUIRED" "COMMAND" "ARGS;FLAGS"
			${ARGN})

	foreach(FLAG IN LISTS C_OPTIONS_CONDITIONAL_FLAGS)
		c_flag_test(${FLAG} _HAVE_FLAG)

		if(${${_HAVE_FLAG}})
			cmake_language(
					CALL
					${C_OPTIONS_CONDITIONAL_COMMAND}
					${C_OPTIONS_CONDITIONAL_ARGS}
					${FLAG})
		elseif(${C_OPTIONS_CONDITIONAL_REQUIRED})
			message(FATAL_ERROR "${FLAG} required")
		endif()
	endforeach()
endfunction()
