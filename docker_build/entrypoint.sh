#!/bin/bash

# get existing nbgrader students
export students=$(nbgrader db student list 2> /dev/null | tail -n +2 | awk '{print $1}')

# set up instructor
if [ ! -d "/home/instructor" ]; then
    mkdir -p /home/instructor/
fi
if [ ! -d "/home/instructor/$(cat /srv/jupyterhub/course_name)" ]; then
    mkdir -p /home/instructor/$(cat /srv/jupyterhub/course_name)
fi
if [ ! -d "/home/instructor/.jupyter" ]; then
    mkdir -p /home/instructor/.jupyter
    cp /etc/jupyter/nbgrader_config.py /home/instructor/.jupyter/.
fi
if [ ! -f "/home/instructor/logfile.txt" ]; then
    touch /home/instructor/logfile.txt
fi
chown -R "instructor:instructor" /home/instructor/


while read -r username; do
    # make user home directories if not already made
    if [ ! -d "/home/$username" ]; then
        mkdir "/home/$username"
    fi
    chown -R "$username:$username" "/home/$username"
    chmod 777 "/home/$username"
    # add users to nbgrader if not already in database
    if [[ ! $students == *$username* ]]; then
        nbgrader db student add $username
    fi
done < /srv/jupyterhub/usernames

# change permissions on bgrader exchange directory
if [ ! -d /srv/nbgrader/exchange ]; then
    mkdir -p /srv/nbgrader/exchange
fi
chmod 777 /srv/nbgrader/exchange

# start jupyterhub
jupyterhub -f /srv/jupyterhub/jupyterhub_config.py
