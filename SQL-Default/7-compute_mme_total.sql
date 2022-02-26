create or replace function is_number (p_string in varchar2)
   return int
is
   v_new_num number;
begin
   v_new_num := to_number(p_string);
   return v_new_num;
exception
when value_error then
   return 0;
end is_number;
/
create or replace function compute_mme_total (
    drug_ varchar2,
    strength number,
    mme_factor number,
    units_per_dose number,
    daily_dose number,
    rx_length number,
    refills varchar2
)
return number 
is 
    out_mme_per_general number;
    aux_mme_factor number;
    aux_refills number;
begin 
    
    if is_number(refills) >= 1 then
        aux_refills := to_number(refills)+1;
    else
        aux_refills := 1;
    end if;
    
    if strength is not null 
        and mme_factor is not null 
        and units_per_dose is not null 
        and daily_dose is not null 
        and rx_length is not null 
        and drug_ is not null
        then
            select 
                (case 
                when lower(trim(drug_)) like 'methadone%' and ((daily_dose * units_per_dose * strength) <= 20) then  4
                when lower(trim(drug_)) like 'methadone%' and ((daily_dose * units_per_dose * strength) > 20) and ((daily_dose * units_per_dose * strength)) <= 40 then 8
                when lower(trim(drug_)) like 'methadone%' and ((daily_dose * units_per_dose * strength) > 40) and ((daily_dose * units_per_dose * strength)) <= 60 then 10
                when lower(trim(drug_)) like 'methadone%' and ((daily_dose * units_per_dose * strength) > 60) then 12
                else null
                end) into aux_mme_factor from dual;
            
            if aux_mme_factor is null then
                out_mme_per_general := strength * mme_factor * units_per_dose * daily_dose * rx_length * aux_refills;
            else 
                out_mme_per_general := strength * aux_mme_factor * units_per_dose * daily_dose * rx_length * aux_refills;
            end if;
    else
        out_mme_per_general := null;
    end if;

    return out_mme_per_general;
end compute_mme_total;
/