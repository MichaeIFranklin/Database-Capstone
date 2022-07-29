-- Clear old table data
Drop View report1;
-- Establish page format
Set Pagesize 52
Set linesize 100
Set Long 1100
Set Echo on
Clear Breaks
Clear Columns
Clear Computes
TTitle off
-- Create the report1 View
-- Usimg aircraft and type tables
Create View report1(serial, type, description, capacity, range) As
Select aircraft_serial, aircraft_type, description, capacity, range
From aircraft
Join aircraft_type Using (aircraft_type);
-- Select the current View data
Select * from report1;
-- Generate the Report based on the View above
TTitle 'Terra Firma Airlines | Aircraft Report'
Column serial Heading 'Serial#' Format A21
Column type Heading 'Type' Format A8
Column description Heading 'Description' Format A21
Column capacity Heading 'Capacity' Format 99999999
Column range Heading 'Range' Format 99999
Break on Report Skip 1
Compute Count Label 'Number of Aircraft:' -
	Sum Label 'Total Capacity:' -
	Avg Label 'Average Capacity:' -
	of Capacity on Report
/