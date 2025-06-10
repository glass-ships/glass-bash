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
	args="$@"
	target=$(trim "${args[@]: -1}")
	files=$(trim "${args[@]:0:-1}")
	[[ ! -d $target ]] && mkdir -p $target
	mv $files $target
}

# rm all except listed files
function keep() {
	local IFS='|'
	find . -type f | grep -v -E "$*" | xargs rm -rf
}

### Git Functions ###

# git add, commit -m, push
function ship() {
	git add -A
	git commit -am "$@"
	git push
}

# pull all repos in specified directories
function pull-all() {
	local current_dir=$(pwd)
	for dir in "$@"; do
		cd $dir
		printf "\nPulling all repos in $(pwd)...\n"
		for repo in $(ls -d */); do
			# if repo is a directory and has a .git directory
			[[ -d $repo && -d $repo/.git ]] || continue
			printf "————————————————————————————————————————\nPulling $repo\n"
			cd $repo
			git pull
			cd ..
		done
		printf "\nDone pulling all repos in $(pwd).\n"
		if [[ $current_dir != $dir ]]; then
			cd $current_dir
		fi
	done
}

# git delete local branches not on remote
function git-cleanup-branches() {
	# git branch --merged | grep -v "\*" | xargs -n 1 git branch -d
	git branch --merged main | grep -v '^[ *]*main$' | xargs -d'\n' git branch -d
}

# git some file
function git_file_gl() {
	# Arguments:
	# 1. the numeric project ID
	# 2. the file you want (incl. ext)
	# 3. the branch to pull from, or 'main' by default
	[[ -z $3 ]] && local branch="main" || local branch=$3
	curl --header "Private-Token: ${GITLAB_TOKEN}" "https://gitlab.com/api/v4/projects/$1/repository/files/$2/raw\?ref\=$3"
}

### Cloudflare stuff

function update-cloudflared() {
	wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
	sudo dpkg -i cloudflared-linux-amd64.deb
	rm cloudflared-linux-amd64.deb
}

### Conda stuff

function install-miniforge() {
	# Install Miniforge
	wget "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
	bash Miniforge3-$(uname)-$(uname -m).sh
	rm Miniforge3-$(uname)-$(uname -m).sh
}

function uninstall-miniforge() {
	if ! [ $# -eq 0 ] && [ $1 = "check" ]; then
		conda init --reverse --dry-run
		return
	else
		conda init --reverse
	fi
	CONDA_BASE_ENVIRONMENT=$(conda info --base)
	echo The next command will delete all files in ${CONDA_BASE_ENVIRONMENT}. Continue? [y/n]
	read -r response
	if [[ $response != [Yy]* ]]; then
		echo Aborting...
		return
	fi
	echo Deleting ${CONDA_BASE_ENVIRONMENT}
	rm -rf ${CONDA_BASE_ENVIRONMENT}
	echo ${HOME}/.condarc will be removed if it exists
	rm -f "${HOME}/.condarc"
	echo ${HOME}/.conda and underlying files will be removed if they exist.
	rm -fr ${HOME}/.conda
	echo Uninstall complete.
}
