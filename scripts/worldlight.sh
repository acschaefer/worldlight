#!/bin/sh

### BEGIN INIT INFO
# Provides:          worldlight
# Required-Start:    $remote_fs $syslog $time
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Worldlight wallpaper update service
# Description:       Updates the worldlight wallpaper every minute.
### END INIT INFO

DIR=/usr/local/bin
DAEMON=$DIR/gen_worldlight_wallpaper.sh
DAEMON_NAME=worldlight
DAEMON_USER=$USER
DAEMON_OPTS=""

# Define where to store the process ID of the script when it is running.
PIDFILE=/var/run/$DAEMON_NAME.pid

. /lib/lsb/init-functions

do_start () {
    log_daemon_msg "Starting system $DAEMON_NAME daemon."
    start-stop-daemon --start --background --pidfile $PIDFILE --make-pidfile --user $DAEMON_USER --chuid $DAEMON_USER --startas $DAEMON -- $DAEMON_OPTS
    log_end_msg $?
}
do_stop () {
    log_daemon_msg "Stopping system $DAEMON_NAME daemon."
    start-stop-daemon --stop --pidfile $PIDFILE --retry 10
    log_end_msg $?
}

case "$1" in

    start|stop)
        do_${1}
        ;;

    restart|reload|force-reload)
        do_stop
        do_start
        ;;

    status)
        status_of_proc "$DAEMON_NAME" "$DAEMON" && exit 0 || exit $?
        ;;

    *)
        echo "Usage: /etc/init.d/$DAEMON_NAME {start|stop|restart|status}"
        exit 1
        ;;

esac

exit 0