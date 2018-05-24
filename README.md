# bash_env

#### My personal Bash environment

To use it, follow these steps:

1. Install Hub: https://hub.github.com/
2. Run the following command: `git clone --recursive -j8 https://github.com/glass-ships/bash_env.git ~/bash_env`
3. Add the following to your `~/.bashrc`:
  ```bash
  cd ~/bash_env
  source main
  cd -
  ```
4. Start a new session and enjoy!

*Note, some submodules may fail to clone automatically. If you encounter this, remove the affected
 directories completely and clone the submodules directly within bash_env/, for example:*
```
$ cd ~/bash_env
$ rm -rf bblib
$ git clone https://github.com/MrDrMcCoy/bblib.git
```
