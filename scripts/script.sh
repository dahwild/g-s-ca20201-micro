#!/bin/bash
if [ -z "$secrets" ]
then
	echo " no variables from Secret Manager "
else
	limit="$(echo $secrets | jq lenght)"
	x=0
	while [ $x -ne $limit ]
	do
		variable_name="$(echo $secrets | jq '. | keys' | jq ".[$x] | sed -e "s/\"//g")"
		variable_value="$(echo $secrets | jq ".$variable_name" | sed -e "s/\"//g")"
		export "$variable_name"="$variable_value"
		x=$(( $x + 1 ))
	done
	echo "$limit variables imported from AWS Secret Manager"
fi
