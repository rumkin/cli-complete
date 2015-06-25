_node()
{
	COMPREPLY=();
	local current
	current="${COMP_WORDS[COMP_CWORD]}"

	if [ $COMP_CWORD -gt 1 ]
	then
		dir=$(dirname ${COMP_WORDS[1]})
		script="${dir}/cli-complete.js"

		if [ ! -f "${script}" ]
		then
			return 0
		fi

		cmd=${COMP_WORDS[0]}
		complete=("${COMP_WORDS[@]:2:COMP_CWORD-1}")

		opts=$($cmd $script "${complete[@]}")
	else
		_longopt
		return 0
	fi

	if [ ${#COMPREPLY} -eq 0 ]
	then
		COMPREPLY=( $(compgen -W "${opts[@]}" -- ${current}) )
	fi


	return 0
}
complete -F _node node
complete -F _node iojs
complete -F _node nodejs