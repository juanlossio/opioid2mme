create or replace function get_mme_factor (
    mme_conversion_factor number,
    ome_factor number
)
return number 
is 
    out_mme_conversion_factor number;
begin 

    if mme_conversion_factor is not null then
        out_mme_conversion_factor := mme_conversion_factor;
    else
        if ome_factor is not null then
            out_mme_conversion_factor := ome_factor;
        else
            out_mme_conversion_factor := null;
        end if;
    end if;

    return out_mme_conversion_factor;
end get_mme_factor;
/