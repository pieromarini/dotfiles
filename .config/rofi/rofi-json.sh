#!/bin/bash

user_file="$(eval echo ${1})"

if [[ "$user_file" = /* ]]
then
	config_file="$user_file"
else
	cwd=$(dirname $0)
	config_file="${cwd}/${user_file}"
fi

json=$(cat ${config_file})

if [ $# -eq 1 ]; then
	echo $json | jq --arg s $(date +"%d-%m-%Y") '
	[($s) | strptime("%d-%m-%Y")] as $r | map(select((.date[:10] | strptime("%d-%m-%Y")) as $d | $d == $r[0]))' | jq -cr '.[] | "\(.name)|\(.command)"' |
		while IFS="|" read -r name command
		do
			if [[ $name == "null" ]]; then
				continue
			fi        
			echo -en "${name}\0icon\x1f\n"
		done  
		exit 1
fi

if [ $# -eq 2 ]; then

	selected=$2
	date_today=$(date +"%d-%m-%Y")

	task=$(echo $json | jq ".[] | select(.name == \"$selected\" and .date == \"$date_today\")")

	if [[ $task == "" ]]; then
		exit 1
	fi

	command=$(echo $task | jq -j ".command")

	if [[ $command == "null" ]]; then
		command=$(echo $task | jq -j ".name")
	fi

	coproc bash -c "$command"
	exit

fi
