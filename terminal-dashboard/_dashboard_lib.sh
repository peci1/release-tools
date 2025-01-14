#!/bin/bash

# TODO:jrivero https://github.com/ignition-tooling/release-tools/issues/551

get_libraries_by_collection()
{
    local COLLECTION=${1}

    if [ "$COLLECTION" = "citadel" ]; then
      LIBS="
	ignition-cmake2
	ignition-math6
	ignition-tools
	ignition-common3
	ignition-msgs5
	ignition-transport8
	ignition-fuel-tools4
	ignition-plugin
	ignition-rendering3
	sdformat9
	ignition-physics2
	ignition-sensors3
	ignition-gui3
	ignition-gazebo3
	ignition-launch2
	ignition-citadel"
    elif [ "$COLLECTION" = "edifice" ]; then
      LIBS="
	ignition-cmake2
	ignition-math6
	ignition-utils1
	ignition-tools
	ignition-common4
	ignition-msgs7
	ignition-transport10
	ignition-fuel-tools6
	ignition-plugin
	ignition-rendering5
	sdformat11
	ignition-physics4
	ignition-sensors5
	ignition-gui5
	ignition-gazebo5
	ignition-launch4
	ignition-edifice"
    elif [ "$COLLECTION" = "fortress" ]; then
      LIBS="
	ignition-cmake2
	ignition-math6
	ignition-utils1
	ignition-tools
	ignition-common4
	ignition-msgs8
	ignition-transport11
	ignition-fuel-tools7
	ignition-plugin
	ignition-rendering6
	sdformat12
	ignition-physics5
	ignition-sensors6
	ignition-gui6
	ignition-gazebo6
	ignition-launch5
	ignition-fortress"
    else
      return 1
    fi

    echo "$LIBS"
}
