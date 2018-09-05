#!/bin/bash

# The Script is purposed to get PFS Report for Flapping Count

# Date variable
MM=$(date +"%m")
DD=$(date +"%d")
YY=$(date +"%Y")

# Format file : $YY$MM$DD.file.csv

echo "#######################################"
echo "PFS 3900 Flapping Report Export Script"
echo "#######################################"

echo "Script is running . . . "

psql -U postgres -d ucmsserverdb_3_6_6_11 -c "COPY(select  date_trunc('hour',to_timestamp(rawtime)) as hourlytimestamp, 
text1 as pfsname, text2 as portname, text4 as porttype, count(text5)/2 as 
FlappingCount from log where text1 not like 'API' group by 
hourlytimestamp, pfsname, portname, porttype order by hourlytimestamp) To 
'/tmp/PFS_eventlog.csv' With CSV HEADER DELIMITER',';"

# Rename the files
mv /tmp/PFS_eventlog.csv /tmp/$YY$MM$DD.JKT-PFS-01_FlappingReport.csv

echo "Script is finished"
echo "Report Exported in : /tmp/$YY$MM$DD.JKT-PFS-01_FlappingReport.csv"
