# Glass's Custom Bash Environment

This repository is designed to add some dazzle and utility to a fresh stock bash environment with minimal permissions required.

## Contents ##

- [`setup.sh`](setup.sh): A script that moves things where they need to, initializes an ssh key, and sets the git username/email

- [`main`](main): File sourced by `~/.bashrc` that handles most of the shell configuration, such as: 
    - Fully colorized command prompt with extra info such as time, user, host, and working directory
    - Colorize errors, ls, etc. 
    - bash_completion
    - force git and ssh password entry in command line
  
- [`aliases`](aliases): Contains several convenience alias such as:
    - `pls` does a `sudo` with the user's PATH in tact
    - `env` is sorted by default, for readability
    - `docker-cleanup` removes any dangling Docker images
    - etc. 

- [`functions`](functions): Contains some useful functions such as:
    - `cs` does a `cd` then `ls`
    - `git_file_gl` downloads a single file from a GitLab repository

- [`options`](options): File with commentable options like extended regex matching and history file appending

- [ssh-config](ssh-config): An example ssh config file, gets placed by `secret.sh`

- [`vimrc`](vimrc): To make vim behave the way I personally like it to :) gets placed by `secret.sh`

- [`secrets-template`](secrets-template): A template for file exporting any API keys or secrets as environment variables

- [bash-tips](bash-tips): Contains some useful chunks of bash code

## Setup ##

1. Clone the repo:
`$ git clone http://github.com/glass-ships/glass-bash.git`

2. Initialize new environment:
`$ cd glass-bash && bash setup.sh`

3. Rename `secrets-template` to `secrets` and enter your private things to keep them safe 
    - `secrets` is ignored, so your secrets are safe if you contribute to this repository

4. Enjoy!

## Contributing

This repo could probably use some regular TLC. If you're interested in helping out, just create an issue, or fork the repo and merge request back in! 

~ Glass
