#!/bin/bash

source utils.sh

#FOO=$(extract_ers_attr "/scratch/director569/transfer-tmp/GSWA_Geophysics/WA_Gravity_Grids/WA_400m_Grav_Merge_v1_2016.ers" LastUpdated)
#echo $FOO

#get_metadata <ers_file_name> <attribute> <metadata_file>


FOO=$(get_metadata WA_400m_Grav_Merge_v1_2016.ers TITLE /home/jvote/pawsey-nci-geo-transfer/metadata.csv)
echo $FOO
