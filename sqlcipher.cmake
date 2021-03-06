set(NEW_LIST_SEPARATOR "<|>")

string(REPLACE ";" "${NEW_LIST_SEPARATOR}" _SQLCIPHER_FETCH_INFO "${SQLCIPHER_FETCH_INFO}")
string(REPLACE ";" "${NEW_LIST_SEPARATOR}" _SQLITE_JDBC_FETCH_INFO "${SQLITE_JDBC_FETCH_INFO}")

ExternalProject_Add(build_sqlcipher
        BUILD_ALWAYS TRUE
        GIT_REPOSITORY https://github.com/jc-lab/sqlcipher-cmake.git
        GIT_TAG        f72393fb02c1f5dd1e783c61cad9ff90f5414ef6
        INSTALL_DIR  ${BUILDING_INSTALL_PREFIX}
        LIST_SEPARATOR "${NEW_LIST_SEPARATOR}"
        CMAKE_ARGS
            ${_PROPAGATE_BUILD_TYPE}
            -DCMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}
            -DCMAKE_INSTALL_PREFIX=${BUILDING_INSTALL_PREFIX}
            -DBUILDING_INSTALL_PREFIX=${BUILDING_INSTALL_PREFIX}
            -DCOMMON_LIBRARY_ROOT_STATIC=${COMMON_LIBRARY_ROOT_STATIC}
            -DSQLCIPHER_FETCH_INFO:string=${_SQLCIPHER_FETCH_INFO}
            -DSQLITE_JDBC_FETCH_INFO:string=${_SQLITE_JDBC_FETCH_INFO}
            -DBUILDING_LIBRARY_OPENSSL_LINK_TYPE=dynamic
            -DFINDJNI_JAVA_HOME_X86_32=${FINDJNI_JAVA_HOME_X86_32}
            -DFINDJNI_JAVA_HOME_X86_64=${FINDJNI_JAVA_HOME_X86_64}
            -DFINDJNI_JAVA_HOME=${FINDJNI_JAVA_HOME}
            -DSQLCIPHER_JDBC_JNI=ON
            -DSQLCIPHER_JDBC_TARGET_NAME=sqlitejdbc
        )
