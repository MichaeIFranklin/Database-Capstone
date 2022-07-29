-- Clear old table data
Drop View report6;
-- Establish page format
Set Pagesize 52
Set linesize 100
Set Long 1100
Set Echo on
Clear Breaks
Clear Columns
Clear Computes
TTitle off
-- Create the report6 View
-- Usimg aircraft and type tables
Create View report6(fl_num, fl_date, cust_num) As
Select flight_num, Extract(month From flight_date)||'/'||Extract(day From flight_date)||'/'||Extract(year From flight_date), customer_num
From booking;
-- Select the current View data
Select * from report6;
-- Generate the Report based on the View above
TTitle 'Terra Firma Airlines | Flight Reservation Summary'
Column fl_num Heading 'Flight|Nbr' Format A5
Column fl_date Heading 'Flight|Date' Format A9
Column cust_num Heading 'Cust|Nbr' Format A4
Break on fl_date on fl_num on Report
/