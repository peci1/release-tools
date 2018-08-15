#!/bin/bash -x

# Knowing Script dir beware of symlink
[[ -L ${0} ]] && SCRIPT_DIR=$(readlink ${0}) || SCRIPT_DIR=${0}
SCRIPT_DIR="${SCRIPT_DIR%/*}"

# the tarball shipped by subt is generated by catkin_make and not compatible
# to be reused by catkin tools
export USE_CATKIN_MAKE=true
export DOCKER_JOB_NAME="subt_robot_examples_tarball"

export INFO_FILE="${WORKSPACE}/repos.info.txt"

if [[ ${DISTRO} == "bionic" ]]; then
  export ROS_DISTRO="melodic"
fi

. ${SCRIPT_DIR}/lib/boilerplate_prepare.sh

# drop sources in the catkin workspace
export ROS_WS_PREBUILD_HOOK="""
rm -f ${INFO_FILE}

ROBOT_EXAMPLE_REPOS=\"\"\"clearpathrobotics/LMS1xx.git
tu-darmstadt-ros-pkg/hector_gazebo.git
husky/husky.git
ros-visualization/interactive_marker_twist_server.git
jackal/jackal.git
jackal/jackal_desktop.git
jackal/jackal_simulator.git
ros-drivers/joystick_drivers.git
fkie/multimaster_fkie.git
ros-perception/pointcloud_to_laserscan.git
ros-drivers/pointgrey_camera_driver.git
ros-teleop/teleop_twist_joy.git
ros-teleop/twist_mux.git
ros-teleop/twist_mux_msgs.git
\"\"\"

for repo in \${ROBOT_EXAMPLE_REPOS}; do
  [[ -d \${repo} ]] && rm -fr \${repo}
  git clone https://github.com/\${repo} \${repo#*/}
  cd \${repo#*/}
    echo \${repo} >> ${INFO_FILE}
    git show-ref HEAD >> ${INFO_FILE}
    if [[ \${repo} == clearpathrobotics/LMS1xx.git ]]; then
      find . -name *.h -exec sed -i -e 's:logDebug:CONSOLE_BRIDGE_logDebug' {} \\;
      find . -name *.h -exec sed -i -e 's:logError:CONSOLE_BRIDGE_logError' {} \\;
      find . -name *.cpp -exec sed -i -e 's:logDebug:CONSOLE_BRIDGE_logDebug' {} \\;
      find . -name *.cpp -exec sed -i -e 's:logError:CONSOLE_BRIDGE_logError' {} \\;
    fi
  cd -
done
"""

export ROS_SETUP_POSTINSTALL_HOOK="""
TIMESTAMP=\$(date '+%Y%m%d')
cp ${INFO_FILE} install/
tar cvzf subt_robot_examples_latest.tgz install/
mv subt_robot_examples_latest.tgz ${WORKSPACE}/pkgs/
# copy of latest into the timestamped tarball
cp ${WORKSPACE}/pkgs/subt_robot_examples_latest.tgz \
   ${WORKSPACE}/pkg/subt_robot_examples_\${TIMESTAMP}.tgz
"""

# Generate the first part of the build.sh file for ROS
. ${SCRIPT_DIR}/lib/_ros_setup_buildsh.bash "fake"

DEPENDENCY_PKGS="git ${ROS_CATKIN_BASE}"
USE_ROS_REPO=true
OSRF_REPOS_TO_USE="stable"

. ${SCRIPT_DIR}/lib/docker_generate_dockerfile.bash
. ${SCRIPT_DIR}/lib/docker_run.bash
