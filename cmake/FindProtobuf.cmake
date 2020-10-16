if (COMMON_LIBRARY_ROOT_STATIC)
    set(_TEMP_LIBRARY_DIR_PREFIX ${COMMON_LIBRARY_ROOT_STATIC})
else()
    set(_TEMP_LIBRARY_DIR_PREFIX ${BUILDING_INSTALL_PREFIX})
endif()

set(protobuf_MODULE_COMPATIBLE ON)
include(${_TEMP_LIBRARY_DIR_PREFIX}/lib/cmake/protobuf/protobuf-config.cmake)
set(Protobuf_FOUND TRUE)
