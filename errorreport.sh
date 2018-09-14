#!/bin/bash

# The Script is purposed to get PFS Report for Port Utilization and Total Error

# Format file : $YY$MM$DD.file.csv

echo "#######################################"
echo "PFS 3900 Error Report Export Script"
echo "#######################################"

# Date variable
MM=$(date +"%m")
DD=$(date +"%d")
YY=$(date +"%Y")

# Format file : $YY$MM$DD.file.csv


echo "Script is running . . . "

psql -U postgres -d ucmsserverdb_3_6_6_11 -c "COPY(select name as PortName, 
to_char(date_trunc('hour',to_timestamp(utilization2.timestamp)+'7 hour'::interval), 'yyyy/MM/dd HH24:MI') as HourlyTimestamp, 
trunc(avg(current_utilization/10.0),1) as Utilization, sum(current_errors) as TotalError , sum(congestion_errors) 
as CongestionError from subport,utilization2 where record_id=source_id group by PortName, HourlyTimestamp order 
by HourlyTimestamp,name) To '/tmp/pfsdbtest_report.csv' With CSV HEADER DELIMITER',';"

# Rename the files
mv /tmp/pfsdbtest_report.csv /tmp/$YY$MM$DD.JKT-PFS-01_ErrorReport.csv

echo "Script is finished"
echo "Report Exported in : /tmp/$YY$MM$DD.JKT-PFS-01_ErrorReport.csv"
