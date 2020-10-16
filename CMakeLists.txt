cmake_minimum_required(VERSION 3.8)
project(libraries_builder)

include(FetchContent)
include(ExternalProject)

##### CONFIG START #####
set(BUILDING_USE_MSVC_STATIC_RUNTIME OFF)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set(GRPC_VERSION v1.32.0)
set(GRPC_FETCH_INFO
        GIT_REPOSITORY https://github.com/grpc/grpc.git
        GIT_TAG        48fa2473046007138a9a932e37db8c92132a15a5
        )

set(ZLIB_VERSION v1.2.11)
set(ZLIB_FETCH_INFO
        GIT_REPOSITORY https://github.com/madler/zlib.git
        GIT_TAG        cacf7f1d4e3d44d871b605da3b647f07d718623f
        )

set(PROTOBUF_VERSION v3.13.0)
set(PROTOBUF_FETCH_INFO
        GIT_REPOSITORY https://github.com/protocolbuffers/protobuf.git
        GIT_TAG        fde7cf7358ec7cd69e8db9be4f1fa6a5c431386a # v3.13.0
        )
set(PROTOBUF_BUILD_SHARED_LIBS OFF)

set(OPENSSL_1_1_VERSION 1.1.1h)
set(OPENSSL_1_1_FETCH_INFO
        URL https://www.openssl.org/source/openssl-1.1.1h.tar.gz
        URL_HASH SHA256=5c9ca8774bd7b03e5784f26ae9e9e6d749c9da2438545077e6b3d755a06595d9
        )

set(SQLCIPHER_VERSION v4.4.0)
set(SQLCIPHER_FETCH_INFO
        URL      https://github.com/sqlcipher/sqlcipher/archive/v4.4.0.tar.gz
        URL_HASH SHA256=0924b2ae1079717954498bda78a30de20ce2a6083076b16214a711567821d148
        )

set(FINDJNI_JAVA_HOME_X86_32 "C:/Program Files (x86)/ojdkbuild/java-1.8.0-openjdk-1.8.0.265-1")
set(FINDJNI_JAVA_HOME_X86_64 "C:/Program Files/ojdkbuild/java-1.8.0-openjdk-1.8.0.265-1")
##### CONFIG END #####

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

if("${CMAKE_GENERATOR}" MATCHES "(Win64|IA64)")
    set(X64 1)
endif()

if(CMAKE_CL_64)
    set(X64 1)
endif()

get_property(isMultiConfig GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
if (isMultiConfig)
    set(_PROPAGATE_BUILD_TYPE "--config $<CONFIG>")
else()
    set(_PROPAGATE_BUILD_TYPE "-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}")
endif()

if (MSVC)
    configure_file(${CMAKE_CURRENT_SOURCE_DIR}/msvc-toolset-version.txt.in ${CMAKE_CURRENT_BINARY_DIR}/msvc-toolset-version.txt @ONLY)
endif()

set(BUILDING_INSTALL_PREFIX ${CMAKE_CURRENT_BINARY_DIR}/output)
set(BUILDING_CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(zlib.cmake)
include(openssl-1_1.cmake)
include(sqlcipher.cmake)
include(protobuf.cmake)
include(grpc.cmake)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/cmake/ DESTINATION "cmake")
install(DIRECTORY ${BUILDING_INSTALL_PREFIX}/ DESTINATION ".")

if (MSVC)
    install(FILES ${CMAKE_CURRENT_BINARY_DIR}/msvc-toolset-version.txt DESTINATION ".")
endif()

set(CMAKE_INSTALL_UCRT_LIBRARIES 1)
set(CMAKE_INSTALL_DEBUG_LIBRARIES $<CONFIG:Debug>)
include(InstallRequiredSystemLibraries)
