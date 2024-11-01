# Glass's Custom Bash Environment

This repository is designed to add some dazzle and utility to a fresh stock bash environment with minimal permissions required.

## Contents

- [`setup.sh`](setup.sh): Initializes shell environment:

  - Adds `source <glass-bash/main.sh` line to `~/.bashrc`
  - Checks for SSH key, creates if missing
  - Sets Git user name and email (user input) if not already set

- [`main.sh`](main.sh): File sourced by `~/.bashrc` that handles most of the shell configuration and sourcing of other files
- [`scripts/`](scripts): Contains all custom content, including:

  - [aliases](scripts/aliases.sh) - custom aliases
  - [functions](scripts/functions.sh) - custom functions
  - [options](scripts/options.sh) - commentable options like extended regex matching and history file appending
  - [prompt.sh](scripts/prompt.sh) - custom, colorized, and informational prompt
  - etc.

- [bash-tips](bash-tips): Just some useful chunks of bash code

## Setup

1. Clone the repo:
   `$ git clone http://github.com/glass-ships/glass-bash.git`

2. Initialize new environment:
   `$ cd glass-bash && bash setup.sh`

3. (Optional) Store any secrets as environment variables. Create a file called `secrets.json` in the root of the repo.

   - This file is ignored by git, so your secrets are safe if you contribute to this repository.  
     The format should be:

   ```json
   {
      "SECRET_ONE": "SECRET_VALUE",
      "SECRET_TWO": "OTHER_SECRET_VALUE"
      ...
   }
   ```

4. Enjoy!

## Contributing

This repo could probably use some regular TLC. If you're interested in helping out, just create an issue, or fork the repo and merge request back in!

~ Glass
