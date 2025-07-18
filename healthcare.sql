create database healthcare;
use healthcare;

select medication, count(*) as frequency, sum(cast(substring_index(dosage,"",1)as unsigned)) as total_dosage
from prescriptions
group by medication
order by frequency desc;

-- analyze the correlation between appointment frequency and billing status
select p.patient_id, count(a.appointment_id) as appointment_count,avg(b.amount) as avg_biling_amount
from patients p
left join appointments a on p.patient_id= a.patient_id
left join billing b on a.appointment_id= b.appointment_id
group by p.patient_id;

-- patment status over time
select date_format(payment_date, "%Y-%m") AS month, status, count(*) as count
from billing
group by month, status
order by month, status;

-- unpaid bills analysis
select p.patient_id, p.first_name, p.last_name, sum(b.amount) as total_unpaid 
from patients p
join appointments a on p.patient_id = a.patient_id
join billing b on a.appointment_id=b.appointment_id
where b.status="pending"
group by p.patient_id, p.first_name, p.last_name
order by total_unpaid desc;

select d.doctor_id, d.first_name, d.last_name, count(a.appointment_id) as number_of_appointments
from doctors d
left join appointments a on d.doctor_id= a.doctor_Id
group by d.doctor_id, d.first_name, d.last_name;

-- day wise appointment counts 
select appointment_date, count(*) as appointment_count
from appointments
group by appointment_date;

-- find patients with missing appointments
select p.patient_id, p.first_name, p.last_name
from patients p
left join appointments a on p.patient_id= a.patient_id
where a.appointment_id is null;


select a.appointment_id, a.patient_id, a.doctor_id, a.appointment_date
from appointments a
left join billing b on a.appointment_id=b.appointment_id
where b.billing_id is null;