ExternalProject_Add(build_protobuf
        ${PROTOBUF_FETCH_INFO}
        BUILD_ALWAYS TRUE
        SOURCE_SUBDIR cmake
        INSTALL_DIR  ${BUILDING_INSTALL_PREFIX}
        PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/fixed-projects/protobuf-module.cmake.in ./cmake/protobuf-module.cmake.in
        DEPENDS build_zlib
        CMAKE_ARGS
        ${_PROPAGATE_BUILD_TYPE}
        -DCMAKE_MODULE_PATH=${BUILDING_CMAKE_MODULE_PATH}
        -DCMAKE_INSTALL_PREFIX=${BUILDING_INSTALL_PREFIX}
        -DCMAKE_POSITION_INDEPENDENT_CODE=${CMAKE_POSITION_INDEPENDENT_CODE}
        -DBUILDING_INSTALL_PREFIX=${BUILDING_INSTALL_PREFIX}
        -DBUILDING_LIBRARY_ZLIB_LINK_TYPE=static
        -DCMAKE_INSTALL_CMAKEDIR=lib/cmake/protobuf
        -Dprotobuf_BUILD_TESTS=OFF
        -Dprotobuf_WITH_ZLIB=ON
        -Dprotobuf_MSVC_STATIC_RUNTIME=${BUILDING_USE_MSVC_STATIC_RUNTIME}
        -Dprotobuf_BUILD_SHARED_LIBS=${PROTOBUF_BUILD_SHARED_LIBS}
        )
