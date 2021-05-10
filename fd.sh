#!/usr/bin/env bash
# This will allow us to identify if the parameter is a file or a directory

#These are variables we will have to work with in the file some may be listed close to their functions
CHECK=$1


#Some colors to make the output easy to read on important parts for quick glances
red='\033[0;31m'
wipe="\033[1m\033[0m"
yellow='\E[1;33m'

#if either the directory.result or file.result files exist we will create a file called c.rf and date when these files were one the system for each run
if test -f "$DIR"; then
        echo "$DIR exists"
        echo -e "$yellow ------ $wipe"
        echo "$(date) DIR" >> $OLD
fi

if test -f "$FIL"; then
        echo "$FIL exists"
        echo -e "$yellow ------ $wipe"
        echo "$(date) FIL" >> $OLD
fi

# This wil tell us if we are handling a directory
if [ -d "${CHECK}" ]; then
        echo "$CHECK is a directory";

        #Getting the date and echo with colored text for easy feedback
        echo -e "$yellow Date $wipe $yellow $(date) $wipe" >> ~/directory.result

        #Call for the date again and send it to the result file without escape characters
        #Escape characters are not supported by the basic text files used in this script
        echo -e "$(date)" >> ~/directory.result

        #We will echo the executing user and their user id(UID) to the directory.results file in the home directory
        #Date and time of access ouputed to the file
        echo "$USER - $UID" >> ~/directory.result
        dirc=$( ls -lsh --color <"$CHECK" )
                echo "Logger: The contents have been checked"
                echo "$dirc"


        #This will output a file to a directory and will temporarily list it in the current directroy
        ls -lash --color >> ~/directory.result
        echo -e "${yellow} Done ${wipe}"; >> ~/directory.result
        echo -e  "${yellow} *------------------------------------------------------------------* ${wipe}" >> ~/directory.result
        #Succes exit with a status of 0
        exit 0
else
#This will tell us if we are handling a file
if [ -f "$CHECK" ]; then
        echo "$CHECK is a file";

        #List the number of lines then the file name
        lines=$( wc -l <"$CHECK") >> ~/file.result
                echo "File : $CHECK"
                echo "Lines: $lines"
                echo "$(date)" >> ~/file.result
                echo "$USER - $UID" >> ~/file.result
                echo "Lines      File" >> ~/file.result
                echo $lines "      " $CHECK >> ~/file.result
                echo -e "$yellow Done $wipe"
                echo -e "$yellow *--------------------------* $wipe" >> ~/file.result
        exit 0
        #Exit or error

        else

                #Check whether the parameter is writable or not then presenting an error based on this data.
                [ -w $CHECK ] && echo -e "$red $CHECK ${wipe} ${yellow} Is an invalid entry you may not have access to the file or you have an extra space ${wipe}" ||
                echo -e "${red} $CHECK ${wipe} ${yellow} is not Writable/Searchable check your input ${wipe}"

                #Failiure exiting with a status of 99
                exit 99
                fi
        fi
fi

