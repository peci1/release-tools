set SCRIPT_DIR="%~dp0"

set VCS_DIRECTORY=ign-common
set PLATFORM_TO_BUILD=x86_amd64
set IGN_CLEAN_WORKSPACE=true

set DEPEN_PKGS="dlfcn-win32 ffmpeg"

set COLCON_PACKAGE=ignition-common
set COLCON_AUTO_MAJOR_VERSION=true

call "%SCRIPT_DIR%/lib/colcon-default-devel-windows.bat"
