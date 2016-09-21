if [[ "$(docker-machine status default)" == "Running" ]]; then
	eval $(docker-machine env default)
fi
