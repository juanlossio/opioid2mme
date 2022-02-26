create or replace function get_strength (
    strength_per_unit number,
    epic_strength varchar2
)
return number 
is 
    out_strength number;
begin 

    if strength_per_unit is not null then
        out_strength := strength_per_unit;
    else
        if epic_strength is not null then
            out_strength := to_number(regexp_substr(epic_strength, '([0-9].[0-9]+e[0-9]+|[0-9]*\.[0-9]+|[0-9]+\.?)'));
        else
            out_strength := null;
        end if;
    end if;

    return out_strength;
end get_strength;
/