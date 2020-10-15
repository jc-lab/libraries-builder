set(_ZLIB_FIND_DIR ${BUILDING_INSTALL_PREFIX})

if ("${BUILDING_LIBRARY_ZLIB_LINK_TYPE}" MATCHES "static")
    set(ZLIB_NAMES zlibstatic)
    set(ZLIB_NAMES_DEBUG zlibstaticd)
elseif("${BUILDING_LIBRARY_ZLIB_LINK_TYPE}" MATCHES "dynamic")
    set(ZLIB_NAMES z zlib zdll zlib1)
    set(ZLIB_NAMES_DEBUG zd zlibd zdlld zlibd1 zlib1d)
else()
    set(ZLIB_NAMES z zlib zdll zlib1 zlibstatic)
    set(ZLIB_NAMES_DEBUG zd zlibd zdlld zlibd1 zlib1d zlibstaticd)
endif()

# Try each search configuration.
find_path(ZLIB_INCLUDE_DIR NAMES zlib.h PATHS ${_ZLIB_FIND_DIR} PATH_SUFFIXES include)

# Allow ZLIB_LIBRARY to be set manually, as the location of the zlib library
if(NOT ZLIB_LIBRARY)
    find_library(ZLIB_LIBRARY_RELEASE NAMES ${ZLIB_NAMES} NAMES_PER_DIR PATHS ${_ZLIB_FIND_DIR} PATH_SUFFIXES lib)
    find_library(ZLIB_LIBRARY_DEBUG NAMES ${ZLIB_NAMES_DEBUG} NAMES_PER_DIR PATHS ${_ZLIB_FIND_DIR} PATH_SUFFIXES lib)

    include(SelectLibraryConfigurations)
    select_library_configurations(ZLIB)
endif()

unset(ZLIB_NAMES)
unset(ZLIB_NAMES_DEBUG)

mark_as_advanced(ZLIB_INCLUDE_DIR)

if(ZLIB_INCLUDE_DIR AND EXISTS "${ZLIB_INCLUDE_DIR}/zlib.h")
    file(STRINGS "${ZLIB_INCLUDE_DIR}/zlib.h" ZLIB_H REGEX "^#define ZLIB_VERSION \"[^\"]*\"$")

    string(REGEX REPLACE "^.*ZLIB_VERSION \"([0-9]+).*$" "\\1" ZLIB_VERSION_MAJOR "${ZLIB_H}")
    string(REGEX REPLACE "^.*ZLIB_VERSION \"[0-9]+\\.([0-9]+).*$" "\\1" ZLIB_VERSION_MINOR  "${ZLIB_H}")
    string(REGEX REPLACE "^.*ZLIB_VERSION \"[0-9]+\\.[0-9]+\\.([0-9]+).*$" "\\1" ZLIB_VERSION_PATCH "${ZLIB_H}")
    set(ZLIB_VERSION_STRING "${ZLIB_VERSION_MAJOR}.${ZLIB_VERSION_MINOR}.${ZLIB_VERSION_PATCH}")

    # only append a TWEAK version if it exists:
    set(ZLIB_VERSION_TWEAK "")
    if( "${ZLIB_H}" MATCHES "ZLIB_VERSION \"[0-9]+\\.[0-9]+\\.[0-9]+\\.([0-9]+)")
        set(ZLIB_VERSION_TWEAK "${CMAKE_MATCH_1}")
        string(APPEND ZLIB_VERSION_STRING ".${ZLIB_VERSION_TWEAK}")
    endif()

    set(ZLIB_MAJOR_VERSION "${ZLIB_VERSION_MAJOR}")
    set(ZLIB_MINOR_VERSION "${ZLIB_VERSION_MINOR}")
    set(ZLIB_PATCH_VERSION "${ZLIB_VERSION_PATCH}")
endif()

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(ZLIB REQUIRED_VARS ZLIB_LIBRARY ZLIB_INCLUDE_DIR
        VERSION_VAR ZLIB_VERSION_STRING)

if(ZLIB_FOUND)
    set(ZLIB_INCLUDE_DIRS ${ZLIB_INCLUDE_DIR})

    if(NOT ZLIB_LIBRARIES)
        set(ZLIB_LIBRARIES ${ZLIB_LIBRARY})
    endif()

    if(NOT TARGET ZLIB::ZLIB)
        add_library(ZLIB::ZLIB UNKNOWN IMPORTED)
        set_target_properties(ZLIB::ZLIB PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES "${ZLIB_INCLUDE_DIRS}")

        if(ZLIB_LIBRARY_RELEASE)
            set_property(TARGET ZLIB::ZLIB APPEND PROPERTY
                    IMPORTED_CONFIGURATIONS RELEASE)
            set_target_properties(ZLIB::ZLIB PROPERTIES
                    IMPORTED_LOCATION_RELEASE "${ZLIB_LIBRARY_RELEASE}")
        endif()

        if(ZLIB_LIBRARY_DEBUG)
            set_property(TARGET ZLIB::ZLIB APPEND PROPERTY
                    IMPORTED_CONFIGURATIONS DEBUG)
            set_target_properties(ZLIB::ZLIB PROPERTIES
                    IMPORTED_LOCATION_DEBUG "${ZLIB_LIBRARY_DEBUG}")
        endif()

        if(NOT ZLIB_LIBRARY_RELEASE AND NOT ZLIB_LIBRARY_DEBUG)
            set_property(TARGET ZLIB::ZLIB APPEND PROPERTY
                    IMPORTED_LOCATION "${ZLIB_LIBRARY}")
        endif()
    endif()
endif()
