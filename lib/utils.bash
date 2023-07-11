#!/usr/bin/env bash

set -euo pipefail

P4_REPO="https://filehost.perforce.com/perforce"
TOOL_NAME="p4"
TOOL_TEST="p4 -V"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_p4_releases() {
	curl -sL "${P4_REPO}" \
		| grep -o "r[0-9]*.[0-9]*/" \
		| sed 's/r\(.*\)\//\1/' \
		| uniq
}

filter_available() {
	xargs -P5 -I%% curl -sIw '%%=%{http_code}\n' -o /dev/null "${P4_REPO}/r%%/bin.linux26x86_64/${TOOL_NAME}" \
	| sed -n 's/=200$//p'
}


list_all_versions() {
	list_p4_releases \
		| filter_available
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	case $(uname | tr '[:upper:]' '[:lower:]') in
	linux*)
		local platform="linux26x86_64"
		;;
	*)
		fail "Platform download not supported."
		;;
	esac

	url="${P4_REPO}/r${version}/bin.${platform}/${TOOL_NAME}"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
