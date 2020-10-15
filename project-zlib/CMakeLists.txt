cmake_minimum_required(VERSION 3.8)
project(project-zlib)

include(FetchContent)

set(INSTALL_BIN_DIR "bin")
set(INSTALL_LIB_DIR "lib")
set(INSTALL_INC_DIR "include")
set(INSTALL_MAN_DIR "share/man")
set(INSTALL_PKGCONFIG_DIR "share/pkgconfig")

FetchContent_Declare(
        fetch_zlib
        ${ZLIB_FETCH_INFO}
)
FetchContent_GetProperties(fetch_zlib)
if (NOT fetch_zlib_POPULATED)
    FetchContent_Populate(fetch_zlib)
    add_subdirectory(${fetch_zlib_SOURCE_DIR} ${fetch_zlib_BINARY_DIR})
endif ()

install(TARGETS zlibstatic EXPORT zlibTargets)
