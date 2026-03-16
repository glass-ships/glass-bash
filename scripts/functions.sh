#!/usr/bin/env bash

# trim whitespace (leading and trailing only)
function trim() {
	local var="$*"
	# remove leading whitespace characters
	var="${var#"${var%%[![:space:]]*}"}"
	# remove trailing whitespace characters
	var="${var%"${var##*[![:space:]]}"}"
	echo -n "$var"
}

# ls after cd
function cs() {
	cd "$@"
	ls -al
}

# mv, create dir if not exists
function move() {
	local args=("$@")
	local target
	local files
	target=$(trim "${args[@]: -1}")
	files=("${args[@]:0:${#args[@]}-1}")
	[[ ! -d $target ]] && mkdir -p "$target"
	mv "${files[@]}" "$target"
}

# rm all except listed files
function keep() {
	local IFS='|'
	find . -type f | grep -v -E "$*" | xargs rm -rf
}

### Cloudflare stuff

function update-cloudflared() {
	if command -v apt &>/dev/null; then
		# Debian/Ubuntu
		wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
		sudo dpkg -i cloudflared-linux-amd64.deb
		rm cloudflared-linux-amd64.deb
	elif command -v pacman &>/dev/null; then
		# Arch Linux
		wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
		chmod +x cloudflared-linux-amd64
		sudo mv cloudflared-linux-amd64 /usr/local/bin/cloudflared
	else
		echo "Unsupported distribution - please install cloudflared manually"
		return 1
	fi
}

### Python env stuff

# Automatically activate/deactivate virtual environments on directory change
cd() {
	builtin cd "$@" &&
		if [ -f "$PWD"/.venv/Scripts/activate ]; then
			. .venv/Scripts/activate
			export VENVDIR=$PWD
		elif [ -f "$PWD"/.venv/bin/activate ]; then
			. .venv/bin/activate
			export VENVDIR=$PWD
		elif [ -f "$PWD"/.condaconfig ] && [ -n "$CONDA_SHLVL" ]; then
			micromamba activate "$(cat .condaconfig)"
			export VENVDIR=$PWD
			export ISCONDAENV=1
		elif [ "$VENVDIR" ]; then
			if [[ $PWD != *"$VENVDIR"* ]]; then
				micromamba deactivate || deactivate
				export VENVDIR=""
			fi
		fi
}
