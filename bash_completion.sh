_node()
{
	local current values value cmd tail script dir items

	COMPREPLY=();
	current="${COMP_WORDS[COMP_CWORD]}"

	if [ $COMP_CWORD -eq 1 ]
	then
			_longopt
    		return 0
	fi

	dir=$(dirname ${COMP_WORDS[1]})
	script="${dir}/cli-complete.js"

	if [ ! -f "${script}" ]
	then
		return 0
	fi

	cmd=${COMP_WORDS[0]}
	tail=("${COMP_WORDS[@]:2:COMP_CWORD-1}")
	values=($($cmd $script "${tail[@]}"))

	items=${#values[@]}
	complen=${#current}

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

	return 0
}
complete -F _node node
complete -F _node iojs
complete -F _node nodejs