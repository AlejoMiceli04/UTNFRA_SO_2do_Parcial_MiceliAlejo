#!/bin/bash

cat << 'FIN' > /tmp/MiceliAltaUser-Groups.sh

#!/bin/bash

USUARIO_REF=$1
LISTA=$2

CONTRA=$(sudo grep "$USUARIO_REF" /etc/shadow | awk -F ':' '{print $2}')

ANT_IFS=$IFS
IFS=$'\n'

for i in $(cat "$LISTA" | awk -F ',' '{print $1 " " $2 " " $3}' | grep -v '^#'); do
    USUARIO=$(echo "$i" | awk '{print $1}')
    GRUPO=$(echo "$i" | awk '{print $2}')
    HOME_USR=$(echo "$i" | awk '{print $3}')

    sudo groupadd -f "$GRUPO"
    sudo useradd -m -d "$HOME_USR" -g "$GRUPO" "$USUARIO"
    echo "$USUARIO:$CONTRA" | sudo chpasswd -e
done

IFS=$ANT_IFS

FIN

sudo mv /tmp/MiceliAltaUser-Groups.sh /usr/local/bin/MiceliAltaUser-Groups.sh
sudo chmod 755 /usr/local/bin/miceliAltaUser-Groups.sh

/usr/local/bin/MiceliAltaUser-Groups.sh miceli /home/miceli/UTN-FRA_SO_Examenes/202406/bash_script/Lista_Usuarios.txt
