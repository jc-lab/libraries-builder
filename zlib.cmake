set(NEW_LIST_SEPARATOR "<|>")

string(REPLACE ";" "${NEW_LIST_SEPARATOR}" _ZLIB_FETCH_INFO "${ZLIB_FETCH_INFO}")

ExternalProject_Add(build_zlib
        BUILD_ALWAYS TRUE
        PREFIX     ${CMAKE_CURRENT_BINARY_DIR}/project-zlib
        DOWNLOAD_COMMAND ""
        SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/project-zlib
        INSTALL_DIR  ${BUILDING_INSTALL_PREFIX}
        LIST_SEPARATOR "${NEW_LIST_SEPARATOR}"
        CMAKE_ARGS
            ${_PROPAGATE_BUILD_TYPE}
            -DCMAKE_MODULE_PATH=${BUILDING_CMAKE_MODULE_PATH}
            -DCMAKE_INSTALL_PREFIX=${BUILDING_INSTALL_PREFIX}
            -DCMAKE_POSITION_INDEPENDENT_CODE=${CMAKE_POSITION_INDEPENDENT_CODE}
            -DBUILDING_INSTALL_PREFIX=${BUILDING_INSTALL_PREFIX}
            -DZLIB_FETCH_INFO:string=${_ZLIB_FETCH_INFO}
        )
