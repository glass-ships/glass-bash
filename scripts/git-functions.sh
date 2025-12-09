#!/usr/bin/env bash

# git add, commit -m, push
function ship() {
	git add -A
	git commit -am "$@"
	git push
}

# pull all repos in specified directories
function pull-all() {
	local current_dir
	current_dir=$(pwd)
	for dir in "$@"; do
		(
			cd "$dir"
			printf "\n========================================"
			printf "\nPulling all repos in $(pwd)...\n"
			for repo in $(ls -d */); do
				( # if repo is a directory and has a .git directory
					if [[ -d "$repo" && -d "$repo/.git" ]]; then
						printf "————————————————————————————————————————\n"
						printf "Pulling $repo\n"
						cd "$repo"
						git pull
					fi
				)
			done
			printf "————————————————————————————————————————\n"
			printf "=== Finished in $(pwd) ==="
			if [[ $current_dir != "$dir" ]]; then
				cd "$current_dir" || exit 1
			fi
		)
	done
}

# git delete local branches not on remote
function git-cleanup-branches() {
	# git branch --merged | grep -v "\*" | xargs -n 1 git branch -d
	local default_branch
	default_branch=$(git remote show origin | sed -n '/HEAD branch/s/.*: //p')
	echo "$default_branch"
	git branch --merged "$default_branch" | grep -v "^[ *]*$default_branch$" | xargs -d'\n' git branch -d
}

function gl-clone() {
	# gitlab clone with personal token
	local url
	local TOKEN
	local org
	local repo
	local target_dir

	if [[ "$1" == "--ornl" || "$1" == "-o" ]]; then
		url="code.ornl.gov"
		TOKEN=$ORNL_PAT
		shift
	else
		url="gitlab.com"
		TOKEN=$GITLAB_PAT
	fi

	# check env for token
	if [[ -z "$TOKEN" ]]; then
		echo "Please set the GITLAB_PAT variable"
		return 1
	fi

	org="$1"
	repo="$2"
	target_dir="$3"

	# check if target dir is set
	if [[ -z "$target_dir" ]]; then
		target_dir="$repo"
	fi
	git clone "https://$TOKEN@$url/$org/$repo.git" "$target_dir"
}

# git some file
function git_file_gl() {
	# Arguments:
	# 1. the numeric project ID
	# 2. the file you want (incl. ext)
	# 3. the branch to pull from, or 'main' by default
	local branch
	if [[ -z "$3" ]]; then
		branch="main"
	else
		branch="$3"
	fi
	curl --header "Private-Token: ${GITLAB_TOKEN}" "https://gitlab.com/api/v4/projects/$1/repository/files/$2/raw\?ref\=$branch"
}
