#!/usr/bin/env bash

trace() {
  echo -e "TRACE: $*"
}

USERNAME=amar@jigsaw.xyz
PASSWORD=Dragoncontrol101
JAR_PATH=./onelogin-aws-cli.jar

if [ -f "${JAR_PATH}" ]; then
    trace "${JAR_PATH} exists... proceeding"
  else
    trace "${JAR_PATH} does not exist... acquiring"
    wget -q https://github.com/onelogin/onelogin-aws-cli-assume-role/raw/master/onelogin-aws-assume-role-cli/dist/onelogin-aws-cli.jar
    if [ ! -f "${JAR_PATH}" ]; then
        trace "Failed to download onelogin-aws-cli.jar..."
        exit 1
      else
        trace "Successfully downloaded ${JAR_PATH}"
    fi
fi

java -jar $JAR_PATH
