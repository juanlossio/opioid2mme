create or replace function compute_mme_per_day (
    drug_ varchar2,
    strength number,
    mme_factor number,
    units_per_dose number,
    daily_dose number
)
return number 
is 
    out_mme_per_day number;
    aux_mme_factor number;
begin 

    if strength is not null 
        and mme_factor is not null 
        and units_per_dose is not null 
        and daily_dose is not null 
        and drug_ is not null
        then
        select 
            (case 
            when lower(trim(drug_)) like 'methadone%' and ((daily_dose * units_per_dose * strength) <= 20) then  4
            when lower(trim(drug_)) like 'methadone%' and ((daily_dose * units_per_dose * strength) > 20) and ((daily_dose * units_per_dose * strength)) <= 40 then 8
            when lower(trim(drug_)) like 'methadone%' and ((daily_dose * units_per_dose * strength) > 40) and ((daily_dose * units_per_dose * strength)) <= 60 then 10
            when lower(trim(drug_)) like 'methadone%' and ((daily_dose * units_per_dose * strength) > 60) then 12
            else mme_factor
            end) into aux_mme_factor from dual;
            out_mme_per_day := strength*aux_mme_factor*units_per_dose*daily_dose;
    else
        out_mme_per_day := null;
    end if;

    return out_mme_per_day;
end compute_mme_per_day;
/