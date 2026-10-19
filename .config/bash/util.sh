
git-cherry-all() {
	local -
	set -e
	git commit -am "$1"
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

