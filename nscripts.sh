#!/bin/bash

# YOU MUST INSTALL YAD FIRST

##############YAD WINDOW############

yad_ip()
{
	ipt=$(yad --width=400 --height=200 --center --title="Network Manager"  --text="<span color='blue' font='Serif Bold 14'>Posibolt Network Setup\n</span>" --text-align=center --form --field='<span color="red" font="11">'"<b>Enter a valid IP ADDRESS: </b></span>:\n" --field="                                                              <b>  Example: 192.168.0.24/24</b>":LBL)
	ip=$(awk -F '|' '{print $1}'<<<$ipt)
}

yad_gw()
{
	ipt=$(yad --width=400 --height=200 --center --title="Network Manager"  --text="<span color='blue' font='Serif Bold 14'>Posibolt Network Setup\n</span>" --text-align=center --form --field='<span color="orange" font="11">'"<b>Enter a valid Gateway IP: </b></span>:\n" --field="                                                              <b>  Example: 192.168.0.2</b>":LBL)
	gw=$(awk -F '|' '{print $1}'<<<$ipt)
}

#############IP ADDRESS CHECKING################

ipcheck3()
{
	IFS=/
        set -- $ip
        echo "re $#"
        B=($1 $2)
        echo "B $1 $2"
        ipno=$1
        if [ $# -eq 2 ]; then
                IFS=.
                set -- $ipno
                echo "tt $#"
                C=($1 $2 $3 $4 $5)
                NB=${#C[@]}
                echo "NB $NB"
                echo "C $1 $2 $3 $4 $5"
                if [ $# -ne 4 ]; then
                        echo "wrong"
                        yad_ip
                        ipcheck3
                else
                        echo "ip $ipno"
                        IFS=$oldIFS
                        set -- $ip
                        echo "ogip $ip"
                fi
        else
                echo "wrong1"
		ipcheck
        fi
}

ipcheck2()
{
	IFS=/
        set -- $ip
        echo "re $#"
        C=($1 $2)
        echo "test $1 $2"
        ipno=$1
	if [ $# -eq 2 ]; then
		ipcheck1
	else
		ipcheck
	fi
	IFS=$oldIFS
	set -- $ip
}

ipcheck()
{
	IFS=
	set -- $ip
	S=`echo ${#ip}`
	echo "number $S"
	while [ $S -eq 0 ]
	do
		yad_ip
		IFS=
		set -- $ip
		S=`echo ${#ip}`
	done
	oldIFS=$IFS
	IFS=/
	set -- $ip
	echo "$#  test"
	while [ "$#" -ne 2 ]
	do
        	yad_ip
        	ipcheck2
        	ipcheck3
        	ipcheck
       		IFS=/
       		set -- $ip
       		echo $#
	done
	IFS=.
	set -- $ip
	B=($1 $2 $3 $4 $5)
	echo "NB $1 $2 $3 $4 $5"
	NB=${#B[@]}
	echo "NB $NB"
	while [ $NB -ne 4 ]
	do
        	yad_ip
       		ipcheck2
       		ipcheck3
       		ipcheck
	done
	echo $ip | egrep "[a-z]" >/dev/null 2>&1
	while  [ "$?" -eq 0 ]
	do
        	yad_ip
        	ipcheck2
       		ipcheck3
       		ipcheck
       		echo $ip | egrep "^[a-z]" >/dev/null 2>&1
	done
	IFS=$oldIFS
	set -- $ip
}



ipcheck1()
{
	 IFS=.
	set -- $ipno
	B=($1 $2 $3 $4 $5)
	echo "b $1 $2 $3 $4 $5"
	no1=`echo ${#1}`
	no2=`echo ${#2}`
	no3=`echo ${#3}`
	no4=`echo ${#4}`
	no5=`echo ${#5}`
	NB=${#B[@]}
	if [[ $no1 -gt 3 ]]; then
		echo "wrong1"
 		yad_ip
 		ipcheck2
 		ipcheck3
 		ipcheck1
	elif [[ $no2 -gt 3 ]]; then
		echo "wrong2"
		yad_ip 
		ipcheck2
		ipcheck3
		ipcheck1
	elif [[ $no3 -gt 3 ]]; then
		echo "wrong3"
		yad_ip
		ipcheck2
		ipcheck3
		ipcheck1
	elif [[ $no4 -gt 3 ]]; then
		echo "wrong4"
		yad_ip
		ipcheck2
		ipcheck3
		ipcheck1
	elif [[ $no5 -gt 3 ]]; then
		echo "wrong5"
	 	yad_ip
	 	ipcheck2
	 	ipcheck3
	 	ipcheck1
	fi
	IFS=$oldIFS
	set -- $ip
}


################GATEWAY IP CHECKING#############


gwcheck1()
{
	IFS=.
	set -- $gw
	B=($1 $2 $3 $4 $5)
	echo "b $1 $2 $3 $4 $5"
	no1=`echo ${#1}`
	no2=`echo ${#2}`
	no3=`echo ${#3}`
	no4=`echo ${#4}`
	no5=`echo ${#5}`
	NB=${#B[@]}
	if [[ $no1 -gt 3 ]]; then
		echo "wrong1"
		 yad_gw
		 gwcheck1
		 gwcheck
	elif [[ $no2 -gt 3 ]]; then
		echo "wrong2"
	 	yad_gw
 		gwcheck1
 		gwcheck
	elif [[ $no3 -gt 3 ]]; then
		echo "wrong3"
		 yad_gw
		 gwcheck1
		 gwcheck
	elif [[ $no4 -gt 3 ]]; then
		echo "wrong4"
		 yad_gw
		 gwcheck1
		 gwcheck
	elif [[ $no5 -gt 3 ]]; then
		echo "wrong5"
		 yad_gw
		 gwcheck1
		 gwcheck
	fi
	IFS=$oldIFS
	set -- $gw
}

gwcheck()
{
	echo $gw
	IFS=
	set -- $gw
	N=`echo ${#gw}`
	echo "gwno $N"
	while [ $N -eq 0 ]
	do
		yad_gw
		echo "gw1 $gw"
		IFS=
		set -- $gw
		N=`echo ${#gw}`
	done
	oldIFS=$IFS
	IFS=.
	set -- $gw
	while [ "$#" -ne "4" ]
	do
		yad_gw
		gwcheck
		IFS=.
		set -- $gw
	done
	G=($1 $2 $3 $4)
	GG=${#G[@]}
	while [ $GG -ne 4 ]
	do
		yad_gw
		gwcheck
	done
	echo $gw | egrep "[a-z]" >/dev/null 2>&1
	while [ "$?" -eq 0 ]
	do
        yad_gw
        gwcheck
		echo $gw | egrep "[a-z]" >/dev/null 2>&1
	done

	echo $gw | egrep "/" >/dev/null 2>&1
	while [ "$?" -eq 0 ]
	do
		yad_gw
		gwcheck
		echo $gw | egrep "/" >/dev/null 2>&1
	done
	IFS=$oldIFS
	set -- $gw
}


start()
{
	ipt=$(yad --width=500 --height=300  --text="<span color='blue' font='Serif Bold 15'>Posibolt Network Setup</span>" --text-align=center --title="Network Manager" --image=/home/jishnu/Documents/backups/logo1.jpg  --form --field="<span font='10'><b>Enter IP Address:</b></span>":\n  --field="                                                             Example: 192.168.0.10/24":LBL --field="<span font='10'> <b>Enter Gateway IP Address</b></span>": --button=OK:0  --field="                                                             Example: 192.168.0.2":LBL)
	ip=$(awk -F "|" '{print $1}'<<<$ipt)
	gw=$(awk -F "|" '{print $3}'<<<$ipt)
	echo $gw
	ifname=$(ifconfig  -s -a |  head -2 | tail -1 | awk -F ' ' '{print $1}')
	ipcheck
	#ipcheck1
	ipcheck2
	echo "OG $ip"
	IPV4=$ip
	gwcheck
	gwcheck1
	GW4=$gw
	sudo hostnamectl set-hostname $host
	sudo  sed -i "/127.0.0.1/ s/$/ $host/g" /etc/hosts
	sudo nmcli connection delete Posibolt
	sudo nmcli connection add con-name "Posibolt" ifname $ifname type ethernet autoconnect yes ip4 $IPV4 gw4 $GW4
	sudo nmcli connection up Posibolt
	sudo systemctl reload NetworkManager.service
}

yd=$(yad --width=400 --height=200 --text="<span color='blue' font='Serif Bold 15'>Posibolt Network Setup\n</span>" --text-align=center --title="Network Manager"  --form --field="<b>Select Network Type</b>:":CB"" ""'Dynamic!Static' --field="<b>Enter Hostname</b>:")
#echo $yd
type=$(awk -F "|" '{print $1}'<<<$yd)
host=$(awk -F "|" '{print $2}'<<<$yd)
#echo $type
case "$type" in
        Dynamic)
		sudo hostnamectl set-hostname $host
		sudo  sed -i "/127.0.0.1/ s/$/ $host/g" /etc/hosts
                exit 1
                ;;
        Static)
		start
                ;;
esac

