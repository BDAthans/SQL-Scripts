-- SQL Query to display list of patients and their Re-Do Lab Orders that have RX notes over 255 characters in length
SELECT patient.patient_no, patient.first_name, patient.last_name, redo_numb, rx_id, lens_notes_mem, len(convert(nvarchar, lens_notes_mem)) as RX_NOTES_LENGTH, rx_entry_date
FROM Frame_RX 
JOIN patient ON Frame_RX.patient_id = patient.patient_no 
WHERE Frame_RX.redo_numb <> '' 
AND len(convert(nvarchar, lens_notes_mem)) >255
ORDER By patient.patient_no ASC;