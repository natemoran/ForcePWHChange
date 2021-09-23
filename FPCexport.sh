#!/bin/bash

export $(xargs <.env)

java -jar unboundid-ldapsdk-6.0.1.jar ldapsearch \
    --hostname $LDAPHOST \
    --port $LDAPPORT  \
    --useSSL \
    --bindDN $LDAPUSER \
    --bindPassword $LDAPPWD \
    --baseDN "dc=neu,dc=edu" \
    --scope sub  \
    --outputFormat multi-valued-csv \
    --outputFile extract.csv \
    --requestedAttribute givenname \
    --requestedAttribute sn \
    --requestedAttribute mail \
    --requestedAttribute eduPersonAffiliation \
    --filter "(eduPersonAffiliation=*)" 
    