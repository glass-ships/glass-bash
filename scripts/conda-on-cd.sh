# if [[ -n "$CONDA_SHLVL" ]]; then
#     export CONDACONFIGDIR=""
#     cd() { builtin cd "$@" &&
#         if [ -f $PWD/.condaconfig ]; then
#             export CONDACONFIGDIR=$PWD
#             conda activate $(cat .condaconfig)
#         elif [ "$CONDACONFIGDIR" ]; then
#             if [[ $PWD != *"$CONDACONFIGDIR"* ]]; then
#                 export CONDACONFIGDIR=""
#                 conda deactivate
#             fi
#         fi; }
# fi

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
