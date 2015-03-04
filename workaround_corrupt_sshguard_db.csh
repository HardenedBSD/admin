#!/bin/csh

#
# If the system / sshguard was not correctly stopped,
# then the sshguard failed to start (segvfaulting)
# because not able to open or repair the corrupted
# database file.
#
# To work around this issue, parse the db file with
# ``strings`` and add the extracted IPs to pure ipfw
# table, and drop traffics from these IPs.
#
# After this is done, drop the corrupted database
# file, and restart the sshguard.
#

set _IPFW_RULE_NUM=1001

set _SSHG_BL="/usr/local/etc/sshguard.blacklist"
set _SSHG_DB="/var/db/sshguard/blacklist.db"
set _SSHG_TMP=`mktemp`

cp ${_SSHG_BL}{,.prev}

strings ${_SSHG_DB} | tr -Cd '[[0-9]\n.' > ${_SSHG_TMP}
cat ${_SSHG_BL} >> ${_SSHG_TMP}
sort -un ${_SSHG_TMP} | sed -rn '/([0-9]{1,3}\.){3}[0-9]{1,3}/p' > ${_SSHG_BL}
unlink ${_SSHG_TMP}

ipfw delete ${_IPFW_RULE_NUM} deny ip from 'table(blacklist)' to any
ipfw table blacklist destroy
ipfw table blacklist create
foreach i ( `cat ${_SSHG_BL}` )
	ipfw table blacklist atomic add $i
end
ipfw add ${_IPFW_RULE_NUM} deny ip from 'table(blacklist)' to any
ipfw table blacklist list

service sshguard stop
rm ${_SSHG_DB}
service sshguard start
