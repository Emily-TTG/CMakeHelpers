### `$<CONFIG:...>`: 3.19

include(${CMAKE_CURRENT_LIST_DIR}/Utilities.cmake)

function()

### Globally enables FastMath in release builds.
function(enable_fast_math)
    # Adapted from https://github.com/CelestiaProject/Celestia/blob/master/cmake/FastMath.cmake
    # Which is licenced under the GNU GPLv2.

    c_options_conditional(
        add_compile_options
        FLAGS
        $<$<CONFIG:Release,RelWithDebInfo>:/fp:fast>
        $<$<CONFIG:Release,RelWithDebInfo>:-ffast-math>
        $<$<CONFIG:Release,RelWithDebInfo>:-fno-finite-math-only>
        $<$<CONFIG:Release,RelWithDebInfo>:-fsigned-zeros>
        $<$<CONFIG:Release,RelWithDebInfo>:-fno-associative-math>)
endfunction()
