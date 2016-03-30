#!/bin/bash
#
#
#

source utils.sh


#comma seperated directories to look for *.ers files in
export SYNC_DIRS="/GSWA_Geophysics/WA_Gravity_Grids,/GSWA_Geophysics/WA_Magnetic_Grids,/GSWA_Geophysics/WA_Radiometric_Grids/"
export NCI_DIR="/g/data1/rl1"
export SCRATCH_DIR="/scratch/director569/transfer-tmp"
export NCI_USER=""
export NCI_PASSWORD=""
export NCI_HOST="raijin.nci.org.au"
export ATERM="`readlink -e aterm.jar`"
export ASHELL="`readlink -e ashell.py`"
export METADATA_CSV="`readlink -e metadata.csv`"
export CLEANUP="1"
export LOG_FILE="transfer.log"
export START_JOB="ncitransfer-read.job"

# parse arguments
while [[ $# > 0 ]]
do
key="$1"

case $key in
  -l|--log)
  LOG_FILE="$2"
  shift
  ;;
  -d|--dirty)
  CLEANUP="0"
  ;;
  -s|--sync)
  START_JOB="ncitransfer-sync.job"
  ;;
  -c|--convert)
  START_JOB="ncitransfer-convert.job"
  ;;
  -?|--help)
  usage
  ;;
  *)
    # unknown option
  ;;
esac
shift # past argument or value
done

if [ ! -f "$LOG_FILE" ]; then
  touch "$LOG_FILE" || finish 1 "ERROR: Unable to create log file $LOG_FILE"
fi
LOG_FILE="`readlink -e $LOG_FILE`"

if [[ -z "$ATERM" || -z "$ASHELL" ]]; then
  echo "aterm.jar and/or ashell.py is missing from the current directory"
  exit 1
fi

echo "Please enter your NCI credentials"
read -p "User: " NCI_USER
read -s -p "Password: " NCI_PASSWORD
echo ""

if [[ -z "$NCI_USER" || -z "$NCI_PASSWORD" ]]; then
  echo "Empty credentials. Aborting"
  exit 1
fi


#expect -f testconnection.tcl > /dev/null
if [[ $? > 0 ]]; then
  echo "The supplied login credentials are invalid."
  exit 1
fi
sbatch "$START_JOB"

