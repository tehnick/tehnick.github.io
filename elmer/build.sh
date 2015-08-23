#!/bin/sh -f 
# Compile Elmer modules and install it

export ELMER_HOME=/mnt/other/elmer

# replace these with your compilers:
export CC=gcc
export CXX=g++
export FC=gfortran
export F77=gfortran


export ELMERGUI_HOME=$ELMER_HOME/bin
modules="matc umfpack mathlibs elmergrid meshgen2d eio hutiter fem post elmerparam front" 

for m in $modules; do
  cd $m
  chmod uog=rwx ./configure
  ./configure --prefix="$ELMER_HOME"
  make
  make install
  cd .. 
done

cd ElmerGUI
qmake
make
make install
cp Application/edf-extra/* $ELMER_HOME/bin/edf/
cd ..

cd ElmerGUIlogger
qmake -project
qmake
make
make install
cp ./ElmerGUIlogger $ELMERGUI_HOME
cd ..
