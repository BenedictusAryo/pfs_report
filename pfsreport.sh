#!/bin/bash

# The Script is purposed to get PFS Report for Port Utilization and Total Error

psql -U postgres -d ucmsserverdb_3_6_6_11 -c "COPY(select name as PortName, 
date_trunc('hour',to_timestamp(utilization2.timestamp)) as HourlyTimestamp, 
trunc(avg(current_utilization/10.0),1) as Utilization, sum(current_errors) as TotalError , sum(congestion_errors) 
as CongestionError from subport,utilization2 where record_id=source_id group by PortName, HourlyTimestamp order 
by HourlyTimestamp,name) To '/tmp/jktpfs1dbtest.csv' With CSV HEADER DELIMITER',';"


