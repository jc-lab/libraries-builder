mkdir %BUILD_DIR%

cd %BUILD_DIR%
if %errorlevel% neq 0 exit /b %errorlevel%

cmake -A %BUILD_ARCH% %PROJECT_DIR%
if %errorlevel% neq 0 exit /b %errorlevel%

cmake --build . --config %BUILD_CONFIG%
rem if %errorlevel% neq 0 exit /b %errorlevel%

set /p BUILD_MSVC_TOOLSET_VERSION=< %BUILD_DIR%\msvc-toolset-version.txt

set DIST_DIR=%TOP_DIST_DIR%windows-%BUILD_ARCH%-msvc-v%BUILD_MSVC_TOOLSET_VERSION%-%BUILD_CONFIG%

cmake --install . --config %BUILD_CONFIG% --prefix %DIST_DIR%
if %errorlevel% neq 0 exit /b %errorlevel%

