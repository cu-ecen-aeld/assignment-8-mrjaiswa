#!/bin/sh
# Author Mrinal
module="scull"
device="scull"
mode="664"

case $1 in
    start)
        echo "Loading ldd modules"

        if grep -q '^staff:' /etc/group; then
            group="staff"
        else
            group="wheel"
        fi

       printf "Loading scull module\n"

       modprobe $module

       major=$(awk "\$2==\"$module\" {print \$1}" /proc/devices)

       rm -f /dev/${device}[0-3]
       mknod /dev/${device}0 c $major 0
       mknod /dev/${device}1 c $major 1
       mknod /dev/${device}2 c $major 2
       mknod /dev/${device}3 c $major 3
       ln -sf ${device}0 /dev/${device}
       chgrp $group /dev/${device}[0-3] 
       chmod $mode  /dev/${device}[0-3]

       rm -f /dev/${device}pipe[0-3]
       mknod /dev/${device}pipe0 c $major 4
       mknod /dev/${device}pipe1 c $major 5
       mknod /dev/${device}pipe2 c $major 6
       mknod /dev/${device}pipe3 c $major 7
       ln -sf ${device}pipe0 /dev/${device}pipe
       chgrp $group /dev/${device}pipe[0-3] 
       chmod $mode  /dev/${device}pipe[0-3]

       rm -f /dev/${device}single
       mknod /dev/${device}single  c $major 8
       chgrp $group /dev/${device}single
       chmod $mode  /dev/${device}single

       rm -f /dev/${device}uid
       mknod /dev/${device}uid   c $major 9
       chgrp $group /dev/${device}uid
       chmod $mode  /dev/${device}uid

       rm -f /dev/${device}wuid
       mknod /dev/${device}wuid  c $major 10
       chgrp $group /dev/${device}wuid
       chmod $mode  /dev/${device}wuid

       rm -f /dev/${device}priv
       mknod /dev/${device}priv  c $major 11
       chgrp $group /dev/${device}priv
       chmod $mode  /dev/${device}priv

        # loading faulty module
        printf "Loading faulty module\n"
        modprobe faulty

        major=$(awk "\$2==\"faulty\" {print \$1}" /proc/devices)

        rm -f /dev/faulty
        mknod /dev/faulty c $major 0
        chgrp wheel /dev/faulty
        chmod 644 /dev/faulty

        # Load hello module
        modprobe hello

        ;;
    stop)
        echo "Unloading ldd modules"

        
        array="scull scullpriv scullpipe scullsingle sculluid scullwuid faulty hello"
        for element in "${array[@]}"
        do
            if [ "$element" = "scull" ]; then
                rm -f /dev/$element /dev/${element}[0-3]
            elif [ "$element" = "scullpipe" ]; then
                rm -f /dev/$element /dev/${element}[0-3]
            elif [ "$element" = "faulty" ]; then
                rmmod $element || exit 1
                rm -f /dev/$element
            elif [ "$element" = "hello" ]; then
                rmmod $element
                rm -f /dev/$element
            else
                rm -f /dev/$element
            fi
        done

        ;;
    *)
        echo "Usage: $0 {start|stop}"
        exit 1
   esac

exit 0
