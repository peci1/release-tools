set SCRIPT_DIR="%~dp0"

call "%SCRIPT_DIR%/lib/windows_configuration.bat"

set VCS_DIRECTORY=ign-common
set PLATFORM_TO_BUILD=x86_amd64
set IGN_CLEAN_WORKSPACE=true
set DEPEND_PKG=FreeImage-vc12-x64-release-debug.zip dlfcn-win32-vc12-x64-release-debug.zip

call "%SCRIPT_DIR%/lib/project-default-devel-windows.bat"
