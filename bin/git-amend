#!/bin/sh -e
# Usage: git-amend <commit>
# Amend changes staged in the index to <commit>, or edit commit message if
# no changes are currently staged. Modifications not staged are stashed and
# then reapplied once the amend and rebase operations are complete.
#
# This command rewrites history. Do not run it after <commit> or its
# decendants have been published to the world.
#
# This version in POSIX sh by Ryan Tomayko <tomayko.com/about>
#
# Based on Mislav's bash version here:
# http://gist.github.com/278825

# NOTE removed check for staged files, since sometimes I just
# want to change the commit message.

TARGET="$1"
BRANCH=$(git name-rev HEAD | cut -d' ' -f2)

test -z "$TARGET" && {
  echo "$(basename $0): you must specify the target commit" 1>&2
  exit 1
}

# stash off work tree modifications leaving the
# index for amending to the target commit
git stash save -q --keep-index git-amend

# always restore from stash before exiting
trap 'git stash pop -q stash@{git-amend} 2>/dev/null' EXIT

# go back in history
git checkout -q "$TARGET" || {
  echo "$(basename $0): changes didn't apply cleanly" 1>&2
  exit 1
}

# amend the commit. this opens your editor
git commit -v --amend

# apply the remaining commits on this branch
git rebase --onto HEAD "$TARGET" "$BRANCH"
