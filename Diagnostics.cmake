include(${CMAKE_CURRENT_LIST_DIR}/Utilities.cmake)

### Add strict C diagnostic flags.
function(c_strict_diagnostics TARGET)
	c_options_conditional(
			COMMAND target_compile_options
			ARGS ${TARGET} PRIVATE
			FLAGS -Wall -Wextra -Werror -pedantic -pedantic-errors)

	c_options_conditional(
			COMMAND target_compile_options
			ARGS ${TARGET} PRIVATE
			FLAGS /Wall /WX
			/wd4820 # Padding
			/wd4710 # Function was not inlined
			/wd5045 # Spectre mitigations
			/wd4514 # Unreferenced inline function has been removed
			/wd4711 # Function selected for automatic inlining
			/wd4706 # Assignment inside conditional expression (even with double paren)
			/wd4061 # Non-explicitly handled enum value (Doesn't count `default:')
			/wd4623 # Default constructor was implicitly defined as deleted
			/wd4868 # Compiler may not enforce left-to-right evaluation order in braced initializer list
			/wd4127 # Conditional expression is constant (Even if block contains a `break')
			/wd4625 # Copy constructor was implicitly defined as deleted
			/wd4626 # Assignment operator was implicitly defined as deleted
			/wd4574) # Macro is defined to be '0': did you mean to use '#if'?
endfunction()
