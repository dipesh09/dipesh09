# This is an Assignment 

#apt-get install bind9 dnsutils

read -p " Please Enter the Domain name " Dom

cd /etc/bind 

if [[ ! -e db.$Dom.mytld ]]; then
    cp db.empty db.$Dom.mytld
elif [[ ! -d db.$Dom.mytld ]]; then
    echo "Please select Diffrent name $Dom is already exist" 1>&2
fi




