- Set script location as working directory
    ```bash
    #!/bin/bash
    export DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
    echo Script directory: $DIR
    ```

-  Push a repository commit-by-commit (useful for very large repositories)

    ```bash
    git log --reverse --oneline | sed -n '0~2p' | awk '{print "git push gitlab "$1":refs/heads/master"}' | while read i; do eval $i; done  
    ```

- Generic CMake clean function (requires `set opt -s globstar`)
    ```bash
    bash -c 'rm -rf **/*~ **/__pycache__ build dist *.egg-info **/*.so **/*.pyc'
    ```

- Docker: Save current container state (in second terminal)  
    ```bash 
    docker commit <containerid> <new-container-name>```
