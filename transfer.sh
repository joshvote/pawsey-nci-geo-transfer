#!/bin/bash

#comma seperated directories to look for *.ers files in
export SYNC_DIRS="/GSWA_Geophysics/WA_Gravity_Grids,/GSWA_Geophysics/WA_Magnetic_Grids,/GSWA_Geophysics/WA_Radiometric_Grids/"
export NCI_DIR="/g/data1/rl1/GSWA_Geophysics/nc"
export SCRATCH_DIR="/scratch/director569/transfer-tmp"
export NCI_USER=""
export NCI_PASSWORD=""
export ATERM="`readlink -e aterm.jar`"
export ASHELL="`readlink -e ashell.py`"

if [[ -z "$ATERM" || -z "$ASHELL" ]]; then
  echo "aterm.jar and/or ashell.py is missing from the current directory"
  exit 1
fi

echo "Please enter your NCI credentials"
read -p "User: " NCI_USER
read -s -p "Password: " NCI_PASSWORD

if [[ -z "$NCI_USER" || -z "$NCI_PASSWORD" ]]; then
  echo "Empty credentials. Aborting"
  exit 1
fi

sbatch "ncitransfer-read.job"
