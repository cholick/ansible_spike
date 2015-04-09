#!/bin/bash -e

red='\033[1;31m'
green='\033[1;32m'
clear='\033[0m'

function usage() {
    echo "usage:
    $0 [--full] [--help]
    Flags:
      --full    Start from a fresh vagrant box & test idempotence
      --help    This menu
"
  exit 0
}

if [ "$1" == "--help" ]; then
    usage;
fi

if [ "$1" == "--full" ]; then
    vagrant destroy --force
fi

vagrant up

ansible-playbook -i ../environments/dev/inventory ../site.yml

if [ "$1" == "--full" ]; then
    ansible-playbook -i hosts ../site.yml \
        | grep -qE "changed=0\s+unreachable=0" \
        && (echo -e "Idempotence test: ${green}pass${clear}" && exit 0) \
        || (echo -e "Idempotence test: ${red}fail${clear}" && exit 1)
fi

rake
