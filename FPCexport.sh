#!/bin/bash

export $(xargs <.env)

#env | sort

FILENAME=extract-$(date +"%H%M%S_%m_%d_%Y").csv

java -jar unboundid-ldapsdk-6.0.1.jar ldapsearch \
    --hostname $LDAPHOST \
    --port $LDAPPORT  \
    --useSSL \
    --bindDN "cn=directory manager" \
    --bindPassword $LDAPPWD \
    --baseDN "dc=neu,dc=edu" \
    --scope sub  \
    --outputFormat multi-valued-csv \
    --outputFile $FILENAME \
    --requestedAttribute givenname \
    --requestedAttribute sn \
    --requestedAttribute mail \
    --requestedAttribute eduPersonAffiliation \
    --requestedAttribute pager \
    --requestedAttribute passwordExpirationTime\
    --filter "(eduPersonAffiliation=*)" 
    
 ls *.csv
 mv $FILENAME '/Users/nate/OneDrive - Northeastern University/Documents/FPC/'
 