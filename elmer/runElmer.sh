#!/bin/sh

export ELMER_HOME=/home/user/elmer

case "$1" in
    "-h"|"-help"|"--help")
        echo "This is a simple script for setting environment variables and launching ElmerGUIlogger."
        echo "ELMER_HOME now is set to: $ELMER_HOME"
        ;;
    *)
        export ELMERGUI_HOME=$ELMER_HOME/bin
        export ELMER_POST_HOME=$ELMERGUI_HOME
        export ELMER_LIB="$ELMER_HOME/lib:$ELMER_HOME/share/elmersolver/lib:$ELMER_HOME/share/elmerpost/lib:$ELMER_HOME/share/elmerfront/lib"
        export PATH=$ELMER_HOME/bin:$ELMER_HOME/lib:$ELMER_HOME/share/elmersolver/lib:$PATH
        export LD_LIBRARY_PATH="${ELMER_LIB}:${LD_LIBRARY_PATH}"
        unset  ELMER_LIB

        # nohup $ELMERGUI_HOME/ElmerGUIlogger
        $ELMERGUI_HOME/ElmerGUIlogger &
        ;;
esac

