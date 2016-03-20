#!/bin/bash

SCRIPT_BASE=$(pwd)
WEBUSER=nighter

function logprint()
{
    printf "[output] %s\n" "$@"
}

function print_usage()
{
clear
cat <<EOT
                __       __   
.----.--------.|  |--.--|  |.-----.--.--.
|  __|        ||    <|  _  ||  -__|  |  |
|____|__|__|__||__|__|_____||_____|\___/ 
mikael.kall@unibet.com
                                         
 General Options

 w|web		Start webbrowser
 p|plugin	Edit plugin
 c|check	Edit check
 s|save		Save checks
 q|quit         Quit application

 Check_mk
 
 x|execute     Freetype cmk command
 i|inventory   Inventory server
 r|run	       Run check
 d|dump	       Dump checks
 l|list	       List checks
 o|reload      Nagios reload 
 h|help	       View cmk help

 Docker

 b|boot        Boot containers
 u|uninstall   Stop and uninstall all containers 

EOT
}

function save_settings()
{
    echo ""
    echo "Enter name for save checks."
    echo -n "➜ "
    read filename	
    if [ -n ${filename} ]; then
	datum=$(date +'%Y%d%H%m')
	cp ${SCRIPT_BASE}/plugins/checkplugin ~/plugin_${filename}.${datum}
	cp ${SCRIPT_BASE}/checks/checkplugin.py ~/checks_${filename}.${datum}
	logprint "Saved ~/plugin_${filename}.${datum}"
	logprint "Saved ~/checks_${filename}.${datum}"
        echo -en "\n*** Press any key to return *** "
        read
    fi

}


function initialize()
{
    docker pull nighter/centos7-omd
    docker run -d -p 5000:5000 --name centos7-omd -v ${SCRIPT_BASE}/checks:/opt/omd/sites/prod/share/check_mk/checks -v ${SCRIPT_BASE}/plugins:/usr/share/check-mk-agent/plugins nighter/centos7-omd    
    docker exec centos7-omd /usr/sbin/xinetd -D
    logprint "Initialized"
}

function docker_uninstall()
{
   echo ""    
   echo -n "This will stop and cleanup all containers. Are you sure?: "    
   read -n1 ans

   if [ ${ans} == 'y' ]; then
       docker stop $(docker ps -a -q)
       docker rm $(docker ps -a -q)
       docker rmi $(docker images -a -q)
       echo -en "\n*** Press any key to return *** "
       read
   fi
}


function run_web()
{
    ( su - $WEBUSER -c '/usr/bin/firefox https://localhost:5000/prod/check_mk' & ) > /dev/null 2>&1 
}


function run_command()
{
   if [ "$@" ]; then
	cmd="docker exec centos7-omd su - prod -c \"./bin/cmk $@\""
        echo ""
        echo "[EXECUTES] cmk $@"
        echo ""

   else
       echo "Enter cmk arguments"
       echo -n "➜ "
       read ARGUMENTS
       cmd="docker exec centos7-omd su - prod -c \"./bin/cmk ${ARGUMENTS}\""
       echo ""
       echo "[EXECUTES] cmk ${ARGUMENTS}"
       echo ""
   fi

   eval "${cmd}"
   echo -en "\n*** Press any key to return *** "
   read
}


function main()
{
    while :
    do
        print_usage
	echo -n "➜ "	
        read -n1 opt

        case "${opt}" in

            q|quit)
		echo ""
                exit 0
            ;;

            w|web)
                run_web
		sleep 1
            ;;

            p|plugin)
		vim plugins/checkplugin
            ;;

            c|check)
                vim checks/checkplugin.py
            ;;

            x|execute)
		echo ""
	        run_command
            ;;

            b|boot)
                initialize
            ;;

            d|dump)
		run_command "-D testhost"
            ;;

            i|inventory)
                run_command "--debug -IIv testhost"
            ;;

            r|run)
                run_command "--debug -nv testhost"
            ;;

            l|list)
                run_command "-L"
            ;;

            h|help)
                run_command "--help"
            ;;

            o|reload)
                run_command "-O"
            ;;

            u|uninstall)
                docker_uninstall
            ;;

            s|save)
                save_settings
            ;;



	esac
    done
    exit 0
}


####
## Entry point
####
NAME=$(basename "$0")
if [ "$NAME" == "cmk.sh" ]; then
    main $@
fi
