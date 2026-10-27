
git-add-cherry-all() {
	local -
	set -e

	git add -A
	git commit -m "$1"

	sha=$(git rev-parse HEAD)
	cur=$(git branch --show-current)

	for b in $(git for-each-ref --format='%(refname:short)' refs/heads/); do
		if [ "$b" != "$cur" ]; then
			git switch -q "$b"
			git cherry-pick -x "$sha"
		fi
	done

	git switch -q "$cur"
}

git-cherry-all() (
	set -e

	git commit -m "$1"

	sha=$(git rev-parse HEAD)
	cur=$(git branch --show-current)

	# stash what wasn't committed so it can't block switch/cherry-pick
	stashed=
	if [ -n "$(git status --porcelain)" ]; then
		git stash push -q --include-untracked -m "git-cherry-all"
		stashed=1
	fi
	trap 'git switch -q "$cur"; if [ -n "$stashed" ]; then git stash pop -q; fi' EXIT

	for b in $(git for-each-ref --format='%(refname:short)' refs/heads/); do
		if [ "$b" != "$cur" ]; then
			git switch -q "$b"
			if ! git cherry-pick -x "$sha"; then
				git cherry-pick --abort
				echo "git-cherry-all: skipped $b (cherry-pick failed)" >&2
			fi
		fi
	done
)


