use OMSQLDB;

TRUNCATE TABLE rpt_feeslip;

TRUNCATE TABLE rpt_statementnew;

TRUNCATE TABLE rpt_statement;

Update fee_slip_items

Set service_from_date = update_dt 

Where service_from_date is null;

Update fee_slip_items

Set service_to_date = update_dt
 
Where service_to_date is null;