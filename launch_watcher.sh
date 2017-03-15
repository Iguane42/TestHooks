#!/bin/bash
if [ "$#" -gt 0 ] && [ "$1" != "" ]; then
    szNomDossier=$1
    echo "$(date) : Appel du script de lancement de watcher avec le parametre $1" >> /var/log/launchwatcher.log
else
    szCheminActuel=$(pwd)
    while [ $szCheminActuel != '/' ] && [ $(ls $szCheminActuel | grep index.php | wc -l) = 0 ]; do
        szCheminActuel=$(echo $szCheminActuel | sed -e "s/\/$(basename $szCheminActuel)\///g")"/"
    done
    if [ $szCheminActuel = "/" ]; then
        exit 1
    fi
    szNomDossier=$(basename $szCheminActuel)
    echo "$(date) : Appel du script de lancement de watcher sans parametre" >> /var/log/launchwatcher.log
fi
szListeDirectories=$(cat /etc/apache2/sites-enabled/* | grep DocumentRoot)
bSucces=1
for szPath in $szListeDirectories; do
    if [ $szPath != "DocumentRoot" ]; then
        if [[ $szPath =~ .*$szNomDossier.* ]]; then
            echo "$(date) : Lancement du script watcher sur le dossier $szPath" >> /var/log/launchwatcher.log
            # Appeler ici ton script, le chemin du projet se trouve dans la variable $szPath
	    bSucces=0
        fi
    fi
done
exit $bSucces
