#!/bin/bash
# This is a Bash Assignment
# First we need to check bind9 is installed in the system or not

bc="$(dpkg-query -W -f='${status}' bind9)"
random="install ok installed"

# if it is install than just give proper message or install it

if [ "$bc" = "$random" ]; then

    echo " Bind9 is already install "

else 
    apt-get update
    apt-get install Bind9
fi 

# Take an input from user for Domain name
read -p " Please Enter the Domain name " Dom

# Change the directory to /etc/bind for new files
cd /etc/bind 

# if user just enter the "space" or "enter" key it will ask again for valid name 
while [ "$Dom" = "" ] ; do 
    echo " This is not a valid name"
    read -p " Please Enter the Domain name " Dom
done

# Assigning current date into one variable for serial number 
ymd="$(date +"%Y%d%m")"

# Creating If statement to check domain name already exists or not
rev="00"
if [[ ! -e db.$Dom.mytld ]]; then

# Create database file with the name enter by the user
# In that file serial number contain current date
    cat << EOF > db.$Dom.mytld

;
; $ymd - created initial zone file fo $Dom.mytld
;
;
\$TTL    86400
@       IN      SOA     ns1.$Dom.mytld. hostmaster.$Dom.mytld. (
                              $ymd$rev                ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                          86400 )       ; Negative Cache TTL
;
@       IN      NS      ns1.$Dom.mytld.                                                                             
ns1     IN      A       127.0.0.1                                                                                     
www     IN      A       192.168.47.91                                                                                 
mail    IN      A       192.168.59.5
EOF


# Here we are going create reverse zone file for 47.168.192.in-addr.arpa
    cat << EOF > db.192.168.47
;
; $ymd - created reverse zone file fr "47.168.192.in-addr.arpa "
;
;
\$TTL    86400
@       IN      SOA     ns1.$Dom.mytld. hostmaster.$Dom.mytld. (
                              $ymd$rev                ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                          86400 )       ; Negative Cache TTL
;
@       IN      NS      ns1.$Dom.mytld.
91      IN      PTR     www.$Dom.mytld.
EOF

# Here we are going create reverse zone file for 59.168.192.in-addr.arpa
cat << EOF > db.192.168.59
;
; $ymd - created reverse zone file fr "59.168.192.in-addr.arpa "
;
;
\$TTL    86400
@       IN      SOA     ns1.$Dom.mytld. hostmaster.$Dom.mytld. (
                              $ymd$rev                ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                          86400 )       ; Negative Cache TTL
;
@       IN      NS      ns1.$Dom.mytld.
5       IN      PTR     mail.$Dom.mytld.
EOF


# Here we are going create named.conf.local
cat << EOF > named.conf.local

zone "47.168.192.in-addr.arpa" {
        type master;
        file "/etc/bind/db.192.168.47";
};

zone "59.168.192.in-addr.arpa" {
        type master;
        file "/etc/bind/db.192.168.59";
 
};

zone "$Dom.mytld" {
        type master;
        file "/etc/bind/db.$Dom.mytld";
 
};
EOF

rndc reload

# Here we are checking the zone file for the database file which we created by user
named-checkzone $Dom.mytld db.$Dom.mytld

# Here we are checking reverse zone file for 47.168.192.in-addr.arpa 
named-checkzone 47.168.192.in-addr.arpa db.192.168.47 

# Here we are checking reverse zone file for 59.168.192.in-addr.arpa
named-checkzone 59.168.192.in-addr.arpa db.192.168.59 


elif [[ ! -d db.$Dom.mytld ]]; then
    echo "Please select Diffrent name $Dom is already exist" 1>&2
fi

