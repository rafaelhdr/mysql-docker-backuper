
if [ -z "${SCHEDULE_CRON}" ] || [ "${SCHEDULE_CRON}" = "" ]; then
    sh /export.sh

    # Sleep for swarm container verification
    # This avoid creation of multiple containers on swarm mode
    sleep 10
else
    echo "$SCHEDULE_CRON /bin/sh /export.sh" >> /backuper.cron
    crontab /backuper.cron
    crond -f
fi
