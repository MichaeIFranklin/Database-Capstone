-- Clear old table data
Drop View report4;
-- Establish page format
Set Pagesize 52
Set linesize 100
Set Long 1100
Set Echo on
Clear Breaks
Clear Columns
Clear Computes
TTitle off
-- Create the report4 View
-- Usimg aircraft and type tables
Create View report4(fl_date, fl_num, serial, resv, avail) As
Select Extract(month From flight_date)||'/'||Extract(day From flight_date), flight_num, sched_flight.aircraft_serial, Count(customer_num), capacity - Count(customer_num)
From sched_flight
Join booking Using (flight_num, flight_date)
Join aircraft On sched_flight.aircraft_serial = aircraft.aircraft_serial
Join aircraft_type Using (aircraft_type)
Group By flight_date, flight_num, sched_flight.aircraft_serial, capacity
Order By flight_date, flight_num;
-- Select the current View data
Select * from report4;
-- Generate the Report based on the View above
TTitle 'Terra Firma Airlines | Scheduled Flight Summary'
Column fl_date Heading 'Flt|Date' Format A22
Column fl_num Heading 'Flt|Nbr' Format A3
Column serial Heading 'Aircraft|Serial #' Format A8
Column resv Heading '# Seats|Reserved' Format 99999999
Column avail Heading '# Seats|Avail.' Format 9999999
Break on Report on fl_date Skip 1
Compute Count Label 'Total Flights:' of fl_num on fl_date
Compute Sum Label 'Seats Reserved:' of resv on fl_date
Compute Count Label 'Grand Total Flights:' of fl_num on Report
Compute Sum Label 'Total Seats Reserved:' of resv on Report
/