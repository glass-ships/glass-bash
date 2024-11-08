if [[ -n "$CONDA_SHLVL" ]]; then
    export CONDACONFIGDIR=""
    cd() { builtin cd "$@" &&
        if [ -f $PWD/.condaconfig ]; then
            export CONDACONFIGDIR=$PWD
            conda activate $(cat .condaconfig)
        elif [ "$CONDACONFIGDIR" ]; then
            if [[ $PWD != *"$CONDACONFIGDIR"* ]]; then
                export CONDACONFIGDIR=""
                conda deactivate
            fi
        fi; }
fi
