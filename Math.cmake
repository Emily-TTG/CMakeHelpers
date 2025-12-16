### `$<CONFIG:...>`: 3.19

include(${CMAKE_CURRENT_LIST_DIR}/Utilities.cmake)

function(_c_flag_release_expr_conditional FLAG)
    c_flag_test(FLAG _HAVE_FLAG)
    if(${_HAVE_FLAG})
        add_compile_options($<$<CONFIG:Release,RelWithDebInfo>:${FLAG}>)
    endif()
endfunction()

### Globally enables FastMath in release builds.
function(enable_fast_math)
    # Adapted from https://github.com/CelestiaProject/Celestia/blob/master/cmake/FastMath.cmake
    # Which is licenced under the GNU GPLv2.

    _c_flag_release_expr_conditional(/fp:fast)
    _c_flag_release_expr_conditional(-ffast-math)
    _c_flag_release_expr_conditional(-fno-finite-math-only)
    _c_flag_release_expr_conditional(-fsigned-zeros)
    _c_flag_release_expr_conditional(-fno-associative-math)
endfunction()
