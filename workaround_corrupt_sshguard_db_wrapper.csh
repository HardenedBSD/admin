#!/bin/sh
#
# WARNING: this file was hooked in in crontab too!
#

ipfw add 1002 deny all from 'table(22)' to any

if [ -f /root/bin/workaround_corrupt_sshguard_db.csh ]
then
	/root/bin/workaround_corrupt_sshguard_db.csh

	if [ -f /root/blocked_ips_geoip.csh ]
	then
		(/root/blocked_ips_geoip.csh > /home/op/public_html/blocked.html)&
	fi
fi
