#!/bin/csh

set _out="/tmp/10-stable-dl.old"
set _pattern="HardenedBSD-10-STABLE_hardenedbsd-10-experimental-amd64.*.(img|iso) "

unlink ${_out}

foreach i ( `grep -r -E "${_pattern}" /var/log/apache/ny-01.build.hardenedbsd.org-access_log | awk '{print $1":"$7}' | sort | uniq` )
	echo $i
	echo $i >> ${_out}
	set i=`echo $i | cut -d ':' -f 1`
	host $i >> ${_out}
	geoiplookup $i >> ${_out}
	echo "-------" >> ${_out}
end

set _out="/tmp/10-stable-dl.new"
set _pattern="HardenedBSD-10-STABLE-v.*.(img|iso) "

unlink ${_out}

foreach i ( `grep -r -E "${_pattern}" /var/log/apache/installer.hardenedbsd.org-access_log | awk '{print $1":"$7}' | sort | uniq` )
	echo $i
	echo $i >> ${_out}
	set i=`echo $i | cut -d ':' -f 1`
	host $i >> ${_out}
	geoiplookup $i >> ${_out}
	echo "-------" >> ${_out}
end

set _out="/tmp/11-current-stable-dl.old"
set _pattern="HardenedBSD-11-CURRENT_hardenedbsd-stable-master-.*.(img|iso) "

unlink ${_out}

foreach i ( `grep -r -E "${_pattern}" /var/log/apache/ny-01.build.hardenedbsd.org-access_log | awk '{print $1":"$7}' | sort | uniq` )
	echo $i
	echo $i >> ${_out}
	set i=`echo $i | cut -d ':' -f 1`
	host $i >> ${_out}
	geoiplookup $i >> ${_out}
	echo "-------" >> ${_out}
end

set _out="/tmp/11-current-stable-dl.new"
set _pattern="HardenedBSD-11-CURRENT-v.*.(img|iso) "

unlink ${_out}

foreach i ( `grep -r -E "${_pattern}" /var/log/apache/installer.hardenedbsd.org-access_log | awk '{print $1":"$7}' | sort | uniq` )
	echo $i
	echo $i >> ${_out}
	set i=`echo $i | cut -d ':' -f 1`
	host $i >> ${_out}
	geoiplookup $i >> ${_out}
	echo "-------" >> ${_out}
end

