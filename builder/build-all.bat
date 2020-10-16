set CURRENT_DIR=%~dp0
set PROJECT_DIR=%CURRENT_DIR%..
set TOP_BUILD_DIR=%CURRENT_DIR%..\build\
set CLEAN_PATH=%PATH%

mkdir %TOP_BUILD_DIR%

set _EXIT_CODE=0

rem ==================================================


set PATH=%CLEAN_PATH%
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars32.bat"


set BUILD_ARCH=Win32
set BUILD_CONFIG=Debug
set BUILD_DIR=%TOP_BUILD_DIR%build-windows-%BUILD_ARCH%-%BUILD_CONFIG%
set DIST_DIR=%TOP_BUILD_DIR%dist\windows-%BUILD_ARCH%-%BUILD_CONFIG%
echo "Build start: %BUILD_ARCH%-%BUILD_CONFIG%"
call %CURRENT_DIR%\win-build-one.bat

set _EXIT_CODE=%errorlevel%
if %_EXIT_CODE% neq 0 goto BAT_EXIT

set BUILD_ARCH=Win32
set BUILD_CONFIG=RelWithDebInfo
set BUILD_DIR=%TOP_BUILD_DIR%build-windows-%BUILD_ARCH%-%BUILD_CONFIG%
set DIST_DIR=%TOP_BUILD_DIR%dist\windows-%BUILD_ARCH%-%BUILD_CONFIG%
echo "Build start: %BUILD_ARCH%-%BUILD_CONFIG%"
call %CURRENT_DIR%\win-build-one.bat

set _EXIT_CODE=%errorlevel%
if %_EXIT_CODE% neq 0 goto BAT_EXIT

rem ==================================================


set PATH=%CLEAN_PATH%
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"


set BUILD_ARCH=x64
set BUILD_CONFIG=Debug
set BUILD_DIR=%TOP_BUILD_DIR%build-windows-%BUILD_ARCH%-%BUILD_CONFIG%
set DIST_DIR=%TOP_BUILD_DIR%dist\windows-%BUILD_ARCH%-%BUILD_CONFIG%
echo "Build start: %BUILD_ARCH%-%BUILD_CONFIG%"
call %CURRENT_DIR%\win-build-one.bat

set _EXIT_CODE=%errorlevel%
if %_EXIT_CODE% neq 0 goto BAT_EXIT


set BUILD_ARCH=x64
set BUILD_CONFIG=RelWithDebInfo
set BUILD_DIR=%TOP_BUILD_DIR%build-windows-%BUILD_ARCH%-%BUILD_CONFIG%
set DIST_DIR=%TOP_BUILD_DIR%dist\windows-%BUILD_ARCH%-%BUILD_CONFIG%
echo "Build start: %BUILD_ARCH%-%BUILD_CONFIG%"
call %CURRENT_DIR%\win-build-one.bat

set _EXIT_CODE=%errorlevel%
if %_EXIT_CODE% neq 0 goto BAT_EXIT


rem ==================================================

:BAT_EXIT

rem CLEANUP

echo "_EXIT_CODE = %_EXIT_CODE%"

set PATH=%CLEAN_PATH%
cd %CURRENT_DIR%

exit /b %_EXIT_CODE%
