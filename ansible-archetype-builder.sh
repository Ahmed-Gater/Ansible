#!/usr/bin/env bash


ROLE_NAME=""
ROLE_ROOT_PATH=$PWD
OVERRIDE="FALSE"

function usage()
{
    echo "This script creates an ansible archetype role"
    echo ""
    echo ".ansible-archetype.sh"
    echo "-h --help"
    echo "--rolename=ROLE_NAME"
    echo "--path=ROLE_PATH" 
    echo "--override"
    echo ""
}

while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            usage
            exit
            ;;
        --rolename)
            ROLE_NAME=$VALUE
            ;;
        --path)
            ROLE_ROOT_PATH=$VALUE
            ;;
        -override)
           OVERRIDE="TRUE"
           ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done

if [ -z ${ROLE_NAME} ]
then
  echo "Role name should not be empty"
  usage
  exit
fi

if [ -d ${ROLE_NAME} ] && [ ${OVERRIDE} = "FALSE" ]
then
  echo "Role Directory already exists. To override it add -override option. Exiting. "
  usage
  exit 1
fi

# Ansible Structure
ROLE_PATH=${ROLE_ROOT_PATH}/${ROLE_NAME}
rm -rf ${ROLE_PATH}
mkdir -p ${ROLE_PATH}
mkdir ${ROLE_PATH}/tasks
cat > ${ROLE_PATH}/tasks/main.yml <<EOF
---
# file: roles/${ROLE_PATH}/tasks/main.yml

EOF

mkdir ${ROLE_PATH}/meta
mkdir ${ROLE_PATH}/files
mkdir ${ROLE_PATH}/templates
mkdir  ${ROLE_PATH}/vars

cat > ${ROLE_PATH}/vars/main.yml <<EOF
---
# file: roles/${ROLE_PATH}/vars/main.yml

EOF
