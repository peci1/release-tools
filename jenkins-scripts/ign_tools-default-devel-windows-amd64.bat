set SCRIPT_DIR=%~dp0

set VCS_DIRECTORY=ign-tools
set PLATFORM_TO_BUILD=x86_amd64
set IGN_CLEAN_WORKSPACE=true
set ENABLE_TESTS=false

set COLCON_PACKAGE=ignition-tools
set COLCON_AUTO_MAJOR_VERSION=true

call "%SCRIPT_DIR%\lib\colcon-default-devel-windows.bat"
