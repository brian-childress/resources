#!/bin/bash

# Explaination available here: https://brianchildress.co/named-parameters-in-bash/

school=${school:-is out}
environment=${environment:-production}

while [ $# -gt 0 ]; do

   if [[ $1 == *"--"* ]]; then
        v="${1/--/}"
        declare $v="$2"
        echo $1 $2
   fi

  shift
done

echo $school $environment