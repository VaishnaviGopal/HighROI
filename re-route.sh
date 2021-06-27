#!/bin/sh
usage()
{
cat << EOF
usage: $0 <hostname> <ip>
EOF
}
if [ $# -ne 2 ]; then
    usage; exit 1;
fi
HOSTNAME=$1
IP=$2
ETC_HOSTS=/etc/hosts
function addhost() {
    echo "Inside add host function"
    HOSTNAME=$1
    HOSTS_LINE="$IP\t$HOSTNAME"
    if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
        then
            echo "$HOSTNAME already exists : $(grep $HOSTNAME $ETC_HOSTS)"
        else
            echo "Adding $HOSTNAME to your $ETC_HOSTS";
            sudo -- sh -c -e "echo '$HOSTS_LINE' >> /etc/hosts";
            if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
                then
                    echo "$HOSTNAME was added succesfully \n $(grep $HOSTNAME /etc/hosts)";
                else
                    echo "Failed to Add $HOSTNAME, Try again!";
            fi
    fi
}
removehost() {
    echo "removing host";
    if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
    then
        echo "$HOSTNAME Found in your $ETC_HOSTS, Removing now...";
        sudo sed -i".bak" "/$HOSTNAME/d" $ETC_HOSTS
    else
        echo "$HOSTNAME was not found in your $ETC_HOSTS";
    fi
}
ping $IP -c 4
if [[ $? == 0 ]]; then
    echo "It is connected to pod ip $IP"
    addhost $1 $IP
    echo "Updated host with pod ip $IP"
else
    echo "PodIP is down, verify another pod and add it to the /etc/hosts"
    removehost
fi
