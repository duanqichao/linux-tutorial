#!/usr/bin/env bash
###################################################################################
# Linux CentOS 环境部署脚本
# Author: Zhang Peng
###################################################################################

function printHeadInfo() {
cat << EOF
***********************************************************************************
* Welcome to using the deployment script for CentOS.
* Author: Zhang Peng
***********************************************************************************
EOF
}

function printFootInfo() {
cat << EOF
***********************************************************************************
* Deployment is over.
* Thank you for using!
***********************************************************************************
EOF
}

function checkOsVersion(){
  if(($1 == 1))
  then
    platform=`uname -i`
    if [[ ${platform} != "x86_64" ]]; then
    echo "this script is only for 64bit Operating System !"
    exit 1
    fi
    echo "the platform is ok"
    version=`lsb_release -r |awk '{print substr($2,1,1)}'`
    if [[ ${version} != 6 ]]; then
    echo "this script is only for CentOS 6 !"
    exit 1
    fi
  fi
}


function showMenu() {
cat << EOF

=================================== Deploy Menu ===================================
【1 - System Environment】
    [sys] initial system environment
    [libs] install commonly libs

【2 - Common Tools】
    [2 | tools] install all tools.
    [git] install git                          [svn] install svn
    [jdk8] install jdk8                        [maven] install maven
    [tomcat] install tomcat8                   [nginx] install nginx
    [nodejs] install node.js                   [elk] install elk
    [redis] install redis                      [mongodb] install mongodb
    [kafka] install kafka

【3 - Recommended Tools】
    [sdk] install sdkman
    [springboot] install spring boot cli

Press <CTRL-D> to exit
Please input key：
EOF
}

function chooseOper() {
  key=""
  filepath=$(cd "$(dirname "$0")"; pwd)
  while read key
  do
    case ${key} in
      # 2 - System Environment
      sys ) ${filepath}/sys/init.sh;;
      libs ) ${filepath}/lib/install-libs.sh;;

      # 2 - Common Tools
      2 | tools ) ${filepath}/ops/service/install-all.sh;;
      git ) ${filepath}/ops/service/git/install-git.sh;;
      svn ) ${filepath}/ops/service/svn/install-svn.sh;;
      jdk8 ) ${filepath}/ops/service/jdk/install-jdk8.sh;;
      maven ) ${filepath}/ops/service/maven/install-maven3.sh;;
      nginx ) ${filepath}/ops/service/nginx/install-nginx.sh;;
      nodejs ) ${filepath}/ops/service/nodejs/install-nodejs.sh;;
      tomcat ) ${filepath}/ops/service/tomcat/install-tomcat8.sh;;
      elk ) ${filepath}/ops/service/elk/install-elk.sh;;
      redis ) ${filepath}/ops/service/redis/install-redis.sh;;
      mongodb ) ${filepath}/ops/service/mongodb/install-mongodb.sh;;
      kafka ) ${filepath}/ops/service/kafka/install-kafka.sh;;

      # 3 - Recommended Tools
      sdk ) ${filepath}/ops/service/sdk/install-sdk.sh;;
      springboot ) ${filepath}/ops/service/springboot/install-springboot.sh;;

      * ) echo "${key} is invalid key";;
    esac

    showMenu
  done
}

######################################## MAIN ########################################
printHeadInfo
checkOsVersion 0
showMenu
chooseOper
printFootInfo
