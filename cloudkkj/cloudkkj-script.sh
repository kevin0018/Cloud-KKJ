#!/bin/bash
while :
do
        echo -e "Selecciona la acción que te haga falta:\n\t1:Crear una nueva UO\n\t2:Crear un nuevo grupo\n\t3:Crear un nuevo usuario\n\t4:Cargar el LDAP\n\t5:Exit"
        read menu
case $menu in
    1)
        read -p "Cómo se llama la UO? " nomUO
                read -p "dónde se encuentra la UO? (escríbelo en formato dc=dominio,dc=dominio) " llocUO
                echo "La nueva UO es esta:"
                echo "dn: ou="$nomUO","$llocUO
                echo "objectClass: organizationalUnit"
                echo "objectClass: top"
                echo "ou: $nomUO"
                read -p "Es correcto? Si/No " correctUO
                UO=${correctUO^^}
                if [ $UO == "SI" ]
                   then
                echo "dn: ou="$nomUO","$llocUO >> uo.ldif
                echo "objectClass: organizationalUnit" >> uo.ldif
                echo "objectClass: top" >> uo.ldif
                echo -e "ou: $nomUO\n" >> uo.ldif
                fi
    ;;#Crear un grupo
    2)
        read -p "Cómo se llama el grupo? " nomGRP
                read -p "Dónde se encuentra el grupo? (escríbelo en formato
dc=dominio,dc=dominio) " llocGRP
               gidsearch=$(ldapsearch -x -LLL -b dc=cloudkkj,dc=org "(objectClass=posixGroup)" | grep gidNumber: | cut -d " " -f 2 | sort | tail -n 1)
            gidgrp=$(cat grp.ldif | grep gidNumber: | cut -d " " -f 2 | sort | tail -n 1) 2> /dev/null
            (( gidmayor= $( echo -e "$gidsearch \n $gidgrp" | sort | tail -n 1) +1 ))
                echo "El nuevo nombre es este:"
                echo "dn: cn="$nomGRP",$llocGRP"
                echo "gidNumber: "$gidmayor
            echo "objectClass: PosixGroup"
                echo "objectClass: top"
                echo "cn: $nomGRP"
                read -p "Es correcto? Si/No " correctGRP
                GRP=${correctGRP^^}
                if [ $GRP == "SI" ]
                then
            echo "dn: cn="$nomGRP","$llocGRP >> grp.ldif
                echo "gidNumber: "$gidmayor >> grp.ldif
                echo "objectClass: PosixGroup" >> grp.ldif
                echo "objectClass: top" >> grp.ldif
                echo "cn: $nomGRP" >> grp.ldif
            echo "" >> grp.ldif
            fi
    ;;
#Crear usuario
    3)
        read -p "introduce el nombre del Usuario: " nomUSR
                read -p "Introduce el apellido del usuario: " cgUSR
                read -p "Introduce dónde se encuentra el usuario(ou=Usurarios,ou=Cloud,dc=cloudkkj,dc=org): " llocUSR
                uidsearch=$(ldapsearch -x -LLL -b dc=cloudkkj,dc=org "(objectClass=posixAccount)" | grep uidNumber: | cut -d " " -f 2 | sort | tail -n 1)
        echo "este es el uid más alto de LDAP" $uidsearch
        uidgrp=$(cat users.ldif | grep uidNumber | cut -d " " -f 2 | sort | tail -n 1) 2> /dev/null
                echo "este es el uid más alto del .ldif" $uidgrp
                (( uidmayor= $( echo -e "$uidsearch \n $uidgrp" | sort | tail -n 1) +1 ))
                echo "dn: cn="$nomUSR" "$cgUSR","$llocUSR
                echo "cn: "$nomUSR" "$cgUSR
                echo "givenName: "$nomUSR
                echo "gidNumber: 500"
                echo "homeDirectory: /home/users/"$(echo $nomUSR | cut -c 1)$cgUSR
                echo "sn: "$cgUSR
                echo "loginShell: /bin/sh"
                echo "objectClass: inetOrgPerson"
                echo "objectClass: posixAccount"
                echo "objectClass: top"
                echo "uidNumber: "$uidmayor
                echo "uid: "$(echo $nomUSR | cut -c 1)$cgUSR
                read -p "És correcta? Si/No " correctUSR
                USR=${correctUSR^^}
                if [ $USR == "SI" ]
                then
                        echo "dn: cn="$nomUSR" "$cgUSR","$llocUSR >> users.ldif
                        echo "cn: "$nomUSR" "$cgUSR >> users.ldif
                        echo "givenName: "$nomUSR >> users.ldif
                        echo "gidNumber: 500" >> users.ldif
                        echo "homeDirectory: /home/users/"$(echo $nomUSR | cut -c 1)$cgUSR >> users.ldif
                        echo "sn: "$cgUSR >> users.ldif
                        echo "loginShell: /bin/sh" >> users.ldif
                        echo "objectClass: inetOrgPerson" >> users.ldif
                        echo "objectClass: posixAccount" >> users.ldif
                        echo "objectClass: top" >> users.ldif
                        echo "uidNumber: "$uidmayor >> users.ldif
                        echo "uid: "$(echo $nomUSR | cut -c 1)$cgUSR >> users.ldif
                        echo "" >> users.ldif
			fi
    ;;
#
4) #Carregar la nova informació dels fitxers uo.ldif, grp.ldif, users.ldif
        ldap -x -D "dn=admin,dc=cloudkkj,dc=org" -w contraseña -f uo.ldif
        ldap -x -D "dn=admin,dc=cloudkkj,dc=org" -w contraseña -f grp.ldif
        ldap -x -D "dn=admin,dc=cloudkkj,dc=org" -w contraseña -f users.ldif
        cat uo.ldif grp.ldif users.ldif > carrega$(date +%Y-%m-%d-%H-%M)
        rm -f uo.ldif grp.ldif users.ldif
    ;;
    5)
        echo "Has cerrado la configuración LDAP"
        exit
    ;;

esac
done
