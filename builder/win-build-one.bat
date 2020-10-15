mkdir %BUILD_DIR%
cd %BUILD_DIR%

cmake -A %BUILD_ARCH% %PROJECT_DIR%
cmake --build . --config %BUILD_CONFIG%
cmake --install . --config %BUILD_CONFIG% --prefix %DIST_DIR%

