#! /bin/bash

# JWT Authorization in Hasura requires access to the Public Key used to sign JWTs by Auth0,
# due to a known issue between Auth0 and Hasura we need to generate the JSON object that contains the public key
# and set this as an environment variable on Hasura. Because we have additional claims/ configurations that we need
# to set to support our use case of Auth0 and Hasura, use this script to generate the string containing all of the
# necessary information to support JWT authz.

# This tool mimics functionality available through this tool hosted by Hasura: https://hasura.io/jwt-config/

# =============================
# TO USE
# =============================

# ./generate-jwt-key-auth0-hasura.sh <Auth0 Tenant URL> <Altigo Audience>

AUTH0_TENANT=${1:-https://<auth0-tenant>.auth0.com}

AUTH0_PEM=$(curl $AUTH0_TENANT/pem)
AUTH0_TYPE="RS512"
AUDIENCE=${2:-https://<audience>}

GENERATED_KEY='{"type": "'"$AUTH0_TYPE"'", "aud": "'"$AUDIENCE"'", "key": "'"$AUTH0_PEM"'"}'

echo $GENERATED_KEY
