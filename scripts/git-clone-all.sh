#!/bin/bash

REPOSITORIES=(FT.Api FT.Services.Tickets FT.Services.Signalr FT.Services.Identity FT.Services.FrequentTravellers FT.Common FT.Services.EmailNotifications) 

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
      echo Cloning repository: $REPOSITORY
      echo ========================================================
      REPO_URL=https://github.com/FrequentTraveller/$REPOSITORY.git
      git clone $REPO_URL
    done
fi