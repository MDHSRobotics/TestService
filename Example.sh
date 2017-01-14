#! /bin/sh
# /etc/init.d/TestService.sh

# source:  http://www.neilson.co.za/creating-a-java-daemon-system-service-for-debian-using-apache-commons-jsvc/


#  /etc/init.d/mydaemon

### BEGIN INIT INFO
# Provides:          mydaemon
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     $remote_fs $syslog
# Default-Stop:      $remote_fs $syslog
# Short-Description: Starts the MyDaemon service
# Description:       This file is used to start the daemon
#                    and should be placed in /etc/init.d
### END INIT INFO

# Author:   Sheldon Neilson <sheldon[AT]neilson.co.za>
# Url:      www.neilson.co.za
# Date:     25/04/2013

NAME="TestService"
DESC="TestService"

# The path to Jsvc
EXEC="/usr/bin/jsvc"

# The path to the folder containing TestService.jar
FILE_PATH="/home/cdnutter/Repositories/TestService/build"

# The path to the folder containing the java runtime
JAVA_HOME="/usr/lib/jvm/java-8-oracle"

# Our classpath including our jar file and the Apache Commons Daemon library
CLASS_PATH="$FILE_PATH/TestService.jar:/home/cdnutter/Repositories/TestService/lib/commons-daemon-1.0.15.jar"

# The fully qualified name of the class to execute
CLASS="team4141.Service"

# Any command line arguments to be passed to the our Java Daemon implementations init() method 
ARGS=""

#The user to run the daemon as
USER="cdnutter"

# The file that will contain our process identification number (pid) for other scripts/programs that need to access it.
PID="/var/run/$NAME.pid"

# System.out writes to this file...
LOG_OUT="$FILE_PATH/log/$NAME.out"

# System.err writes to this file...
LOG_ERR="$FILE_PATH/err/$NAME.err"

jsvc_exec()
{   
    cd $FILE_PATH
    $EXEC -home $JAVA_HOME -cp $CLASS_PATH -user $USER -outfile $LOG_OUT -errfile $LOG_ERR -pidfile $PID $1 $CLASS $ARGS
}

case "$1" in
    start)  
        echo "Starting the $DESC..."        
        
        # Start the service
        jsvc_exec
        
        echo "The $DESC has started."
    ;;
    stop)
        echo "Stopping the $DESC..."
        
        # Stop the service
        jsvc_exec "-stop"       
        
        echo "The $DESC has stopped."
    ;;
    restart)
        if [ -f "$PID" ]; then
            
            echo "Restarting the $DESC..."
            
            # Stop the service
            jsvc_exec "-stop"
            
            # Start the service
            jsvc_exec
            
            echo "The $DESC has restarted."
        else
            echo "Daemon not running, no action taken"
            exit 1
        fi
            ;;
    *)
    echo "Usage: /etc/init.d/$NAME {start|stop|restart}" >&2
    exit 3
    ;;
esac