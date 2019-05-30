echo "#.description define your own search"
echo "#.exmaple searchpath='"'/home/amar/.kube'"' "

  #  read Inputfromsconsole
  #  patern="$Inputfromsconsole"

  #  patern="kubectl"

  #  searchpath= $(pwd)

  #  grep -rnw $searchpath -e $patern

  #  ## tree and level and pattern as its better

#!/bin/bash
#source $HOME/.bash_profile

#read Inputfromsconsole
#patern=$Inputfromsconsole

searchpatern="LoadBalancer"
searchpatern2="frontend"

#new directory
 searchpath="/home/amar/linux"

#current directory
  #searchpath="$(pwd)"

grep --color -rnw $searchpath -e $searchpatern -e $searchpatern2
