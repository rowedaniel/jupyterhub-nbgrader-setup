#!/bin/bash

# create students
while read -r username password; do
    [[ -z "$username" || "$username" =~ ^# ]] && continue
    useradd -ms /bin/bash $username
    echo "$username:$password" | chpasswd
    echo "$username" >> usernames
done < users/users

# make instructor a superuser
usermod -aG sudo instructor

# # enable nbgrader extensions for instructor
# su instructor -c "jupyter nbextension enable --user create_assignment/main"
# su instructor -c "jupyter nbextension enable --user formgrader/main --section=tree"
# su instructor -c "jupyter serverextension enable --user nbgrader.server_extensions.formgrader"
#
