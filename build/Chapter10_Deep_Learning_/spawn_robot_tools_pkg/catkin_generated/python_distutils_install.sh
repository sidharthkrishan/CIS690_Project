#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/sid/CIS690/src/Chapter10_Deep_Learning_/spawn_robot_tools_pkg"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/sid/CIS690/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/sid/CIS690/install/lib/python2.7/dist-packages:/home/sid/CIS690/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/sid/CIS690/build" \
    "/usr/bin/python2" \
    "/home/sid/CIS690/src/Chapter10_Deep_Learning_/spawn_robot_tools_pkg/setup.py" \
    build --build-base "/home/sid/CIS690/build/Chapter10_Deep_Learning_/spawn_robot_tools_pkg" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/sid/CIS690/install" --install-scripts="/home/sid/CIS690/install/bin"
