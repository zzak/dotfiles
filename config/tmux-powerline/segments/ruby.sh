# Prints the ruby version.

# Source lib to get the function get_tmux_pwd
source "${TMUX_POWERLINE_DIR_LIB}/tmux_adapter.sh"

generate_segmentrc() {
	echo "$rccontents"
}

__process_settings() {
        return 0
}

run_segment() {
	__process_settings
	local opts=""


        tmux_path=$(get_tmux_cwd)
        cd "$tmux_path"
        #cat .ruby-version
        ruby -e 'puts RUBY_VERSION'
	return 0
}
