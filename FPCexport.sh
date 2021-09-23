#!/bin/bash

export $(xargs <.env)

#env | sort

#now=$(date +"%m_%d_%Y")

java -jar unboundid-ldapsdk-6.0.1.jar ldapsearch \
    --hostname $LDAPHOST \
    --port $LDAPPORT  \
    --useSSL \
    --bindDN "cn=directory manager" \
    --bindPassword $LDAPPWD \
    --baseDN "dc=neu,dc=edu" \
    --scope sub  \
    --outputFormat multi-valued-csv \
    --outputFile "extract.csv" \
    --requestedAttribute givenname \
    --requestedAttribute sn \
    --requestedAttribute mail \
    --requestedAttribute eduPersonAffiliation \
    --requestedAttribute pager \
    --filter "(eduPersonAffiliation=*)" 
    
 ls "extract.csv"
