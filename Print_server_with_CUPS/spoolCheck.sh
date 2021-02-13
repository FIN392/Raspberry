#!/bin/bash

#
# EDITOR=nano crontab -e
#
#     (Add to beginning of file)
#
#     # telegramMonitoring: Check spool every minute
#     * * * * * (sudo /home/pi/telegramMonitoring/spoolCheck.sh)
#

# Path for telegramMonitoring
tMPath=/home/pi/telegramMonitoring

#
# Send message if spool is added in CUPS
#
for SPOOLFILE in $(find /var/spool/cups/ -maxdepth 1 -newermt "1 minute ago" -name "c*" -type f)
do
 	JOBNAME=$(strings "$SPOOLFILE" | grep --after-context=1 "job-name" | grep --invert-match "job-name")
	( \
			echo -e "<code>%F0%9F%96%A8" ; \
			echo "Job added to spool: '${JOBNAME:17:-1}'</code>" ; \
	) | $tMPath/sendTelegramMessage.sh
done
