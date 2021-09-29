#!/bin/bash

export $(xargs <.env)

curl https://repo1.maven.org/maven2/com/unboundid/unboundid-ldapsdk/6.0.1/unboundid-ldapsdk-6.0.1.jar --output unboundid-ldapsdk-6.0.1.jar

echo "Building parents Email file"
java -jar unboundid-ldapsdk-6.0.1.jar ldapsearch \
    --hostname $LDAPHOST \
    --port $LDAPPORT  \
    --useSSL \
    --bindDN "cn=directory manager" \
    --bindPassword $LDAPPWD \
    --baseDN "ou=people,dc=neu,dc=edu" \
    --scope sub  \
    --outputFormat multi-valued-csv \
    --outputFile parents.csv \
    --requestedAttribute givenname \
    --requestedAttribute sn \
    --requestedAttribute neuedualtmail \
    --terse \
    --filter "(&(pager=nopwchg)(neuedualtmail=*)(eduPersonAffiliation=parent))" 
wc parents.csv

echo "Building students Email file"
java -jar unboundid-ldapsdk-6.0.1.jar ldapsearch \
    --hostname $LDAPHOST \
    --port $LDAPPORT  \
    --useSSL \
    --bindDN "cn=directory manager" \
    --bindPassword $LDAPPWD \
    --baseDN "ou=student,dc=neu,dc=edu" \
    --scope sub  \
    --outputFormat multi-valued-csv \
    --outputFile students.csv \
    --requestedAttribute givenname \
    --requestedAttribute sn \
    --requestedAttribute mail \
    --terse \
    --filter "(&(|(eduPersonAffiliation=student)(eduPersonAffiliation=ugadmit))(pager=nopwchg)(mail=*))" 
wc students.csv    

echo "Building facultyandstaff Email file"
java -jar unboundid-ldapsdk-6.0.1.jar ldapsearch \
    --hostname $LDAPHOST \
    --port $LDAPPORT  \
    --useSSL \
    --bindDN "cn=directory manager" \
    --bindPassword $LDAPPWD \
    --baseDN "ou=facultyandstaff,dc=neu,dc=edu" \
    --scope sub  \
    --outputFormat multi-valued-csv \
    --outputFile facultyandstaff.csv \
    --requestedAttribute givenname \
    --requestedAttribute sn \
    --requestedAttribute mail \
    --terse \
    --filter "(&(pager=nopwchg)(mail=*))"    
wc facultyandstaff.csv      

echo "Building alumni Email file"
java -jar unboundid-ldapsdk-6.0.1.jar ldapsearch \
    --hostname $LDAPHOST \
    --port $LDAPPORT  \
    --useSSL \
    --bindDN "cn=directory manager" \
    --bindPassword $LDAPPWD \
    --baseDN "ou=student,dc=neu,dc=edu" \
    --scope sub  \
    --outputFormat multi-valued-csv \
    --outputFile alumni.csv \
    --requestedAttribute givenname \
    --requestedAttribute sn \
    --requestedAttribute mail \
    --terse \
    --filter "(&(eduPersonAffiliation=alumni)(pager=nopwchg)(mail=*)(!(|(eduPersonAffiliation=student))))" 
wc alumni.csv     