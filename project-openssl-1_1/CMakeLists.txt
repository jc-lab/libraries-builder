cmake_minimum_required(VERSION 3.8)
project(project-openssl)

include(FetchContent)

FetchContent_Declare(
        openssl
        GIT_REPOSITORY https://github.com/jc-lab/openssl-cmake.git
        GIT_TAG        837aef416ab093c634c7a3f67adb43aa17fb85f9
)
FetchContent_GetProperties(openssl)
if (NOT openssl_POPULATED)
    FetchContent_Populate(openssl)
    add_subdirectory(${openssl_SOURCE_DIR} ${openssl_BINARY_DIR})
endif ()

add_executable(openssl-1_1-dummy-static dummy.cc)
add_executable(openssl-1_1-dummy-shared dummy.cc)
target_link_libraries(openssl-1_1-dummy-static
        PRIVATE
        openssl_crypto_static
        openssl_ssl_static
        )
target_link_libraries(openssl-1_1-dummy-shared
        PRIVATE
        openssl_crypto_static
        openssl_ssl_static
        )

INSTALL(TARGETS
        openssl-1_1-dummy-static
        openssl-1_1-dummy-shared
        RUNTIME DESTINATION "tmp")
