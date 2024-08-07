#!/usr/bin/env bash

# Shell options
# shopt -s autocd         # cd to directory by name, without cd
shopt -s cdspell        # autocorrect directory names
shopt -s checkhash      # If set, Bash checks that a command found in the hash table exists before trying to execute it. If a hashed command no longer exists, a normal path search is performed.
shopt -s checkjobs      # warn about background jobs before exiting
shopt -s checkwinsize   # track window resizes
shopt -s cmdhist        # merge multiline commands in history
shopt -s dirspell       # perform spelling corrections on directory names to match a glob
shopt -s dotglob        # include .files in expansion
shopt -s expand_aliases # expand aliases
shopt -s extglob        # enable extended pattern matching
shopt -u failglob       # expansion failures will print error messages
shopt -s globstar       # enables ** recursive expansion
shopt -s gnu_errfmt     # use gnu error format
shopt -s histappend     # append to the history file, don't overwrite it
# shopt -s huponexit      # send SIGHUP to all subprocesses when a shell exists
# shopt -s lithist        # multi-line commands are saved to the history with embedded newlines rather than using semicolon separators where possible
# shopt -s nocaseglob     # matches filenames in a case-insensitive fashion when performing pathname expansion
# shopt -s nocasematch    # matches patterns in a case-insensitive fashion when performing matching while executing case or [[ conditional commands
# shopt -s xpg_echo       # the echo-builtin command expands backslash-escape sequences by default

# set -o notify
# set +o errexit
# set -o errtrace
# set -o functrace
# set +o nounset
# set +o pipefail
