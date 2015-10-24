# This is a Bash Assignment 

apt-get install bind9 

read -p " Please Enter the Domain name " Dom

cd /etc/bind 

if [[ ! -e db.$Dom.mytld ]]; then
    cat << EOF > db.$Dom.mytld

;
; 20151910 - created initial zone file fo $Dom.mytld
;
;
\$TTL    86400
@       IN      SOA     ns1.$Dom.mytld. hostmaster.$Dom.mytld. (
                              2015191000                ; Serial
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

named-checkzone $Dom.mytld db.$Dom.mytld

    cat << EOF > db.192.168.47
;
; 20151910 - created reverse zone file fr "47.168.192.in-addr.arpa "
;
;
\$TTL    86400
@       IN      SOA     ns1.$Dom.mytld. hostmaster.$Dom.mytld. (
                              2015191000                ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                          86400 )       ; Negative Cache TTL
;
@       IN      NS      ns1.$Dom.mytld.
91      IN      PTR     www.$Dom.mytld.
EOF

named-checkzone 47.168.192.in-addr.arpa db.192.168.47 

cat << EOF > db.192.168.59
;
; 20151910 - created reverse zone file fr "59.168.192.in-addr.arpa "
;
;
\$TTL    86400
@       IN      SOA     ns1.$Dom.mytld. hostmaster.$Dom.mytld. (
                              2015191000                ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                          86400 )       ; Negative Cache TTL
;
@       IN      NS      ns1.$Dom.mytld.
5       IN      PTR     mail.$Dom.mytld.
EOF
 

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

named-checkzone 59.168.192.in-addr.arpa db.192.168.59 

elif [[ ! -d db.$Dom.mytld ]]; then
    echo "Please select Diffrent name $Dom is already exist" 1>&2
fi