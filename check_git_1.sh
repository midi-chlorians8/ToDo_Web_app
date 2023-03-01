#!/usr/bin/env bash 

# checks if branch has something pending
function parse_git_dirty() {
  git diff --quiet --ignore-submodules HEAD 2>/dev/null; [ $? -eq 1 ] && echo "*"
}

# gets the current git branch
function parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# get last commit hash prepended with @ (i.e. @8a323d0)
function parse_git_hash() {
  git rev-parse --short HEAD 2> /dev/null | sed "s/\(.*\)/@\1/"
}

# DEMO
GIT_BRANCH=$(parse_git_branch)$(parse_git_hash)
echo ${GIT_BRANCH}

NEW_GIT_BRANCH=abc
while 1>0
do
        echo "cycle"
        sleep 1

        git pull
        echo "I made git pull"

        GIT_BRANCH=$(parse_git_branch)$(parse_git_hash)
        echo GIT_BRANCH: ${GIT_BRANCH}

        if [ "$NEW_GIT_BRANCH" != "$GIT_BRANCH" ];  then
        NEW_GIT_BRANCH=$GIT_BRANCH

        echo GIT_BRANCH: $GIT_BRANCH
        echo NEW_GIT_BRANCH: $GIT_BRANCH

        sudo docker-compose up -d --no-deps --build web
        fi

        
done