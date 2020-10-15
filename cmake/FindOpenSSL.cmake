set(_OPENSSL_FIND_DIR ${BUILDING_INSTALL_PREFIX})

if ("${BUILDING_LIBRARY_OPENSSL_LINK_TYPE}" MATCHES "static")
    set(OPENSSL_CRYPTO_NAMES libcrypto_static crypto_static)
    set(OPENSSL_SSL_NAMES    libssl_static ssl_static)
elseif("${BUILDING_LIBRARY_OPENSSL_LINK_TYPE}" MATCHES "dynamic")
    set(OPENSSL_CRYPTO_NAMES libcrypto crypto)
    set(OPENSSL_SSL_NAMES    libssl ssl)
else()
    set(OPENSSL_CRYPTO_NAMES libcrypto crypto libcrypto_static crypto_static)
    set(OPENSSL_SSL_NAMES    libssl ssl libssl_static ssl_static)
endif()

# Try each search configuration.
find_path(OPENSSL_INCLUDE_DIR NAMES openssl/opensslv.h PATHS ${_OPENSSL_FIND_DIR} PATH_SUFFIXES include)

find_library(SSL_LIBRARY    NAMES ${OPENSSL_CRYPTO_NAMES} NAMES_PER_DIR PATHS ${_OPENSSL_FIND_DIR} PATH_SUFFIXES lib)
find_library(CRYPTO_LIBRARY NAMES ${OPENSSL_SSL_NAMES}    NAMES_PER_DIR PATHS ${_OPENSSL_FIND_DIR} PATH_SUFFIXES lib)

mark_as_advanced(OPENSSL_INCLUDE_DIR)

if (SSL_LIBRARY AND CRYPTO_LIBRARY)
    set(OPENSSL_FOUND 1)
endif()

if(OPENSSL_FOUND)
    set(OPENSSL_INCLUDE_DIRS ${OPENSSL_INCLUDE_DIR})

    if(NOT OPENSSL_LIBRARIES)
        set(OPENSSL_LIBRARIES ${SSL_LIBRARY} ${CRYPTO_LIBRARY})
    endif()

    if(NOT TARGET OpenSSL::Crypto)
        add_library(OpenSSL::Crypto UNKNOWN IMPORTED)
        set_target_properties(OpenSSL::Crypto PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES "${OPENSSL_INCLUDE_DIRS}")
        set_target_properties(OpenSSL::Crypto PROPERTIES
                IMPORTED_LOCATION "${CRYPTO_LIBRARY}")
    endif()

    if(NOT TARGET OpenSSL::SSL)
        add_library(OpenSSL::SSL UNKNOWN IMPORTED)
        set_target_properties(OpenSSL::SSL PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES "${OPENSSL_INCLUDE_DIRS}")
        set_target_properties(OpenSSL::SSL PROPERTIES
                IMPORTED_LOCATION "${SSL_LIBRARY}")
    endif()
endif()
