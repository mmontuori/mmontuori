#!/bin/bash

function cls {
	docker container ls
}

function clogs {
	docker logs $*
}

function cexec {
	docker exec -ti $* /bin/bash
}
