-  Push a repository commit-by-commit (useful for very large repositories)

    ```bash
    git log --reverse --oneline | sed -n '0~2p' | awk '{print "git push gitlab "$1":refs/heads/master"}' | while read i; do eval $i; done  
    ```

