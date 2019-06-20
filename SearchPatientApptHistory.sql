/* 
Officemate Appointment history transactions 
Show all appointment history and changes for specific patient ID
Sorting by appt_date ascending. 
*/

DECLARE @patientID int = 32; --Enter patient ID here before running

SELECT appt_name, appt_om_no as patient_no, appt_phone, appt_date, appt_notes, appt_start_time, appt_end_time, recorded_by, recorded_by_computer, recorded_date, created_by, 
created_by_computer, created_date, description

FROM AppSch_Appointment_History
WHERE appt_om_no = @patientID
ORDER BY appt_date DESC;