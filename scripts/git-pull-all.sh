#!/bin/bash

REPOSITORIES=(DNC-FrequentTraveller FT.Api FT.Services.Tickets FT.Services.Signalr FT.Services.Identity FT.Services.FrequentTravellers FT.Common FT.Services.EmailNotifications) 

dir=$(pwd)
actReposPath="DNC-FrequentTraveller/scripts"
orgDir="${dir/$actReposPath/}"
partition=${orgDir:1:1}
destinationDir="${orgDir/\/$partition/$partition:}"

cd $destinationDir

if [ "$1" = "-p" ]
  then
    echo ${REPOSITORIES[@]} | sed -E -e 's/[[:blank:]]+/\n/g' | xargs -I {} -n 1 -P 0 sh -c 'printf "========================================================\nCloning repository: {}\n========================================================\n"; git clone https://github.com/FrequentTraveller/{}.git'
  else
    for REPOSITORY in ${REPOSITORIES[*]}
    do
      echo ========================================================
      echo Updating repository: $REPOSITORY
      echo ========================================================
      cd $REPOSITORY
      #git checkout develop
      #git pull
      git checkout master
      git pull
      #git checkout develop
      cd ..
    done
fi