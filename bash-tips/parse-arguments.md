## __Bash: Parsing Arguments: `getopt`__

- `-o` - for short options like `-v`
- `-l` - for long options with double dash like `--version`
- `,` - separates different long options
- `:` - means the argument expects a value (`::` means argument is optional)
- `-a` - for long options with single dash like -version
- `$@` - all command line parameters passed to the script.

For more information, see [man page](https://linux.die.net/man/1/getopt)

Example:
```bash
showHelp() {
    cat <<EOL

Usage: $0 [option...] 
Options:
    -h, --help       Show this help message and exit
    -o, --option     Option to run with
    -v, --value      Option to run with a value
EOL
}

options=$(getopt -l "help,option,value" -o "hov:" -a -- "$@")
if [ $? -ne 0 ]; then
    showHelp
    exit 1
fi
eval set -- "$options"
unset options

while true; do
    case $1 in
    -h | --help)
        showHelp
        exit 0
        ;;
    -o | --option)
        option=true
        shift
        ;;
    -v | --value)
        value="$2"
        shift 2
        ;;
    --)
        shift $(($OPTIND))
        remaining_args="$@"
        break
        ;;
    *)
        printf "\nInvalid option: $1\n"
        exit 1
        ;;
    esac
done

if [ "$option" = true ]; then
    printf "\nRunning with 'option'"
fi

if [ "$value" ]; then
    printf "\nRunning with value: $value"
fi

printf "\nRemaining args: $remaining_args"

```