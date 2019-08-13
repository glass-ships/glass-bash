# Glass's Custom Bash Environment

This repository is designed to add some dazzle and utility to a fresh stock bash environment with minimal permissions required.

## What's included

- An `init.sh` script which moves things where they need to, initializes an ssh key, and sets the git username/email
  - **Note - this init script sets me as the default git user; you may want to adjust this to reflect your own authorship**
- A template `bashrc` file you can use and add onto
  - I recommend putting any environment variable and script sourcing into your `.bashrc` for organization and to help ensure that your env variables after everything else
- A `main` file sourced by `bashrc` which handles most of the shell configuration, such as: 
  - Fully colorized command prompt with extra info such as time, user, host, and working directory
  - Colorize errors, ls, etc. 
  - bash_completion
  - force git and ssh password entry in command line
- Files for `aliases` and `functions` containing helpful commands like:
  - `cs` to `ls` after a `cd`
  - `pls` does a `sudo` with the user's PATH in tact
  - `env` is sorted by default, for readability
  - etc. (see `bash_env/aliases` for the rest)
- An `options` file with commentable options like extended regex matching and history file appending
- An example ssh config file, gets placed by `init.sh` script

## Installation

0. Move to home dir:
``$ cd ~``

1. Clone the repo:
``$ git clone http://github.com/glass-ships/bash_env.git``

2. Initialize new environment:
``$ bash bash_env/init.sh``

3. Enjoy!
