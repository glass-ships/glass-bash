#!/usr/bin/env bash

# trim whitespace (leading and trailing only)
trim() {
	local var="$*"
	# remove leading whitespace characters
	var="${var#"${var%%[![:space:]]*}"}"
	# remove trailing whitespace characters
	var="${var%"${var##*[![:space:]]}"}"
	echo -n "$var"
}

# ls after cd
cs() {
	cd "$@" || return 1
	ls -al
}

# mv, create dir if not exists
move() {
	local args=("$@")
	local target
	local files
	target=$(trim "${args[@]: -1}")
	files=("${args[@]:0:${#args[@]}-1}")
	[[ ! -d $target ]] && mkdir -p "$target"
	mv "${files[@]}" "$target"
}

# rm all except listed files
keep() {
	local IFS='|'
	find . -type f | grep -v -E "$*" | xargs rm -rf
}

# Update all tools (uv, pixi, bun, rustup)
upd-tools() {
	printf "\nUpdating uv...\n" && uv self update || echo "Failed to update uv"
	printf "\nUpdating pixi...\n" && pixi self-update || echo "Failed to update pixi"
	printf "\nUpdating bun...\n" && bun upgrade || echo "Failed to update bun"
	printf "\nUpdating rustup...\n" && rustup update || echo "Failed to update rustup"
}

# Download latest VSCode and unpack to usual directory
upd-vscode() {
	(
		cd ~/dev/bin/vscode || exit 1
		keep data chrome-sandbox # Clean up old files, keep data/ and chrome-sandbox
		wget "https://code.visualstudio.com/sha/download?build=stable&os=linux-x64" -O vscode.tar.gz &&
			tar -xf vscode.tar.gz &&
			mv VSCode-linux-x64/* . &&
			rm -rf VSCode-linux-x64 vscode.tar.gz
	)
}

#####################################################################
### Cloudflare stuff

update-cloudflared() {
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

#####################################################################
### Python env stuff

# Automatically activate/deactivate virtual environments on cd
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
