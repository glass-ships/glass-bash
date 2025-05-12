# Automatically activate/deactivate virtual environments on directory change
cd() {
    builtin cd "$@" &&
        if [ -f $PWD/.condaconfig ] && [ -n "$CONDA_SHLVL" ]; then
            conda activate $(cat .condaconfig)
            export VENVDIR=$PWD
            export ISCONDAENV=1
        elif [ -f $PWD/.venv/Scripts/activate ]; then
            . .venv/Scripts/activate
            export VENVDIR=$PWD
        elif [ -f $PWD/.venv/bin/activate ]; then
            . .venv/bin/activate
            export VENVDIR=$PWD
        elif [ "$VENVDIR" ]; then
            if [[ $PWD != *"$VENVDIR"* ]]; then
                conda deactivate || deactivate
                export VENVDIR=""
            fi
        fi
}
