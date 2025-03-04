#!/bin/bash

###
### This is a script that can be used to completely compile and
### install Sire from the current directory. This script will
### download and install miniconda, install openmm into that
### and will then configure and compile Sire in build/corelib
### and build/python
###

# Process arguments
key="$1"

case $key in
    -h|--help)
    echo "compile_sire.sh -h/--help shows help."
    echo "compile_sire.sh --install /path/to/sire.app will install Sire in /path/to/sire.app"
    echo "compile_sire.sh --clean completely cleans the build directory."
    exit 0
    ;;
    --install)
    INSTALL_SIRE_DIR="$2"
    echo "Installing Sire into ${INSTALL_SIRE_DIR}"
    ;;
    --clean)
    echo "Completely cleaning the build directories..."
    echo "rm -rf build/miniconda.sh build/corelib/* build/wrapper/*"
    rm -rf build/miniconda.sh build/corelib/* build/wrapper/*
    echo "...all clean"
    exit 0
    ;;
esac

# Set the version of miniconda to use. Choose "latest" for the latest
# miniconda, or set a specific version here
MINICONDA_VERSION="4.2.12"
#MINICONDA_VERSION="latest"

if [ -z "$INSTALL_SIRE_DIR" ]; then
    # Ask the user where they would like to install sire. By default
    # we will aim for $HOME/sire.app
    echo -n "Where would you like to install Sire? [$HOME/sire.app]: "
    read INSTALL_DIR

    if [ ! ${INSTALL_DIR} ]; then
        INSTALL_DIR=$HOME/sire.app
    else
        # Use eval so that we can expand variables such as $HOME
        INSTALL_DIR=`eval echo ${INSTALL_DIR}`
    fi
else
    INSTALL_DIR=`eval echo ${INSTALL_SIRE_DIR}`
fi

echo "Installing into directory '${INSTALL_DIR}'"

# Check whether or not miniconda has been downloaded and 
# installed into this directory
if [ -e "${INSTALL_DIR}/bin/python" ]; then
    # the miniconda distribution already exists.
    # We can now jump straight to the python install script
    echo "** Running the Python install script... **"
    echo "** ${INSTALL_DIR}/bin/python build/build_sire.py **"
    ${INSTALL_DIR}/bin/python build/build_sire.py
    exit 0
elif [ -e "${INSTALL_DIR}/python.exe" ]; then
    # the windows miniconda distribution already exists.
    # We can jump straight to the python install script
    echo "** Running the python install script... **"
    ${INSTALL_DIR}/python build/build_sire.py
    exit 0
fi

# Now work out if we are 32bit or 64bit...
LONG_BIT=$(getconf LONG_BIT)
OS_BIT=$(uname -m)

# (note that BIT_TYPE is the string used by miniconda to
#  denote a 32bit or 64bit operating system)
BIT_TYPE="x86_64"

if [ ${LONG_BIT} == "64" ]; then
    echo "64 bit processor"
elif [ ${LONG_BIT} == "32" ]; then
    echo "32 bit processor"
else
    echo "Unknown number of bits. Assuming 64 bit"
fi

if [ ${OS_BIT} == "x86_64" ]; then
    echo "64 bit operating system"
elif [ ${LONG_BIT} == "32" ]; then
    # must be 32 bit operating system on 32 bit processor
    echo "32 bit operating system"
    BIT_TYPE="x86"
elif [ ${OS_BIT} == "i386" | ${OS_BIT} == "i486" | ${OS_BIT} == "i586" | ${OS_BIT} == "i686" ]; then
    echo "32 bit operating system"
    BIT_TYPE="x86"
else
    echo "Assuming a 64 bit operating system."
    echo "If you want to change this, set BIT_TYPE to x86 here"
    #BIT_TYPE="x86"
fi

# Work out whether we are on OS X, Linux or Windows, and
# then download the appropriate miniconda distribution
if [ "$(uname)" == "Darwin" ]; then
    # This is running on a Mac
    PLATFORM="OSX"
    MINICONDA="https://repo.continuum.io/miniconda/Miniconda3-${MINICONDA_VERSION}-MacOSX-${BIT_TYPE}.sh"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # This is running on Linux
    PLATFORM="Linux"
    MINICONDA="https://repo.continuum.io/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-${BIT_TYPE}.sh"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # This is running on Windows NT
    echo "Compilation on windows is not supported."
    exit -1
elif [ "$(expr substr $(uname -s) 1 9)" == "CYGWIN_NT" ]; then
    # This is running on windows under cygwin
    echo "Running an install under cygwin on windows"
    PLATFORM="Windows"
    SUBPLATFORM="Cygwin"
    MINICONDA="https://repo.continuum.io/miniconda/Miniconda3-${MINICONDA_VERSION}-Windows-${BIT_TYPE}.exe"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    # This is running on windows under cygwin
    echo "Running an install under MSYS2 on windows"
    PLATFORM="Windows"
    SUBPLATFORM="MSYS2"
    MINICONDA="https://repo.continuum.io/miniconda/Miniconda3-${MINICONDA_VERSION}-Windows-${BIT_TYPE}.exe"
else
    # Cannot identify the platform. Tell the user to download
    # miniconda directly
    echo "Cannot identify your operating system / platform."
    echo "Please download and install miniconda manually, and then "
    echo "use the Python from that miniconda to run the build/build_sire.py script."
    PLATFORM="$(uname -s)"
    echo $PLATFORM
    exit -1
fi

if [ -e ${INSTALL_DIR} ]; then
    echo "Install directory already exists. Assuming that miniconda is already installed here."
else
    if [ ${PLATFORM} == "Windows" ]; then
        # Download miniconda.exe if it is not already in build/downloads
        if [ ! -e "build/miniconda.exe" ]; then
            echo "** Downloading miniconda from ${MINICONDA}... **"
            echo "curl ${MINICONDA} -o build/miniconda.exe"
            curl ${MINICONDA} -o build/miniconda.exe
            chmod a+x build/miniconda.exe
        fi

        # Now unpack miniconda and install it into the requested directory
        echo "Running the miniconda installation. Make sure you install miniconda just for yourself."
        echo "Also, ensure that you install miniconda into the directory 'C:\msys2\${INSTALL_DIR}'"
        echo "Also note that you should't select the option to 'add anaconda to the PATH' or to"
        echo "register anaconda as the default python"
        ./build/miniconda.exe
    else
        # Download miniconda if it is not already in build/downloads
        if [ ! -e "build/miniconda.sh" ]; then
            echo "** Downloading miniconda from ${MINICONDA}... **"
            echo "** wget ${MINICONDA} -O build/miniconda.sh 2>/dev/null || curl ${MINICONDA} -o build/miniconda.sh  **"
            wget ${MINICONDA} -O build/miniconda.sh 2>/dev/null || curl ${MINICONDA} -o build/miniconda.sh
        fi

        # Now unpack miniconda and install it into the requested directory
        echo "** Unpacking miniconda into ${INSTALL_DIR}... **"
        echo "** bash build/miniconda.sh -b -p ${INSTALL_DIR} **"
        bash build/miniconda.sh -b -p ${INSTALL_DIR}
    fi
fi

# Now set the MACOSX_DEPLOYMENT_TARGET to make sure
# that we can work with Mountain Lion or above
export MACOSX_DEPLOYMENT_TARGET="10.8"

# Now run the python install script
if [ -e "${INSTALL_DIR}/bin/python" ]; then
    echo "** Running the Python install script... **"
    echo "** ${INSTALL_DIR}/bin/python build/build_sire.py **"
    ${INSTALL_DIR}/bin/python build/build_sire.py
    exit $?
elif [ -e "${INSTALL_DIR}/python" ]; then
    echo "** Running the Python install script... **"
    echo "** ${INSTALL_DIR}/python build/build_sire.py **"
    ${INSTALL_DIR}/python build/build_sire.py
    exit $?
else
    echo "** FATAL **"
    echo "** Cannot find ${INSTALL_DIR}/bin/python **"
    echo "** Something went wrong with the miniconda install! **"
    echo "** Remove ${INSTALL_DIR}, then run compile_sire.sh --clean, then try again **"
    exit -1
fi

