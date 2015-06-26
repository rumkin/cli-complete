_node()
{
	COMPREPLY=();
	local current values value cmd complete script dir items

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
		values=($($cmd $script "${complete[@]}"))

		items=${#values[@]}
		complen=${#complete}

		if [ $items -eq 1 ]
		then
			COMPREPLY=( ${values[0]} )
		else
			for (( i=0; i<items; i++ ))
			do
				value=${values[$i]}
				if [ -n "${value}" ] && [ "${value:0:$complen}" == "$current" ]
				then
					COMPREPLY+=( ${values[$i]} )
				fi
			done
		fi
	else
		_longopt
		return 0
	fi



	return 0
}
complete -F _node node
complete -F _node iojs
complete -F _node nodejs