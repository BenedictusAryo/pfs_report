-- Query Port Error PFS
select name as PortName, date_trunc('hour',to_timestamp(utilization2.timestamp)) as HourlyTimestamp, 
trunc(avg(current_utilization/10.0),1) as Utilization, sum(current_errors) as TotalError , 
sum(congestion_errors) as CongestionError 
from subport,utilization2 where record_id=source_id 
group by PortName, HourlyTimestamp
order by HourlyTimestamp,name;
