set CURRENT_DIR=%~dp0
set PROJECT_DIR=%CURRENT_DIR%..
set TOP_BUILD_DIR=%CURRENT_DIR%..\build\

mkdir %TOP_BUILD_DIR%


rem ==================================================


call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars32.bat"


set BUILD_ARCH=Win32
set BUILD_CONFIG=Debug
set BUILD_DIR=%TOP_BUILD_DIR%build-windows-%BUILD_ARCH%-%BUILD_CONFIG%
set DIST_DIR=%TOP_BUILD_DIR%dist\windows-%BUILD_ARCH%-%BUILD_CONFIG%
echo "Build start: %BUILD_ARCH%-%BUILD_CONFIG%"
%CURRENT_DIR%\win-build-one.bat

set BUILD_ARCH=Win32
set BUILD_CONFIG=RelWithDebInfo
set BUILD_DIR=%TOP_BUILD_DIR%build-windows-%BUILD_ARCH%-%BUILD_CONFIG%
set DIST_DIR=%TOP_BUILD_DIR%dist\windows-%BUILD_ARCH%-%BUILD_CONFIG%
echo "Build start: %BUILD_ARCH%-%BUILD_CONFIG%"
%CURRENT_DIR%\win-build-one.bat


rem ==================================================


call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"


set BUILD_ARCH=x64
set BUILD_CONFIG=Debug
set BUILD_DIR=%TOP_BUILD_DIR%build-windows-%BUILD_ARCH%-%BUILD_CONFIG%
set DIST_DIR=%TOP_BUILD_DIR%dist\windows-%BUILD_ARCH%-%BUILD_CONFIG%
echo "Build start: %BUILD_ARCH%-%BUILD_CONFIG%"
%CURRENT_DIR%\win-build-one.bat


set BUILD_ARCH=x64
set BUILD_CONFIG=RelWithDebInfo
set BUILD_DIR=%TOP_BUILD_DIR%build-windows-%BUILD_ARCH%-%BUILD_CONFIG%
set DIST_DIR=%TOP_BUILD_DIR%dist\windows-%BUILD_ARCH%-%BUILD_CONFIG%
echo "Build start: %BUILD_ARCH%-%BUILD_CONFIG%"
%CURRENT_DIR%\win-build-one.bat


rem ==================================================

