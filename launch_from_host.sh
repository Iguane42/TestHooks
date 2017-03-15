#!/bin/bash
szCheminActuel=$(pwd)
while [ $szCheminActuel != '/' ] && [ $(ls $szCheminActuel | grep index.php | wc -l) = 0 ]; do
    szCheminActuel=$(echo $szCheminActuel | sed -e "s/\/$(basename $szCheminActuel)\///g")"/"
done
if [ $szCheminActuel != '/' ]; then
    bSucces=`vagrant ssh -c "sudo /bin/launch_watcher.sh $(basename $szCheminActuel)"`
fi
exit $bSucces