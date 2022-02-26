create or replace function parse_units_per_dose (in_sig varchar2)
    return number is out_units_per_dose number;
begin 
    select 
        (case 
            when ' ' || lower(in_sig) || ' ' like lower('%eight tab%') then 8
            when ' ' || lower(in_sig) || ' ' like lower('%eight cap%') then 8
            when ' ' || lower(in_sig) || ' ' like lower('%eight pill%') then 8
            when ' ' || lower(in_sig) || ' ' like lower('%8 po%') then 8
            when ' ' || lower(in_sig) || ' ' like lower('%8po%') then 8
            when ' ' || lower(in_sig) || ' ' like lower('%8 tab%') then 8
            when ' ' || lower(in_sig) || ' ' like lower('%8 cap%') then 8
            when ' ' || lower(in_sig) || ' ' like lower('%seven tab%') then 7
            when ' ' || lower(in_sig) || ' ' like lower('%seven cap%') then 7
            when ' ' || lower(in_sig) || ' ' like lower('%seven pill%') then 7
            when ' ' || lower(in_sig) || ' ' like lower('%7 po%') then 7
            when ' ' || lower(in_sig) || ' ' like lower('%7po%') then 7
            when ' ' || lower(in_sig) || ' ' like lower('%7 tab%') then 7
            when ' ' || lower(in_sig) || ' ' like lower('%7 cap%') then 7
            when ' ' || lower(in_sig) || ' ' like lower('%six tab%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%six cap%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%six pill%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%6 po%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%6po%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%6 tab%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%6 cap%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('five tab%') then 5
            when ' ' || lower(in_sig) || ' ' like lower('five cap%') then 5
            when ' ' || lower(in_sig) || ' ' like lower('five pill%') then 5
            when ' ' || lower(in_sig) || ' ' like lower('5 po%') then 5
            when ' ' || lower(in_sig) || ' ' like lower('5po%') then 5
            when ' ' || lower(in_sig) || ' ' like lower('5 tab%') then 5
            when ' ' || lower(in_sig) || ' ' like lower('5 cap%') then 5
            when ' ' || lower(in_sig) || ' ' like lower('% five tab%') then 5
            when ' ' || lower(in_sig) || ' ' like lower('% five cap%') then 5
            when ' ' || lower(in_sig) || ' ' like lower('% five pill%') then 5
            when ' ' || lower(in_sig) || ' ' like lower('% 5 po%') then 5
            when ' ' || lower(in_sig) || ' ' like lower('% 5po%') then 5
            when ' ' || lower(in_sig) || ' ' like lower('% 5 tab%') then 5
            when ' ' || lower(in_sig) || ' ' like lower('% 5 cap%') then 5
            when ' ' || lower(in_sig) || ' ' like lower('%four tab%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%four cap%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%four pill%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%4 po%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%4po%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%4 tab%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%4 cap%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%three tab%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('%three cap%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('%three pill%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('%3 po%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('%3po%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('%3 tab%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('%3 cap%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('%0.5 pill%') then 0.5
            when ' ' || lower(in_sig) || ' ' like lower('%0.5 cap%') then 0.5
            when ' ' || lower(in_sig) || ' ' like lower('%1/2 tab%') then 0.5
            when ' ' || lower(in_sig) || ' ' like lower('%1/3 tab%') then 0.33
            when ' ' || lower(in_sig) || ' ' like lower('%1/4 tab%') then 0.25
            when ' ' || lower(in_sig) || ' ' like lower('%0.25 tab%') then 0.25
            when ' ' || lower(in_sig) || ' ' like lower('%0.5 tab%') then 0.5
            when ' ' || lower(in_sig) || ' ' like lower('%0.5 tab%') then 0.5
            when ' ' || lower(in_sig) || ' ' like lower('%2 1/2 tab%') then 2.5
            when ' ' || lower(in_sig) || ' ' like lower('%2.5 tab%') then 2.5
            when ' ' || lower(in_sig) || ' ' like lower('%two tab%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('%two cap%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('%two pills') then 2
            when ' ' || lower(in_sig) || ' ' like lower('%2 po%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('%2po%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('%2 tab%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('%2 cap%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('%1 1/2 tab%') then 1.5
            when ' ' || lower(in_sig) || ' ' like lower('%1.5 tab%') then 1.5
            when ' ' || lower(in_sig) || ' ' like lower('%1.25 tab%') then 1.25
            when ' ' || lower(in_sig) || ' ' like lower('%one tab%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%one cap%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%one pill%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%1 po%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%1po%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%1 tab%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%1 cap%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%0.75 tab%') then 0.75
            when ' ' || lower(in_sig) || ' ' like lower('%five patches%') then 5
            when ' ' || lower(in_sig) || ' ' like lower('%5 patch%') then 5
            when ' ' || lower(in_sig) || ' ' like lower('%four patches%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%4 patch%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%three patches%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('%3 patch%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('%0.5 patch%') then 0.5
            when ' ' || lower(in_sig) || ' ' like lower('%1/2 patch%') then 0.5
            when ' ' || lower(in_sig) || ' ' like lower('%two patches%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('%2 patch%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('%one patch%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%1 patch%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%patch%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%once nightly%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%2-4 every%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%2-3 every%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('%1-2 every%') then 2
        else null end) into out_units_per_dose from dual;
    return out_units_per_dose;
end parse_units_per_dose;
/
create or replace function get_units_per_dose (
    strength number,
    hv_discrete_dose varchar2,
    hv_dose_unit varchar2, 
    sig varchar2
)
return number 
is 
    aux_var number;
    out_units_per_dose number;
begin 

    if hv_discrete_dose is not null then
        --aux_var := to_number(regexp_replace(hv_discrete_dose, '^.*?-'));
        --aux_var := to_number(regexp_replace(hv_discrete_dose, '([0-9].[0-9]+e[0-9]+|[0-9]*\.[0-9]+|[0-9]+\.?)'));
        aux_var := to_number(regexp_substr(hv_discrete_dose, '([0-9].[0-9]+e[0-9]+|[0-9]*\.[0-9]+|[0-9]+\.?)'));
    else
        if sig is not null then
            aux_var := parse_units_per_dose(sig);
        else
            aux_var := 1;
        end if;
    end if;
    
    if lower(hv_dose_unit) in ('mg','mcg','mcg/hr','mcg/day') then
        out_units_per_dose := aux_var/strength;
    else
        out_units_per_dose := aux_var;
    end if;

    return out_units_per_dose;
end get_units_per_dose;
/