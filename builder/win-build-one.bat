mkdir %BUILD_DIR%

cd %BUILD_DIR%
if %errorlevel% neq 0 exit /b %errorlevel%

cmake -A %BUILD_ARCH% %PROJECT_DIR%
if %errorlevel% neq 0 exit /b %errorlevel%

cmake --build . --config %BUILD_CONFIG%
rem if %errorlevel% neq 0 exit /b %errorlevel%

cmake --install . --config %BUILD_CONFIG% --prefix %DIST_DIR%
if %errorlevel% neq 0 exit /b %errorlevel%

