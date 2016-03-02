#!/bin/bash

function finish {
  if [ "$CLEANUP" -ne "0" ]
  then
    if [ "$SCRATCH_DIR" != "" ]
    then
      log "Cleaning up contents of \"$SCRATCH_DIR\""
      rm $SCRATCH_DIR/*
    fi
  fi

  if [ "$2" != "" ]
  then
    log "$2"
  fi

  exit $1
}

function usage {
  echo 'transfer.sh [options]'
  echo ''
  echo "Reads the following public directories for ers files: $SYNC_DIRS"
  echo "before copying the files to $SCRATCH_DIR"
  echo "Files will then be converted to NetCDF files and then transferred to NCI using"
  echo "the credentials that are requested when this script is run."
  echo '[options]'
  echo '-l|--logfile The file where all log info will be recorded (defaults to transfer.log)'
  echo '-s|--sync    Skip the reading and conversion steps and start straight at sync (useful to recover if running with -d)'
  echo '-c|--convert Skip the reading step and start straight at conversion (useful to recover if running with -d)'
  echo '-d|--dirty   Dont perform any cleanup after the transfer finishes (successful or not)'
  echo '             default is to delete the scratch directory contents'
  exit 0
}

function log {
  timestamp="`date +%Y-%m-%d:%H:%M:%S`"
  echo "$timestamp $@"
  if [ "$LOG_FILE" != "" ]
  then
    echo "$timestamp $@" >> "$LOG_FILE"
  fi
}

