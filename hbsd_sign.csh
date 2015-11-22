#!/bin/csh

set _path=$1

if ( -f ${_path} ) then
	gpg --sign -a --detach -u 819B11A26FFD188D -o ${_path}{.asc,}
	if ( $? == 0 ) then
		echo "${_path} signed"
		exit 0
	else
		echo "${_path} sign failed"
		exit 1
	endif
else
	echo "${_path} is not a file!"
	exit 1
endif
